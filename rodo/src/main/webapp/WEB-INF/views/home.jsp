<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Main
</h1>

<ul>
<li><a href="readGps">지도 테스트</a></li>
<<<<<<< HEAD

<li><a href = "freeboardlist">자유게시판</a></li>
</ul>

<p>

<ul>
<c:choose>
	<c:when test = "${sessionScope.id == null}">
			<!-- <li><a href = "insert">회원가입</a></li> -->
			
			<li><a href="index">로그인</a></li>
			
			<li><a href = "find">id pw 찾기</a></li>
	</c:when>
	
	<c:otherwise>
			<li>${sessionScope.name} 님 안녕하세요.</li>
			
			<li><a href = "checkupdate">개인정보 수정</a></li>
			
			<li><p><a href = "logout">로그아웃</a></p></li>
	</c:otherwise>
</c:choose>
<<<<<<< HEAD
=======

=======
<li><a href="index">부트스트랩 테스트</a></li>
<li><a href="socketTest">웹소켓 테스트</a></li>
>>>>>>> branch 'master' of https://github.com/YU-SEUNGHWAN/rodoGitRepository.git
</ul>

</body>
</html>