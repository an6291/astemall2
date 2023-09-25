package com.astemall.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.astemall.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {

	// email-config.xml의 mailSender bean주입
	@Setter(onMethod_ = {@Autowired})
	private JavaMailSender mailSender;
	
	@Override
	public void sendMail(EmailDTO dto, String message) {
		
		// 메일구성정보를 담당하는 객체(받는사람, 보내는사람, 전자우편주소, 본문내용)
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			// 받는사람의 메일주소 - RecipientType.TO: 받는사람, new InternetAddress(dto.getReceiverMail()): 받는사람의 메일주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
			// 보내는 사람(메일, 이름)
			// addFrom파라미터-배열, InternetAddress extends Address 확인확인
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			// 메일제목
			msg.setSubject(dto.getSubject(), "utf-8");
			// 본문내용
			msg.setText(message, "utf-8");
			
			// 메일전송
			mailSender.send(msg);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}

}




