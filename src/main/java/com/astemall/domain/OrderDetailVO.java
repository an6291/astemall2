package com.astemall.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {
	private Long	ord_no; 	  // 주문번호
	private	int		prd_no; 	  // 상품번호
	private	int		ord_amount;	  // 주문수량
	private	int		ord_price;	  // 주문 상품 (개별) 금액
}	
