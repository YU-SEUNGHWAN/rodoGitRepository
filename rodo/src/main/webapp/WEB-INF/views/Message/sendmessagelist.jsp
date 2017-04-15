<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/js/jquery-3.1.1.js"></script>


<style>
h3
{
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


<script>

function pagingFormSubmit(currentPage)
{
	/* var form2 = $("#pagingForm");
	
	form2.action = "aaaa";
	form2.submit(); */
	
	var form = document.getElementById("pagingForm");
	var page = document.getElementById("page");
	page.value = currentPage;
	
	form.submit();
}


function readMessage(messagenum)
{
	location.href='readsentMessage?messagenum='+messagenum;
}

function deletesendMessage(messagenum, sender)
{
	location.href='deletesendMessage?messagenum='+messagenum+'&sender='+sender;
}

function alldeleteSend()
{
	location.href='alldeleteSend';	
}


</script>

</head>
<body>


<header>
	<h3>쪽지함</h3>
	
	<div class="slice"></div>
	<div class="message-menu">
	
	<!-- <a href="#none" onclick="receivedMsg()">받은 쪽지함</a>
	<a href="#none" onclick="sentMsg()">보낸 쪽지함</a>
	<a href='writeMessage'>쪽지 보내기</a> -->
	
	<a href="messageList">받은 쪽지함</a>
	<a href="sendlist">보낸 쪽지함</a>
	<a href='writeMessage'>쪽지 보내기</a>
	<a id = "alldeleteSend" href="#none" onclick="alldeleteSend()" style="margin-left : 125px;">쪽지함 비우기</a>
	
	</div>
	
</header>


<div id="messageTable">
	<table class="table-striped" style="width:500px;">
		<tr style="background: #666464; color:white;">
			<td style='width:90px;'>받는사람</td>
			<td style='width:220px;'>제목</td>
			<td style='width:130px;'>보낸날짜</td>
			<td></td>
		</tr>
		<c:forEach var="message" items="${sent}">
			<tr>
				<td>${message.receiver}</td>
				<td><a href="#none" onclick="readMessage('${message.messagenum}')">${message.title}</a></td>
				<td>${message.senddate}</td>
				<td><a href="#none" onclick="deletesendMessage('${message.messagenum}', '${message.sender}')">삭제</a>
			</tr>
		</c:forEach>
		
	</table>
</div>


<div class="container wow fadeInUp"> 
	<table style="width:500px;" class="board-navi">
		<tr>
			<td style="text-align:center;">
				<span class="page-navi">
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})">&lt;&lt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - 1})">&lt;</a></span>
				
				<c:forEach var = "count" begin = "${navi.startPageGroup}" end = "${navi.endPageGroup}">
				
				<span class="btn-page">
						<a class = "pagingset" href = "javascript:pagingFormSubmit(${count})">${count}</a>
				</span>
				
				</c:forEach>
				
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + 1})">&gt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})">&gt;&gt;</a></span>
				</span>
			</td>
			</tr>
	</table>
</div>


<form action = "sendlist" class="pull-right position" method = "get" id = "pagingForm">

	<div class="input-append">
	
		<input type = "hidden" name = "page" id = "page">
		<%-- <input type="text" class="sr-input" name = "searchText" id = "searchText" placeholder="Search Text" value = "${searchText}"> --%>
		<!-- <button class="btn sr-btn" type="button" onclick = "pagingFormSubmit(1)"><i class="fa fa-search"></i></button> -->
	
	</div>
	
</form>


</body>
</html>