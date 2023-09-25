package com.astemall.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderVO {
	private Long	ord_no;			    // 주문번호
	private	String	mb_id;			    // 주문인(아이디)
	private	String	ord_rcv_name;	    // 수령인 이름
	private	String	ord_rcv_zipcode;    // 수령 우편번호
	private	String	ord_rcv_addr; 		// 수령 기본주소
	private	String	ord_rcv_addr_d; 	// 수령 상세주소
	private	String	ord_rcv_phone; 		// 수령인 연락처
	private	int		ord_tot_price; 		// 총 주문금액
	private	Date	ord_date;			// 주문일
	private String	pay_method;			// 결제방식
}
