<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<Html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 입력</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="style2.css" type="text/css"/>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body align="center">
<div>
	<h1>게시글 입력 화면</h1>
	<div class="c">
	<form action="qna_insert.jsp" method="post" align="center">
			<table border="0" align="center">
					<tr>
							<td>제목</td>
							<td><input type="text" name="subject" size="60" class="form-control"
       							placeholder="제목 입력(4-60)"
       							maxlength="60" required="required"
       							pattern=".{4,60}"></td>
					</tr>
					<tr>
							<td>작성자</td>
							<td><input type="text" name="name" size="60" class="form-control"
       							placeholder="작성자 입력(4-10)"
       							maxlength="10" required="required"
       							pattern=".{4,10}"></td>
					</tr>
					<tr>
							<td>내용</td>
							<td><textarea name="memo" rows="10" class="form-control"
       							placeholder="내용 입력" required="required"></textarea> </td>
					</tr>
					<tr>
					</tr>
					
			</table>
			<br> <br> <input type="submit" value="게시글 등록"> <input type="reset" value="다시 쓰기">
	</form>
</div>	
	<a href="qna_list.jsp"><input type="button" value="게시글 리스트 보기"></a>
	<br>
	</div>
</body>
</Html>