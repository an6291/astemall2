package com.astemall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.astemall.domain.MemberVO;
import com.astemall.domain.ReviewVO;
import com.astemall.dto.Criteria;
import com.astemall.dto.PageDTO;
import com.astemall.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review/*")
@RestController
public class ReviewController {

	@Setter(onMethod_ = {@Autowired})
	private ReviewService reviewService;
	
	// 상품 후기 목록
	@GetMapping("/list/{prd_no}/{page}")
	public ResponseEntity<Map<String, Object>> review_list(@PathVariable("prd_no") int prd_no, @PathVariable("page") int page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		
		// 상품 후기 목록 데이터
		List<ReviewVO> list = reviewService.review_list(cri, prd_no);
		map.put("list", list);
		
		// 페이징정보
		PageDTO pageDTO = new PageDTO(reviewService.review_count(prd_no), cri);
		map.put("pageMaker", pageDTO);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	// 상품 후기 쓰기(저장)
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> review_write(@RequestBody ReviewVO vo, HttpSession session){
		
		log.info("상품후기: " + vo);
		
		ResponseEntity<String> entity = null;
		
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  // 세션객체로부터 사용자 아이디 확보
		vo.setMb_id(mb_id);
		
		// 상품후기 저장(db연동)
		reviewService.review_write(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 상품 후기 수정
	@PatchMapping(value = "/edit", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> edit(@RequestBody ReviewVO vo, HttpSession session){
		ResponseEntity<String> entity = null;
		
		// 상품후기 수정반영(db연동)
		reviewService.review_edit(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	// 상품후기 삭제
	@DeleteMapping(value = "/delete/{rv_no}")
	public ResponseEntity<String> delete(@PathVariable Long rv_no){
		ResponseEntity<String> entity = null;
		
		// 상품후기 삭제반영(db연동)
		reviewService.review_delete(rv_no);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
}
