package com.astemall.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 메일을 보내기 위한 기본 구성 정보

@Getter
@Setter
@ToString
@AllArgsConstructor
public class EmailDTO {

	private String	senderName;		// 발신자 이름
	private	String 	senderMail;		// 발신자 메일주소
	private	String	receiverMail;	// 수신자 메일주소(회원 메일주소)
	private	String	subject;		// 제목
	private	String	message;		// 본문내용
	
	public EmailDTO() {
		this.senderName = "DocMall";
		this.senderMail = "DocMall";
		this.subject = "DocMall 회원가입 메일인증코드입니다.";
		this.message = "메일 인증을 위한 인증코드를 확인하시고, 회원가입시 인증코드 입력란에 입력하세요.";
	}
}
