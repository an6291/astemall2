package com.astemall.kakaopay;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
// 결제승인요청에 의한 응답 데이터의 하위 결제금액정보
public class Amount {
	
	private	Integer	total;		// 전체 결제 금액
	private	Integer	tax_free;	// 비과세 금액
	private	Integer	vat;		// 부가세 금액
	private	Integer	point;		// 사용한 포인트 금액
	private Integer discount;	// 할인 금액
	
}
