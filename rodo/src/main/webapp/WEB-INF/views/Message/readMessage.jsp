<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/js/jquery-3.1.1.js"></script>
<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script>

var wsUri = "ws://203.233.196.105:8899/rodo/echo.do";
var websocket;

function init() 
{
    websocket = new WebSocket(wsUri);
    websocket.onopen = function(evt) 
    {
    	
    };
}

function receiveMessage()
{
    websocket.onerror = function(evt) 
    {
        onError(evt)
    };
}

function onError(evt) 
{
	 console.log('ERROR: ' + evt.data);
}

function doSend(message) 
{
	websocket.send(message);
}

window.addEventListener("load", init, false);



$(function()
{
	$("#messagelist").on("click", function()
	{
		location.href='messageList';
	})
})

$(function()
{
	$("#sendlist").on("click", function()
	{
		location.href='sendlist';
	})
})

function henjiMessage()
{
	var receivemessagesender = $("#receivemessagesender").val();
	var sendmessagesender = $("#sendmessagesender").val();
	
	if (receivemessagesender != null)
	{
		var sender = receivemessagesender;
		location.href='henjiMessage?sender='+sender;
	}
	
	else if (sendmessagesender != null)
	{
		var sender = sendmessagesender;
		location.href='henjiMessage?sender='+sender;
	}	
}
</script>
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
#msgwrite{
	margin-left: 10px;
}
#receiver{
	width: 200px;
	margin-bottom: 15px;
	border:none;
	border-bottom: 2px solid black;
}
#title{
	width: 430px;
	margin-bottom: 20px;
	border:none;
	border-bottom: 2px solid black;
}
#text{
	width: 480px;
	height: 300px;
	margin-bottom: 15px;
	resize: none;
	border: 1.5px solid black;
}
#messagelist{
	border: 2px solid #363838;
	background: #363838;
	color: white;
}
#messagelist:hover{
	border: 2px solid #363838;
	background: white;
	color: #363838;
	font-weight: bolder;
}
#sendlist{
	border: 2px solid #363838;
	background: #363838;
	color: white;
}
#sendlist:hover{
	border: 2px solid #363838;
	background: white;
	color: #363838;
	font-weight: bolder;
}
#henji{
	border: 2px solid #363838;
	background: #363838;
	color: white;
}
#hengi:hover{
	margin-left:5px;
	border: 2px solid #363838;
	background: white;
	color: #363838;
	font-weight: bolder;
}
</style>
</head>

<body>
<header>
	<c:choose>
		<c:when test="${sendmessage!=null}">
			<h3>보낸 메세지</h3>
		</c:when>
		<c:otherwise>
			<h3>받은 메세지</h3>
		</c:otherwise>
	</c:choose>
	<div class="slice"></div>
	<div class="message-menu">
   
	<a href="messageList">받은 쪽지함</a>
	<a href="sendlist">보낸 쪽지함</a>
	<a href='writeMessage'>쪽지 보내기</a>
	
	</div>
	
</header>

<div id='msgwrite'>
	<c:choose>
		<c:when test="${sendmessage!=null}">
			<b>To.</b> <input type="text" id="receiver" value="${sendmessage.receiver}" readonly="readonly"><br>
			<b>TITLE</b> <input type="text" id = "title" value="${sendmessage.title}" readonly="readonly"><br>
			<textarea id ="text" readonly="readonly">${sendmessage.text}</textarea><br>
			<input type="button" id = "sendlist" value="목록으로">
		</c:when>
		<c:otherwise>
			<b>From.</b> <input type="text" id="receiver" value="${receivemessage.sender}" readonly="readonly"><br>
			<b>TITLE</b> <input type="text" id = "title" value="${receivemessage.title}" readonly="readonly"><br>
			<textarea id ="text" readonly="readonly">${receivemessage.text}</textarea><br>
			<input type="button" id = "messagelist" value="목록으로">
			<input type="button" id = "henji" value="답장하기" onclick="henjiMessage()">
		</c:otherwise>
	</c:choose>
</div>

	<input type = "hidden" id = "receivemessagesender" value = "${receivemessage.sender}">
	<input type = "hidden" id = "sendmessagesender" value = "${sendmessage.sender}">

</body>
</html>