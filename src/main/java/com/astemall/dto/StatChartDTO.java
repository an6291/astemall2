package com.astemall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StatChartDTO {
	
	private String	categoryname;  // (1차, 2차)카테고리명
	private	String	month;		   // 월
	private	String	year;		   // 년
	private	String	sales;		   // 매출금액
}
