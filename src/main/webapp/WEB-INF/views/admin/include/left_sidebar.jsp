<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Alexander Pierce</p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      <!-- search form (Optional)
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
            </span>
        </div>
      </form>
      -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu tree" data-widget="tree">
        <li class="header">HEADER</li>
        <!-- 기능별 메뉴. <li class="treeview"> 복사하여 사용 -->
        <!-- 상품관리 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>상품 관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/product/pro_insert">상품 등록</a></li>
            <li><a href="/admin/product/pro_list">상품 목록</a></li>
          </ul>
        </li>
        
        <!-- 주문관리 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>주문 관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/order/order_list">주문 목록</a></li>
            <li><a href="#">취소 주문 목록</a></li>
          </ul>
        </li>
        
        <!-- 회원관리 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>회원 관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/member/mem_list">회원 목록</a></li>
            <li><a href="/admin/member/mem_list">탈퇴 회원 목록</a></li>
          </ul>
        </li>
        
        <!-- 게시판 및 상품후기 관리 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>게시판 및 상품후기관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="#">상품 등록</a></li>
            <li><a href="#">상품 목록</a></li>
          </ul>
        </li>
        
        <!-- 통계 관리 -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>통계 관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/chart/overall">상품 매출통계</a></li>
          </ul>
        </li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>