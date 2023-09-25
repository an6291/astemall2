package com.astemall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.astemall.domain.AdminVO;
import com.astemall.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminService adminService;
	
	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder passwordEncoder;
	
	// 관리자 로그인 폼
	@GetMapping("")
	public String adLogin() {
		return "/admin/adLogin";
	}
	
	// 로그인
	@PostMapping("/adLogin_ok")
	public String login(AdminVO vo, HttpSession session, RedirectAttributes rttr) {
		log.info("로그인 정보: " + vo);
		
		// 로그인한 관리자 정보
		AdminVO db_vo = adminService.login(vo.getAd_id());
		
		String url = "";
		String msg = ""; 
		
		// ID중복검사
		if(db_vo != null) {
			// 관리자 정보가 존재하면, 비밀번호 검사
			if(passwordEncoder.matches(vo.getAd_pw(), db_vo.getAd_pw())) {
				// 비밀번호가 맞는 경우
				session.setAttribute("adminLoginStatus", db_vo);
				url = "admin/admin_main";  // 관리자 메인페이지로
				adminService.now_visit(db_vo.getAd_id());  // 로그인한 시간 업데이트
			}else {
				// 비밀번호가 틀린 경우
				msg = "failPW";
				url = "admin/";  // 관리자 로그인페이지로
			}
		// 관리자 정보가 존재하지 않으면, (아이디가 틀린 경우)
		}else {
			msg = "failID";
			url = "admin/";  // 관리자 로그인페이지로
		}
		rttr.addFlashAttribute("msg", msg);
		return "redirect:/" + url;
	}
	
	// 로그아웃
	@GetMapping("/adLogout")
	public String adLogout(HttpSession session) {
		session.invalidate();
		return "return:/admin/";
	}
	
	// 관리자 메인페이지
	@GetMapping("/admin_main")
	public void admin_main() {
		
	}

}
