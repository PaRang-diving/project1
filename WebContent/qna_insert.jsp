<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<link rel="stylesheet" href="style2.css" type="text/css" />
<body>
<%
		String name, email, subject, memo, time;
		name = request.getParameter("name");
		email = request.getParameter("email");
		subject = request.getParameter("subject");
		memo = request.getParameter("memo");
		
		ResultSet rs = null;
		String sql;
		Connection con=null;
		Statement stmt=null;
		try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3308/jspdb";
				con = DriverManager.getConnection(url,"root","1q1q2w2w");
		}
		catch(Exception e) {
				out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
		}
		stmt = con.createStatement();

		//	DB 서버에 게시물을 저장	
		sql = "insert into message2 "+
				"(subject, name, time, memo) "+
				"values (" + "'" +subject+ "','"+name+"',now(),'" +memo+"');";
		try {
				stmt.executeUpdate(sql);
		} catch(Exception e) {
					out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr>");
					out.println(e.getMessage());
					e.printStackTrace();
		}
%>

<div class="c">
<h3>게시글이 등록되었습니다.</h3>
<a href="qna_list.jsp"><input type="button" value="게시글 리스트 보기"></a>
</div>
</html>