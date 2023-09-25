package com.astemall.service;

import org.apache.ibatis.annotations.Param;

import com.astemall.domain.MemberVO;

public interface MemberService {

	// ID 중복체크
	String idCheck(String mb_id);
	
	// 회원정보 저장
	void join(MemberVO vo);
	
	// 로그인, 회원수정 폼
	MemberVO login(String mb_id);
	
	// 로그인한 시간 업데이트
	void now_visit(String mb_id);
	
	// 회원정보 수정
	void modify(MemberVO vo);
	
	// 비밀번호 수정
	void pwchange(@Param("mb_id") String mb_id, @Param("new_mb_pw") String new_mb_pw);
	
	// 회원탈퇴
	void delete(String mb_id);
}
