package com.astemall.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminVO {
	private	String	ad_id;		// 관리자 아이디
	private	String	ad_pw;		// 관리자 비밀번호
	private	Date	last_visit;	// 최근 방문일
}
