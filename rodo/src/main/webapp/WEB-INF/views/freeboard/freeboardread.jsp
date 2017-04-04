<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 읽기</title>
</head>
<body>

<h1> 게시판 글 읽기 </h1>

<table>
	<tr>
		<td>
			작성자
		</td>
		
		<td>
			${board.free_id}
		</td>
	</tr>
	
	<tr>
		<td>작성일 </td>
		
		<td> ${board.free_input_dt} </td>
	</tr>
	
	<tr>
		<td>
			내용
		</td>
		
		<td>
			${board.free_content}
		</td>
	</tr>
	
	<tr>
		<td>
			파일 첨부
		</td>
		
		<td>
		
			<c:if test = "${board.freefile_original != null}">
			
				<img alt = "" src = "download?free_boardnum=${board.free_boardnum}"><br>
				<a href = "download?free_boardnum=${board.free_boardnum}">
					${board.freefile_original}
				</a>
				
			</c:if>
			
			
		</td>
	</tr>
	
	<tr>
		<td>
			<c:if test = "${sessionScope.id!=null}">
				<c:if test = "${sessionScope.id == board.free_id}">
					<a href = "updateboard?free_boardnum=${board.free_boardnum}">수정</a>
				</c:if>
			</c:if>
		</td>
	</tr>
	
	
</table>

</body>
</html>