<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1> 로그인 </h1>
	
<form action = "login" method = "post">
	<input type = "text" name = "id" id = "id" placeholder = "Your ID"> <br>
	<input type = "password" name = "password" id = "password" placeholder = "Your Password"><br>
	
	<input type = "submit" value = "로그인">
	<input type = "reset" value = "다시입력">
	
	<c:if test = "${loginErr != null}">
		${loginErr}
	</c:if>	
	
</form>	

</body>
</html>