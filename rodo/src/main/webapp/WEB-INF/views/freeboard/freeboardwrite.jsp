<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판 게시글작성</title>
</head>
<body>

<h1> 자유게시판 게시글작성 </h1>

<form action = "freeboardwrite" method = "post">

<table border = "1">
	<tr>
		<td>
			제목
		</td>
		
		<td>
			<input type = "text" name = "title" id = "title">
		</td>
	</tr>
	
	<tr>
		<td>
			본문
		</td>
	
		<td>
			<textarea rows = "20" cols = "50" name = "content"></textarea>
		</td>
	</tr>
	
	<tr>
		<td>
			파일첨부
		</td>
		
		<td>
			<input type = "file" name = "upload" size = "30" multiple = "multiple">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type = "submit" value = "작성완료">
		</td>
	</tr>
	
</table>

</form>

</body>
</html>