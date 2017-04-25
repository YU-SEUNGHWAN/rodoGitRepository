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

$(function()
{
	$("#replybtn").on("click", function()
	{
		var reply = $("#freereply_text").val();
		var boardnum = $("#free_boardnum").val();
		
		$.ajax
		({
			type : "post",
			url : "replywrite",
			
			data : 
			{
				free_boardnum : boardnum,
				freereply_text : reply
			},
			
			/* complete : function(data)
			{
				alert("오는거 맞냐");
			},  */
			
			success : function(data)
			{
		         console.log(data);
		         var html =    "<tr class='replymenu'>"
		                  +"<td>아이디</td>"
		                  +"<td>댓글</td>"
		                  +"<td>날짜</td>"
		                  +"<td></td>"
		                  +"</tr>"; 
		         
		            $.each(data, function(index,item)
		            {
			            html += "<tr>"
			                     +"<td class='rename'>"+item.freereply_id+"</td>"
			                     +"<td id='"+item.freereply_replynum+"' class='retext'>"+item.freereply_text+"</td>"
			                     +"<td class='redate'>"+item.freereply_input_dt+"</td>"
			                     +"<td class='reetc'>"
			                           +"<td><a href='javascript:replyUpdateForm("+item.freereply_replynum+","+item.free_boardnum+")'>[수정]</a></td>"
			                           +"<td><a href='#none' onclick='deletereplywarp("+item.freereply_replynum+", "+item.free_boardnum+")'>[삭제]</a></td>"
			                     +"</td>"
			                  +"</tr>";
		         });
				
		         $("#freereply_text").val("");
		         $("#replytable").html(html);
		      },
		      
		      error : function(e)
		      {
		         console.log(e);
		      }
		   })
		})
	})

function deletereplywarp(replynum, boardnum)
{
	console.log(replynum);
	console.log(boardnum);
	
	$.ajax
	({
		type : "get",
		url : "deletereply",
		
		data : 
		{
			freereply_replynum : replynum,
			free_boardnum : boardnum
		},
		
		success : function(data)
		{	
			console.log(data);
			
	         var html =    "<tr class='replymenu'>"
	                  +"<td>아이디</td>"
	                  +"<td>댓글</td>"
	                  +"<td>날짜</td>"
	                  +"<td></td>"
	                  +"</tr>"; 
	         
	            $.each(data, function(index,item)
	            {
		            html += "<tr>"
		                     +"<td class='rename'>"+item.freereply_id+"</td>"
		                     +"<td id='"+item.freereply_replynum+"' class='retext'>"+item.freereply_text+"</td>"
		                     +"<td class='redate'>"+item.freereply_input_dt+"</td>"
		                     +"<td class='reetc'>"
		                           +"<a href='javascript:replyUpdateForm("+item.freereply_replynum+","+item.free_boardnum+")'>[수정]</a>"
		                     	   +"<a href='#none' onclick='deletereplywarp("+item.freereply_replynum+", "+item.free_boardnum+")'>[삭제]</a>"
		                     +"</td>"
		                  +"</tr>";
	         });
			
	         $("#freereply_text").val("");
	         $("#replytable").html(html);
		},
		
		error : function(e)
		{
			console.log(e);
		}
	})
}


function deletefreeboard(free_boardnum)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href="deletefreeboard?free_boardnum="+${board.free_boardnum};
	}
}

</script>

</head>
<body>

<h1> 게시판 글 읽기 </h1>

<table>
	<tr>
		<td>작성자</td>
		<td>${board.free_id}</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td> ${board.free_input_dt}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${board.free_title}</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>${board.free_content}</td>
	</tr>
				<c:if test = "${board.freefile_saved.size() > 0}">
	<tr>
		<td>파일 첨부</td>
		<td>
			<c:forEach items="${board.freefile_saved}" var ="free">
				<img src='freeLoad?origin=${free}' />
			</c:forEach>
		</td>
	</tr>
				</c:if>
	<tr>
		<td>
			<c:if test = "${sessionScope.loginId!=null}">
				<c:if test = "${sessionScope.loginId == board.free_id}">
					<a href = "updateboard?free_boardnum=${board.free_boardnum}">[수정]</a>
					<a href ='#none' onclick="deletefreeboard('${board.free_boardnum}')">[삭제]</a>
				</c:if>
			</c:if>
				<a href = "freeboardlist">목록보기</a>
		</td>
	</tr>
	
	
</table>

<p>

<!-- <form action = "replywrite" method = "post"> -->

리플내용

	<input type = "hidden" name = "free_boardnum" id = "free_boardnum" value = "${board.free_boardnum}">
	<input type = "text" name = "freereply_text" id = "freereply_text">
		
	<input type = "hidden" id = "replynum" value = "${reply.freereply_replynum}">
	<input type = "hidden" id = "boardnum" value = "${reply.free_boardnum}">
	
	<input type = "submit" id = "replybtn" value = "확인">
	
<!-- </form> -->
	
<table id = "replytable">
	
	<tr class = "replymenu">
		<td>아이디</td>
		<td>댓글</td>
		<td>날짜</td>
		<td></td>
	</tr>
	
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
				<a href = "">[수정]</a>
				<a id = "deletereplywarp" href="#none" onclick = "deletereplywarp('${reply.freereply_replynum}', '${reply.free_boardnum}')">[삭제]</a>
			</c:if>
		</td>
		
		<%-- <td>
			<c:if test = "${sessionScope.loginId == reply.freereply_id}">
								
			</c:if>
		</td> --%>
		
	</tr>
	</c:forEach>
	
</table>



</body>
</html>