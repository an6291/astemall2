package com.astemall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.astemall.domain.CategoryVO;
import com.astemall.domain.ProductVO;
import com.astemall.dto.Criteria;
import com.astemall.mapper.ProductMapper;

import lombok.Setter;

@Service
public class ProductServiceImpl implements ProductService {

	@Setter(onMethod_ = {@Autowired})
	private ProductMapper productMapper;

	@Override
	public List<CategoryVO> mainCategoryList() {
		return productMapper.mainCategoryList();
	}

	@Override
	public List<CategoryVO> subCategoryList(Integer cat_code) {
		return productMapper.subCategoryList(cat_code);
	}

	@Override
	public List<ProductVO> pro_list(Integer ctgr_cd, Criteria cri) {
		return productMapper.pro_list(ctgr_cd, cri);
	}

	@Override
	public int pro_count(Integer ctgr_cd, Criteria cri) {
		return productMapper.pro_count(ctgr_cd, cri);
	}

	@Override
	public ProductVO pro_detail(Integer prd_no) {
		return productMapper.pro_detail(prd_no);
	}
}
