package com.astemall.service;

import java.util.List;

import com.astemall.domain.CartVO;
import com.astemall.dto.CartListDTO;

public interface CartService {
	
	// 장바구니에 상품 추가
	int cart_add(CartVO vo);
	
	// 장바구니 상품 목록
	List<CartListDTO> cart_list(String mb_id);
	// 장바구니 총 금액
	int cart_tot_price(String mb_id);
	
	// 장바구니 상품수량 변경
	int cart_amount_change(Long cart_no, int cart_amount);
	
	// 장바구니 상품 개별삭제
	int cart_delete(Long cart_no);
	
	// 장바구니 상품 전체삭제
	void cart_empty(String mb_id);
}
