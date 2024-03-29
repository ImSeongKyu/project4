<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<link rel="shortcut icon" href="/images/shortcut.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
</head>
 
<body>
<c:import url="/menu/top.do" />
 
  <div class='title_line'>${procateVO.name } > 글 등록</div>
  
  <aside class="aside_right">
    <a href="./over_create.do?catenum=${procateVO.catenum }">등록</a>
    <span class='menu_divide' >│</span>
    <a href="javascript:location.reload();">새로고침</a>
    <span class='menu_divide' >│</span>
    <a href="./list_by_cateno_search_paging.do?catenum=${procateVO.catenum }">기본 목록형</a>    
    <span class='menu_divide' >│</span>
    <a href="./list_by_cateno_grid.do?catenum=${procateVO.catenum }">갤러리형</a>
  </aside>
  
  <div style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search_paging.do'>
      <input type='hidden' name='catenum' value='${procateVO.catenum }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-info btn-sm'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-info btn-sm' 
                    onclick="location.href='./list_by_cateno_search.do?catenum=${procateVO.catenum}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </div>
  
  <div class='menu_line'></div>
  <!-- 파일 업로드 폼 설정 = enctype="multipart/form-data" -->
  <!-- 이거 빠지면 파일 업로드가 안되니 주의 -->
  <FORM name='frm' method='POST' action='./over_create.do' enctype="multipart/form-data">
    <input type="hidden" name="catenum" value="${param.catenum }">
    
    <div>
       <label>제목</label>
       <input type='text' name='title' value='제목' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>재료 : 
       
       
조리법 : </textarea>
    </div>
    <div>
       <label>검색어</label>
       <input type='text' name='word' value='' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <div>
       <label>이미지</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' value='' placeholder="파일 선택">
       <!-- 이곳의 id값은 ContentsVO.java의 private MultipartFile file1MF; 와 연결되어있다 -->
    </div>   
    <div>
       <label>패스워드</label>
       <input type='password' name='passwd' value='1234' required="required" 
                 class="form-control" style='width: 50%;'>
    </div>   
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-secondary btn-sm">등록</button>
      <button type="button" onclick="location.href='./list_by_cateno_search_paging.do?catenum=${param.catenum}'" class="btn btn-secondary btn-sm">목록</button>
    </div>
  
  </FORM>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>