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
    /* 아래코드 주석 후 이 코드를 주석해제하면, alert창이 먼저 뜬다.
    let msg = '${msg}';
    if(msg == 'failID'){
      alert("아이디 확인바람");
    }else if(msg == 'failPW'){
      alert("비밀번호 확인바람");
    }
    */
    
    // read event: html태그를 모두 읽은 뒤 동작
    $(document).ready(function(){
      let msg = '${msg}';
      if(msg == 'failID'){
        alert("아이디를 확인해주세요.");
        $("#mb_id").focus();
      }else if(msg == 'failPW'){
        alert("비밀번호를 확인해주세요.");
        $("#mb_pw").focus();
      }
    });
    
	</script>
    
    
  </head>
  <body>
    
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">로그인</h4>
        <div class="box box-info">
          <div class="box-header with-border">
            <h3 class="box-title"></h3>
          </div>
          <!-- /.box-header -->
          <!-- form start -->
          <form class="form-horizontal" method="post" action="/member/login">
            <div class="box-body">
              <div class="form-group">
                <label for="mb_id" class="col-sm-2 control-label">ID</label>
                <div class="col-sm-12">
                  <input type="text" class="form-control" name="mb_id" id="mb_id" placeholder="아이디 입력">
                </div>
              </div>
              <div class="form-group">
                <label for="mb_password" class="col-sm-2 control-label">Password</label>
                <div class="col-sm-12">
                  <input type="password" class="form-control" name="mb_pw" id="mb_pw" placeholder="비밀번호 입력">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-12">
                  <div class="find_button float-right">
                    <button type="button" class="btn btn-link">ID찾기</button>
                    <button type="button" class="btn btn-link">PW찾기</button>
                    <button type="submit" class="btn btn-info pull-right">로그인</button>
                  </div>
                </div>
              </div>
            </div>
            <!-- /.box-body -->
            <!-- /.box-footer -->
          </form>
        </div>
      </div>
    </div>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>


</html>