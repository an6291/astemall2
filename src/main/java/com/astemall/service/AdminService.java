package com.astemall.service;

import com.astemall.domain.AdminVO;

public interface AdminService {
	
	// 로그인
	AdminVO login(String ad_id);
	// 로그인한 시간 업데이트
	void now_visit(String ad_id);
	
}
