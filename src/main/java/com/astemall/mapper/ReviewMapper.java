package com.astemall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.astemall.domain.ReviewVO;
import com.astemall.dto.Criteria;

public interface ReviewMapper {

	// 후기 목록
	List<ReviewVO> review_list(@Param("cri") Criteria cri, @Param("prd_no") int prd_no);
	// 후기 개수
	int review_count(int prd_no);
	
	// 후기 쓰기(저장)
	void review_write(ReviewVO vo);
	
	// 후기 수정
	void review_edit(ReviewVO vo);
	
	// 후기 삭제
	void review_delete(Long rv_no);
}
