package com.astemall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.astemall.domain.MemberVO;
import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.dto.CartListDTO;
import com.astemall.kakaopay.ApproveResponse;
import com.astemall.kakaopay.ReadyResponse;
import com.astemall.service.CartService;
import com.astemall.service.KakaoPayService;
import com.astemall.service.MemberService;
import com.astemall.service.OrderService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/order/*")
@Controller
public class OrderController {
	
	@Resource(name = "cid")
	private String cid;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;

	@Setter(onMethod_ = {@Autowired})
	private MemberService memberService;  // login() 사용자 로그인 정보
	
	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;  // cart_list() 장바구니 상품 목록
	
	@Setter(onMethod_ = {@Autowired})
	private KakaoPayService kakaoPayService;  // payReady(), payApprove() 카카오페이 결제
	
	
	// 주문정보 폼 - 장바구니, 바로구매 공통
	// (바로구매는 장바구니에 상품을 담는 과정을 별도로 거친다. CartController의 direct_order_cart_add()메소드)
	@GetMapping("/order_info")
	public void order_info(HttpSession session, Model model) {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		

		// 주문자 정보
		model.addAttribute("memberVO", memberService.login(mb_id));
		
		// 장바구니 상품 목록(주문 목록)
		List<CartListDTO> cart_list = cartService.cart_list(mb_id);
		cart_list.forEach(dto -> {
			dto.setPrd_up_folder(dto.getPrd_up_folder().replace("\\", "/"));  // 상품이미지 폴더 경로 \ -> / 변경
		});
		model.addAttribute("cart_list", cart_list);
		
		// 주문 총 금액
		model.addAttribute("cart_tot_price", cartService.cart_tot_price(mb_id));
		
		// 주문 상품명 - 카카오페이 API 서버 전달용
		String order_productName = cart_list.get(0).getPrd_name() + " 외 " + (cart_list.size() - 1) + " 건";
		model.addAttribute("order_productName", order_productName);
		
	}
	
	// 주문하기.  Ajax, 트랜잭션
	@GetMapping("/orderBuy")
	@ResponseBody
	public ReadyResponse orderBuy(String pay_type, String order_productName, OrderVO o_vo, PaymentVO p_vo, HttpSession session) {
		
		ReadyResponse readyResponse = new ReadyResponse();
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		o_vo.setMb_id(mb_id);  // 주문정보에 로그인한 회원 아이디 저장
		p_vo.setMb_id(mb_id);  // 결제정보에 로그인한 회원 아이디 저장
		
		log.info("결제방식: " + pay_type);
		log.info("무통장 주문정보: " + o_vo);
		log.info("무통장 결제정보: " + p_vo);
		
		/* 무통장입금 결제 */
		if(pay_type.equals("bank")) {
			// 주문정보, 주문상세정보, 결제정보 저장, 장바구니 비우기 - 트랜잭션 처리
			orderService.order_save(o_vo, p_vo);
		}
		
		/* 카카오페이 API 결제 */
		if(pay_type.equals("kakaopay")) {
			p_vo.setPay_bank("kakaopay");
			p_vo.setPay_user(p_vo.getMb_id());	
			
			log.info("카카오페이 결제정보: " + p_vo);
			
			// 주문정보, 주문상세정보, 결제정보 저장, 장바구니 비우기 - 트랜잭션 처리
			orderService.order_save(o_vo, p_vo);
			
			String approval_url = "http://localhost:8080/order/orderApproval";  // 결제준비요청 성공시 사용주소
			String cancel_url = "http://localhost:8080/order/orderCancel";  // 결제준비요청 취소시 사용주소
			String fail_url = "http://localhost:8080/order/orderFail";  // 결제준비요청 실패시 사용주소
			
			log.info("결제준비요청 파라미터: " + cid);
			log.info("결제준비요청 파라미터: " + o_vo.getOrd_no());
			log.info("결제준비요청 파라미터: " + mb_id);
			log.info("결제준비요청 파라미터: " + order_productName);
			log.info("결제준비요청 파라미터: " + o_vo.getOrd_tot_price());
			
			// 결제준비요청 및 응답데이터
			readyResponse = kakaoPayService.payReady(cid, o_vo.getOrd_no(), mb_id, order_productName, 1, o_vo.getOrd_tot_price(), 0, approval_url, cancel_url, fail_url);
			
			// 응답데이터 확인
			log.info("결제준비요청 응답: " + readyResponse);
			log.info("결제고유번호(tid): " + readyResponse.getTid());
			log.info("결제요청URL(QR코드):" + readyResponse.getNext_redirect_pc_url());
			
			session.setAttribute("ord_no", o_vo.getOrd_no());    // partner_order_id(주문번호) 저장. 결제승인요청 단계에서 사용 목적 
			session.setAttribute("tid", readyResponse.getTid()); // tid 저장. 결제승인요청 단계에서 사용 목적
		}
		
		return readyResponse;
	}
	
	/* 카카오페이 API 결제 */
	// 결제승인요청 (결제준비요청에 보낸 파라미터와 결제승인요청에 보낼 파라미터가 동일하다면 값 또한 동일해야 한다.)
	@GetMapping("/orderApproval")
	public String orderApproval(String pg_token, HttpSession session) {
		
		String tid = (String) session.getAttribute("tid");  // 결제준비요청 단계에서 카카오서버에게 받은 tid값을 사용
		session.removeAttribute("tid");
		
		Long ord_no = (Long) session.getAttribute("ord_no");  // 결제준비요청 단계에서 카카오서버에게 받은partner_order_id(ord_no)값을 사용
		session.removeAttribute("tid");
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		
		// 결제승인요청 작업
		ApproveResponse approveResponse = kakaoPayService.payApprove(cid, tid, ord_no, mb_id, pg_token); 
		
		// 응답데이터 확인
		log.info("결제승인요청 응답: " + approveResponse);
		
		return "redirect:/order/orderComplete";
	}
	
	// 카카오페이 결제및주문 완료
	@GetMapping("/orderComplete")
	public String orderComplete() {
		return "/order/order_complete";
	}
	
	// 결제준비요청 취소
	@GetMapping("/orderCancel")
	public void orderCancel() {
		
	}
	
	// 결제준비요청 실패
	@GetMapping("/orderFail")
	public void orderFail() {
		
	}

}
