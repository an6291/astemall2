package com.astemall.service;

import java.util.List;

import com.astemall.domain.CategoryVO;
import com.astemall.domain.ProductVO;
import com.astemall.dto.Criteria;

public interface AdProductService {

	// 1차 카테고리 출력
	List<CategoryVO> mainCategoryList();
	// 2차 카테고리 출력
	List<CategoryVO> subCategoryList(Integer ctgr_cd);
	
	// 상품 등록
	void pro_insert(ProductVO vo);
	
	// 상품 목록
	// 페이징기능 1)
	List<ProductVO> getListWithPaging(Criteria cri, Integer ctgr_cd); 
	// 페이징기능 2)
	int getTotalCount(Criteria cri, Integer ctgr_cd);  // 검색조건에 따른 상품 수 구하기
	
	// 상품 수정 폼
	ProductVO pro_modifyForm(Integer prd_no);
	// (2차 카테고리를 가지고 상위 카테고리인) 1차 카테고리 출력
	CategoryVO mainFSCategory(int ctgr_cd);
	
	// 상품 수정
	void pro_modify(ProductVO vo);
	// 선택상품 수정
	void pro_checked_modify(List<ProductVO> prd_list);
		
	// 상품 삭제
	void pro_delete(Integer prd_no);
	// 선택상품 삭제
	void pro_checked_delete(List<Integer> prd_no_arr);
	
	// 상품 상세
	ProductVO pro_detail(Integer prd_no);
	// 2차 카테고리명 출력
	CategoryVO subCategory(int ctgr_cd);
}
