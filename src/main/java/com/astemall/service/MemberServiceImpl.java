package com.astemall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.MemberVO;
import com.astemall.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public String idCheck(String mb_id) {
		// TODO Auto-generated method stub
		return memberMapper.idCheck(mb_id);
	}

	@Override
	public void join(MemberVO vo) {
		// TODO Auto-generated method stub
		memberMapper.join(vo);
	}

	@Override
	public MemberVO login(String mb_id) {
		// TODO Auto-generated method stub
		return memberMapper.login(mb_id);
	}
	
	@Override
	public void now_visit(String mb_id) {
		// TODO Auto-generated method stub
		memberMapper.now_visit(mb_id);
	}

	@Override
	public void modify(MemberVO vo) {
		// TODO Auto-generated method stub
		memberMapper.modify(vo);
	}

	@Override
	public void pwchange(String mb_id, String new_mb_pw) {
		// TODO Auto-generated method stub
		memberMapper.pwchange(mb_id, new_mb_pw);
	}

	@Override
	public void delete(String mb_id) {
		// TODO Auto-generated method stub
		memberMapper.delete(mb_id);
	}
}
