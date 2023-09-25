<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="categoryMenu">
  <!-- 카테고리 -->    
  <ul class="nav justify-content-center" id="mainCategory">
    <c:forEach items="${ctgrList}" var="categoryVO">
      <li class ="nav-item">
        <a class="nav-link" href="${categoryVO.ctgr_cd }">${categoryVO.ctgr_name }</a>
      </li>
    </c:forEach>
  </ul>
</div>

<script>
  // 상단 카테고리에 마우스오버 시, 2차 카테고리 출력
  $("ul.nav li.nav-item a").on("mouseover", function(e){
    e.preventDefault(); 
    //console.log("1차카테고리 선택");

    let selectedCategory = $(this);
    let ctgr_cd = $(this).attr("href");
    let url = "/product/subCategory/" + ctgr_cd;

    // 2차 카테고리 데이터(JSON)를 가져와 출력
      $.getJSON(url, function(subCategory){
      
      let subCategoryStr = '<ul class="nav justify-content-center" id="subCategory">';

      for(let i=0; i<subCategory.length; i++){
        subCategoryStr += '<li class ="nav-item">';
        subCategoryStr += '<a class="nav-link" href="' + subCategory[i].ctgr_cd + '">' + subCategory[i].ctgr_name + '</a>';
        subCategoryStr += '</li>';
      }
      subCategoryStr += '</ul>';

      //console.log(subCategoryStr);

      selectedCategory.parent().parent().next().remove();  // 누적되는 2차 카테고리 제거
      selectedCategory.parent().parent().after(subCategoryStr);  // 1차 카테고리 큰틀 뒤에 2차 카테고리(subCategoryStr)를 추가
    });

    // 상단메뉴 2차 카테고리 선택
    $("div#categoryMenu").on("click", "ul#subCategory li.nav-item a", function(e){  // "ul#subCategory li.nave-item a": 동적으로 생성된 2차 카테고리 태그
      e.preventDefault();
      console.log("2차 카테고리 선택");

      //"/pro_list/{cat_code}/{cat_name}" 이 형태의 주소를 만든다.
      let url = "/product/pro_list/" + $(this).attr("href") + "/" + $(this).html();
      location.href = url;
    });

  });
</script>