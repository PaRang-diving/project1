<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.memberMgr.*" %>
<jsp:useBean id="memVo" class="web.memberMgr.MemberVO"></jsp:useBean>
<jsp:setProperty name="memVo" property="*"/> 
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html>
 
	<head> 
		<meta charset="UTF-8"> 
		<title>Join</title>
		<link rel="stylesheet" type="text/css" href="style2.css" />
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

		
	</head> 
	<body>
		
	
		<div align="center"> 
			<h3>[회원가입 페이지]</h3> 
			<form action="member_control.jsp" method="post"> 
			<input type=hidden id="hdnId" name="action" value="insert">
			
				<table border="1"> 
					<tr> 
						<th>아이디</th> 
						<td><input type="text" name="member_id" id="member_id" required="required"/>
							<input type="button" name=memberCheck value="중복확인" onclick="chkDuplFnc();">
						</td>
					</tr> 
					<tr> 
						<th>비밀번호</th>
						<td><input type="password" name="member_pw" id="member_pw"required="required"/></td> 
					</tr> 
					<tr> 
						<th>이름</th> 
						<td><input type="text" name="member_name"id="member_name" required="required"/></td> 
					</tr> 
					<tr> 
						<th>나이</th> 
						<td><input type="number" name="member_age"id="member_age" required="required" min="0" /></td> 
					</tr> 
					<tr> 
						<th>성별</th> 
						<td> <input type="radio" name="member_gender" value="남" checked="checked" />남자 
						<input type="radio" name="member_gender" value="여" />여자 
						</td> 
					</tr> 
					<tr> 
						<th>이메일 주소</th> 
						<td><input type="text" name="member_email" id="member_email" maxlength="30" required="required"/></td> 
					</tr> 
					<tr> 
						<td colspan="2" align="center"> 
						<input type="button" value="확인" onclick="join();"/> <!--아이디 중복확인을 먼저 해야 확인버튼을 누를 수 있다-->
						<input type="button" value="다시작성" onclick="location.href='joinForm.jsp';"> 
						<input type="button" value="뒤로가기" onclick="window.close();"/> 
						</td> 
					</tr> 
				</table> 
			</form> 
		</div> 
		
		<script type="text/javascript">
			var globalFlag = false;				// 중복 체크 여부를 확인하기위한 글로벌 변수

			document.addEventListener("DOMContentLoaded", function(){		// 모든 소스를 로드하여 화면구성이 완료된 직후 실행되는 함수.
				var isDupl = <%=request.getParameter("isDupl")%>;		// isDupl이라는 파리미터의 값을 저장 (최초 url 직접입해서 들어왔을때에는 null, 중복체크를 통해 member_control.jsp 에 다녀온 후엔 'Y' 혹은 'N')
				if(!chkNull(isDupl)) {		// isDupl 의 값이 비어있지 않으면
					if(isDupl == 'Y') {
						alert("중복된 아이디가 있다.")
						$('#member_id').val(''); 				// 화면의 member_id 를 id 값으로 갖는 input 박스의 값을 '' 으로 초기화 해준다.
						$('#member_id').prop("readonly", false);	// 화면의 member_id 를 id 값으로 갖는 input 박스의 readonly 속성을 비활성화 해준다
					} else if (isDupl == 'N'){
						alert("중복체크 완료");
						globalFlag = true;
					
						$('#member_id').val('<%=memVo.getMember_id()%>');	// 화면의 member_id 를 id 값으로 갖는 input 박스의 값을 memVo 객체 안에 저장되어 있는 mem_id값을 가져와서 세팅해준다.
						$('#member_id').prop("readonly", true);		// 화면의 member_id 를 id 값으로 갖는 input 박스의 readonly 속성을 활성화 해준다.
					}
				
					if(chkNull('<%=memVo.getMember_pw()%>')){
						$('#member_pw').val(''); 
					} else {
						$('#member_pw').val('<%=memVo.getMember_pw()%>');
					}  	   
				
					if(chkNull('<%=memVo.getMember_name()%>')){
						$('#member_name').val('');
					} else {
						$('#member_name').val('<%=memVo.getMember_name()%>');
					}
				
					if(chkNull('<%=memVo.getMember_age()%>')){
						$('#member_age').val('');
					} else {
						if('<%=memVo.getMember_age()%>' == 0) {
							$('#member_age').val('');	
						} else {
							$('#member_age').val('<%=memVo.getMember_age()%>');
						}
					}
				
					if(chkNull('<%=memVo.getMember_gender()%>')){
						$('input[name="member_gender"]:radio[value="남"]').prop('checked',true);					// name 을 member_gender 로 갖는 radio 세트중에 값이 "남"인 라디오 영역의 속성을 활성화 한다.	
					} else {
						if('<%=memVo.getMember_gender()%>' == '남') {
							$('input[name="member_gender"]:radio[value="남"]').prop('checked',true);
						} else {
							$('input[name="member_gender"]:radio[value="여"]').prop('checked',true);
						}
					}
				
					if(chkNull('<%=memVo.getMember_email()%>')){
						$('#member_email').val('');
					} else {
						$('#member_email').val('<%=memVo.getMember_email()%>');
					}      
				}
			});
		
			function chkDuplFnc() {				// 아이디 중복 여부를 체크하는 함수 
				if(chkNull($('#member_id').val())) {
					alert("아이디를 입력해!");
					return;
				}
			
				$("#hdnId").val("chk");			// form 태그 내부에 있는 hdnId  라는 아이디를 갖는 영역의 값을 'chk'로 세팅한다.
				$("form").submit();				// member_control.jsp를 호출한다.(이때에 member_control.jsp 로 가져가는 값은 form태그 안의 입력값 전부)
			
			}
		
			function chkNull (text) {		// 파라미터로 받는 (text)의 값이 비어있는지 아닌지 여부를 판단하는 함수 (비어있으면 true 를 리턴하고, 비어있지 않으면 false 를 리턴한다.)
			
				if(text == null || text == 'null' || text == '' || text == undefined) {
					return true;
				} else {
					return false;
				}
			}
		
			function join() {				// 회원가입을 수행하는 함수
				if(globalFlag) {		// globalFlag 가 true 인 경우에만 수행한다.
					if(chkVali()) {		// 입력값이 모두 세팅되어 있을때만 수행한다.
						$("#hdnId").val("insert");
						$("form").submit();	// 서브미션 한당 (가져가는 값은 form 태그의 전부)
					}
				} else {
					alert("아이디 중복체크를 먼저 진행해 주세요!");
					return;
				}	 
			}
		
			function chkVali() {	// 입력값 유효성 체크 (빈값 있는지.. )
			
				if(chkNull($('#member_id').val())) {
					alert("아이디를 입력 해주세요.");
					return false;
				}
				if(chkNull($('#member_pw').val())) {
					alert("패스워드를 입력 해주세요.");
					return false;
				}
			
				if(chkNull($('#member_name').val())) {
					alert("이름을 입력 해주세요.");
					return false;
				}
			
				if(chkNull($('#member_age').val())) {
					alert("나이를 입력 해주세요.");
					return false;
				}

				if(chkNull($('#member_email').val())) {
					alert("이메일을 입력 해주세요.");
					return false;
				}
				return true;
			}
		</script>
	</body>
</html>
