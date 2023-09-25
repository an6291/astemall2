package com.astemall.mapper;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;

public interface OrderMapper {

	// 주문정보
	void order_save(OrderVO o_vo);
	
	// 주문상세정보
	void order_detail_save(Long	ord_no);
	
	// 결제정보 
	void payment_save(PaymentVO p_vo);
	
}
