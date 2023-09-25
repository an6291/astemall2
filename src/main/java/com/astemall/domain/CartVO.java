package com.astemall.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVO {
	
	private Long	cart_no;		// 장바구니 번호
	private Integer	prd_no; 		// 상품 번호
	private String	mb_id;			// 회원 아이디
	private int		cart_amount;	// 장바구니 수량
	
}
