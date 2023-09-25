<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  <script>
    let msg = "${msg}";
    if(msg == 'modify'){
      alert("상품이 수정되었습니다.");
    }else if(msg == 'delete'){
      alert("상품이 삭제되었습니다.");
    }
  </script>
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
        <small>상품목록</small>
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
        	  <div class="box">
              <!------ 검색 기능 출력 ------>
              <div class="box-header with-border">
                <div class="form-group row">
                
                  <!---- 검색어 검색 ---->
                  <div class="col-md-4">
                    <form id="searchForm" action="/admin/product/pro_list" method="get">
                      <select name="type">
                        <option value="" <c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>-----</option>
                        <option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }" />>상품명</option>
                        <option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }" />>제조사</option>
                      </select>
                      <input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword}"/>'>
                      <!-- (페이징 정보) -->
                      <input type="hidden" name="pageNum" value="1">  <!-- 처음엔 1페이지 조회 -->
                      <input type="hidden" name="amount" value="${pageMaker.cri.amount}">  <!-- 처음엔 Criteria 기본생성자에 의해 value="10" -->
                      <button type="submit" class="btn btn-success">Search</button>
                    </form>
                  </div>
                  
                  <!---- 카테고리 검색 ---->
                  <div class="col-md-2" >
                    <select name="ctgr_prt_cd" id="firstCategory" class="form-control">
                      <option value="">1차카테고리 선택</option>
                      <c:forEach items="${categoryList}" var="category">
                        <option value="${category.ctgr_cd}">${category.ctgr_name}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="col-md-2" >
                    <select name=ctgr_cd id="secondCategory" class="form-control">
                      <option>2차카테고리 선택</option>
                    </select>
                  </div>
                  <div class="col-md-2">
                    <button type="button" id="categorySearch" class="btn btn-success">Search</button>                  
                  </div>
                  
                  <!---- 선택상품 버튼 ---->
                  <div class="col-md-2">
                    <button type="button" id="btn_checkedModify" class="btn btn-primary">선택상품 수정</button>
                    <button type="button" id="btn_checkedDelete" class="btn btn-danger">선택상품 삭제</button>
                  </div>
                </div>
              </div>
              
              <!-- /.box-header -->
              
              
              <div class="box-body">
                <table class="table table-bordered">
                  <tbody>
                    <!------ 제목행 ------>
                    <tr>
                      <th style="width: 3%"><input type="checkbox" id="checkAll"></th>
                      <th style="width: 5%">상품코드</th>
                      <th>상품명</th>
                      <th style="width: 10%">가격</th>
                      <th style="width: 10%">판매여부</th>
                      <th style="width: 15%">등록일</th>
                      <th style="width: 5%">수정</th>
                      <th style="width: 5%">삭제</th>
                    </tr>
                    <!------ 데이터행 ------>
                    <c:forEach items="${pro_list}" var="productVO">
                      <tr>
                        <!-- 체크박스 (상품코드 숨김 - 선택상품 수정에 사용) -->
                        <td><input type="checkbox" name="check" value="${productVO.prd_no }"></td>
                        <!-- 상품코드 (2차카테고리 정보 숨김 - 상품 수정에 사용) -->
                        <td>
                          <input type="hidden" name="ctgr_cd" value="${productVO.ctgr_cd }"> 
                          <c:out value="${productVO.prd_no }" />
                        </td> 
                        <!-- 상품이미지 미리보기 + 상품명 -->
                        <td>
                          <a class="move" href="${productVO.prd_no}"><img src="/admin/product/displayImage?folderName=${productVO.prd_up_folder }&fileName=s_${productVO.prd_img }" /></a>
                          <a class="move" href="${productVO.prd_no}"><c:out value="${productVO.prd_name}" /></a>
                        </td>
                        <!-- 가격 -->
                        <td>
                          <input type="text" name="prd_price" value="${productVO.prd_price}">
                        </td>
                        <!-- 판매여부 -->
                        <td>
                          <select name="prd_buy">
                            <option value="Y" ${productVO.prd_buy == 'Y' ? 'selected':''}>판매 가능</option>
                            <option value="N" ${productVO.prd_buy == 'N' ? 'selected':''}>판매 불가능</option>
                          </select>
                        </td>
                        <!-- 등록일 -->
                        <td><fmt:formatDate value="${productVO.create_date }" pattern="yyyy-MM-dd HH:mm"/></td>
                        <!-- 상품 수정/삭제 후 다시 목록으로 돌아올 때 원래 주소로 돌아와야 하므로, 버튼에 상품코드 정보를 숨겨 넣는다. -->
                        <td><button type="button" name="btn_productEdit" data-prd_no="${productVO.prd_no }" class="btn btn-primary">수정</button></td>
                        <td><button type="button" name="btn_productDelete" data-prd_no="${productVO.prd_no }" class="btn btn-danger">삭제</button></td>
                      </tr> 
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              <!-- /.box-body -->
              
              <!------ 페이징 기능 ------>
              <!-- pageMaker에는 starPage, endPage, prev, next 정보존재  -->
              <div class="box-footer clearfix">
                <ul class="pagination pagination-sm no-margin pull-right">
                  <c:if test="${pageMaker.prev }">
                    <!-- 이전 페이지 이동 -->
                    <li><a href="${pageMaker.startPage - 1}">[이전]</a></li> 
                  </c:if>
                  
                  <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
                    <!-- active: 현재 페이지에 색상을 나타낸다. -->
                    <li ${pageMaker.cri.pageNum == pageNum ? "class='active'": ""}><a href="${pageNum}">${pageNum }</a></li>
                  </c:forEach>
                  
                  <c:if test="${pageMaker.next }">
                    <!-- 다음 페이지 이동 -->
                    <li><a href="${pageMaker.endPage + 1}">[다음]</a></li> 
                  </c:if>
                </ul>
                
                <!-- 페이징 정보 -->
                <form id="actionForm" action="/admin/product/pro_list" method="get">
                  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                  <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                  <input type="hidden" name="type" value="${pageMaker.cri.type}">
                  <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>
              </div>
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
<script>
  
  $(document).ready(function(){
    
    let actionForm = $("#actionForm"); // actionForm: 페이징정보가 있는 form태그

    // 상품명 클릭 (상품 상세보기)
    $("a.move").on("click", function(e){
      e.preventDefault();

      let prd_no = $(this).attr("href");  // 상품을 클릭했을 때 해당 상품코드
      // console.log("상품코드" + prd_no);
      
      // 수정폼 화면 진입하면, 1차/2차 카테고리 정보 출력되어야 함 -> actionForm에 2차 카테고리 정보 추가
      let ctgr_cd = $(this).parent().parent().find("input[name='ctgr_cd']").val();
      actionForm.find("input[name='ctgr_cd']").remove();  //상품 상세보기 -> 뒤로가기 -> actionForm에 prd_no값 남아있지 않게 삭제
      actionForm.append("<input type='hidden' name='ctgr_cd' value='" + ctgr_cd + "'>");

      actionForm.find("input[name='prd_no']").remove();  //상품 상세보기 -> 뒤로가기 -> actionForm에 prd_no값 남아있지 않게 삭제
      actionForm.append("<input type='hidden' name='prd_no' value='" + prd_no + "'>");  //상품명 클릭 시, actionForm에 prd_no값 추가
      actionForm.attr("action", "/admin/product/pro_get"); 
      actionForm.submit();
    }); 

    // 페이지번호, 이전, 다음 클릭 
    $("ul.pagination a").on("click", function(e){
      e.preventDefault(); 

      actionForm.attr("action", "/admin/product/pro_list"); 
      actionForm.find("input[name='pageNum']").val($(this).attr("href"));
      actionForm.submit();  // /admin/product/pro_list?pageNum=선택한페이지번호&amount=출력건수 
    });

    // 수정버튼 클릭
    $("button[name='btn_productEdit']").on("click", function(){
      
      actionForm.find("input[name='prd_no']").remove();  // 상품 수정 -> 뒤로가기 -> actionForm에 prd_no값 남아있지 않게 삭제
      actionForm.find("input[name='ctgr_cd']").remove();  // 상품 수정 -> 뒤로가기 -> actionForm에 ctgr_cd값 남아있지 않게 삭제
      
      // 수정상품코드, 검색/페이징 정보 필요 -> actionForm에 수정 상품코드 추가
      actionForm.append("<input type='hidden' name='prd_no' value='" + $(this).data("prd_no") + "'>");

      // 수정폼 화면 진입하면, 1차/2차 카테고리 정보 출력되어야 함 -> actionForm에 2차 카테고리 정보 추가
      let ctgr_cd = $(this).parent().parent().find("input[name='ctgr_cd']").val();
      actionForm.append("<input type='hidden' name='ctgr_cd' value='" + ctgr_cd + "'>");

      actionForm.attr("method", "get");
      actionForm.attr("action", "/admin/product/pro_modifyForm");
      
      actionForm.submit(); 
    });

    // 삭제버튼 클릭
    $("button[name='btn_productDelete']").on("click", function(){
      
      if(!confirm("상품을 삭제하겠습니까?")) return;
      
      //actionForm에 삭제 상품코드 추가
      actionForm.append("<input type='hidden' name='prd_no' value='" + $(this).data("prd_no") + "'>"); 

      actionForm.attr("method", "post");
      actionForm.attr("action", "/admin/product/pro_delete");
      actionForm.submit(); 
    });

    /*** 체크박스 ***/
    let isCheck = true;

    // 제목행 체크박스 선택
    $("#checkAll").on("click", function(){
      // 데이터행 체크박스 모두 선택
      $("input[name='check']").prop("checked", this.checked);
      isCheck = this.checked
    });

    // 데이터행 체크박스 선택
    $("input[name='check']").on("click",function(){
      // 제목행 체크박스에 영향
      $("#checkAll").prop("checked", this.checked);
      // 데이터행의 체크박스 상태 확인
      $("input[name='check']").each(function(){  // (반복 작업)
        // 하나라도 체크되어있지않으면, 제목행 체크박스 해제
        if(!$(this).is(":checked")){
          $("#checkAll").prop("checked", false);
        }
      });  
    });  
    /*** 체크박스 end***/

    // 선택상품 수정
    $("#btn_checkedModify").on("click", function(){
      // 체크박스가 하나도 체크되어있지않으면, 알림창
      if($("input[name='check']:checked").length == 0){
        alert("수정할 상품을 선택하세요.");
        return;
      }

      if(!confirm("수정하시겠습니까?")) return;

      let prd_no_arr = [];    // 수정상품코드 배열
      let prd_price_arr = [];  // 수정상품가격 배열
      let prd_buy_arr = [];    // 판매여부 배열
      
      //체크된 상품들 정보 확보
      $("input[name='check']:checked").each(function(){
        prd_no_arr.push($(this).val());
        prd_price_arr.push($(this).parent().parent().find("input[name='prd_price']").val());
        prd_buy_arr.push($(this).parent().parent().find("select[name='prd_buy']").val());
      });
      /*
      console.log("수정상품코드: " + prd_no_arr);
      console.log("수정상품가격: " + prd_price_arr);
      console.log("수정상품판매여부: " + prd_buy_arr);
      */

      $.ajax({
        url: '/admin/product/pro_checked_modify',
        type: 'post',
        data: {prd_no_arr:prd_no_arr, prd_price_arr:prd_price_arr, prd_buy_arr:prd_buy_arr},
        dataType: 'text',
        success: function(result){
          // 수정 성공시, 상품 목록으로 이동
          if(result == 'success'){
            alert("선택상품이 수정되었습니다.")
            actionForm.attr("method", "get");
            actionForm.attr("action", "/admin/product/pro_list");
            actionForm.submit();
          }
        }
      });
    });

    // 선택상품 삭제
    $("#btn_checkedDelete").on("click", function(){
      // 체크박스가 하나도 체크되어있지않으면, 알림창
      if($("input[name='check']:checked").length == 0){
        alert("삭제할 상품을 선택하세요.");
        return;
      }

      if(!confirm("삭제하시겠습니까?")) return;

      let prd_no_arr = [];    // 삭제상품코드 배열
      
      //체크된 상품들 코드 확보
      $("input[name='check']:checked").each(function(){
        prd_no_arr.push($(this).val());
      });
      //console.log("삭제상품코드: " + prd_no_arr);

      $.ajax({
        url: '/admin/product/pro_checked_delete',
        type: 'post',
        data: {prd_no_arr:prd_no_arr},
        dataType: 'text',
        success: function(result){
          // 삭제 성공시, 상품 목록으로 이동
          if(result == 'success'){
            alert("선택상품이 삭제되었습니다.")
            actionForm.attr("method", "get");
            actionForm.attr("action", "/admin/product/pro_list");
            actionForm.submit();
          }
        }
      });
    });

    // 카테고리 검색 - 1차카테고리 선택
    $("#firstCategory").change(function(){
      let ctgr_cd = $(this).val();
      // console.log("1차 카테고리 코드: " + ctgr_cd);

      // (1차카테고리 선택에 따른) 2차카테고리 출력. Ajax
      let url = "/admin/product/subCategory/" + ctgr_cd + ".json";
      $.getJSON(url, function(subCategoryData){
        // console.log(subCategoryData);
        let optionStr = "";
        let secondCategory = $("#secondCategory");

        // 1차카테고리 변경에 따른 이전 상태(누적된 2차카테고리) 제거 후 -> 원래 모양으로
        secondCategory.find("option").remove();  
        secondCategory.append("<option value=''>2차카테고리 선택</option>");

        for(let i=0; i<subCategoryData.length; i++){
          optionStr += "<option value='" + subCategoryData[i].ctgr_cd + "'>" + subCategoryData[i].ctgr_name + "</option>";
        }
        // console.log(optionStr);
        secondCategory.append(optionStr);
      });
    });

    // 카테고리 검색 - 검색 버튼 클릭
    $("#categorySearch").on("click", function(){
      actionForm.attr("action", "/admin/product/pro_list");
      actionForm.append("<input type='hidden' name='ctgr_cd' value='" + $("#secondCategory").val() + "'>");
      actionForm.submit();
      // 참고) "/pro_list" 주소로 이동 -> 검색어 검색 기능 사용 후, 카테고리 검색 시 검색 파라미터 초기화 작업해두었기에 주소에 검색어 관련 파라미터가 있어도 무시됨
    });

  }); // jQuery ready event END
</script>
</body>
</html>