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
  </head>
  
  <body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <div class="container">
      <div class="input-form-backgroud row">
        <div class="input-form col-md-12 mx-auto">
          <h4 class="mb-4">회원가입</h4>
          <form class="validation-form" id="joinForm" method="post" action="/member/join">
          			
          	<div class="row">
              <div class="col-md-12 mb-2">아이디</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="text" class="form-control" name="mb_id" id="mb_id" placeholder="아이디 8~15자 이내 입력">
              </div>
              <div class="col-md-3 mb-3">
                <button type="button" class="btn btn-secondary w-100" id="btn_IdCheck">중복 확인</button>
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_pw">비밀번호</label>
                <input type="password" class="form-control" name="mb_pw" id="mb_pw" placeholder="비밀번호 입력">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_pwCheck">비밀번호 확인</label>
                <input type="password" class="form-control" id="mb_pwCheck">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_name">이름</label>
                <input type="text" class="form-control" name="mb_name" id="mb_name">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-2">우편번호</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="text" class="form-control" name="mb_zipcode" id="sample2_postcode">
              </div>
              <div class="col-md-3 mb-3">
              	<button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-secondary w-100">주소검색</button>
              </div>
            </div>
              
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="sample2_address">주소</label>
                <input type="text" class="form-control" name="mb_addr" id="sample2_address">
              </div>
            </div>

            <div class="row">
              <div class="col-md-12 mb-4">
                <label for="sample2_detailAddress">상세주소</label>
                <input type="text" class="form-control" name="mb_addr_d" id="sample2_detailAddress">
                <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-3">
                <label for="mb_phone">연락처</label>
                <input type="text" class="form-control" name="mb_phone" id="mb_phone">
              </div>
            </div>
            
            <div class="row">
              <div class="col-md-12 mb-2">이메일</div>
            </div>
            <div class="row">
              <div class="col-md-9 mb-3">
                <input type="email" class="form-control" name="mb_email" id="mb_email" placeholder="email@example.com">
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
              <input type="checkbox" class="custom-control-input" name="mb_email_acpt" id="mb_email_acpt">
              <label class="custom-control-label" for="mb_email_acpt">이메일 수신 여부</label>
            </div>
            
            <div class="mb-4"></div>
            <button class="btn btn-primary btn-lg btn-block" id="btn_join" type="button">가입하기</button>
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
      let idCheck = false;     // 아이디 사용가능 여부
      let isAuthcode = false;  // 인증코드 확인성공 여부

      /* ID중복체크 */
      $("#btn_IdCheck").click(function(){

        // ID 입력하지 않았을 시
        if($("#mb_id").val() == ""){
          alert("아이디를 입력하세요.");
          $("#mb_id").focus();
          return;
        }

        $.ajax({
          url: '/member/idCheck',
          type: 'get',
          dataType: 'text',
          data: {mb_id : $("#mb_id").val()},
          success: function(result){

            if(result == "yes"){
              alert("아이디 사용 가능");
              idCheck = true;
            }else{
              alert("아이디 사용 불가능");
              $("#mb_id").val("");
              $("#mb_id").focus();
            }
            //alert(result);
          }
        });
      });
      
      /* 메일인증코드 전송 */
      $("#btn_authcode").click(function(){
        
        // 메일 입력하지 않았을 시
        if($("#mb_email").val() == ""){
          alert("메일주소를 입력하세요.");
          $("#mb_email").focus();
          return;
        }

        $.ajax({
          url: '/email/send',
          type: 'get',
          dataType: 'text',
          data: {receiverMail : $("#mb_email").val() },
          //receiverMail
          success : function(result){
            if(result == "success") {
              alert("인증메일이 발송되었습니다. 메일을 확인해주세요.");
            }
          }
        });
      });

      /* 메일인증코드 확인 */
      $("#btn_confirmAuthcode").click(function(){
        
        // 인증코드 입력하지 않았을 시
        if($("#email_auth_code").val() == ""){
          alert("인증코드를 입력하세요.");
          $("#email_auth_code").focus();
          return;
        }

        $.ajax({
          url: '/email/confirmAuthcode',
          type: 'get',
          dataType: 'text',
          data: {authCode : $("#email_auth_code").val() },
          success : function(result){
            if(result == "success") {
              alert("인증코드가 확인되었습니다.");
              isAuthcode = true;
            }else if(result == "fail"){
              alert("인증코드가 다릅니다. 인증코드 요청을 다시 해주세요.");
            }
          }
        });
      }); 

      /* 회원가입 */
      $("#btn_join").click(function(){
        let joinForm = $("#joinForm");

        // 자바스크립트 유효성검사 코드작업

        joinForm.submit();
      });

    });
  </script>

</html>