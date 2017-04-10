<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
보낸이 <input type="text" value="${message.sender}"><br>
제목 <input type="text" value="${message.title}"><br>
보낸 날짜 <input type="text" value="${message.senddate}"><br>
<textarea>${message.text}</textarea><br>
<input type="button" value="목록으로">
<input type="button" value="답장하기">
</body>
</html>