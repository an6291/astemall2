package com.astemall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.astemall.domain.CategoryVO;
import com.astemall.domain.ProductVO;
import com.astemall.dto.Criteria;

public interface ProductMapper {

	// 1차 카테고리 출력
	List<CategoryVO> mainCategoryList();
	// 2차 카테고리 출력
	List<CategoryVO> subCategoryList(Integer ctgr_cd);
	
	// 2차 카테고리별 상품 목록
	List<ProductVO> pro_list(@Param("ctgr_cd") Integer ctgr_cd, @Param("cri") Criteria cri);
	// 상품 개수
	int pro_count(@Param("ctgr_cd") Integer ctgr_cd, @Param("cri") Criteria cri);
	
	// 상품 상세
	ProductVO pro_detail(Integer prd_no);
}
