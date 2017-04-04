<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet"> 
  
  <!-- Bootstrap CSS File -->
  <link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Libraries CSS Files -->
  <link href="resources/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="resources/lib/animate-css/animate.min.css" rel="stylesheet">
  
  <!-- Main Stylesheet File -->
  <link href="resources/css/style.css" rel="stylesheet">
  <link href="resources/css/login.css" rel="stylesheet">
</head>
<body>

<!--==========================
  Header Section
============================-->
  <header id="header">
    <div class="container">
    
      <div id="logo" class="pull-left">
        <a href="#none" onclick="javascript:location.href='index'"><img src="resources/img/logo.png" alt="" title="" /></img></a>
        <!-- Uncomment below if you prefer to use a text image -->
        <!--<h1><a href="#hero">Header 1</a></h1>-->
      </div>
      <nav id="nav-menu-container">
        <ul class="nav-menu">
          <li><a href="#none" onclick="javascript:location.href='index'">Home</a></li>
          <li><a href="#none" id="log" onclick="javascript:location.href='logBoard'">log</a></li>
          <li><a href="#none" id="photo" onclick="javascript:location.href='photoBoard'">photo</a></li>
          <li><a href="#none" id="video" onclick="javascript:location.href='videoBoard'">video</a></li>
          <li class="menu-has-children"><a href="#none">community</a>
            <ul>
              <li><a href="">free board</a></li>
              <li class="menu-has-children"><a href="#none">local board</a>
                <ul>
                  <li><a href="#">Deep Drop Down 1</a></li>
                  <li><a href="#">Deep Drop Down 2</a></li>
                  <li><a href="#">Deep Drop Down 3</a></li>
                  <li><a href="#">Deep Drop Down 4</a></li>
                  <li><a href="#">Deep Drop Down 5</a></li>
                </ul>
              </li>
              <li><a href="#">Q&A</a></li>
            </ul>
          </li>
		  <c:choose>
          	<c:when test="${loginId==null}">
	          	<li style="padding-left:100px;"><a href="#about">login</a></li>
	       	</c:when>
	        <c:otherwise>
			 <li class="menu-has-children" style="padding-left:100px;"><a href="#none">${loginId} 님</a>
		        <ul>
		             <li><a href="#">my info</a></li>
		             <li><a href="#">my List</a></li>
		             <li><a href="logout">log out</a></li>
			    </ul>  
			 </li>
       		</c:otherwise>
	      </c:choose>
        </ul>
      </nav><!-- #nav-menu-container -->
    </div>
  </header><!-- #header -->
  
</body>
</html>