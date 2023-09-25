package com.astemall.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentVO {
	
	private Integer pay_cd;		 // 결제코드
	private long 	ord_no;		 // 주문번호
	private String	mb_id;		 // 주문자
	private String	pay_method;  // 결제방법
	private int 	pay_price;   // 총결제금액
	private String 	pay_user;    // 입금자명
	private String	pay_bank;    // 입금은행
	private Date 	pay_date; 	 // 결제일
	private String 	pay_memo;	 // 메모
	
}
