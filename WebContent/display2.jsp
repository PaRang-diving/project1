<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<link rel="stylesheet" href="style2.css" type="text/css" />
<title>게시글 표시</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body align="center">
<h1>게시글 내용</h1>
<div>
<%
		String subject="", memo="", name="", time="", hit="";
		int id = Integer.parseInt(request.getParameter("id"));
		
		Connection con=null;
		Statement stmt=null;
		
		try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3308/jspdb";
				con = DriverManager.getConnection(url,"root","1q1q2w2w");
		} catch(Exception e) {
				out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
		}
		stmt = con.createStatement();
		// 글을 볼 시에 해당 id의 DB hit값 1개 증가
		String sqll = "UPDATE message2 SET hit= hit + 1 WHERE id = " + id;
		stmt.executeUpdate(sqll);
		
		//	각 해당하는 컬럼의 DB값을 읽어오기
		String sql = "select * from message2 where id = " + id;
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
				subject = rs.getString("subject");
				memo = rs.getString("memo");
				name = rs.getString("name");
				time = rs.getString("time");
				hit = rs.getString("hit");
		}
%>
<!-- 게시글 내용 테이블 -->
<div class="c">
<table border = "1" style="table-layout: fixed" align="center">
<tr>
		<td>제목</td>
		<td><%= subject %></td>
</tr>
<tr>
		<td>작성자</td>
		<td><%=name %></td>
</tr>
<tr>
		<td>내용</td>
		<td><%=memo %></td>
</tr>
<tr>
		<td>날짜</td>
		<td><%=time %></td>
</tr>
<tr>
		<td>조회수</td>
		<td><%=hit %></td>
</tr>
</table>
</div>
</div>
<br>
<br>
<!-- 버튼(잘림) -->
<a href="qna_list.jsp"><input type="button" value="게시글 리스트 보기"></a>
</body>
</html>