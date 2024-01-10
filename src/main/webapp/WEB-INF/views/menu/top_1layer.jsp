<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<div class='container_main'>
  <div class='top_img'>
    <div class="top_menu_label">만화 리뷰 블로그 4.0</div>      
    <nav class="top_menu">
      <a href="/" class="menu_link">메인 화면</a><span class="top_menu_sep"> </span>
      
      <c:forEach var="procateVO" items="${list_top }">
        <a href="/contents/over_list_by_cateno.do?catenum=${procateVO.catenum }&now_page=1" class="menu_link">${procateVO.name }</a><span class="top_menu_sep"> </span> 
      </c:forEach>
      
      <a href="/member/the_create.do" class="menu_link">회원 가입</a><span class="top_menu_sep"> </span>
      <a href="/member/the_list.do" class="menu_link">회원 목록</a><span class="top_menu_sep"> </span>
      
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <a href="/member/login.do" class="menu_link">로그인</a><span class="top_menu_sep"> </span>
        </c:when>
        <c:otherwise>
          <a href='/member/logout.do' class="menu_link">${sessionScope.id } 로그아웃</a><span class="top_menu_sep"> </span>
          <a href='/member/the_passwd_update.do' class="menu_link">비밀번호 변경</a><span class="top_menu_sep"> </span>
        </c:otherwise>
      </c:choose>
      
      <c:choose>
        <c:when test="${sessionScope.admin_id == null }">
          <a href="/admin/ms_login.do" class="menu_link">관리자 로그인</a>
        </c:when>
        <c:otherwise>
          <a href="/cate/cate_list.do" class="menu_link">카테고리 전체 목록</a><span class="top_menu_sep"> </span>
          <a href="/contents/over_list.do" class="menu_link">전체 글 목록</a><span class="top_menu_sep"> </span>
          <a href="/contents/over_list_all_gallery.do" class="menu_link">Gallery</a><span class="top_menu_sep"> </span>
          <a href="/admin/ms_logout.do" class="menu_link">관리자 ${sessionScope.admin_id } 로그아웃</a>
        </c:otherwise>
      </c:choose>
      
    </nav>
  </div>
  <div class='content_body'> <!--  내용 시작 -->  