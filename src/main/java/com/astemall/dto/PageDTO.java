package com.astemall.dto;

import com.astemall.dto.Criteria;

import lombok.Getter;
import lombok.Setter;

//페이징기능 구현 목적으로 사용
//스프링 내부에서 동작하여 객체가 생성된다.

@Getter
@Setter
public class PageDTO {

	private int startPage;  	// 시작페이지 번호
	private int endPage;		// 마지막페이지 번호
	private boolean prev, next; // [이전] [다음] 버튼 표시여부. 상품 개수에 따라 결정된다.
	private int total; 			// 총 상품 개수
	private Criteria cri;  		// 페이징정보(pageNum 선택한 페이지 번호, amount 페이지마다 출력할 게시물 개수)와 검색필드(type 검색종류, keyword 검색어)
	
	public PageDTO(int total, Criteria cri) {
		
		this.cri = cri;
		this.total = total;
		
		int pageSize = 10; 				 // 블럭당 출력할 페이지 개수
		int endPageInfo = pageSize - 1;  // endPage필드값을 구하기위한 용도
		
		this.endPage = (int) Math.ceil(cri.getPageNum() / (double) pageSize) * pageSize;
		this.startPage = this.endPage - endPageInfo;
		
		// Product_tb 테이블의 실제 데이터 개수에 따른 마지막페이지 번호를 구한다.
		int realEnd = (int) Math.ceil((total * 1.0) / cri.getAmount());  // cri.getAmount() : 출력건수
		// 실제 마지막페이지 번호가 endPage보다 작으면 값을 바꾼다.
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;  // (총 상품 수에 따른) 마지막페이지 번호
		}
		
		this.prev = this.startPage > 1;      // true: startPage가 1보다 크므로, [이전] 블럭에 표시할 데이터가 존재
		this.next = this.endPage < realEnd;  // true: 실제 마지막페이지 endPage보다 크므로, [다음] 블럭에 표시할 데이터가 존재 
	}
	
}
