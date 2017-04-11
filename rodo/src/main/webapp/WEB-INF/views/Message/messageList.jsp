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
		
			var html = "<table class='table-striped' style='width:430px;'>"	
				+ "<tr style='background: #666464; color:white;'>"
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
		
			$(".message-menu a").css("color", "black");
			$("#rvmsg").css("color","red");
			
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
		
				var html = "<table class='table-striped' style='width:430px;'>"	
				+ "<tr style='background: #666464; color:white;'>"
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
			
			$(".message-menu a").css("color", "black");
			$("#sdmsg").css("color","red");
			
		},
		error : function(e){
			console.log(e);
		}
		
	});
	
}

</script>
<style>
h3{
	font-weight: bolder;
	margin-left: 10px;
	font-family: "Open Sans",sans-serif;
}
.slice{
background: black;
width: 450px;
height: 3px;
margin-bottom: 15px;
margin-left: 5px;
}
.message-menu{
	margin-bottom: 15px;
}
.message-menu a{
	color : black;
	text-decoration: none;
	font-weight: bolder;
	margin-left: 10px;
	margin-right: 10px;
}
.message-menu a:hover{
	color : red;
}
#messageTable{
	margin-left: 10px;
}
#messageTable table tr td{
	border-bottom : 1px solid black;
	padding:3px;
}
</style>
</head>
<body>
<header>
	<h3>MESSAGE</h3>
	<div class="slice"></div>
	<div class="message-menu">
	<a href="#none" id="rvmsg" onclick="receivedMsg()">받은 쪽지함</a> | 
	<a href="#none" id="sdmsg" onclick="sentMsg()">보낸 쪽지함</a> | 
	<a href='writeMessage'>쪽지 보내기</a>
	<div>
</header>
<div id="messageTable">
	<table class="table-striped" style="width:440px;">
		<tr style="background: #666464; color:white;">
			<td style='width:90px;'>보낸사람</td>
			<td style='width:220px;'>제목</td>
			<td style='width:130px;'>보낸날짜</td>
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