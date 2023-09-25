package com.astemall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Long	rv_no; 
	private	String	mb_id; 
	private	int		prd_no; 
	private	String	rv_content; 
	private	int		rv_rating; 
	private	Date	rv_date;
	
}
