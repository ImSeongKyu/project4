<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0, maximum-scale=10.0, width=device-width" /> 
<title>http://localhost:9092/contents/over_list_by_cateno.do</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
  
<script type="text/javascript">

/* $(function() {

      // 모든 radio를 순회한다.
      $('input[name="1btnradio"]').each(function() {
          var value = $(this).val();              // value
          if($('#type1').val() == value )
              $(this).prop('checked', true);
      });
      $('input[name="2btnradio"]').each(function() {
          var value = $(this).val();              // value
          if($('#type2').val() == value )
              $(this).prop('checked', true);
      });
      $('input[name="3btnradio"]').each(function() {
          var value = $(this).val();              // value
          if($('#type3').val() == value )
              $(this).prop('checked', true);
      });
    
}); */


$(document).ready(function()
{   $("input:radio[name=1btnradio]").click(function()
      {
            var value = $(this).val();              // value
            var checked = $(this).prop('checked'); 
        
            if(checked)
                $('#type1').val(value);   
      })

      $("input:radio[name=2btnradio]").click(function()
      {
            var value = $(this).val();              // value
            var checked = $(this).prop('checked'); 
        
            if(checked)
                $('#type2').val(value);   
      })

      $("input:radio[name=3btnradio]").click(function()
      {
            var value = $(this).val();              // value
            var checked = $(this).prop('checked'); 
        
            if(checked)
                $('#type3').val(value);   
      })
});

