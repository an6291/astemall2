<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
  <h5 class="my-0 mr-md-auto font-weight-normal">DocMall</h5>
  <!-- 로그인 했을 시 정보 표시 -->
  <c:if test="${sessionScope.loginStatus != null }">
  <span>${sessionScope.loginStatus.mb_name} 님</span>&nbsp;/&nbsp;
  <span>포인트 : ${sessionScope.loginStatus.mb_point} </span>&nbsp;/&nbsp;
  <span>최근접속 : 
  	<fmt:formatDate value="${sessionScope.loginStatus.last_visit}" pattern="yyyy-MM-dd HH:mm"/>
  </span>&nbsp;&nbsp;
  </c:if>
  <nav class="my-2 my-md-0 mr-md-3">
  	
  	<!-- 로그인 이전 표시 -->
  	<c:if test="${sessionScope.loginStatus == null }">  <!-- null이면 비로그인 상태 -->
    <a class="p-2 text-dark" href="/member/login">Login</a>
    <a class="p-2 text-dark" href="/member/join">Join</a>
    </c:if>
    
    <!-- 로그인 이후 표시 -->
    <c:if test="${sessionScope.loginStatus != null }">  <!-- null이 아니면 로그인 상태 -->
    <a class="p-2 text-dark" href="/member/logout">Logout</a>
    <a class="p-2 text-dark" href="/member/modify">Modify</a>
    <a class="p-2 text-dark" href="/member/mypage">Mypage</a>
    </c:if>
    
    <a class="p-2 text-dark" href="#">Order</a>
    <a class="p-2 text-dark" href="/cart/cart_list">Cart</a>
  </nav>
</div>