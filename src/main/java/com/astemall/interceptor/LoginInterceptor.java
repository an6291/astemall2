package com.astemall.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.astemall.domain.MemberVO;

import lombok.extern.log4j.Log4j;

// 사용자 로그인 인증관리 인터셉터 기능

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter {@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		log.info("로그인 인증관리 인터셉터: preHandle");
		
		HttpSession session = request.getSession();  // 세션객체 정보
		
		MemberVO loginAuth = (MemberVO) session.getAttribute("loginStatus");
		
		// 로그인 인증정보가 없다면,
		if(loginAuth == null) {
			
			// ajax 요청 구분
			
		}
		
		//로그인 인증정보가 있다면, 요청한 컨트롤러의 매핑주소로 제어가 넘어간다.
		return true;
		
	}

	// ajax 요청 구분
	private boolean isAjaxRequest(HttpServletRequest request) {
		
		boolean isAjax = false;
		
		String header = request.getHeader("AJAX");  // 이름이 AJAX인 헤더의 값
		
		if(header != null && header.equals("true")) {
			isAjax = true;
			
			System.out.println("ajax요청");
		}
		
		return isAjax;
	}
	
	private void getTargetUrl(HttpServletRequest request) {
		
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		System.out.println("uri: " + uri);
		System.out.println("query: " + query);
		
		// 쿼리스트링이 존재하지 않는다면,
		if(query == null || query.equals("null")) {
			query = "";
		// 쿼리스트링이 존재한다면,
		}else {
			query = "?" + query;  // 앞에 ?를 추가
		}
		
		String targetUrl = uri + query;
		
		// 요청방식이 GET이라면,
		if(request.getMethod().equals("GET")) {
			System.out.println("dest: " + targetUrl);
			
			// 원래 요청주소를 세션에 저장
			request.getSession().setAttribute("dest", targetUrl);  // 로그인 인증처리작업에서 참조
		}
	}

}
