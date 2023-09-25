package com.astemall.service;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;

public interface OrderService {

	// 주문정보, 주문상세정보, 결제정보
	void order_save(OrderVO o_vo, PaymentVO p_vo);
	
}
