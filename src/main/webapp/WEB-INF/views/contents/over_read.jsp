<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="name" value="${procateVO.name }" />

<c:set var="catenum" value="${overcontentsVO.catenum }" />
<c:set var="overcontentsno" value="${overcontentsVO.overcontentsno }" />
<c:set var="thumb1" value="${overcontentsVO.thumb1 }" />
<c:set var="file1saved" value="${overcontentsVO.file1saved }" />
<c:set var="title" value="${overcontentsVO.title }" />
<c:set var="content" value="${overcontentsVO.content }" />
<c:set var="rdate" value="${overcontentsVO.rdate }" />
<c:set var="youtube" value="${overcontentsVO.youtube }" />
<c:set var="map" value="${overcontentsVO.map }" />
<c:set var="file1" value="${overcontentsVO.file1 }" />
<c:set var="size1_label" value="${overcontentsVO.size1_label }" />
<c:set var="word" value="${overcontentsVO.word }" />
<c:set var="cnt" value="${overcontentsVO.cnt }" />

<c:set var="chu" value="${replyVO.chu }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9091/</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
  
<script type="text/javascript">
  window.onload = function() {
  }
  function checkCHU() {
        let id = document.getElementById('id');//ID의 정체가 존재해야 해당 값을 조정할 수 있다.
        let url ='./the_checkID.do?id='+id.value;

     // fetch를 사용하여 데이터를 서버에 GET 요청합니다.
        fetch(url,{
            method:'GET',
        }).then(response=>response.json())
        .then(rdata=>{
            if (rdata.cnt > 0) { // 아이디 중복
                id_msg.innerHTML= '이미 사용중인 ID(이메일) 입니다. 다른 ID(이메일)을 지정해주세요.';
                id_msg.classList.add('span_warning');
                id.focus();
                
              } else { // 아이디 중복 안됨.
                id_msg.innerHTML= '사용 가능한 ID(이메일) 입니다.';
                id_msg.classList.add('span_info');
                document.getElementById('passwd').focus(); 
                // $.cookie('checkId', 'TRUE'); // Cookie 기록
              }
        }).catch(error => {
            console.error('Error :', error);
        });
        
        // 처리중 출력
        id_msg.innerHTML="<img src='/member/images/ani04.gif' style='width: 5%;'>"; // static 기준
        
    }
  }
</script>
  
</head>
<body>
<c:import url="/menu/top.do" />
  <div class='title_line'><a href="./over_list_by_cateno.do?catenum=${catenum }" class='title_link'>${name }</a></div>

  <aside class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.admin_id != null }">
      <%--
      http://localhost:9092/contents/over_create.do?catenum=1
      http://localhost:9092/contents/over_create.do?catenum=2
      http://localhost:9092/contents/over_create.do?catenum=3
      --%>
      <A href="./over_create.do?catenum=${catenum }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./over_update_text.do?overcontentsno=${overcontentsno}&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./over_update_file.do?overcontentsno=${overcontentsno}&now_page=${param.now_page == null ? 1 : param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
