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

function init() {
    websocket = new WebSocket(wsUri);
    websocket.onopen = function(evt) {
    };
}

function receiveMessage(){
    websocket.onerror = function(evt) {
        onError(evt)
    };
}

function onError(evt) {
	 console.log('ERROR: ' + evt.data);
}

function doSend(message) {
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

/* $(function()
{
	$("#henji").on("click", function()
	{
		var sender = $("#sender").val();
		var title = $("#title").val();
		var text = $("#text").val();

		$.ajax({
			
			type : "post",
			url : "writeMessage",
			data : {
				receiver : receiver,
				title : title,
				text : text
			},
			
			success : function(data)
			{
				doSend(receiver);
				location.href="messageList";
			},
			
			error : function(e)
			{
				console.log(e);
			}
		
		}) 
	})
}) */

</script>


</head>
<body>

<c:choose>
	<c:when test="${sendmessage!=null}">
	
		보낸이 <input type="text" id="sender" value="${sendmessage.sender}"><br>
		제목 <input type="text" id="title" value="${sendmessage.title}"><br>
		보낸 날짜 <input type="text" value="${sendmessage.senddate}"><br>
		<textarea id="text">${sendmessage.text}</textarea><br>
		<input type="button" id = "messagelist" value="목록으로">
	
	</c:when>
	
	<c:otherwise>
	
		보낸이 <input type="text" id="sender" value="${receivemessage.sender}"><br>
		제목 <input type="text" id="title" value="${receivemessage.title}"><br>
		보낸 날짜 <input type="text" value="${receivemessage.senddate}"><br>
		<textarea id="text">${receivemessage.text}</textarea><br>
		<input type="button" id = "messagelist" value="목록으로">
		<input type="button" id = "henji" value="답장하기" onclick="henjiMessage()">
	
	</c:otherwise>
</c:choose>	

	<input type = "hidden" id = "receivemessagesender" value = "${receivemessage.sender}">
	<input type = "hidden" id = "sendmessagesender" value = "${sendmessage.sender}">

	
</body>
</html>