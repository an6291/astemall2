<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        Page Header
        <small>Optional description</small>
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
              <div class="box-header with-border">
                <div class="form-group row">
                  <!---- 날짜 / 검색어 검색 기능 ---->
                  <div class="col-md-10">
                    <form id="searchForm" action="" method="get">
                      주문일 : <input type="date" name="startDate" value="${startDate}"> ~ <input type="date" name="endDate" value="${endDate}">
                      <select name="type">
                        <option value="" <c:out value="${pageMaker.cri.type == null? 'selected':'' }" />>-----</option>
                        <option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }" />>주문번호</option>
                        <option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected':'' }" />>주문인ID</option>
                        <option value="R" <c:out value="${pageMaker.cri.type eq 'R'? 'selected':'' }" />>수령인명</option>
                      </select>
                      <input type="text" name="keyword" placeholder="검색어를 입력하세요." value='<c:out value="${pageMaker.cri.keyword}"/>'>
                      <!-- (페이징 정보) -->
                      <input type="hidden" name="pageNum" value="1">  <!-- 처음엔 1페이지 조회 -->
                      <input type="hidden" name="amount" value="${pageMaker.cri.amount}">  <!-- Criteria 기본생성자에 의해 value="10" -->
                      <button type="button" id="btn_orderSearch" class="btn btn-success">검색</button>
                    </form>
                  </div>
                  <!---- 선택주문 버튼 ---->
                  <div class="col-md-2">
                    <button type="button" id="btn_checkedDelete" class="btn btn-primary">선택주문 삭제</button>
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
                      <th style="width: 17%">주문일시</th>
                      <th style="width: 15%">주문번호</th>
                      <th style="width: 20%">주문자/수령인</th>
                      <th style="width: 15%">주문금액</th>
                      <th style="width: 15%">결제방식</th>
                      <th colspan="2" style="width: 15%">주문관리</th>
                    </tr>
                    <!------ 데이터행 ------>
                    <c:forEach items="${order_list}" var="orderVO">
                      <tr>
                        <!-- 체크박스 (상품코드 숨김 - 선택상품 수정에 사용?) -->
                        <td><input type="checkbox" name="check" value="${orderVO.ord_no }"></td>
                        <!-- 주문일시 -->
                        <td><fmt:formatDate value="${orderVO.ord_date }" pattern="yyyy-MM-dd HH:mm"/></td>
                        <!-- 주문번호 -->
                        <td>${orderVO.ord_no }</td> 
                        <!-- 주문자/수령인 -->
                        <td>${orderVO.mb_id } / ${orderVO.ord_rcv_name }</td>
                        <!-- 주문금액 -->
                        <td><fmt:formatNumber type="currency" pattern="#,###" value="${orderVO.ord_tot_price }" /> 원</td>
                        <!-- 결제방식 -->
                        <td>${orderVO.pay_method }</td>
                        <!-- 주문관리 -->
                        <!-- 버튼에 상품코드 정보를 숨겨 넣음. 서버에 요청 작업에 필요-->
                        <td><button type="button" name="btn_orderDetail" data-ord_no="${orderVO.ord_no }" class="btn btn-link">상세보기</button></td>
                        <td><button type="button" name="btn_orderDelete" data-ord_no="${orderVO.ord_no }" class="btn btn-link">삭제</button></td>
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
                <form id="actionForm" action="/admin/order/order_list" method="get">
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

