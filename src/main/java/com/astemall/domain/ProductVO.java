package com.astemall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductVO {

	private Integer	prd_no;				// 상품 번호
	private int		ctgr_cd;			// 2차(하위) 카테고리 코드
	private String	prd_name;			// 상품명
	private int		prd_price;			// 상품 가격
	private int 	prd_discount;		// 할인율
	private String  prd_company;		// 제조사
	private String  prd_detail;			// 상세설명
	private String	prd_up_folder;		// (상품 이미지를 업로드하면, 업로드한 날짜별로 저장될 것이다.)
										// 상품 이미지가 저장될 날짜폴더 경로. 예>23\05\01
	private String	prd_img;			// 상품 이미지의 파일명 : 랜덤 문자열_원래 파일명
	private int		prd_amount;			// 상품 수량
	private String	prd_buy;			// 판매여부
	private Date	create_date;		// 등록일
	private Date	update_date;		// 수정일
	private MultipartFile uploadFile;	// 파일 업로드 필드
	
}
