package com.astemall.service;

import java.util.List;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.dto.AdOrderDetailDTO;
import com.astemall.dto.Criteria;

public interface AdOrderService {
	
	// 주문 목록
	List<OrderVO> order_list(Criteria cri, String startDate, String endDate);
	// 주문 수
	int order_count(Criteria cri, String startDate, String endDate);
	
	// 주문 상세
	List<AdOrderDetailDTO> order_detail(Long ord_no);
	
	// 주문 상세 - 상품 삭제
	void orderDetailProductDelete(Long ord_no, int prd_no, OrderVO o_vo, PaymentVO p_vo, int ord_price, int ord_amount);
	// 주문테이블
	OrderVO getOrderVO(Long ord_no);
	// 결제테이블
	PaymentVO getPaymentVO(Long ord_no);
	
	// 주문 삭제
	void order_info_delete(Long ord_no);

}
