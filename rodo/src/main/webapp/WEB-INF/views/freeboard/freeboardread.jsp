<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 읽기</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

// $(function()
// {
// 	$("#replybtn").on("click", function()
// 	{
// 		var reply = $("#freereply_text").val();
// 		var boardnum = $("#free_boardnum").val();
		
// 		$.ajax
// 		({
// 			type : "post",
// 			url : "replywrite",
			
// 			data : 
// 			{
// 				free_boardnum : boardnum,
// 				freereply_text : reply
// 			},
			
// 			dataType : "JSON",
			
// 			complete : function(data)
// 			{
				
// 			}
			
// // 			success : function(data)
// // 			{
// // 				console.log("댓글");
				
// // 				alert("안나오면 디짐");
// // 			},
			
			
			
// // 			error : function(e)
// // 			{
// // 				console.log(e);
// // 			}
// 		})
// 	})
// })

</script>

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
			
				<img alt = "" src = "downloadFree?free_boardnum=${board.free_boardnum}"><br>
				<a href = "downloadFree?free_boardnum=${board.free_boardnum}">
					${board.freefile_original}
				</a>
				
			</c:if>
			
			
		</td>
	</tr>
	
	<tr>
		<td>
			<c:if test = "${sessionScope.loginId!=null}">
				<c:if test = "${sessionScope.loginId == board.free_id}">
					<a href = "updateboard?free_boardnum=${board.free_boardnum}">수정</a>
					<a href = "deleteFreeboard?free_boardnum=${board.free_boardnum}">삭제</a>
				</c:if>
			</c:if>
				<a href = "freeboardlist">목록보기</a>
		</td>
	</tr>
	
	
</table>

<p>

<form action = "replywrite" method = "post">

리플내용

	<input type = "hidden" name = "free_boardnum" id = "free_boardnum" value = "${board.free_boardnum}">
	<input type = "text" name = "freereply_text" id = "freereply_text">
	
	<input type = "submit" id = "replybtn" value = "확인">
	
</form>
	
<table>
	<c:forEach var = "reply" items = "${replylist}">
		
	<tr>

		<td>
			${reply.freereply_id}
		</td>
		
		<td>
			${reply.freereply_text}
		</td>
		
		<td>
			${reply.freereply_input_dt}
		</td>
		
		<td>
			<c:if test = "${sessionScope.loginId == reply.freereply_id}">
				<a href = "">수정</a>
			</c:if>
		</td>
		
		<td>
			<c:if test = "${sessionScope.loginId == reply.freereply_id}">
				<a href = "deletereply?freereply_replynum=${reply.freereply_replynum}&free_boardnum=${reply.free_boardnum}">삭제</a>
			</c:if>
		</td>
		
	</tr>
	
	</c:forEach>
</table>








</body>
</html>