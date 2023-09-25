package com.astemall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.AdminVO;
import com.astemall.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = {@Autowired})
	private AdminMapper adminMapper;

	@Override
	public AdminVO login(String ad_id) {
		// TODO Auto-generated method stub
		return adminMapper.login(ad_id);
	}

	@Override
	public void now_visit(String ad_id) {
		// TODO Auto-generated method stub
		adminMapper.now_visit(ad_id);
	}
	
}
