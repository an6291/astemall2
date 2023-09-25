<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <h4 class="display-4">주문하기</h4>
  </div>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <form id="" method="post" action="/order/order_info">
          <div class="input-form col-md-12 mx-auto">
            <h4 class="mb-3">주문자정보</h4> <!-- DB 저장 용도 x, 사용자 정보 읽어옴 -->
            <div class="row border-top pt-3">
              <div class="col-md-2">
                <label for="mb_name">이름</label>
              </div>
              <div class="col-md-10">
                ${memberVO.mb_name}
              </div>
            </div>
            <div class="row pt-3">
              <div class="col-md-2">
                <label for="mb_email">이메일</label>
              </div>
              <div class="col-md-10">
                <input type="text" class="form-control" name="mb_email" id="mb_email" value="${memberVO.mb_email}">
              </div>
            </div>
            <div class="row pt-3">
              <div class="col-md-2">
                <label for="mb_phone">연락처</label>
              </div>
              <div class="col-md-10">
                <input type="text" class="form-control" name="mb_phone" id="mb_phone" value="${memberVO.mb_phone}">
              </div>
            </div>

            <h4 class="mb-3 mt-3">배송정보<span><input type="checkbox" id="">위 정보와 같음</span></h4>  <!-- DB 저장 용도 -->
            <div class="row border-top pt-3">
              <div class="col-md-2">
                <label for="ord_rcv_name">이름</label>
              </div>
              <div class="col-md-10">
                <input type="hidden" id="order_productName" value="${order_productName }"> <!-- 주문상품명 숨겨넣음 (카카오페이 API 서버 전달용) -->
                <input type="text" class="form-control" name="ord_rcv_name" id="ord_rcv_name">
              </div>
            </div>
            <div class="row pt-3">
              <div class="col-md-2">
                <label for="ord_rcv_phone">연락처</label>
              </div>
              <div class="col-md-10">
                <input type="text" class="form-control" name="ord_rcv_phone" id="ord_rcv_phone">
              </div>
            </div>
            <div class="row pt-3">
              <div class="col-md-2">
                <label for="sample2_postcode">주소</label>
              </div>
              <div class="col-md-10">
                <input type="text" class="form-control" name="ord_rcv_zipcode" id="sample2_postcode">
                <button type="button" onclick="sample2_execDaumPostcode()" class="btn btn-primary">우편번호 찾기</button>
                <input type="text" class="form-control" name="ord_rcv_addr" id="sample2_address" placeholder="서울특별시 강남구">
                <input type="text" class="form-control" name="ord_rcv_addr_d" id="sample2_detailAddress" placeholder="상세주소를 입력해주세요.">
              <input type="hidden" id="sample2_extraAddress" placeholder="참고항목">	
              </div>
            </div>
            
            <div class="row pt-3">
              <div class="col-md-2">
                <label>결제방법</label>
              </div>
              <div class="col-md-10">
                <select name="pay_method" id="pay_method" class="custom-select w-40">
                  <option value="">결제방법을 선택하세요.</option>
                  <option value="무통장입금">무통장입금</option>
                  <option value="카카오페이">카카오페이</option>
                </select>
                <select name="pay_bank" id="pay_bank" class="custom-select w-40" style="display: none;">
                  <option value="">입금은행을 선택하세요.</option>
                  <option value="국민은행 111111111111">국민은행</option>
                  <option value="하나은행 222222222222">하나은행</option>
                </select>
                <p id="pay_user_vw" style="display: none;">입금자명 : <input type="text" class="form-control" name="pay_user" id="pay_user"></p>
              </div>
            </div>
                      
            <hr class="mb-4">
            <div class="custom-control custom-checkbox">
              <input type="checkbox" class="custom-control-input" name="mbsp_receive" id="mbsp_receive">
              <label class="custom-control-label" for="mbsp_receive">개인정보 수집 및 이용에 동의합니다.</label>
            </div>
            <div class="mb-4 text-center">
              <input type="hidden" name="ord_tot_price" id="ord_tot_price" value="${cart_tot_price }"> <!-- 주문금액 숨겨넣기 -->
              <button type="button" id="btn_bank" name="btn_buy" data-paytype="bank" class="btn btn-primary" >무통장입금 결제하기</button>
              <img src="/img/payment_icon_yellow_medium.png" id="btn_kakaopay" name="btn_buy"  data-paytype="kakaopay">
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <th style="width: 50%">상품</th>
              <th style="width: 10%">수량</th>
              <th style="width: 10%">포인트</th>
              <th style="width: 10%">배송비</th>
              <th style="width: 10%">주문금액</th>
            </tr>
            <c:forEach items="${cart_list }" var="cartListDTO">
              <tr>
                <td>
                  <img src="/cart/displayImage?folderName=${cartListDTO.prd_up_folder }&fileName=s_${cartListDTO.prd_img}" />
                  <c:out value="${cartListDTO.prd_name }" ></c:out>
                </td>
                <td>
                  ${cartListDTO.cart_amount }
                
                </td>
                <td>포인트 : 0</td>
                <td>
                  [기본배송조건]
                  </td>
                <td>${cartListDTO.unitprice }</td>               
              </tr>
            </c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="6" class="text-right">총 구매금액 : <fmt:formatNumber type="currency" pattern="₩#,###" value="${cart_tot_price }"/></td>
            </tr>
          </tfoot>
        </table>
      </div>
    </div>
    <%@include file="/WEB-INF/views/include/footer.jsp" %>
  </div>

  <!-- 우편번호 API -->
  <%@ include file="/WEB-INF/views/include/zipcode.jsp" %>

  <script>
  $(document).ready(function() {

    $("#btn_bank").hide();
    $("#btn_kakaopay").hide();

    // 무통장입금 결제하기 또는 카카오페이 버튼 클릭
    $("[name='btn_buy']").on("click", function(){
      
      let pay_type = $(this).data("paytype");  // 결제방식 저장. (bank or kakaopay)

      // 주문정보, 결제정보 수집
      let order_info = {
        
        pay_type : pay_type,  // 결제방식
        order_productName : $("#order_productName").val(),  // 상품명
        
        // 주문정보. OrderVO
        ord_rcv_name :    $("#ord_rcv_name").val(),
        ord_rcv_zipcode : $("input[name='ord_rcv_zipcode']").val(),
        ord_rcv_addr :    $("input[name='ord_rcv_addr']").val(),
        ord_rcv_addr_d :  $("input[name='ord_rcv_addr_d']").val(),
        ord_rcv_phone :   $("#ord_rcv_phone").val(),
        ord_tot_price :   $("#ord_tot_price").val(), 

        // 결제정보. PaymentVO
        pay_method : $("#pay_method").val(),
	      pay_price : $("#ord_tot_price").val(),
	      pay_user : $("#pay_user").val(),
	      pay_bank : $("#pay_bank").val(),
	      pay_memo : '생략'
      }
      
      $.ajax({
        url: '/order/orderBuy',
        data: order_info,
        dataType: 'json',
        type: 'get',
        success: function(result){
          // alert(pay_type);

          if(pay_type == "kakaopay"){
            console.log("응답: " + result.next_redirect_pc_url);
            location.href = result.next_redirect_pc_url  // 카카오페이 API서버에서 운영하는 QR코드 페이지 주소로 이동
          }else if(pay_type == "bank"){
            location.href = "/order/orderComplete"
          }
        }
      });
    });

    // 결제방법 변경 시
    $("#pay_method").on("change", function(){
      
      let pay_method = $(this).val();

      if(pay_method == "무통장입금"){
        $("#btn_bank").show();     // 무통장입금 결제하기 버튼 노출
        $("#btn_kakaopay").hide();
        $("#pay_user_vw").css("display", "block");  // 입금자명 화면에 노출
        $("#pay_bank").css("display", "block");     // 입금은행 선택 화면에 노출
      }else if(pay_method == "카카오페이"){
        $("#btn_kakaopay").show();
        $("#btn_bank").hide();
        $("#pay_user_vw").css("display", "none");
        $("#pay_bank").css("display", "none");
      }
    });

  });
  </script>
</body>
</html>