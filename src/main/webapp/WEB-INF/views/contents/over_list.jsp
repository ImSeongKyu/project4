<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9091/</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>전체 글 목록</div>
  
  <aside class="aside_right">
    <a href="javascript:location.reload();">새로고침</a>
  </aside>
  
  <div class="menu_line"></div> 
  
  <table class="table table-hover">
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 80%;"></col>
        <col style="width: 10%;"></col>
      </colgroup>
      <thead>
        <tr>
          <th style='text-align: center;'>이미지</th>
          <th style='text-align: center;'>글</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="overcontentsVO" items="${list }" varStatus="info">
          <c:set var="overcontentsno" value="${overcontentsVO.overcontentsno }" />
          <c:set var="thumb1" value="${overcontentsVO.thumb1 }" />
    
          <tr onclick="location.href='./over_read.do?overcontentsno=${overcontentsno}'" style="cursor: pointer;">
            <td>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpeg') || thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                  <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
                  <img src="/contents/storage/${thumb1 }" style="width: 120px; height: 90px;">
                </c:when>
                <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                  <img src="/contents/images/none1.png" style="width: 120px; height: 90px;">
                </c:otherwise>
              </c:choose>
            </td>
            <td class="td_bs_left">
                <span style="font-weight:bold; font-size:22px;">${overcontentsVO.title }</span><br>
                <c:choose>
                    <c:when test="${overcontentsVO.content.length() > 100}">
                        ${overcontentsVO.content.substring(0,100) }...
                    </c:when>
                    <c:otherwise>
                        ${overcontentsVO.content }
                    </c:otherwise>
                </c:choose>
                (${overcontentsVO.rdate.substring(0, 16) })
            </td>
            <td class="td_bs">
              <a href="/contents/youtube.do?catenum=${param.catenum }&overcontentsno=${overcontentsno}" title="유튜브 설정"><img src="/contents/images/youtube.png" class="icon"></a>
              <a href="/contents/over_delete.do?overcontentsno=${overcontentsno}&now_page=${param.now_page }&catenum=${param.catenum }" title="삭제"><img src="/contents/images/delete.png" class="icon"></a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
      
  </table>
 
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>