<!-- Include Handlebars from a CDN -->
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<!-- handlebars template. 주문상세내역UI -->
<script id="orderDetailView" type="text/x-handlebars-template">
  <table class="table table-bordered">
    <tbody>
      <tr>
        <td style="width: 3%"><input type="checkbox" id="checkAll"></td>
        <td style="width: 22%">이미지</td>
        <td style="width: 20%">상품명</td>
        <td style="width: 15%">판매가</td>
        <td style="width: 15%">수량</td>
        <td style="width: 15%">상품당 금액</td>
        <td style="width: 10%">비고</td>
      </tr>
      {{#each .}}
        <tr>
          <!-- 체크박스 -->
          <th style="width: 3%">
            <input type="checkbox" id="checkAll">
            <input type="hidden" name="ord_no" value="{{ord_no}}"> <!-- 주문상세-상품삭제 용도의 주문번호 숨겨넣음 -->
          </th>
          <!-- 이미지 -->
          <th style="width: 22%"><img src="{{imageView prd_up_folder prd_img}}"></th>
          <!-- 상품명 -->
          <th style="width: 20%">{{prd_name}}</th>
          <!-- 판매가 -->
          <th style="width: 15%">{{ord_price}}</th>
          <!-- 수량 -->
          <th style="width: 15%">{{ord_amount}}</th>
          <!-- 상품당 금액 -->
          <th style="width: 15%">{{prd_tot_price}}</th>
          <!-- 비고 -->
          <th style="width: 10%">
			<!-- 주문상세-상품삭제 용도의 코드 숨겨넣음 -->
            <button type="button" name="btn_orderProductDel" data-prd_no="{{prd_no}}" data-ord_price="{{ord_price}}" data-ord_amount="{{ord_amount}}" class="btn btn-link">상품삭제</button>
          </th>
        </tr>
      {{/each}}
    </tbody>
  </table>
</script>

<!-- Handlebar의 사용자정의 Helper 함수 -->
<script>
  Handlebars.registerHelper("imageView", function(folder, file) {
    let url = "/admin/order/displayImage?folderName=" + folder.replace(/\\/g, "/") + "&fileName=" + "/s_" + file;
    return url;
  });
</script>

<!-- 부트스트랩 Live Modal -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">주문 상세내역</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalDetailView">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">선택삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
  
  $(document).ready(function(){
    
    // 상세보기 버튼 클릭. Ajax
    $("button[name='btn_orderDetail']").on("click", function(){
      let ord_no = $(this).data("ord_no");  // 상품번호
      let url = "/admin/order/order_detail?ord_no=" + ord_no;
      
      $.getJSON(url, function(data){
        
        let templateObj = Handlebars.compile($("#orderDetailView").html());  // 작성한 핸들바템플릿 참조
        let orderDetailViewHtml = templateObj(data);  // 테이블과 주문상세정보가 바인딩된 결과
        
        $("#modalDetailView").empty(); // 동적 작업이기에 누적되는 데이터 제거
        $("#modalDetailView").append(orderDetailViewHtml);  // 테이블과 데이터 바인딩된 결과를 보여줄 영역에 append

        $("#orderDetailModal").modal("show"); // 완성된 modal을 보여준다.
        
      });
    });

    // 삭제 버튼 클릭.  Ajax
    $("button[name='btn_orderDelete']").on("click", function(){
      
      if(!confirm("주문을 삭제하시겠습니까?")) return;
      
      let ord_no = $(this).data("ord_no");  // 상품번호

      $.ajax({
        url: '/admin/order/order_info_delete',
        type: 'post',
        data: {ord_no:ord_no},
        dataType: 'text',
        success: function(result){
          if(result == 'success'){
            alert("주문이 삭제되었습니다.");
            location.href="/admin/order/order_list";    // 페이징 기능 적용 필요
          }
        }
      });
      
    });

    // 상세보기 - 상품삭제 클릭
    $("div#modalDetailView").on("click", "button[name='btn_orderProductDel']", function(){
      //console.log("상품삭제 클릭");
      
      if(!confirm("주문상세 상품을 삭제하시겠습니까?")) return;

      let cur_row = $(this).parent().parent()  // 해당상품의 행 미리 저장
      
      let prd_no = $(this).data("prd_no");
      let ord_no = $(this).parent().parent().find("input[name='ord_no']").val();
      let ord_price = $(this).data("ord_price");
      let ord_amount = $(this).data("ord_amount");
      
      console.log("상품번호: " + prd_no);
      console.log("주문번호: " + ord_no);
      console.log("상품금액: " + ord_price);
      console.log("주문수량: " + ord_amount);

      $.ajax({
        url: '/admin/order/order_detail_product_delete',
        type: 'post',
        data: {prd_no:prd_no, ord_no:ord_no, ord_price:ord_price, ord_amount:ord_amount},
        dataType: 'text',
        success: function(result){
          if(result == 'success'){
            alert("주문상품이 삭제되었습니다.");
            cur_row.remove(); // 해당 주문상품 행 제거
          }
        }
      });

    });

    let searchForm = $("#searchForm");
    // 검색 버튼 클릭
    // 검색을 사용하지 않는 경우 and 검색을 사용하는 경우 -> 동일한 매핑주소 /admin/order/order_list 사용
    $("#btn_orderSearch").on("click", function(){
      searchForm.attr("action", "/admin/order/order_list");
      searchForm.find("input[name='pageNum']").val(1);  // 1페이지로 이동
      searchForm.submit();
    });

    let actionForm = $("#actionForm");
    // 페이지번호, 이전, 다음 클릭 
    $("ul.pagination a").on("click", function(e){
      e.preventDefault(); 

      // 페이지번호 파라미터
      actionForm.attr("action", "/admin/order/order_list"); 
      actionForm.find("input[name='pageNum']").val($(this).attr("href"));

      // 검색 기능 사용 시, 동적 태그가 누적되지 않게 제거
      actionForm.find("input[name='startDate']").remove();
      actionForm.find("input[name='endDate']").remove();

      // 날짜검색 파라미터
      actionForm.append("<input type='hidden' name='startDate' value='${startDate}'>");
      actionForm.append("<input type='hidden' name='endDate' value='${endDate}'>");

      actionForm.submit();
    });

  }); // jQuery ready event END
</script>




</body>
</html>