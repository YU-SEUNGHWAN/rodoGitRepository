<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
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
		var reply = $("#qareply_text").val();
		var boardnum = $("#qa_boardnum").val();
		
		$.ajax
		({
			type : "post",
			url : "qareplywrite",
			
			data : 
			{
				qa_boardnum : boardnum,
				qareply_text : reply
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
			                     +"<td class='rename'>"+item.qareply_id+"</td>"
			                     +"<td id='"+item.qareply_replynum+"' class='retext'>"+item.qareply_text+"</td>"
			                     +"<td class='redate'>"+item.qareply_input_dt+"</td>"
			                     +"<td class='reetc'>"
			                           +"<td><a href='javascript:replyUpdateForm("+item.qareply_replynum+","+item.qa_boardnum+")'>[수정]</a></td>"
			                           +"<td><a href='#none' onclick='deletereplywarp("+item.qareply_replynum+", "+item.qa_boardnum+")'>[삭제]</a></td>"
			                     +"</td>"
			                  +"</tr>";
		         });
				
		         $("#qareply_text").val("");
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
		url : "qadeletereply",
		
		data : 
		{
			qareply_replynum : replynum,
			qa_boardnum : boardnum
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
		                     +"<td class='rename'>"+item.qareply_id+"</td>"
		                     +"<td id='"+item.qareply_replynum+"' class='retext'>"+item.qareply_text+"</td>"
		                     +"<td class='redate'>"+item.qareply_input_dt+"</td>"
		                     +"<td class='reetc'>"
		                           +"<a href='javascript:replyUpdateForm("+item.qareply_replynum+","+item.qa_boardnum+")'>[수정]</a>"
		                     	   +"<a href='#none' onclick='deletereplywarp("+item.qareply_replynum+", "+item.qa_boardnum+")'>[삭제]</a>"
		                     +"</td>"
		                  +"</tr>";
	         });
			
	         $("#qareply_text").val("");
	         $("#replytable").html(html);
		},
		
		error : function(e)
		{
			console.log(e);
		}
	})
}


function deleteqaboard (qa_boardnum)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href="deleteqaboard?qa_boardnum="+${board.qa_boardnum};
	}
}

</script>

</head>
<body>

<h1> 게시판 글 읽기 </h1>

<table>
	<tr>
		<td>작성자</td>
		<td>${board.qa_id}</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td> ${board.qa_input_dt}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${board.qa_title}</td>
	</tr>
	<tr>
		<td>내용</td>
		<td>${board.qa_content}</td>
	</tr>
				<c:if test = "${board.qafile_saved.size() > 0}">
	<tr>
		<td>파일 첨부</td>
		<td>
			<c:forEach items="${board.qafile_saved}" var ="qa">
				<img src='qaLoad?origin=${qa}' />
				<br>
			</c:forEach>
		</td>
	</tr>
				</c:if>
	<tr>
		<td>
			<c:if test = "${sessionScope.loginId!=null}">
				<c:if test = "${sessionScope.loginId == board.qa_id}">
					<a href = "updateqaboard?qa_boardnum=${board.qa_boardnum}">[수정]</a>
					<a href ='#none' onclick="deleteqaboard('${board.qa_boardnum}')">[삭제]</a>
				</c:if>
			</c:if>
				<a href = "qaboardlist">목록보기</a>
		</td>
	</tr>
	
	
</table>

<p>


리플내용

	<input type = "hidden" name = "qa_boardnum" id = "qa_boardnum" value = "${board.qa_boardnum}">

	<input type = "text" name = "qareply_text" id = "qareply_text">
	<input type = "hidden" id = "replynum" value = "${reply.qareply_replynum}">
	<input type = "hidden" id = "boardnum" value = "${reply.qa_boardnum}">
	
	<input type = "submit" id = "replybtn" value = "확인">
	
	
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
			${reply.qareply_id}
		</td>
		
		<td>
			${reply.qareply_text}
		</td>
		
		<td>
			${reply.qareply_input_dt}
		</td>
		
		<td>
			<c:if test = "${sessionScope.loginId == reply.qareply_id}">
				<a href = "">[수정]</a>
				<a id = "deletereplywarp" href="#none" onclick = "deletereplywarp('${reply.qareply_replynum}', '${reply.qa_boardnum}')">[삭제]</a>
			</c:if>
		</td>
		
		<%-- <td>
			<c:if test = "${sessionScope.loginId == reply.qareply_id}">
								
			</c:if>
		</td> --%>
		
	</tr>
	</c:forEach>
	
</table>

</body>
</html>