<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <h5 class="display-4">장바구니</h5>
</div>

<div class="container">
  <div class="row">
    <div class="col-md-12">
      <div class="box">            
        <div class="box-body">
          <table class="table table-bordered">
            <tbody>
              <!------ 제목행 ------>
              <tr>
                <th style="width: 45%">상품정보</th>
                <th style="width: 10%">수량</th>
                <th style="width: 10%">상품구매금액</th>
                <th style="width: 10%">할인금액</th>
                <th style="width: 10%">배송구분</th>
                <th style="width: 10%">배송비</th>
                <th style="width: 5%">삭제</th>
              </tr>
              <!------ 데이터행 ------>
              <c:forEach items="${cart_list}" var="cartListDTO">
                <tr>
                  <!-- 상품정보 : 상품이미지 미리보기 + 상품명 -->
                  <td>
                    <a class="move" href="${cartListDTO.prd_no}"><img src="/admin/product/displayImage?folderName=${cartListDTO.prd_up_folder }&fileName=s_${cartListDTO.prd_img }" /></a>
                    <a class="move" href="${cartListDTO.prd_no}"><c:out value="${cartListDTO.prd_name}" /></a>
                    <input type="hidden" name="cart_no" value="${cartListDTO.cart_no}"> <!-- 장바구니 번호 --> 
                  </td>
                  <!-- 수량 -->
                  <td>
                    <input type="text" style="width: 100px;" name="cart_amount" value="${cartListDTO.cart_amount}">
                    <button type="button" name="btn_cart_amount_change" class="btn btn-link">수량변경</button>
                  </td>
                  <!-- 상품구매금액 -->
                  <td><input type="text" style="width: 120px;" name="unitprice" value="${cartListDTO.unitprice}" readonly></td>
                  <!-- 할인금액 -->
                  <td>-</td>
                  <!-- 배송구분 -->
                  <td>기본배송</td>
                  <!-- 배송비 -->
                  <td>00원<br> 조건</td>
                  <!-- 삭제 -->
                  <td><button type="button" name="btn_cart_del" class="btn btn-link">삭제</button></td>
                </tr> 
              </c:forEach>
            </tbody>
            <c:if test="${!empty cart_list}">
              <tfoot>
                <td colspan="6" class="text-right">총 구매금액: <fmt:formatNumber type="currency" pattern="#,###" value="${cart_tot_price}" /> 원</td>
              </tfoot>
            </c:if>
            <c:if test="${empty cart_list}">
              <tfoot>
                <td colspan="6" class="text-center">[ 장바구니가 비었습니다.]</td>
              </tfoot>
            </c:if>
          </table>
        </div>
        <!-- /.box-body -->
      </div>
    </div>
  </div>
  
  <div class="row">
    <div class="col-md-12 text-center">
      <button type="button" id="btn_cart_empty" class="btn btn-light">장바구니 비우기</button>
      <button type="button" class="btn btn-light">계속 쇼핑하기</button>
      <button type="button" id="btn_order" class="btn btn-dark">주문하기</button>
    </div>
  </div>
  
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<script>
  
  $(document).ready(function(){

    // 장바구니 수량변경 클릭
    $("button[name='btn_cart_amount_change']").on("click", function(){
      // 장바구니 코드
      let cart_no = $(this).parent().parent().find("input[name='cart_no']").val();
      // 변경 수량
      let cart_amount_changed = $(this).parent().find("input[name='cart_amount']").val();

      $.ajax({
        url: '/cart/cart_amount_change',
        type: 'post',
        data: {cart_no:cart_no, cart_amount:cart_amount_changed},
        dataType: 'text',
        success: function(result){
          alert("장바구니 상품 수량이 변경되었습니다.");
          location.href = "/cart/cart_list";
        }
      });
    });

    // 상품 우측끝 삭제버튼 클릭 (개별 삭제)
    $("button[name='btn_cart_del']").on("click", function(){
      if(!confirm("해당 상품을 삭제하시겠습니까?")) return;

      // 장바구니 코드
      let cart_no = $(this).parent().parent().find("input[name='cart_no']").val();

      $.ajax({
        url: '/cart/cart_delete',
        type: 'post',
        data: {cart_no:cart_no},
        dataType: 'text',
        success: function(result){
          if(result == "success"){
            alert("장바구니 상품이 삭제되었습니다.");
            location.href = '/cart/cart_list';
          }
        }
      });

    });

    // 장바구니 비우기 클릭 (전체 삭제)
    $("#btn_cart_empty").on("click", function(){
      if(!confirm("장바구니를 비우시겠습니까?")) return;
      location.href = '/cart/cart_empty';
    });
    
    // 주문하기 클릭
    $("#btn_order").on("click", function(){
    	location.href = "/order/order_info";
    });

  }); // jQuery ready event END
</script>

  </body>
</html>