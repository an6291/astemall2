package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.MemberVO;
import com.astemall.dto.Criteria;
import com.astemall.mapper.AdMemberMapper;

import lombok.Setter;

@Service
public class AdMemberServiceImpl implements AdMemberService {

	@Setter(onMethod_ = {@Autowired})
	private AdMemberMapper adMemberMapper;

	@Override
	public List<MemberVO> getListWithPaging(Criteria cri) {
		return adMemberMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return adMemberMapper.getTotalCount(cri);
	}
	
}
