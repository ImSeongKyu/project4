<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>Resort world</title>

<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<!-- <script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

</script>
</head> 


<body>
<c:import url="/menu/top.do" />
  <DIV class='title_line'>회원 정보 조회</DIV>

  <DIV class='content_body'>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./the_create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./the_list.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  
  <div style="width: 60%; margin: 0px auto ">
  <FORM name='frm' id='frm'>
    <input type="hidden" name="thememberno" value="${thememberVO.thememberno }">
    
    <div class="form-group"> <%-- 줄이 변경되지 않는 패턴 --%>
      <label>아이디*:
        <input type='text' class="form-control form-control-sm" name='id' id='id' value='${thememberVO.id }' required="required" placeholder="아이디*" autofocus="autofocus" readonly>
      </label>
    </div>   
  
    <div class="form-group"> <%-- label의 크기에따라 input 태그의 크기가 지정되는 형태 --%>
      <label>성명*:
        <input type='text' class="form-control form-control-sm" name='mname' id='mname' value='${thememberVO.mname }' required="required" placeholder="성명" readonly>
      </label>
    </div>   

    <div class="form-group"> <%-- label의 크기에따라 input 태그의 크기가 지정되는 형태, 줄이 변경되지 않는 패턴 --%>
      <label>전화 번호:
        <input type='text' class="form-control form-control-sm" name='tel' id='tel' value='${thememberVO.tel }' required="required" placeholder="전화번호" readonly>
      </label>
    </div>   

    <div class="form-group"> <%-- 줄이 변경되지 않는 패턴 --%>
      <label>우편 번호:
        <input type='text' class="form-control form-control-sm" name='zipcode' id='zipcode' value='${thememberVO.zipcode }' placeholder="우편번호" readonly>
      </label>
    </div>  

    <div class="form-group">
      <label style="width: 100%;">주소:</label> <%-- label의 크기를 변경하여 주소를 많이 입력받는 패턴 --%>
      <input type='text' class="form-control form-control-sm" name='address1' id='address1' value='${thememberVO.address1 }' placeholder="주소" readonly>
    </div>   

    <div class="form-group">
      <label style="width: 100%;">상세 주소:</label>
      <input type='text' class="form-control form-control-sm" name='address2' id='address2' value='${thememberVO.address2 }' placeholder="상세 주소" readonly>
    </div>   
    
    <div class="form_input">
      <button type="button" onclick="location.href='./the_read.do'" class="btn btn-primary btn-sm">회원정보 수정</button>
      <button type="button" onclick="history.back()" class="btn btn-primary btn-sm">뒤로 가기</button>
    </div>   
  </FORM>
  </DIV>
  
  </DIV>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

