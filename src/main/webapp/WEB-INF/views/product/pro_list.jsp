<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    </style>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <%@ include file="/WEB-INF/views/include/categoryMenu.jsp" %>

  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
    <h5 class="display-4">${cat_name}</h5>
  </div>

  <div class="container">
    <div class="row">
      <div class="card-deck mb-3 text-center">
        <c:forEach items="${pro_list }" var="productVO">
          <div class="col-md-3">
            <div class="card mb-4 shadow-sm">
              <div class="card-body">
                <!-- 상품이미지 (+상품코드) -->
                <a class="move" href="${productVO.prd_no}"><img src="/product/displayImage?folderName=${productVO.prd_up_folder}&fileName=s_${productVO.prd_img}"></a>
                <!-- 상품명 (+상품코드) -->
                <h4><a class="move" href="${productVO.prd_no}">${productVO.prd_name}</a></h4>
                <!-- 상품가격 -->
                <h4><fmt:formatNumber type="currency" pattern="#,###" value="${productVO.prd_price}" /></h4>
                <button type="button" name="btn_cart" data-prd_no="${productVO.prd_no}" class="btn btn-link">장바구니</button>
                <button type="button" name="btn_direct_order" data-prd_no="${productVO.prd_no}" class="btn btn-link">바로구매</button>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
    <!------ 페이징 기능 ------>
    <div class="row">
      <div class="col-md-12">
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
        </form>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>

  <script>
    
    $(document).ready(function(){
      
      let actionForm = $("#actionForm"); // actionForm: 페이징정보가 있는 form태그

      // 상품명 or 상품이미지 클릭 (상품 상세보기)
      $("a.move").on("click", function(e){
        e.preventDefault();

        let prd_no = $(this).attr("href");  // 상품을 클릭했을 때 해당 상품코드
        // console.log("상품코드" + prd_no);

        actionForm.find("input[name='prd_no']").remove();  //상품 상세보기 -> 뒤로가기 -> actionForm에 prd_no값 남아있지 않게 삭제
        actionForm.append("<input type='hidden' name='prd_no' value='" + prd_no + "'>");  //상품 클릭 시, actionForm에 prd_no값 추가
        actionForm.attr("action", "/product/pro_detail"); 
        actionForm.submit();
      }); 

      // 페이지번호, 이전, 다음 클릭 
      $("ul.pagination a").on("click", function(e){
        e.preventDefault(); 

        actionForm.attr("action", "/product/pro_list/${cat_code}/${cat_name}"); 
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.submit();  // /product_pro_list/카테고리코드/카테고리이름?pageNum=선택한페이지번호&amount=출력건수 
      });

      // 장바구니 버튼 클릭
      $("button[name='btn_cart']").on("click", function(){
        $.ajax({
          url: '/cart/cart_add',
          type: 'post',
          data: {prd_no: $(this).data("prd_no"), cart_amount:1},
          success: function(result){
            if(result == "success"){
              alert("장바구니에 추가되었습니다.")
              if(confirm("장바구니로 이동하시겠습니까?")){
                location.href = "/cart/cart_list";
              }
            }
          }
        });
      });

      // 바로구매 버튼 클릭 - (장바구니에 상품이 담긴 후) 주문 정보 폼으로 이동
      $("button[name='btn_direct_order']").on("click", function(){
        alert("장바구니에 담겨 있는 상품도 함께 주문됩니다.\n원치 않으실 경우 장바구니를 비워주세요.")
        let url = "/cart/direct_order_cart_add?prd_no=" + $(this).data("prd_no") + "&cart_amount=1";  // 상품수량 1로 장바구니에 추가
        location.href = url;
      });

    }); // jQuery ready event END
  </script>

</body>
</html>