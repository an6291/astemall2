package com.astemall.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CategoryVO {

	private Integer	ctgr_cd;		// 2차(하위) 카테고리 코드
	private	int		ctgr_prt_cd;	// 1차(상위) 카테고리 코드
	private String	ctgr_name;		// 카테고리 이름
	
}