<%--       <A href="./map.do?catenum=${catenum }&overcontentsno=${overcontentsno}">맵</A>
      <span class='menu_divide' >│</span> --%>
      <A href="./youtube.do?catenum=${catenum }&overcontentsno=${overcontentsno}">Youtube</A>
      <span class='menu_divide' >│</span>
      <A href="./over_delete.do?overcontentsno=${overcontentsno}&now_page=${param.now_page == null ? 1 : param.now_page}&catenum=${catenum}">삭제</A>  
      <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./over_list_by_cateno.do?catenum=${catenum }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./over_list_by_cateno_grid.do?catenum=${catenum }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">갤러리형</A>
  </aside> 
  
  <DIV class='position-relative' style="text-align: right; clear: both;">  
    <form class='row g-2 justify-content-end' name='frm' id='frm' method='get' action='./over_list_by_cateno.do'>
      <input type='hidden' name='catenum' value='${catenum }'>  <%-- 게시판의 구분 --%>
      <div class="col-auto">
        <c:choose>
          <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
            <input type='text' name='word' id='word' value='${param.word }' class="form-control form-control-sm" style='height:40px;'>
          </c:when>
          <c:otherwise> <%-- 검색하지 않는 경우 --%>
            <input type='text' name='word' id='word' value='' class="form-control form-control-sm" style='height:40px;'>
          </c:otherwise>
        </c:choose>
      </div>
      <div class="col-auto">
        <button type='submit' class='btn btn-outline-success'>검색</button>
        <c:if test="${param.word.length() > 0 }">
          <button type='button' class='btn btn-outline-success' 
                      onclick="location.href='./over_list_by_cateno.do?catenum=${catenum}&word='">검색 취소</button>  
        </c:if>  
      </div>
  
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <c:if test="${youtube.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style="text-align: center;">
            ${youtube }
          </DIV>
        </li>
      </c:if>
      <li class="li_none">
        <DIV style="width: 100%; word-break: break-all; text-align: center;">
          <c:choose>
            <c:when test="${thumb1.endsWith('jpeg') || thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <%-- /static/contents/storage/ --%>
              <img src="/contents/storage/${file1saved }" style='width: 50%; margin-top: 0.5%; margin-right: 1%;'> 
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
              <img src="/contents/images/none1.png" style='width: 50%; margin-top: 0.5%; margin-right: 1%;'> 
            </c:otherwise>
          </c:choose>
          <br><br>
          <span style="font-size: 1.5em; font-weight: bold;">${title }</span>
          <span style="font-size: 1em;"> 조회수 : ${cnt }    |    ${rdate }</span>
          <br><br>
          ${content }
        </DIV>
      </li>
      

      
      <c:if test="${map.trim().length() > 0 }">
        <li class="li_none" style="clear: both; padding-top: 5px; padding-bottom: 5px;">
          <DIV style='text-align: center; width:640px; height: 360px; margin: 0px auto;'>
            ${map }
          </DIV>
        </li>
      </c:if>
      
      <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
          <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <div>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <a href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'>${file1}</a> (${size1_label}) 
            <a href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'><img src="/contents/images/download.png"></a>
          </c:if>
        </div>
      </li>   
    </ul>
  </fieldset>
  <br><br>
  
  <div style="text-align:center">
      <form name='frm' id='frm' method='get' action='./over_list_by_cateno.do'>
          <c:choose>
            <c:when test="${chu == 0}">
              <input type="submit" class="rounded-circle" style="background-image: url('/css/images/heart.png'); background-size: cover; width: 80px; height: 80px;">
            </c:when>
            <c:otherwise> 
              <input type="submit" class="rounded-circle" style="background-image: url('/css/images/heart1.png'); background-size: cover; width: 80px; height: 80px;">
            </c:otherwise>
          </c:choose>
      </form>
  </div>

  
  <br><br>
  
  
<div class="col-lg-12">
    <div class="card">
        <div class="card-header with-border">
            <h3 class="card-title">댓글 작성</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="form-group col-sm-8" style="width:80%">
                    <input class="form-control input-sm" id="newReplyText" type="text" placeholder="댓글 입력...">
                </div>
                <div class="form-group col-sm-2">
                    <button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn">
                        <i class="fa fa-save"></i> 저장
                    </button>
                </div>
            </div>  
        </div>
        <div class="card-footer">
            <ul id="replies">
                <li data-reply_no='" + this.reply_no + "' class='replyLi'>
                   <p class='reply_text'>reply_text</p>
                   <p class='reply_writer'>reply_writer</p>
                 </li>


            </ul>
        </div>
        <div class="card-footer">
            <nav aria-label="Contacts Page Navigation">
                    <ul class="pagination pagination-sm no-margin justify-content-center m-0">
    
                    </ul>
            </nav>
        </div>
    </div>
  </div>

<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>

