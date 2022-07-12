<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>

<!-- board CSS 값을 불러와 적용 -->
<link rel="stylesheet" href="style2.css" type="text/css"/>
<title>게시판</title>

</head>
<body align="center">

	<h1>자유 게시판</h1>
	<div class="c">
	<table border="2" align="center">
	<!-- colgroup을 사용해 반응형 길이 조정, 제목을 50%로 고정하고 나머지 항목은 자동으로 배분 -->
			<colgroup>
  				<col width="*" />
  				<col width="50%" />
  				<col width="*" />
  				<col width="*" />
  			</colgroup>
		<tr>
		<!-- 테이블 생성 -->
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>
		
		<!--  게시판 구현을 위한 sql 변수 등록 -->
	<%
		Connection con = null;
		Statement stmt = null;
		try {			
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3308/jspdb";
				con = DriverManager.getConnection(url,"root","1q1q2w2w");
				
				//String url = "jdbc:mysql://localhost:3308/jspdb";
				//String user = "root";
				//String password = "1q1q2w2w";
				//String driver = "com.mysql.jdbc.Driver";
				
				//Class.forName(driver);
				//con = DriverManager.getConnection(url, user, password);
						
								
		} catch (ClassNotFoundException e){
			System.out.println("드라이브로딩실패" + e);
			
		} catch (SQLException e) {
			System.out.println("DB 연결 실패" + e);
			
		} catch (Exception e) {
			out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
		
		stmt = con.createStatement();
		String sql = "select * from message order by id asc ";
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs != null) {
				while (rs.next()) {
						int id = Integer.parseInt(rs.getString("id"));
	%>
	
	<!-- 게시물 각 제목에 링크를 걸어 목록을 표시 -->
	<tr>
			<td><%=id%></td>
			<td><a href=display.jsp?id=<%=id%>>
				<%=rs.getString("subject") %></a></td>
			<td><%=rs.getString("name") %></td>
			<td><%=rs.getString("time") %></td>
			<td><%=rs.getString("hit") %></td>
	</tr>
	
	<%
				}
		}
	%>
	</table>
	</div>
	<!-- 게시글 쓰기 버튼 생성 -->
	<a href="community_write.jsp"><input type="button" value="게시글 쓰기"></a>&nbsp;&nbsp;&nbsp;
	<a href="main.html"><input type="button" value="메인화면으로 가기"></a>
	<%
			if (stmt != null)
					stmt.close();
			if (con != null)
					con.close();
	%>
</body>
</html>