<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/include/header.jsp" %>
  
  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/left_sidebar.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        	상품관리
        <small>상품상세</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->


        <div class="row">
          <div class="col-md-12">
            <div class="box box-primary">
            <!-- operForm - 목록, 수정, 삭제 클릭시 사용 ----------------------------------------------------------->
	        <form id="operForm" action="/admin/product/pro_list" method="get">
	          <!-- <input type="hidden" name="prd_no" value="${productVO.prd_no }" />  -->
	          <!-- <input type="hidden" name="ctgr_cd" value="${subCategoryVO.ctgr_cd }" /> -->
	          <input type="hidden" name="pageNum" value="${cri.pageNum }" />
	          <input type="hidden" name="amount" value="${cri.amount }" />
	          <input type="hidden" name="type" value="${cri.type }" />
	          <input type="hidden" name="keyword" value="${cri.keyword }" />
              <div class="box-header">
              </div>
              <div class="box-body">	
                <div class="form-group row">
                  <label for="firstCategory" class="col-sm-2 col-form-label">카테고리</label>
                  <!---- 1차 카테고리 ---->
                  <div class="col-sm-4">
                  ${mainCategoryVO.ctgr_name}  -  ${subCategoryVO.ctgr_name}
                  </div>
                </div>
                
                <div class="form-group row">
                  <label for="prd_name" class="col-sm-2 col-form-label">상품명</label>
                  <div class="col-sm-4">
                    <!-- 상품코드 숨겨 넣음 - 상품 수정 시 사용 -->
                    <input type="hidden" class="form-control" id="prd_no" name="prd_no" value="${productVO.prd_no}">
                    ${productVO.prd_name}
                  </div>
                  <label for="prd_price" class="col-sm-2 col-form-label">상품가격</label>
                  <div class="col-sm-4">
                    ${productVO.prd_price}
                  </div>
                </div>
                <div class="form-group row">
                  <label for="prd_discount" class="col-sm-2 col-form-label">할인율</label>
                  <div class="col-sm-4">
                    ${productVO.prd_discount}
                  </div>
                  <label for="prd_company" class="col-sm-2 col-form-label">제조사</label>
                  <div class="col-sm-4">
                    ${productVO.prd_company}
                  </div>
                </div>
                <!-- 미리보기 이미지. 기존/변경 이미지 -->
                <div class="form-group row">
                  <label for="current_img" class="col-sm-2 col-form-label">상품 이미지</label>
                  <div class="col-sm-4">
                    <img id="current_img" src="/admin/product/displayImage?folderName=${productVO.prd_up_folder}&fileName=${productVO.prd_img}" style="width: 200px;height: 200px;">
                  </div>
                </div>
                <div class="form-group row">
                  <label for="prd_detail" class="col-sm-2 col-form-label">상품설명</label>
                  <div class="col-sm-10">
                    ${productVO.prd_detail}
                  </div>
                </div>
                <div class="form-group row">
                  <label for="prd_amount" class="col-sm-2 col-form-label">수량</label>
                  <div class="col-sm-4">
                    ${productVO.prd_amount}
                  </div>
                  <label for="prd_buy" class="col-sm-2 col-form-label">판매여부</label>
                  <div class="col-sm-4">
                    ${productVO.prd_buy}
                  </div>
                </div>	  
            
              </div>
              <div class="box-footer">
                <div class="form-group">
                  <ul class="uploadedList"></ul>
                </div>    				
                <div class="form-group row">
                  <div class="col-sm-12 text-center">
                    <button type="submit" id="btn_list" class="btn btn-secondary">목록</button>
                  </div>			
                </div>
              </div>
            </form>
              
            </div>
          </div>
       </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Right Control Sidebar -->
  <%@include file="/WEB-INF/views/admin/include/right_control_sidebar.jsp" %>
  
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

</body>
</html>