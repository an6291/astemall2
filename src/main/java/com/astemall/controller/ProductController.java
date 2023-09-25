package com.astemall.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.astemall.domain.CategoryVO;
import com.astemall.dto.Criteria;
import com.astemall.service.ProductService;
import com.astemall.util.FileUtils;
import com.astemall.domain.ProductVO;
import com.astemall.dto.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/product/*")
@Controller
public class ProductController {
	
	@Setter(onMethod_ = {@Autowired})
	private ProductService productService;
	
	// 업로드폴더 주입
	@Resource(name = "uploadPath") 
	private String uploadPath; 
	
	// 상단 카테고리에서 2차 카테고리 출력. Ajax
	@ResponseBody
	@GetMapping("/subCategory/{ctgr_cd}")
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("ctgr_cd") Integer ctgr_cd){
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(productService.subCategoryList(ctgr_cd), HttpStatus.OK);
		
		return entity;
	}
	
	// (2차 카테고리 정보가 포함된) 상품 목록
	@GetMapping("/pro_list/{ctgr_cd}/{ctgr_name}")
	public String pro_list(@ModelAttribute("cri") Criteria cri,
							@PathVariable("ctgr_cd") Integer ctgr_cd,
							@PathVariable("ctgr_name") String ctgr_name,
							Model model) {
		
		// 카테고리 코드, 카테고리 이름
		model.addAttribute("cat_code", ctgr_cd);
		model.addAttribute("cat_name", ctgr_name);
		
		// 상품 목록 정보
		List<ProductVO> pro_list = productService.pro_list(ctgr_cd, cri);
		
		pro_list.forEach(vo -> {
			vo.setPrd_up_folder(vo.getPrd_up_folder().replace("\\", "/"));  // 상품이미지 폴더 경로 \ -> / 변경
		});
		
		model.addAttribute("pro_list", pro_list);
		
		// 페이징 정보
		int count = productService.pro_count(ctgr_cd, cri);
		PageDTO pageDTO = new PageDTO(count, cri);
		model.addAttribute("pageMaker", pageDTO);
		
		return "/product/pro_list";
	}
	
	// 상품 이미지 (상품 목록에 사용)
	// /admin/product/displayImage?folderName=값&fileName=값
	@GetMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(String folderName, String fileName) throws IOException{
		return FileUtils.getFile(uploadPath+folderName, fileName);
	}
	
	// 상품 상세
	@GetMapping("/pro_detail")
	public void pro_detail(Integer prd_no, @ModelAttribute("cri") Criteria cri, Model model) {
		ProductVO productVO = productService.pro_detail(prd_no);
		productVO.setPrd_up_folder(productVO.getPrd_up_folder().replace("\\", "/"));  // 폴더 구분자 \ -> /로 변경
		model.addAttribute("productVO", productVO);
		
	}
}
