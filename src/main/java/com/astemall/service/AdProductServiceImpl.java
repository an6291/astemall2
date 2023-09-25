package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.CategoryVO;
import com.astemall.domain.ProductVO;
import com.astemall.dto.Criteria;
import com.astemall.mapper.AdProductMapper;

import lombok.Setter;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Setter(onMethod_ = {@Autowired})
	private AdProductMapper adProductMapper;

	@Override
	public List<CategoryVO> mainCategoryList() {
		return adProductMapper.mainCategoryList();
	}

	@Override
	public List<CategoryVO> subCategoryList(Integer ctgr_cd) {
		return adProductMapper.subCategoryList(ctgr_cd);
	}

	@Override
	public void pro_insert(ProductVO vo) {
		adProductMapper.pro_insert(vo);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri, Integer ctgr_cd) {
		return adProductMapper.getListWithPaging(cri, ctgr_cd);
	}

	@Override
	public int getTotalCount(Criteria cri, Integer ctgr_cd) {
		return adProductMapper.getTotalCount(cri, ctgr_cd);
	}

	@Override
	public ProductVO pro_modifyForm(Integer prd_no) {
		return adProductMapper.pro_modifyForm(prd_no);
	}

	@Override
	public CategoryVO mainFSCategory(int ctgr_cd) {
		return adProductMapper.mainFSCategory(ctgr_cd);
	}

	@Override
	public void pro_modify(ProductVO vo) {
		adProductMapper.pro_modify(vo);
	}

	@Override
	public void pro_delete(Integer prd_no) {
		adProductMapper.pro_delete(prd_no);
	}

	@Override
	public void pro_checked_modify(List<ProductVO> prd_list) {
		adProductMapper.pro_checked_modify(prd_list);
	}

	@Override
	public void pro_checked_delete(List<Integer> prd_no_arr) {
		adProductMapper.pro_checked_delete(prd_no_arr);
	}

	@Override
	public ProductVO pro_detail(Integer prd_no) {
		return adProductMapper.pro_detail(prd_no);
	}

	@Override
	public CategoryVO subCategory(int ctgr_cd) {
		return adProductMapper.subCategory(ctgr_cd);
	}
}
