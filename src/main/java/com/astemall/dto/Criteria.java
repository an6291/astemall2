package com.astemall.dto;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//검색기능 및 페이징정보
//클라이언트로부터 정보를 받아온다.

@Getter
@Setter
@ToString
public class Criteria {
	
	private int pageNum;  // 선택한 페이지 번호  
	private int amount;   // 페이지당 출력할 상품 개수
	
	
	// 검색기능에 사용할 필드
	// 목록에서 검색기능을 사용하지 않을 경우 type, keyword필드는 null이 된다.
	private String type; 	 // 검색종류
	private String keyword;  // 검색어
	
	
	// 생성자
	// 처음 이 주소(/admin/product/pro_list)를 요청 시  아래 생성자가 호출된다.
	public Criteria() {
		this(1, 10);  // 목록을 열자마자 첫번째 페이지, 10개 데이터가 보일 것
	}
	
	//this(1, 10)값이 여기로 전달
    public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

    // (Mapper XML에서 참조)
    public String[] getTypeArr() {
    	//null이면, new String[] {}: 공백의 배열 생성
    	//null이 아니면, type.split(""): 예)NC - "N","C"
    	return type == null? new String[] {} : type.split("");
    }
	
    // 검색/페이징 정보가 포함된 주소 생성
    // 예) /admin/product/pro_list?pageNum=3&amount=10&type=N&keyword=검색어
    public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
				
				return builder.toUriString();  
	}
}
