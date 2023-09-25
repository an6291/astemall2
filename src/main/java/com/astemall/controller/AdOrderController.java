package com.astemall.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.dto.AdOrderDetailDTO;
import com.astemall.dto.Criteria;
import com.astemall.dto.PageDTO;
import com.astemall.service.AdOrderService;
import com.astemall.util.FileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/order/*")
@Controller
public class AdOrderController {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderService adOrderService;
	
	// 상품이미지 업로드폴더 주입
	@Resource(name = "uploadPath") 
	private String uploadPath;
	
	
	// 주문 목록
	@GetMapping("/order_list")
	public void order_list(@ModelAttribute("cri") Criteria cri, 
			@ModelAttribute("startDate") String startDate, @ModelAttribute("endDate") String endDate, Model model) {
		
		// 주문 목록 정보
		List<OrderVO> order_list = adOrderService.order_list(cri, startDate, endDate);
		model.addAttribute("order_list", order_list);
		
		// 페이징 정보
		int count = adOrderService.order_count(cri, startDate, endDate);
		model.addAttribute("pageMaker", new PageDTO(count, cri));
		
	}
	
	// 주문 삭제.  Ajax
	@ResponseBody
	@PostMapping("/order_info_delete")
	public ResponseEntity<String> order_info_delete(Long ord_no){
		ResponseEntity<String> entity = null;
		adOrderService.order_info_delete(ord_no);
		entity = new ResponseEntity<String>("success", HttpStatus.OK); 
		return entity;
	}
	
	// 주문 상세.  Ajax
	@ResponseBody
	@GetMapping("/order_detail")
	public ResponseEntity<List<AdOrderDetailDTO>> order_detail(Long ord_no){
		ResponseEntity<List<AdOrderDetailDTO>> entity = null;
		
		// 주문 상세 정보
		entity = new ResponseEntity<List<AdOrderDetailDTO>>(adOrderService.order_detail(ord_no), HttpStatus.OK);

		return entity;
	}
	
	// 상품 이미지 - 주문 상세보기
	@GetMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(String folderName, String fileName) throws IOException{
		return FileUtils.getFile(uploadPath+folderName, fileName);
	}
	
	// 주문 상세 - 상품 삭제.  Ajax
	@ResponseBody
	@PostMapping("/order_detail_product_delete")
	public ResponseEntity<String> order_detail_product_delete(Long ord_no, int prd_no, int ord_price, int ord_amount){
		ResponseEntity<String> entity = null;
		
		OrderVO o_vo = adOrderService.getOrderVO(ord_no);
		PaymentVO p_vo = adOrderService.getPaymentVO(ord_no);
		
		log.info("총주문금액: " + o_vo.getOrd_tot_price());
		log.info("총결제금액: " + p_vo.getPay_price());
		 
		adOrderService.orderDetailProductDelete(ord_no, prd_no, o_vo, p_vo, ord_price, ord_amount);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK); 
		return entity;
	}
}
