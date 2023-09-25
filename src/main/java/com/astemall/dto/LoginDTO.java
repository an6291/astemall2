package com.astemall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 사용자가 입력한 id, password를 받기 위한 클래스

@Getter
@Setter
@ToString
public class LoginDTO {

	private String	mb_id;
	private	String	mb_pw;
	
}
