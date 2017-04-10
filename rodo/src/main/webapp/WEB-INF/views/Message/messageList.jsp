<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.1.1.js"></script>
<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script>
function readMessage(messagenum){
	location.href='readMessage?messagenum='+messagenum;
}

function receivedMsg(){

	$.ajax({
		
		type : "get",
		url : "ajaxReceived",
		success : function(data){
		
			var html = "<table class='table-striped' style='width:300px;'>"	
				+ "<tr>"
				+"<td>보낸사람</td>"
				+"<td>제목</td>"
				+"<td>보낸날짜</td>"
				+"</tr>"; 
	
			$.each(data, function(index,item){
			html += "<tr>"
						+"<td>"+item.sender+"</td>"
						+"<td><a href='#none' onclick='readMessage("+item.messagenum+")'>"
						+item.title+"</a></td>"
						+"<td>"+item.senddate+"</td>"
					+"</tr>";
			});

			html +=  "</table>";
			
			$("#messageTable").html(html);
		
			
		},
		error : function(e){
			console.log(e);
		}
		
	});
	
}

function sentMsg(){
	
	$.ajax({
		
		type : "get",
		url : "ajaxSent",
		success : function(data){
		
				var html = "<table class='table-striped' style='width:300px;'>"	
				+ "<tr>"
				+"<td>받는사람</td>"
				+"<td>제목</td>"
				+"<td>보낸날짜</td>"
				+"</tr>"; 
	
			$.each(data, function(index,item){
			html += "<tr>"
						+"<td>"+item.receiver+"</td>"
						+"<td><a href='#none' onclick='readMessage("+item.messagenum+")'>"
						+item.title+"</a></td>"
						+"<td>"+item.senddate+"</td>"
					+"</tr>";
			});

			html +=  "</table>";
			
			$("#messageTable").html(html);
		
			
		},
		error : function(e){
			console.log(e);
		}
		
	});
	
}

</script>
</head>
<body>
<header>
	<h3>쪽지함</h3>
	<a href="#none" onclick="receivedMsg()">받은 쪽지함</a> | 
	<a href="#none" onclick="sentMsg()">보낸 쪽지함</a> | 
	<a href='writeMessage'>쪽지 보내기</a>
</header>
<div id="messageTable">
	<table class="table-striped" style="width:300px;">
		<tr>
			<td>보낸사람</td>
			<td>제목</td>
			<td>보낸날짜</td>
		</tr>
		<c:forEach var="message" items="${received}">
			<tr>
				<td>${message.sender}</td>
				<td><a href="#none" onclick="readMessage('${message.messagenum}')">${message.title}</a></td>
				<td>${message.senddate}</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>