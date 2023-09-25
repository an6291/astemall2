package com.astemall.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.astemall.service.CartService;
import com.astemall.util.FileUtils;
import com.astemall.domain.CartVO;
import com.astemall.domain.MemberVO;
import com.astemall.dto.CartListDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/cart/*")
@Controller
public class CartController {

	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	// 업로드폴더 주입
	@Resource(name = "uploadPath") 
	private String uploadPath; 
		
	
	// 장바구니에 상품 추가(로그인 사용자). Ajax
	@ResponseBody
	@PostMapping("/cart_add")
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session){
		ResponseEntity<String> entity = null;
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		vo.setMb_id(mb_id);
		
		if(cartService.cart_add(vo) == 1) { // 메소드 실행결과(insert) 작업 행 수가 1이라면,
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK); 
		}
		
		return entity;
	}
	
	// 바로구매 시 장바구니에 상품 담기
	@GetMapping("/direct_order_cart_add")
	public String direct_order_cart_add(CartVO vo, HttpSession session) {
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		vo.setMb_id(mb_id);
		
		cartService.cart_add(vo);
		
		return "redirect:/order/order_info";  // 주문 정보 폼으로 이동
	}
	
	// 장바구니 상품 목록
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session, Model model) {
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		
		// 장바구니 상품 목록 데이터
		List<CartListDTO> cart_list = cartService.cart_list(mb_id);
		cart_list.forEach(dto -> {
			dto.setPrd_up_folder(dto.getPrd_up_folder().replace("\\", "/"));  // 상품이미지 폴더 경로 \ -> / 변경
		});
		model.addAttribute("cart_list", cart_list);
		
		// 장바구니 총 금액
		// cartService.cart_tot_price()메소드의 리턴타입은 int -> 장바구니가 비여있을 경우 null -> 에러 발생
		if(cart_list.size() != 0) {
			// 장바구니가 비어있지 않는 경우에만 아래 코드를 실행한다.
			model.addAttribute("cart_tot_price", cartService.cart_tot_price(mb_id));
		}
	}
	
	// 상품 이미지 (장바구니 상품 목록)
	// /cart/product/displayImage?folderName=값&fileName=값
	@GetMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(String folderName, String fileName) throws IOException{
		return FileUtils.getFile(uploadPath+folderName, fileName);
	}
	
	// 장바구니 상품수량 변경
	@ResponseBody
	@PostMapping("/cart/cart_amount_change")
	public ResponseEntity<String> cart_amount_change(Long cart_no, int cart_amount){
		log.info("장바구니 번호: " + cart_no);
		log.info("장바구니 상품수량: " + cart_amount);	
		
		ResponseEntity<String> entity = null;
		
		if(cartService.cart_amount_change(cart_no, cart_amount) == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 장바구니 상품 개별삭제
	@ResponseBody
	@PostMapping("/cart_delete")
	public ResponseEntity<String> cart_delete(Long cart_no){
		ResponseEntity<String> entity = null;
		
		if(cartService.cart_delete(cart_no) == 1) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	// 장바구니 상품 전체삭제 (장바구니 비우기)
	@GetMapping("/cart_empty")
	public String cart_empty(HttpSession session) {
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		cartService.cart_empty(mb_id);
		
		return "redirect:/cart/cart_list";
	}
	
}
