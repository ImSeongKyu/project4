<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9092/</title>
<!-- css, image, java파일 등은 static에서 찾는게 베스트, 그리고 자동으로 static부터 찾음 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<c:import url="/menu/top.do" />

  <div style="width: 50%; margin: 30px auto;">
    <a href="/contents/over_list_all_gallery.do">
      <img src="/images/jesus.jpg" style="width: 100%;">
    </a>
  </div>

<jsp:include page="./menu/bottom.jsp" flush='false' /> 
</body>
</html>
