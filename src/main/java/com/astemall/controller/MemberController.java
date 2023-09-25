package com.astemall.controller;

import java.nio.channels.SeekableByteChannel;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.astemall.domain.MemberVO;
import com.astemall.dto.LoginDTO;
import com.astemall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Setter(onMethod_ = {@Autowired})
	private MemberService memberService;
	
	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder passwordEncoder;
	
	
	// ID중복체크. Ajax
	@ResponseBody
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(String mb_id){
		
		log.info("아이디: " + mb_id);
		ResponseEntity<String> entity = null;
		String isUse = "";
		// ID 중복체크 작업
		if(memberService.idCheck(mb_id) != null) {
			isUse = "no";
		}else {
			isUse = "yes";
		}
		entity = new ResponseEntity<String>(isUse, HttpStatus.OK);
		
		return entity;
	}
	
	// 회원가입 폼
	@GetMapping("/join")
	public void join() {
		log.info("회원가입 폼");
	}
	
	// 회원가입(회원정보 저장)
	@PostMapping("/join")
	public String join(MemberVO vo) {
		
		log.info("회원정보: " + vo);  // 암호화되지 않은 평문텍스트 비밀번호 존재
		
		// 평문 텍스트인 비밀번호를 스프링시큐리티 암호화클래스를 이용하여, 암호화
		vo.setMb_pw(passwordEncoder.encode(vo.getMb_pw()));
		log.info("회원정보: " + vo);  // 암호화된 비밀번호 존재
				
		memberService.join(vo);
		return "redirect:/member/login";
	}

	// 로그인 폼
	@GetMapping("/login")
	public void login() {
		log.info("로그인 폼");
	}
	
	// 로그인
	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr) {
		
		log.info("로그인 정보: " + dto);
		
		// 로그인 검사
		MemberVO vo = memberService.login(dto.getMb_id());
		String url = "";  // 이동할 페이지 경로
		String msg = "";  // 메세지
		
		// vo가 null이 아니면, 사용자가 입력한 아이디가 존재 -> 존재하는 것을 확인한 후에 비밀번호 검사
		if(vo != null) { 
			if(passwordEncoder.matches(dto.getMb_pw(), vo.getMb_pw())) {
				session.setAttribute("loginStatus", vo);  // 로그인한 사용자의 회원정보가 세션형태로 저장
				memberService.now_visit(dto.getMb_id());  // 로그인 시간 업데이트
				
				// (비밀번호가 맞는 경우) 강제로 로그인페이지로 이동하기 이전의 매핑주소와 정보 존재 유무 확인 - 인터셉터 기능
				String targetUrl = (String) session.getAttribute("dest");
				url = (targetUrl != null) ? targetUrl : "/";  // targetUrl이 존재-targetUrl로 이동 / null이면-메인페이지로 이동
				
				// 세션제거 
				if(targetUrl != null) {
					session.removeAttribute("dest");
				}
				
			}else {
				url = "/member/login";  // 비밀번호가 틀린 경우 -> 로그인 페이지로
				msg = "failPW";
			}
		}else {
			url = "/member/login";  // 아이디가 틀린 경우 -> 로그인 페이지로
			msg = "failID";
		}
		
		rttr.addFlashAttribute("msg", msg);
		return "redirect:" + url;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();  // 사용자 세션관련정보가 모두 소멸
		return "redirect:/";
	}	
	
	// 회원정보 수정 폼, 마이페이지 폼
	@GetMapping(value = {"/modify", "/mypage"})
	public void modify(Model model, HttpSession session) { 
		
		// 수정 전 비밀번호 확인 과정
		// 세션객체로부터 사용자 아이디 확보
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();
		model.addAttribute("memberVO", memberService.login(mb_id));  //memberService.login()메소드 재활용
	}
	
	// 수정정보 저장
	@PostMapping("/modify")
	public String modify(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		String url = "";
		String msg = "";
		
		// 수정 전, 비밀번호 확인 작업
		// 로그인한 회원 아이디
		String mb_id = ((MemberVO) session.getAttribute("loginStatus")).getMb_id();  
		// db에 저장된 암호화된 비밀번호
		String db_mb_pw = ((MemberVO)memberService.login(mb_id)).getMb_pw();
		if(passwordEncoder.matches(vo.getMb_pw(), db_mb_pw)) {
			//일치하면, 회원정보 수정
			memberService.modify(vo);
			msg = "modify";
			url = "/";
		}else {
			//일치하지 않으면, 수정페이지로
			msg = "failPW";
			url = "/member/modify";
		}
		log.info("수정 정보:" + vo);
		
		rttr.addFlashAttribute("msg", msg);  //addFlashAttribute로 전달한 값은 url뒤에 붙지 않는다.
		return "redirect:" + url;
	}
	
	// 비밀번호 변경. Ajax
	@ResponseBody
	@PostMapping("/pwchange")
	public ResponseEntity<String> pwchange(String old_mb_pw, String new_mb_pw, HttpSession session){
		
		ResponseEntity<String> entity = null;
		String body = "";
		
		log.info("기존비밀번호: " + old_mb_pw);
		log.info("신규비밀번호: " + new_mb_pw);
		
		// 로그인한 회원 정보
		MemberVO vo = (MemberVO)session.getAttribute("loginStatus");
		// 로그인한 회원 아이디
		String mb_id = vo.getMb_id();
		// DB의 암호화된 비밀번호
		String db_mb_pw = memberService.login(mb_id).getMb_pw();
		
		// 사용자가 입력한 기존 비밀번호가 맞는지 확인 작업 -> 비밀번호 수정 반영
		if(passwordEncoder.matches(old_mb_pw, db_mb_pw)) {
			// 일치하면, 신규 비밀번호 암호화 
			String enc_mb_pw = passwordEncoder.encode(new_mb_pw);
			// 비밀번호 수정 반영
			memberService.pwchange(mb_id, enc_mb_pw);
			body = "success";
		}else {
			// 일치하지 않으면,
			body = "failPW";
		}
		entity = new ResponseEntity<String>(body, HttpStatus.OK);
		
		return entity;
	}
	
	// 회원탈퇴. Ajax
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> delete(String mb_pw, HttpSession session){
		ResponseEntity<String> entity = null;
		String body = "";
		
		// 로그인한 회원 아이디
		String mb_id = ((MemberVO)session.getAttribute("loginStatus")).getMb_id();
		// DB의 암호화된 비밀번호
		String db_mb_pw = memberService.login(mb_id).getMb_pw();
		
		// 사용자가 입력한 기존 비밀번호가 맞는지 확인 작업 -> 회원 탈퇴
		if(passwordEncoder.matches(mb_pw, db_mb_pw)) {;
			// 일치하면, 회원탈퇴
			memberService.delete(mb_id);
			session.invalidate();
			body = "success";
		}else {
			body = "failPW";
		}
		entity = new ResponseEntity<String>(body, HttpStatus.OK);
		return entity;
	}
	
	
}
