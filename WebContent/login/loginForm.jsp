<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
		<link rel="stylesheet" type="text/css" href="style2.css" />
	</head>
	<body>
		<div align="center"> 
			<h3>로그인</h3>
			<form action="loginPro.jsp" method="post"> 
				<table border="1"> 
					<tr> 
						<th>아이디</th> 
						<td><input type="text" name="member_id" /></td> 
					</tr> 
					<tr> 
						<th>비밀번호</th> 
						<td><input type="password" name="member_pw" /></td> 
					</tr> 
					<tr> 
						<td colspan="2" align="center"> 
							<input type="submit" value="로그인" /> 
							<input type="button" value="메인화면으로가기" onclick="#"/> 
							<input type="button" value="회원가입" onclick="location.href='joinForm.jsp'"/> 
						</td> 
					</tr> 
				</table> 
			</form> 
		</div>
	</body>
</html>