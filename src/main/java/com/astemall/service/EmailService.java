package com.astemall.service;

import com.astemall.dto.EmailDTO;

public interface EmailService {

	void sendMail(EmailDTO dto, String message);
}
