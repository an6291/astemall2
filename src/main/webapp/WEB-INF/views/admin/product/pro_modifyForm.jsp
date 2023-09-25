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
        <small>상품수정</small>
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
              <form id="productForm" action="/admin/product/pro_modify" method="post" enctype="multipart/form-data">
                <div class="box-header">
                </div>
                <div class="box-body">	
                  <div class="form-group row">
                    <label for="firstCategory" class="col-sm-2 col-form-label">카테고리</label>
                    <!---- 1차 카테고리 ---->
                    <div class="col-sm-2">
                    <!-- /pro_list로 돌아갈 때 필요한 검색/페이징 정보 -->
                    <input type="hidden" name="pageNum" value="${cri.pageNum}">
                    <input type="hidden" name="amount" value="${cri.amount}">
                    <input type="hidden" name="type" value="${cri.type}">
                    <input type="hidden" name="keyword" value="${cri.keyword}">
                      <select name="ctgr_prt_cd" id="firstCategory" class="form-control">
                        <option>1차카테고리 선택</option>
                        <c:forEach items="${mainCategoryList }" var="category">
                          <option value="${category.ctgr_cd}" ${category.ctgr_cd == categoryVO.ctgr_cd ? 'selected':''}>${category.ctgr_name}</option>
                        </c:forEach>
                      </select>
                    </div>
                    <!---- 2차 카테고리 ---->
                    <div class="col-sm-2">					    	
                      <select name=ctgr_cd id="secondCategory" class="form-control">
                        <option>2차카테고리 선택</option>
                        <c:forEach items="${subCategoryList}" var="category">
                          <option value="${category.ctgr_cd}" ${category.ctgr_cd == productVO.ctgr_cd ? 'selected':''}>${category.ctgr_name}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  
                  <div class="form-group row">
                    <label for="prd_name" class="col-sm-2 col-form-label">상품명</label>
                    <div class="col-sm-4">
                      <!-- 상품코드 숨겨 넣음 - 상품 수정 시 사용 -->
                      <input type="hidden" class="form-control" id="prd_no" name="prd_no" value="${productVO.prd_no}">
                      <input type="text" class="form-control" id="prd_name" name="prd_name" value="${productVO.prd_name}">
                    </div>
                    <label for="prd_price" class="col-sm-2 col-form-label">상품가격</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="prd_price" name="prd_price" value="${productVO.prd_price}">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="prd_discount" class="col-sm-2 col-form-label">할인율</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="prd_discount" name="prd_discount" value="${productVO.prd_discount}">
                    </div>
                    <label for="prd_company" class="col-sm-2 col-form-label">제조사</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="prd_company" name="prd_company" value="${productVO.prd_company}">
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="uploadFile" class="col-sm-2 col-form-label">상품 이미지 업로드</label>
                    <div class="col-sm-4">
                      <!-- 관리자가 상품이미지를 변경하지 않으면 DB에 저장되어있던 업로드폴더, 이미지로 업데이트 된다. -->
                      <input type="hidden" name="prd_up_folder" value="${productVO.prd_up_folder}">
                      <input type="hidden" name="prd_img" value="${productVO.prd_img}">
                      <input type="file" class="form-control" id="uploadFile" name="uploadFile">  <!-- ProductVO 클래스의 필드에 작성 -->
                    </div>
                  </div>
                  <!-- 미리보기 이미지. 기존/변경 이미지 -->
                  <div class="form-group row">
                    <label for="current_img" class="col-sm-2 col-form-label">현재 이미지</label>
                    <div class="col-sm-4">
                      <img id="current_img" src="/admin/product/displayImage?folderName=${productVO.prd_up_folder}&fileName=${productVO.prd_img}" style="width: 200px;height: 200px;">
                    </div>
                    <label for="change_img" class="col-sm-2 col-form-label">변경 이미지</label>
                    <div class="col-sm-4">
                      <img id="change_img" style="width: 200px;height: 200px;">
                    </div>
                  </div>
                  <div class="form-group row">
                    <!-- CKEditor 적용 -->
                    <label for="prd_detail" class="col-sm-2 col-form-label">상품설명</label>
                    <div class="col-sm-10">
                      <textarea class="form-control" id="prd_detail" name="prd_detail" rows="3">${productVO.prd_detail}</textarea>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label for="prd_amount" class="col-sm-2 col-form-label">수량</label>
                    <div class="col-sm-4">
                      <input type="text" class="form-control" id="prd_amount" name="prd_amount" value="${productVO.prd_amount}">
                    </div>
                    <label for="prd_buy" class="col-sm-2 col-form-label">판매여부</label>
                    <div class="col-sm-4">
                      <select id="prd_buy" name="prd_buy">
                        <option value="Y" ${productVO.prd_buy == 'Y' ? 'selected':''}>판매가능</option>
                        <option value="N" ${productVO.prd_buy == 'N' ? 'selected':''}>판매불가능</option>
                      </select>
                    </div>
                  </div>	  
              
                </div>
                <div class="box-footer">
                  <div class="form-group">
                    <ul class="uploadedList"></ul>
                  </div>    				
                  <div class="form-group row">
                    <div class="col-sm-12 text-center">
                      <button type="submit" class="btn btn-dark">상품수정</button>
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

<!-- CKEditor 적용 -->
<script src="/bower_components/ckeditor/ckeditor.js"></script>

<script>
  $(document).ready(function(){

    // 1차카테고리 선택
    $("#firstCategory").change(function(){
      let ctgr_cd = $(this).val();
      // console.log("1차 카테고리 코드: " + ctgr_cd);

      // 2차카테고리 출력. Ajax
      let url = "/admin/product/subCategory/" + ctgr_cd + ".json";
      $.getJSON(url, function(subCategoryData){
        // console.log(subCategoryData);
        let optionStr = "";
        let secondCategory = $("#secondCategory");

        // 1차카테고리 변경에 따른 이전 상태(누적된 2차카테고리) 제거 후 -> 원래 모양으로
        secondCategory.find("option").remove();  
        secondCategory.append("<option>2차카테고리 선택</option>");

        for(let i=0; i<subCategoryData.length; i++){
          optionStr += "<option value='" + subCategoryData[i].ctgr_cd + "'>" + subCategoryData[i].ctgr_name + "</option>";
        }
        // console.log(optionStr);
        secondCategory.append(optionStr);
      });
    });

    // 업로드한 상품이미지 미리보기
    $("#uploadFile").on("change", function(e){
      let file = e.target.files[0];
      let reader = new FileReader();
      reader.onload = function(e){
        $("#change_img").attr("src", e.target.result);
      }
      reader.readAsDataURL(file);
    });

    // CKEditor ver.4.12.1(Standard) 환경설정 목적
    let ckeditor_config = {
      resize_enabled : false,
      enterMode : CKEDITOR.ENTER_BR,
      shiftEnterMode : CKEDITOR.ENTER_P,
      toolbarCanCollapse : true,
      removePlugins : "elementspath",
      // 업로드 탭 표시.
      filebrowserUploadUrl : '/admin/product/imageUpload'  
    }
    CKEDITOR.replace("prd_detail", ckeditor_config);
    console.log("버전: " + CKEDITOR.version);

  }); // jQuery ready event end
</script>
</body>
</html>