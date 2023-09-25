package com.astemall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.astemall.dto.EmailDTO;
import com.astemall.service.EmailService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/email/*")
public class EmailController {

	@Setter(onMethod_ = {@Autowired})
	private EmailService emailService;
	
	// 메일인증코드 요청
	@GetMapping("/send")
	public ResponseEntity<String> send(EmailDTO dto, HttpSession session){ 
		
		log.info("메일정보: " + dto);
		
		ResponseEntity<String> entity = null;
		
		// 6자리 인증코드 생성
		String authCode = "";
		for(int i=0; i<6; i++) { 
			authCode += String.valueOf((int)(Math.random() * 10));
		}
		
		log.info("인증코드: " + authCode);
		
		session.setAttribute("authCode", authCode);  // 사용자에게 발급해준 인증코드를 세션형태로 저장
		
		// 인증코드 메일발송
		try {
			emailService.sendMail(dto, authCode);
			entity = new ResponseEntity<String>("success", HttpStatus.OK); 
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	// 인증코드 확인
	@GetMapping("/confirmAuthcode")
	public ResponseEntity<String> confirmAuthCode(String authCode, HttpSession session){
		ResponseEntity<String> entity = null;
		
		// 사용자에게 발급한 인증코드와 사용자가 입력한 인증코드 비교 작업
		String confirm_authCode = (String) session.getAttribute("authCode");  // 사용자에게 발급한 인증코드
		if(authCode.equals(confirm_authCode)) {
			// 인증코드 일치 시
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			session.removeAttribute("authCode");  // 서버측의 메모리상에서 인증코드 제거
		}else {
			// 인증코드 불일치 시
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		return entity;
	}
	
}
