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

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
  window.onload = function() {
	  document.querySelector('#id').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('btn_checkID').focus();
        }
      }); 
      
      document.querySelector('#passwd').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('passwd2').focus();
        }
      }); 
      
      document.querySelector('#passwd2').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('mname').focus();
        }
      }); 
      
      document.querySelector('#mname').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('tel').focus();
        }
      });
      
      document.querySelector('#tel').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('btn_DaumPostcode').focus();
        }
      }); 
      
      document.querySelector('#address2').addEventListener('keypress', (event) => {
      // document.getElementById('passwd').addEventListener('keypress', (event) => {
        if(event.key === 'Enter') {
          document.getElementById('btn_send').focus();
        }
      });
  }

  // jQuery ajax 요청
  function checkID() {
    // console.log('-> checkID()');
      
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
    
    // let frm = $('#frm'); // id가 frm인 태그 검색
    // let id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    // let cnt = parseInt(document.querySelector('form[name="frm"] #id').value);
    // let params = '';
    // let msg = '';
    // console.log('-> id : ' + id);
    
    // jQuery
    // if ($.trim(id).length == 0) { // $.trim(id): 문자열 좌우의 공백 제거, length: 문자열 길이, id를 입력받지 않은 경우
    //  // console.log('-> $.trim(id).length == 0');
    //  $('#id_msg').html('ID 입력은 필수 입니다. ID(이메일)는 3자이상 권장합니다.');
    //  $('#id_msg').attr('class', 'span_warning'); 
    //  $('#id').focus();

    // Javascript
    let id = document.getElementById('id');
    let id_msg = document.getElementById('id_msg');

    if (id.value.trim().length == 0) {
      id_msg.innerHTML= 'ID가 누락됬습니다. ID 입력은 필수 입니다. ID(이메일)는 3자이상 권장합니다.';
      id_msg.classList.add('span_warning');    // class 적용
      id.focus();

      return false;  // 회원 가입 진행 중지
      
    } else {  // when ID is entered
    	id_msg.classList.remove('span_warning'); // class 삭제

        //let formData = { "id" : id };
        //하단은 jquery방법, 위의 방법은 JSON방법
        //formData = 'id=' + id.value;
        // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
        // alert('params: ' + params);

        let id = document.getElementById('id');//ID의 정체가 존재해야 해당 값을 조정할 수 있다.
        //근데 이걸 빠트리냐?
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
  function send() { // 회원 가입 처리
      let id = document.getElementById('id');
      let id_msg = document.getElementById('id_msg');
    
      if (id.value.trim().length == 0) {
        id_msg.innerHTML= 'ID가 누락됬습니다. ID 입력은 필수 입니다. ID(이메일)는 3자이상 권장합니다.';
        id_msg.classList.add('span_warning');    // class 적용
        id.focus();
    
        return false;  // 회원 가입 진행 중지
        
      }
    
      // 패스워드를 정상적으로 2번 입력했는지 확인
      let passwd = document.getElementById('passwd');
      let passwd2 = document.getElementById('passwd2');
      let passwd2_msg = document.getElementById('passwd2_msg');
    
      if (passwd.value != passwd2.value) {
        passwd2_msg.innerHTML= '입력된 패스워드가 일치하지 않습니다.';
        passwd2_msg.classList.add('span_warning');    // class 적용
        passwd.focus();  // 첫번째 패스워드로 focus 설정
    
        return false;  // 회원 가입 진행 중지
      }
    
      let mname = document.getElementById('mname');
      let mname_msg = document.getElementById('mname_msg');
    
      if (mname.value.length == 0) {
        mname_msg.innerHTML= '이름 입력은 필수입니다.';
        mname_msg.classList.add('span_warning');    // class 적용
        mname.focus();
    
        return false;  // 회원 가입 진행 중지
      }
    
      document.getElementById('frm').submit(); // required="required" 작동 안됨.
  }  
</script>
</head> 


<body>
<c:import url="/menu/top.do" />

  <DIV class='title_line'>회원 가입(*: 필수)</DIV>

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./the_create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./the_list.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  
  <div style="width: 60%; margin: 0px auto ">
  <FORM name='frm' id='frm' method='POST' action='./the_create.do' class="">
  
  <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='id' id='id' value='' required="required" placeholder="아이디*" autofocus="autofocus">
      <label for="id">아이디*</label>
      
    </div>
    <div style="text-align: center;">
      <span id='id_msg'></span>
      <br>
      <button type='button' id="btn_checkID" onclick="checkID()" class="btn btn-primary btn-sm">중복확인</button>
      
    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="password" class="form-control" name='passwd' id='passwd' value='' required="required" placeholder="패스워드*" autofocus="autofocus">
      <label for="mname">패스워드*</label>
      
    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="password" class="form-control" name='passwd2' id='passwd2' value='' required="required" placeholder="패스워드확인*" autofocus="autofocus">
      <label for="mname">패스워드 확인*</label>
      <span id='passwd2_msg'></span>
    </div>
    
    
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='mname' id='mname' value='' required="required" placeholder="성명*" autofocus="autofocus">
      <label for="mname">성명*</label>
      
    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='tel' id='tel' value='01012345678' required="required" placeholder="전화 번호" autofocus="autofocus">
      <label for="tel">전화 번호</label>
      
    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='zipcode' id='zipcode' value='' required="required" placeholder="우편번호" autofocus="autofocus">
      <label for="zipcode">우편번호</label>
      
    </div>
    <div style="text-align:center;">
        <button type="button" id="btn_DaumPostcode" onclick="DaumPostcode()" class="btn btn-primary btn-sm">우편번호 찾기</button>
    </div>
    <div>
<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                /*
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample3_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample3_extraAddress").value = '';
                }
                */

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; // 우편번호
                document.getElementById("address1").value = addr;  // 주소

                document.getElementById("address2").innerHTML=""; // 상세 주소 지우기
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();  // 상세 주소로 포커스 이동

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='address1' id='address1' value='${thememberVO.address1 }' required="required" placeholder="주소" autofocus="autofocus">
      <label for="address1">주소</label>
      
    </div>
    <div class="form-floating mb-1 mt-3" style="width: 60%; margin:0px auto;">
      <input type="text" class="form-control" name='address2' id='address2' value='${thememberVO.address2 }' required="required" placeholder="상세주소" autofocus="autofocus">
      <label for="address2">상세주소</label>
      
    </div>
    
    <div class="form_input" style="text-align:center; margin-bottom:20px">
      <button type="button" id='btn_send' onclick="send()" class="btn btn-info btn-sm">가입</button>
      <button type="button" onclick="history.back()" class="btn btn-info btn-sm">취소</button>
    </div>   
  </FORM>
  </DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

