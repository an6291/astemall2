package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.dto.AdOrderDetailDTO;
import com.astemall.dto.Criteria;
import com.astemall.mapper.AdOrderMapper;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = {@Autowired})
	private AdOrderMapper adOrderMapper;

	@Override
	public List<OrderVO> order_list(Criteria cri, String startDate, String endDate) {
		return adOrderMapper.order_list(cri, startDate, endDate);
	}

	@Override
	public int order_count(Criteria cri, String startDate, String endDate) {
		return adOrderMapper.order_count(cri, startDate, endDate);
	}

	@Override
	public List<AdOrderDetailDTO> order_detail(Long ord_no) {
		return adOrderMapper.order_detail(ord_no);
	}

	@Transactional  // 트랜잭션 적용
	@Override
	public void orderDetailProductDelete(Long ord_no, int prd_no, OrderVO o_vo, PaymentVO p_vo, int ord_price, int ord_amount) {
		// 주문상세-상품삭제
		adOrderMapper.orderDetailProductDelete(ord_no, prd_no);
		// 총주문금액 업데이트
		adOrderMapper.updateOrder(ord_no, o_vo, ord_price, ord_amount);
		// 총결제금액 업데이트
		adOrderMapper.updatePayment(ord_no, p_vo, ord_price, ord_amount);
	}

	@Override
	public OrderVO getOrderVO(Long ord_no) {
		return adOrderMapper.getOrderVO(ord_no);
	}

	@Override
	public PaymentVO getPaymentVO(Long ord_no) {
		return adOrderMapper.getPaymentVO(ord_no);
	}

	@Transactional  // 트랜잭션 적용
	@Override
	public void order_info_delete(Long ord_no) {
		
		// 주문상세정보 삭제
		adOrderMapper.order_detail_delete(ord_no);
		// 주문정보 삭제
		adOrderMapper.order_delete(ord_no);
		// 결제정보 삭제
		adOrderMapper.payment_delete(ord_no);
	}
	
}
