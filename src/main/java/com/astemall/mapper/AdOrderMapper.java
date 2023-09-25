package com.astemall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.astemall.domain.OrderVO;
import com.astemall.domain.PaymentVO;
import com.astemall.dto.AdOrderDetailDTO;
import com.astemall.dto.Criteria;

public interface AdOrderMapper {

	// 주문 목록 
	List<OrderVO> order_list(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	// 주문 수
	int order_count(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	// 주문 상세
	List<AdOrderDetailDTO> order_detail(Long ord_no);
	
	/* 주문 상세 - 상품 삭제 */
	void orderDetailProductDelete(@Param("ord_no")Long ord_no, @Param("prd_no")int prd_no);
	// 주문테이블
	OrderVO getOrderVO(Long ord_no);
	// 결제테이블
	PaymentVO getPaymentVO(Long ord_no);
	// 주문정보(총주문금액) 업데이트
	void updateOrder(@Param("ord_no") Long ord_no, @Param("o_vo") OrderVO o_vo, @Param("ord_price") int ord_price, @Param("ord_amount") int ord_amount);
	// 결제정보(총결제금액) 업데이트
	void updatePayment(@Param("ord_no") Long ord_no, @Param("p_vo") PaymentVO p_vo, @Param("ord_price") int ord_price, @Param("ord_amount") int ord_amount);
	
	/* 주문 삭제 (순서 유의. 주문상세정보 먼저 삭제 -> 주문정보 삭제) */
	// 주문상세정보 삭제
	void order_detail_delete(Long ord_no);
	// 주문정보 삭제
	void order_delete(Long ord_no);
	// 결제정보 삭제
	void payment_delete(Long ord_no);
}
