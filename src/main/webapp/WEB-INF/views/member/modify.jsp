<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

	  <!-- jQuery library, Popper JS, Bootstrap core CSS -->
    <%@ include file="/WEB-INF/views/include/config.jsp" %>

    <!-- Favicons 
	<link rel="apple-touch-icon" href="/docs/4.6/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
	<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
	<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
	<link rel="manifest" href="/docs/4.6/assets/img/favicons/manifest.json">
	<link rel="mask-icon" href="/docs/4.6/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
	<link rel="icon" href="/docs/4.6/assets/img/favicons/favicon.ico">
	<meta name="msapplication-config" content="/docs/4.6/assets/img/favicons/browserconfig.xml">
	-->
	<meta name="theme-color" content="#563d7c">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      body {
      min-height: 100vh;

      
    }

    .input-form {
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
    </style>
    
    <script>
		let msg = '${msg}';
		if(msg == 'failPW'){
	      alert("비밀번호를 확인하세요.");
	    }
	</script>
    
  </head>
  
  <body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <div class="container">
      <div class="input-form-backgroud row">
        <div class="input-form col-md-12 mx-auto">
          <h4 class="mb-4">회원정보 수정</h4>
          <form class="validation-form" id="modifyForm" method="post" action="/member/modify">
          			
          	<div class="row">
              <div class="col-md-12 mb-2">아이디</div>
            </div>
            <div class="row">
              <div class="col-md-12 mb-3">
                <input type="text" class="form-control" name="mb_id" id="mb_id" value="${memberVO.mb_id}" readonly>
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_pw">비밀번호</label>
                <input type="password" class="form-control" name="mb_pw" id="mb_pw">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_name">이름</label>
                <input type="text" class="form-control" name="mb_name" id="mb_name" value="${memberVO.mb_name}">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-2">우편번호</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="text" class="form-control" name="mb_zipcode" id="sample2_postcode" value="${memberVO.mb_zipcode}">
              </div>
              <div class="col-md-3 mb-3">
              	<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-secondary w-100">주소검색</button>
              </div>
            </div>
              
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="sample2_address">주소</label>
                <input type="text" class="form-control" name="mb_addr" id="sample2_address" value="${memberVO.mb_addr}">
              </div>
            </div>

            <div class="row">
              <div class="col-md-12 mb-4">
                <label for="sample2_detailAddress">상세주소</label>
                <input type="text" class="form-control" name="mb_addr_d" id="sample2_detailAddress" value="${memberVO.mb_addr_d}">
                <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_phone">연락처</label>
                <input type="text" class="form-control" name="mb_phone" id="mb_phone" value="${memberVO.mb_phone}">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-2">이메일</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="email" class="form-control" name="mb_email" id="mb_email" value="${memberVO.mb_email}">
              </div>
              <div class="col-md-3 mb-3">
                <button type="button" class="btn btn-secondary w-100" id="btn_authcode">인증코드 전송</button>
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-2">인증코드 확인</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="text" class="form-control" id="email_auth_code">
              </div>
              <div class="col-md-3 mb-3">
                <button type="button" class="btn btn-secondary w-100" id="btn_confirmAuthcode">확인</button>
              </div>
            </div>

            <hr class="mb-4">
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" name="mb_email_acpt" id="mb_email_acpt" value="${memberVO.mb_email_acpt}">
              <label class="custom-control-label" for="mb_email_acpt">이메일 수신 여부</label>
            </div>
            
            <div class="mb-4"></div>
            <button class="btn btn-primary btn-lg btn-block" id="btn_modify" type="button">수정</button>
          </form>
        </div>
      </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>
 
  </body>
  
  <!-- 우편번호 API -->
  <%@ include file="/WEB-INF/views/include/zipcode.jsp" %>

  <script>

    $(document).ready(function(){

      // 회원수정정보 전송
      $("#btn_modify").click(function(){
        let modifyForm = $("#modifyForm");
        modifyForm.submit();
      });

    });
  </script>

</html>