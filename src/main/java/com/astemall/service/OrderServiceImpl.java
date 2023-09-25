package com.astemall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.mapper.CartMapper;
import com.astemall.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = {@Autowired})
	private OrderMapper orderMapper;

	@Setter(onMethod_ = {@Autowired})
	private CartMapper cartMapper;  // cart_empty() 사용
	
	@Transactional  // 트랜잭션 적용
	@Override
	public void order_save(OrderVO o_vo, PaymentVO p_vo) {
		// 주문정보
		orderMapper.order_save(o_vo);
		// 주문상세정보
		orderMapper.order_detail_save(o_vo.getOrd_no());
		// 결제정보
		p_vo.setOrd_no(o_vo.getOrd_no());
		orderMapper.payment_save(p_vo);
		// 장바구니 비우기
		cartMapper.cart_empty(o_vo.getMb_id());
	}
}
