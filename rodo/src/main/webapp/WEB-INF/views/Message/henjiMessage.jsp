<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	$("#cancel").on("click", function()
	{
		history.go(-1);
	})
})


function writeMessage()
{
	var receiver = $("#receiver").val();
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
		success : function(data){
			doSend(receiver);
			location.href="messageList";
		},
		error : function(e){
			console.log(e);
		}
	
	})
}

</script>
</head>
<body>
받는이 <input type="text" id="receiver" value="${sender}"><br>
제목 <input type="text" id = "title"><br>
<textarea id ="text"></textarea><br>
<input type="button" id="cancel" value="취소">
<input type="button" value="보내기" onclick="writeMessage()">
</body>
</html>