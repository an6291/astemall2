package com.astemall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.astemall.dto.Criteria;
import com.astemall.dto.PageDTO;
import com.astemall.service.AdMemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/member/*")
@Controller
public class AdMemberController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdMemberService adMemberService;
	
	// 회원 목록
	@GetMapping("/mem_list")
	public void mem_list(@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("파라미터: " + cri);
		
		// 회원 목록 데이터
		model.addAttribute("mem_list", adMemberService.getListWithPaging(cri));
	
		// 페이징 기능 데이터
		int totalCount = adMemberService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(totalCount, cri));
		
	}
	
	// 회원 상세

}
