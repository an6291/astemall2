package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.ReviewVO;
import com.astemall.dto.Criteria;
import com.astemall.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper reviewMapper;

	@Override
	public List<ReviewVO> review_list(Criteria cri, int prd_no) {
		return reviewMapper.review_list(cri, prd_no);
	}

	@Override
	public int review_count(int prd_no) {
		return reviewMapper.review_count(prd_no);
	}

	@Override
	public void review_write(ReviewVO vo) {
		reviewMapper.review_write(vo);
	}

	@Override
	public void review_edit(ReviewVO vo) {
		reviewMapper.review_edit(vo);
	}

	@Override
	public void review_delete(Long rv_no) {
		reviewMapper.review_delete(rv_no);
	}
	
}
