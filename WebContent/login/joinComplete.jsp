<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("utf-8"); %>

<%
	String isLogin = request.getParameter("isLogin");
	System.out.println("isLogin :: " +isLogin);
	
	
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style2.css" />
</head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" language="javascript">


</script>

<body>
	<h3>회원가입이 완료되었습니다. </h3>
	<input type="button" value="로그인 하러가기" onclick="window.close();"/> 
</body>
</html>