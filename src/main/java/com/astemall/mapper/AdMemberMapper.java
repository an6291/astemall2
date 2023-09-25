package com.astemall.mapper;

import java.util.List;

import com.astemall.domain.MemberVO;
import com.astemall.dto.Criteria;

public interface AdMemberMapper {

	// 회원 목록
	List<MemberVO> getListWithPaging(Criteria cri);
	// 회원 수
	int getTotalCount(Criteria cri);
}
