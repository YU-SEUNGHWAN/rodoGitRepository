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
      
  <script src="resources/js/message.js"></script>
  
  <script>
  
  function checkupdate(){
  	window.open("checkupdate", "", "width=330, height=200, left=400, top=100");
  }
  
  	$(function(){
	  $.ajax({
			type:"GET",
			url: "newMessage",
			success : function(data){
				if(data.length!=0){
		        	var message = "<img style='width:20px;' src='resources/img/message.png'> ";
					var inner = $(".messagestatus").html();
					if(!inner.includes("message")){
						$(".messagestatus").html(message+inner);
					}
				}
			},
			erroe: function(e){
				console.log(e);
			}
		})
	})
	$(".messagestatus").on("click", function(){
		$(".messagestatus").html("");		
	})
  </script>
</head>
<body>

<!--==========================
  Header Section
============================-->
  <header id="header">
    <div class="container">
    
      <div id="logo" class="pull-left">
    	  <a href='index'><img src="resources/img/logo.png" alt="" title="" /></img></a>
      </div>
      <nav id="nav-menu-container">
        <ul class="nav-menu">
          <li><a href="#none" onclick="javascript:location.href='index'">Home</a></li>
          <li><a href="#none" id="log" onclick="javascript:location.href='logBoard'">log</a></li>
          <li><a href="#none" id="photo" onclick="javascript:location.href='photoBoard'">photo</a></li>
          <li><a href="#none" id="video" onclick="javascript:location.href='videoBoard'">video</a></li>
          <li class="menu-has-children"><a href="#none">community</a>
            <ul>
              <li><a href="freeboardlist">free board</a></li>
              <li><a href="qaboardlist">Q&A</a></li>
              
            </ul>
          </li>
		  <c:choose>
          	<c:when test="${loginId==null}">
	          	<li style="padding-left:100px;"><a href="index#login">login</a></li>
	       	</c:when>
	        <c:otherwise>
			 <li class="menu-has-children" style="padding-left:100px;"><a class="loginstatus" href="#none">${loginId} 님</a>
		        <ul>
		             <li><a href="#none" onclick="checkupdate()">my info</a></li>
		             <li><a href="mypage">my List</a></li>
		             <li><a href="#none" onclick="messageWindow()">message</a></li>
		             <li><a href="logout">log out</a></li>
			    </ul>  
			 </li>
			 <li><a style="padding-left: 0px;" href="#none" onclick="messageWindow()" class="messagestatus"></a></li>
			 
       		</c:otherwise>
	      </c:choose>
        </ul>
      </nav><!-- #nav-menu-container -->
    </div>
  </header><!-- #header -->
  
  <input type="hidden" id="loginId" value="${loginId}">
  
</body>
</html>