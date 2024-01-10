<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9092/cate/cate_list.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>카테고리</div>
  
<%--   <aside class="aside_right">
    <a href="./cate_create.do?catenum=${procateVO.catenum }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  <div class="menu_line"></div>  --%>
  
  <form name='frm' method='post' action='/cate/cate_create.do'>
    <div style="text-align: center;">
      <label>카테고리 이름</label>
      <input type="text" name="name" value="" required="required" autofocus="autofocus" 
                 class="" style="width: 50%">
      <button type="submit" class="btn btn-secondary btn-sm" style="height: 28px; margin-bottom: 5px;">등록</button>
      <button type="button" onclick="location.href='./cate_list.do'" class="btn btn-secondary btn-sm" 
                  style="height: 28px; margin-bottom: 5px;">목록</button> 
    </div>
  </form>
  
  <table class="table table-hover">
    <colgroup>
        <col style='width: 10%;'/>
        <col style='width: 40%;'/>
        <col style='width: 10%;'/>    
        <col style='width: 20%;'/>
        <col style='width: 20%;'/>
      </colgroup>
      <thead>
        <tr>
          <th class="th_bs">순서</th>
          <th class="th_bs">카테고리 이름</th>
          <th class="th_bs">자료수</th>
          <th class="th_bs">등록일</th>
          <th class="th_bs">기타</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="procateVO" items="${list }" varStatus="info">
          <c:set var="catenum" value="${procateVO.catenum }" />
          <c:set var="seqno" value="${procateVO.seqno }" />
    
          <tr>
            <td class="td_bs">${seqno }</td>
            <td><a href="../contents/over_list_by_cateno.do?catenum=${catenum }" style="display: block;">${procateVO.name }</a></td>
            
            <td class="td_bs">${procateVO.cnt }</td>
            <td class="td_bs">${procateVO.rdate.substring(0, 10) }</td>
            <td class="td_bs">
            <%-- ./ = 현재 폴더 경로, ../ = 상위 폴더로 올라간 뒤에 탐색 --%>
              <a href="../contents/over_create.do?catenum=${catenum }" title="등록"><img src="/cate/images/create.png" class="icon"></a>
              <c:choose>
                <c:when test="${procateVO.visible == 'Y'}">
                  <a href="./cate_update_visible_n.do?catenum=${catenum }" title="카테고리 공개 설정"><img src="/cate/images/show.png" class="icon"></a>
                </c:when>
                <c:otherwise>
                  <a href="./cate_update_visible_y.do?catenum=${catenum }" title="카테고리 비공개 설정"><img src="/cate/images/hide.png" class="icon"></a>
                </c:otherwise>
              </c:choose>    
              
              <a href="./cate_update_seqno_forward.do?catenum=${catenum }" title="우선 순위 높임"><img src="/cate/images/decrease.png" class="icon"></a>
              <a href="./cate_update_seqno_backward.do?catenum=${catenum }" title="우선 순위 낮춤"><img src="/cate/images/increase.png" class="icon"></a>
              <a href="./cate_update.do?catenum=${catenum }" title="수정"><img src="/cate/images/update.png" class="icon"></a>
              <a href="./cate_delete.do?catenum=${catenum }" title="삭제"><img src="/cate/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>