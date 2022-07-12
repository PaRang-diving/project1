<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<jsp:useBean id="memVo" class="web.memberMgr.MemberVO"></jsp:useBean>
<jsp:setProperty name="memVo" property="*"/>
<%@ page import="web.memberMgr.MemberDAO" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	if(session.getAttribute("member_id") == null) {
		System.out.println("세션만료");
	}

%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("member_id");
	String pw = request.getParameter("member_pw");
	
	MemberDAO memdao = new MemberDAO();
	
	boolean check = memdao.loginCheck(id, pw);
	System.out.print(check);
	if(check) {
		session.setAttribute("member_id", id);
		System.out.println("로그인성공");
		response.sendRedirect("loginComplete.jsp"); //차후 로그인 완료시 이동페이지 링크
	} else {
		System.out.println("로그인실패");
		response.sendRedirect("loginFailed.jsp");
	}
	
%>



<body>

</body>
</html>