</script>
</head>
<body>
<c:import url="/menu/top.do" />

  <div class='title_line'>
    ${procateVO.name }
    <c:if test="${param.word.length() > 0 || param.type1.length() > 0 || param.type2.length() > 0 || param.type3.length() > 0 }">
      ->「${param.type1 }」 「${param.type2 }」 「${param.type3 }」 「${param.word }」 검색 ${over_search_count } 건
    </c:if> 
  </div>
  
  <aside class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.admin_id != null }">
      <a href="./over_create.do?catenum=${procateVO.catenum }">등록</a>
      <span class='menu_divide' >│</span>
    </c:if>
    <a href="javascript:location.reload();">새로고침</a>
    <span class='menu_divide' >│</span>    
    <A href="./over_list_by_cateno.do?catenum=${param.catenum }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./over_list_by_cateno_grid.do?catenum=${param.catenum }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">갤러리형</A>
  </aside>
  <br>
  
    <div class="accordion" id="accordionExample">
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          <strong>${procateVO.name } 음식 설명</strong>
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
        <div class="accordion-body">
            ${procateVO.explain }
        </div>
      </div>
    </div>
      
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingTwo">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            <strong>카테고리</strong>
          </button>
        </h2>
        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
          <div class="accordion-body">
            <table class="table">
                <tbody>
                  <tr>
                    <th scope="row">방법별</th>
                    <td>
                      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <input type="radio" class="btn-check" value='' name="1btnradio" id="1btnradio0" value="" autocomplete="off" checked>
                        <label class="btn btn-outline-primary" for="1btnradio0">전체</label>
                      
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio1" value="볶음" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio1">볶음</label>
                      
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio2" value="끓임" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio2">끓임</label>
                      
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio3" value="무침" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio3">무침</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio4" value="부침" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio4">부침</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio5" value="조림" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio5">조림</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio6" value="절임" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio6">절임</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio7" value="튀김" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio7">튀김</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio8" value="삶기" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio8">삶기</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio9" value="구이" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio9">구이</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio10" value="회" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio10">회</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio11" value="비빔" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio11">비빔</label>
                        
                        <input type="radio" class="btn-check" name="1btnradio" id="1btnradio12" value="기타" autocomplete="off">
                        <label class="btn btn-outline-primary" for="1btnradio12">기타</label>
                      </div>
                     </td>

                  </tr>
                  <tr>
                    <th scope="row">재료별</th>
                    <td>
                      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio0" value="" autocomplete="off" checked>
                        <label class="btn btn-outline-primary" for="2btnradio0">전체</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio1" value="소고기" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio1">소고기</label>
                      
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio2" value="돼지고기" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio2">돼지고기</label>
                      
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio3" value="닭고기" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio3">닭고기</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio4" value="육류" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio4">육류</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio5" value="채소류" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio5">채소류</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio6" value="해물류" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio6">해물류</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio7" value="유제품" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio7">유제품</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio8" value="곡류" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio8">곡류</label>
                        
                        <input type="radio" class="btn-check" name="2btnradio" id="2btnradio9" value="기타" autocomplete="off">
                        <label class="btn btn-outline-primary" for="2btnradio9">기타</label>
                        
                      </div>
                     </td>                 
                  </tr>
                  <tr>
                    <th scope="row">상황별</th>
                    <td>
                      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                        <input type="radio" class="btn-check" name="3btnradio" id="3btnradio0" value="" autocomplete="off" checked>
                        <label class="btn btn-outline-primary" for="3btnradio0">전체</label>
                        
                        <input type="radio" class="btn-check" name="3btnradio" id="3btnradio1" value="주식" autocomplete="off">
                        <label class="btn btn-outline-primary" for="3btnradio1">주식</label>
                      
                        <input type="radio" class="btn-check" name=3btnradio id="3btnradio2" value="부식" autocomplete="off">
                        <label class="btn btn-outline-primary" for="3btnradio2">부식</label>
                      
                        <input type="radio" class="btn-check" name="3btnradio" id="3btnradio3" value="디저트" autocomplete="off">
                        <label class="btn btn-outline-primary" for="3btnradio3">디저트</label>
                        
                      </div>
                     </td>     
                  </tr>
                </tbody>
              </table>
          </div>
        </div>
      </div>
    </div>
    <br>
  
   <%-- url에 나와있는 데이터 정보는 param.으로 챙겨올 수 있다 --%>
  <div class='position-relative' style="text-align: right; clear: both;">  
    <form class='row g-2 justify-content-end' name='frm' id='frm' method='get' action='./over_list_by_cateno_grid.do'>
      <input type='hidden' name='type1' id='type1' value=''>  <!-- 카테고리 태그1 -->
      <input type='hidden' name='type2' id='type2' value=''>  <!-- 카테고리 태그2 -->
      <input type='hidden' name='type3' id='type3' value=''>  <!-- 카테고리 태그3 -->
      <input type='hidden' name='catenum' value='${param.catenum }'>  <!-- 게시판의 구분 -->
        <div class="col-auto">
            <c:choose>
              <c:when test="${param.word != '' }"> <!-- 검색하는 경우 -->
                <input type='text' name='word' id='word' value='${param.word }' class="form-control form-control-sm" style='height:40px;'>
              </c:when>
              <c:otherwise> <!-- 검색하지 않는 경우 -->
                <input type='text' name='word' id='word' value='' class="form-control form-control-sm"  style='height:40px;'>
              </c:otherwise>
            </c:choose>
        </div>
        <div class="col-auto">
              <button type='submit' class='btn btn-outline-success'>검색</button>
              <c:if test="${param.word.length() > 0 }">  <!-- 검색 상태라면 검색 취소 버튼 활성화 -->
                <button type='button' class='btn btn-outline-success' 
                            onclick="history.back()">검색 취소</button>  
              </c:if> 
          </div>   
    </form>
  </div>

  <div class="menu_line"></div> 
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="overcontentsVO" items="${list }" varStatus="status">
      <c:set var="title" value="${overcontentsVO.title }" />
      <c:set var="content" value="${overcontentsVO.content }" />
      <c:set var="catenum" value="${overcontentsVO.catenum }" />
      <c:set var="overcontentsno" value="${overcontentsVO.overcontentsno }" />
      <c:set var="thumb1" value="${overcontentsVO.thumb1 }" />
      <c:set var="size1" value="${overcontentsVO.size1 }" />
      
      <%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 5 == 0}"> 
        <HR class='menu_line'> <%-- 줄바꿈 --%>
      </c:if>
        
      <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
      <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
      <div onclick="location.href='./over_read.do?overcontentsno=${overcontentsno}&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }&catenum=${param.catenum }'"
            style='cursor: pointer; width: 19%; height: 240px; float: left; margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: left;'>
        
        <c:choose> 
          <c:when test="${thumb1.endsWith('jpeg') || thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
            <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
            <img src="/contents/storage/${thumb1 }" style="width: 100%; height: 180px;">
          </c:when>
          <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
            <IMG src="/contents/images/none1.png" style="width: 100%; height: 180px;">
          </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${title.length()  > 16 }" >
                ${title.substring(0,16) }...<br>
            </c:when>
            <c:otherwise>
                ${title }<br>
            </c:otherwise>
        </c:choose>
        
          조회수 : ${overcontentsVO.cnt } |  ${overcontentsVO.rdate.substring(0,10) } 
        
      </div>
              

    </c:forEach>
  </div>

  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
<jsp:include page="../menu/bottom.jsp" flush='false' /> 
</body>
</html>
