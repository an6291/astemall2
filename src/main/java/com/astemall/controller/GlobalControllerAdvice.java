package com.astemall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.astemall.domain.CategoryVO;
import com.astemall.service.ProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//각 컨트롤러 공통작업

@Log4j
@ControllerAdvice(basePackages = {"com.astemall.controller"})
public class GlobalControllerAdvice {

	@Setter(onMethod_ = {@Autowired})
	private ProductService productService;
	
	@ModelAttribute
	public void categoryList(Model model) {
		//log.info("1차카테고리 목록");
		
		List<CategoryVO> ctgrList = productService.mainCategoryList();
		model.addAttribute("ctgrList", ctgrList);
	}
}
