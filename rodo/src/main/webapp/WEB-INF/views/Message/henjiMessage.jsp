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

var wsUri = "ws://203.233.196.103:8888/rodo/echo.do";
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
			location.href="sendlist";
		},
		error : function(e){
			console.log(e);
		}
	
	})
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
#cancel{
	margin-left : 5px;
	border: 2px solid #363838;
	background: #363838;
	color: white;
}
#cancel:hover{
	border: 2px solid #363838;
	background: white;
	color: #363838;
	font-weight: bolder;
}
#send{
	border: 2px solid #363838;
	background: #363838;
	color: white;
}
#send:hover{
	border: 2px solid #363838;
	background: white;
	color: #363838;
	font-weight: bolder;
}
</style>
</head>
<body>
	<header>
		<h3>쪽지 보내기</h3>
		<div class="slice"></div>
		<div class="message-menu">
			<a href="messageList">받은 쪽지함</a>
			<a href="sendlist">보낸 쪽지함</a>
			<a href='writeMessage' style="color:red">쪽지 보내기</a>
		</div>
	</header>
	
	<div id='msgwrite'>
		<b>To. </b> <input type="text" id="receiver" value="${sender}" readonly="readonly"><br>
		<b>TITLE </b> <input type="text" id = "title"><br>
		<textarea id ="text"></textarea><br>
		<input type="button" id="send" value="보내기" onclick="writeMessage()">
		<input type="button" id = "cancel" value="취소">
	</div>

</body>
</html>