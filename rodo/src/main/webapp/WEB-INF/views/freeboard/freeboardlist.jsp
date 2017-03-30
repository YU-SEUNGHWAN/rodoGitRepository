<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>



</script>

</head>
<body>

	<h1> 자유게시판 </h1>

<p><a href = "freeboardwrite">글쓰기</a></p>

<table>

<c:forEach var = "board" items = "${list}">
	<tr>
		<td class = "list">
			<p>작성자 : ${board.id}</p>
			<p>제목 : <a href = "read?boardnum=${board.boardnum}">${board.title}</a></p>
		</td>
	</tr>
</c:forEach> 
</table>

</body>
</html>