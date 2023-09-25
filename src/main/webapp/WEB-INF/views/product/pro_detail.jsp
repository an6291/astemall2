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

    <!-- Tabs. (위치 유의 - config.jsp 내용과 충돌) -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="//jqueryui.com/resources/demos/style.css">
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

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

      /* 상품후기 작성에서별평점 */
      p#star_rv_rating a.rv_rating {
        font-size: 22px;
        text-decoration: none;
        color: lightgray;
      }
	  /* 상품후기 작성에서 별평점 클릭 시 */
      p#star_rv_rating a.rv_rating.on {
        color: black;
      }

      /* 상품후기 목록, 수정에서 별평점 */
      td#star_rv_rating a.rv_rating {
        font-size: 22px;
        text-decoration: none;
        color: lightgray;
      }
      /* 상품후기 목록, 수정에서 별평점 클릭 시 */
      td#star_rv_rating a.rv_rating.on {
        color: black;
      }

    </style>
</head>

<body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <%@ include file="/WEB-INF/views/include/categoryMenu.jsp" %>

  <div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
  </div>

  <div class="container">
  	<!-- 기본 정보 -->
    <div class="row">
      <div class="col-md-6">
        <!-- 상품 이미지 -->
        <img style="width:400px; height:400px" src="/product/displayImage?folderName=${productVO.prd_up_folder}&fileName=${productVO.prd_img}">
      </div>
      <div class="col-md-6">
        <p>상품명 : ${productVO.prd_name}</p>
        <p>가격 : <fmt:formatNumber type="currency" pattern="￦#,###" value="${productVO.prd_price}"/></p>
        <p>제조사 : ${productVO.prd_company}</p>
        <p>수량 : <input type="text" id="prd_amount" value="1" style="width: 50px"></p>
        <button type="button" name="btn_cart" data-prd_no="${productVO.prd_no}" class="btn btn-link">장바구니</button> <!-- 상품코드 숨겨넣음 -->
        <button type="button" name="btn_direct_order" data-prd_no="${productVO.prd_no}" class="btn btn-link">바로구매</button>  <!-- 상품코드 숨겨넣음 -->
      </div>
    </div>
    
    <!-- Tabs -->
    <div id="tabs">
      <ul>
        <li><a href="#prd_desc">상세정보</a></li>
        <li><a href="#prd_review">상품후기</a></li>
      </ul>
      <!-- 상세설명 -->
      <div id="prd_desc">
        ${productVO.prd_detail}
      </div>
      <!-- 상품후기 -->
      <div id="prd_review">
	      <!-- 상품후기 쓰기 폼 -->
        <div class="row">
          <div class="col-md-12">
            <div class="box-body">
              <div class="form-group row">
                <div class="col-md-8">
                  <input type="text" class="form-control" id="rv_content" placeholder="상품후기를 작성하세요.">
                  <p id="star_rv_rating"> 
                    <a class="rv_rating" href="#">☆</a>
                    <a class="rv_rating" href="#">☆</a>
                    <a class="rv_rating" href="#">☆</a>
                    <a class="rv_rating" href="#">☆</a>
                    <a class="rv_rating" href="#">☆</a>
                  </p>
                </div>
                <div class="col-md-4"></div>
                  <button type="button" id="btn_review_write" class="btn btn-primary">등록</button>
              </div>
            </div>
          </div>
        </div>
        <div id="reviewList"></div>
        <div id="reviewPaging"></div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </div>


  <!-- 1) Include Handlebars from a CDN -->
  <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
  <!-- 2) handlebars template. 상품후기UI -->
  <!-- 후기목록데이터 출력을 위한 Handlebars 템플릿. 반복이 되는 성격이기 때문에 이 안에서 id속성을 사용하면 안됨 -->
  <script id="replyViewTemplate" type="text/x-handlebars-template">
    <table class="table">
        {{#each .}}
        <tr>
          <td>{{rv_no}}</td>
          <td>{{displayStar rv_rating}} <input type="hidden" name="rv_rating" value="{{rv_rating}}"></td>
          <td>{{rv_content}}</td>
          <td>{{mb_id}}</td>
          <td>{{convertDate rv_date}}</td>
          <td>{{authority mb_id rv_no}}</td>
        </tr>
        {{/each}}
    </table>
  </script>

  <!-- Handlebar의 사용자정의 Helper -->
  <script>
    // 날짜데이터가 json으로 변환되어 밀리세컨드 단위로 된 것을, 다시 날짜로 변환하는 함수
    Handlebars.registerHelper("convertDate", function(timeValue) {
      const date = new Date(timeValue);  // timeValue: millisecond

      return date.getFullYear() + "/" + (date.getMonth() + 1) + "/" + date.getDate();
    })
    
    // 평점을 별로 표시하는 함수
    Handlebars.registerHelper("displayStar", function(rating) {
      let starStr = "";
      switch(rating) {
      	case 1:
      		starStr = "★☆☆☆☆";
      		break;
      	case 2:
      		starStr = "★★☆☆☆";
      		break;
      	case 3:
      		starStr = "★★★☆☆";
      		break;
      	case 4:
      		starStr = "★★★★☆";
      		break;
      	case 5:
      		starStr = "★★★★★";
      		break;
      }
      return starStr;
    })

    // 로그인한 사용자 본인이 작성한 후기만 수정 및 삭제가 가능하도록 버튼 표시
    Handlebars.registerHelper("authority", function(mb_id, rv_no){
      let str = "";
      let login_id = '${sessionScope.loginStatus.mb_id}';
      if(mb_id == login_id){
        str += "<button type='button' class='btn btn-link' name='btn_re_edit' data-rv_no='" + rv_no + "'>[수정]</button>";
        str += "<button type='button' class='btn btn-link' name='btn_re_delete' data-rv_no='" + rv_no + "'>[삭제]</button>";
      }
      return new Handlebars.SafeString(str);
    });
  </script>


  <script>
    
    $(document).ready(function(){

      // Tabs
      $( "#tabs" ).tabs();

      // 장바구니 버튼 클릭
      $("button[name='btn_cart']").on("click", function(){
        $.ajax({
          url: '/cart/cart_add',
          type: 'post',
          data: {prd_no: $(this).data("prd_no"), cart_amount:$("#prd_amount").val()},
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

    });
  </script>


  <script>

    /** 상품후기 **/
    $(document).ready(function(){

      // 상품후기 페이지 번호 클릭 (동적으로 추가된 태그에 click이벤트 설정)
      $("#reviewPaging").on("click", "li a", function(e){
        e.preventDefault();  // 링크기능 취소
        //console.log("댓글 페이지번호 클릭");
        reviewPage = $(this).attr("href");  // reviewPage: 선택한 댓글 페이지 번호.  this: 선택한 a태그를 가리킴 
        url = "/review/list/" + prd_no + "/" + reviewPage + ".json";
        getPage(url);  // 스프링에서 댓글번호에 해당하는 댓글데이터 가져오기
      });

      // 별(평점) 클릭
      $("p#star_rv_rating a.rv_rating").on("click", function(e){
        e.preventDefault();  // 링크기능 취소 
        $(this).parent().children().removeClass("on");  // (다른 별 클릭 시) 기존의 별css 삭제
        $(this).addClass("on").prevAll("a").addClass("on");  // 선택한 별과 왼쪽의 별 모두 css 적용
      });

      // 상품후기 등록 버튼 클릭
      $("#btn_review_write").on("click", function(){
        let rv_content = $("#rv_content").val();      // 상품후기 내용
        let rv_rating = 0;  // 체크된 별의 개수

        // 체크된 별의 개수 확보
        $("p#star_rv_rating a.rv_rating").each(function(index,item){
          if($(this).attr("class") == "rv_rating on"){
            rv_rating += 1;
          }
        });

        // 별을 체크하지 않았을 경우
        if(rv_rating == 0){
          alert("별 평점 선택하세요.");
          return;
        }

        // 후기내용을 입력하지 않았을 경우
        if(rv_content == 0){
          alert("상품후기 내용을 입력하세요.");
          return;
        }

        // JSON포맷으로 변경
        let reviewData = JSON.stringify({prd_no:${productVO.prd_no}, rv_rating:rv_rating, rv_content:rv_content});  

        //console.log(reviewData);
        
        $.ajax({
          type: 'post',
          url: '/review/new',   
          headers: {            
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
          },
          dataType: 'text',     
          data: reviewData,      
          success: function(result) {
            if(result == "success"){
              alert("상품후기가 등록되었습니다.");
              $("#rv_content").val("");  // 작성한 상품후기 내용 초기화
              $("p#star_rv_rating a.rv_rating").removeClass("on");  // 선택했던 별 css 초기화

              reviewPage = 1;
              url = "/review/list/" + prd_no + "/" + reviewPage + ".json";
              getPage(url); // 1페이지로 이동
            }
          }
        });
      }); //댓글 쓰기

      // 상품후기 수정 버튼 클릭 - 수정 폼
      $("div#reviewList").on("click", "button[name='btn_re_edit']", function(){
        //console.log("후기 수정");
        
        let cur_tr = $(this).parent().parent();  // 선택한 edit버튼의 현재 tr

        let rv_no = cur_tr.children().eq(0).text();  // 번호
        
        /* 평점 */
        let rv_rating = cur_tr.children().eq(1).find("input[name='rv_rating']").val();
        //console.log("평점: " + rv_rating);
        // 별(모양) 평점
        let displayStar = "";
        for(let i=0; i<5; i++){
          if(i < rv_rating){
            displayStar += "<a href='#' class='rv_rating on'>";
            displayStar += "★";
          }else{
            displayStar += "<a href='#' class='rv_rating'>";
            displayStar += "☆";
          }
          displayStar += "</a>";
        }
        // (실제) 평점
        let input_displayStar = "<input type='hidden' name='rv_rating' value='" + rv_rating + "'>";
        /* 평점 end */

        let rv_content = cur_tr.children().eq(2).text();  // 내용
        let mb_id = cur_tr.children().eq(3).text();       // 작성자(아이디)
        let rv_date = cur_tr.children().eq(4).text(); // 등록일(수정일)
        
        /* <tr>태그 안의 내용 삭제 -> 편집 상태로 재구성 -> 내용 채우기 */
        // 내용 삭제
        cur_tr.empty();  

        // 편집 상태로 재구성
        let rv_no_str = "<td><input type='text' id='edit_rv_no' style='width:50px' value='" + rv_no + "' readonly></td>";
        let rv_rating_str = "<td id='star_rv_rating'>" + displayStar + input_displayStar + "</td>";
        let rv_content_str = "<td><input type='text' id='edit_rv_content' value='" + rv_content + "'></td>";
        let mb_id_str = "<td>" + mb_id + "</td>";
        let rv_date_str = "<td>" + rv_date + "</td>";
        // 취소, 수정 버튼    
        let btn_str = "<td><button type='button' id='btn_re_cancel' class='btn btn-link'>취소</button>";     
        btn_str += "<button type='button' id='btn_re_editComplete' class='btn btn-link'>수정반영</button></td>";

        // 내용 채우기
        cur_tr.append(rv_no_str, rv_rating_str, rv_content_str, mb_id_str, rv_date_str, btn_str);

      });

      // (수정) 별평점 클릭
      $("div#reviewList").on("click", "td#star_rv_rating a.rv_rating", function(e){
        e.preventDefault();  // 링크기능 취소 
        $(this).parent().children().removeClass("on");  // (다른 별 클릭 시) 기존의 별css 삭제
        $(this).addClass("on").prevAll("a").addClass("on");  // 선택한 별과 왼쪽의 별 모두 css 적용
      });
      

      // 상품후기 수정반영 버튼 클릭
      $("div#reviewList").on("click", "#btn_re_editComplete", function(){
        let edit_rv_no = $("#edit_rv_no").val();            // 후기번호
        let edit_rv_content = $("#edit_rv_content").val();  // 내용

        // 별평점
        let edit_rv_rating = 0;
        $("td#star_rv_rating a.rv_rating").each(function(index,item){  // 기존 별평점 읽어오기 (체크된 별의 개수 확보)
          if($(this).attr("class") == "rv_rating on"){
            edit_rv_rating += 1;
          }
        });
        //console.log("별평점: " + rv_rating);
        
        let reviewData = JSON.stringify({rv_no:edit_rv_no, rv_content:edit_rv_content, rv_rating:edit_rv_rating});
        //console.log("수정 상품후기 데이터: " + reviewData);

        $.ajax({
          type: 'patch',
          url: '/review/edit/',
          headers: {
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PATCH"
          },
          data: 'text',
          data: reviewData,
          success: function(result) {
            if(result == "success") {
              alert("상품후기가 수정되었습니다.");

              url = "/review/list/" + prd_no + "/" + reviewPage + ".json";
              getPage(url);  // 수정한 상품후기가 존재하는 페이지로 이동
            }
          }
        });
      });

      // 상품후기 (수정) 취소 버튼 클릭
      $("div#reviewList").on("click", "#btn_re_cancel", function(){
        //console.log("상품후기 취소");
        
        // 수정 버튼 클릭 전의 값 읽어오기
        let cur_tr = $(this).parent().parent();
        let edit_rv_no = cur_tr.children().eq(0).find("#edit_rv_no").val();            // 후기번호
        let edit_star = cur_tr.children().eq(1).html();                                // 별평점
        let edit_rv_content = cur_tr.children().eq(2).find("#edit_rv_content").val();  // 내용
        let edit_mb_id = cur_tr.children().eq(3).text();                               // 작성자(아이디)
        let edit_rv_date = cur_tr.children().eq(4).text();                             // 등록일(수정일)
        
        // <td>태그 형태로
        let edit_rv_no_str = "<td>" + edit_rv_no + "</td>";
        let edit_star_str = "<td>" + edit_star + "</td>";                          
        let edit_rv_content_str = "<td>" + edit_rv_content + "</td>";
        let edit_mb_id_str = "<td>" + edit_mb_id + "</td>";                           
        let edit_rv_date_str = "<td>" + edit_rv_date + "</td>";
        // 수정, 삭제 버튼    
        let btn_str = "<td><button type='button' class='btn btn-link' name='btn_re_edit' data-rv_no='" + edit_rv_no + "'>[수정]</button>";
        btn_str += "<button type='button' class='btn btn-link' name='btn_re_delete' data-rv_no='" + edit_rv_no + "'>[삭제]</button></td>";

        cur_tr.empty();  // <tr>태그 안의 내용 비우기

        // 내용 채우기 (원래 상태로)
        cur_tr.append(edit_rv_no_str, edit_star_str, edit_rv_content_str, edit_mb_id_str, edit_rv_date_str, btn_str);
      });

      // 상품후기 삭제하기
      $("div#reviewList").on("click", "button[name='btn_re_delete']", function(){
        //console.log("상품후기 삭제");

        if(!confirm("상품후기를 하시겠습니까?")) return;

        $.ajax({
          type: 'delete',
          url: '/review/delete/' + $(this).data("rv_no"),
          headers: {
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
          },
          data: 'text',
          success: function(result) {
            if(result == "success") {
              alert("댓글이 삭제되었습니다.");
              url = "/review/list/" + prd_no + "/" + reviewPage + ".json";
              getPage(url);  // 삭제한 상품후기가 존재했던 페이지로 이동
            }
          }
        });
      });

    }); //jQuery ready END


    // 후기 목록과 페이징작업. ajax
    let prd_no = ${productVO.prd_no};  // 상품코드
    let reviewPage = 1;
    let url = "/review/list/" + prd_no + "/" + reviewPage + ".json";

    getPage(url);

    function getPage(url) {
      $.getJSON(url, function(data){ 
    	  
        printReplyData(data.list, $("#reviewList"), $("#replyViewTemplate")); 
        printreviewPaging(data.pageMaker, $("#reviewPaging"));

      });
    }

    //댓글목록 출력기능. replyArr: 댓글목록데이터(json), target: 댓글삽입위치, template: 핸들바 문법이 사용된 댓글 디자인
    function printReplyData(replyArr, target, template){
      
      //Handlebars 파일 안에 Handlebars 객체 만들어져 있음
      //template의 내용을 compile(문법검사)
      //templateObj: 댓글UI 참조
      let templateObj = Handlebars.compile(template.html());  
      let replyHtml = templateObj(replyArr); // replyHtml: 테이블과 댓글데이터가 바인딩된 결과
      target.empty(); // empty(): <div>태그 내의 내용을 지움
      target.append(replyHtml);
      
      //console.log(replyHtml);
    }

    // 페이징 출력기능
    function printreviewPaging(pageMaker, target){
      
      let pageInfoStr = '<nav aria-label="Page navigation example">';
        pageInfoStr += '<ul class="pagination">';

      if(pageMaker.prev){
        pageInfoStr += '<li class="page-item">';
        pageInfoStr += '<a class="page-link" href="' + (pageMaker.startPage - 1) + '" aria-label="Previous">';
        pageInfoStr += '<span aria-hidden="true">&laquo;</span>';
        pageInfoStr += '</a>';
        pageInfoStr += '</li>';
      }

      for(let i=pageMaker.startPage; i<=pageMaker.endPage; i++){
        let currPageClass = (pageMaker.cri.pageNum == i) ? 'active' : '';
        pageInfoStr += '<li class="page-item ' + currPageClass + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
      }

      if(pageMaker.next){
        pageInfoStr += '<li class="page-item">';
        pageInfoStr += '<a class="page-link" href="' + (pageMaker.endPage + 1) + '" aria-label="Next">';
        pageInfoStr += '<span aria-hidden="true">&raquo;</span>';
        pageInfoStr += '</a>';
        pageInfoStr += '</li>';
      }
      //console.log(pageInfoStr);
      target.html(pageInfoStr);
    }
  </script>

</body>
</html>