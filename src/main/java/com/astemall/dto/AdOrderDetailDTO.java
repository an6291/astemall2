package com.astemall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 관리자 - 주문 상세조회용

@Getter
@Setter
@ToString
public class AdOrderDetailDTO {
	
	private Long	ord_no; 		// 주문번호
	private	int		prd_no; 		// 상품번호
	private	int		ord_amount;		// 주문수량
	private	int		ord_price;		// 주문 상품 (개별) 금액
	private int		prd_tot_price;	// 주문 상품 (상품별) 금액
	private int		ord_tot_price;  // 총 주문 금액
	private String	prd_name;		// 주문 상품명
	private String	prd_up_folder;	// 상품이미지 업로드폴더
	private String	prd_img;		// 상품이미지
	
}
