<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Share Your Road</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
    
  
  <!-- Place your favicon.ico and apple-touch-icon.png in the template root directory -->
  <link href="favicon.ico" rel="shortcut icon">
  
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
        <a href="#hero"><img src="resources/img/logo.png" alt="" title="" /></img></a>
        <!-- Uncomment below if you prefer to use a text image -->
        <!--<h1><a href="#hero">Header 1</a></h1>-->
      </div>
        
      <nav id="nav-menu-container">
        <ul class="nav-menu">
          <li class="menu-active"><a href="#hero">Home</a></li>
          <li><a href="#none" onclick="javascript:location.href='logBoard'">log</a></li>
          <li><a href="#none" onclick="javascript:location.href='photoBoard'">photo</a></li>
          <li><a href="#none" onclick="javascript:location.href='videoBoard'">video</a></li>
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

  
<!--==========================
  Hero Section
============================-->
  <section id="hero">
    <div class="hero-container">
      <div class="wow fadeIn">
        <div class="hero-logo">
          <img class="" src="resources/img/logo.png" alt="Imperial">
        </div>
        
        <h1>Welcome to project Rodo</h1>
        <h2>Share your <span class="rotating">road, trip, memory</span></h2>
        <div class="actions">
          	<c:choose>
	          	<c:when test="${loginId==null}">
		          	<a href="#about" id="btn-services" class="btn-services">로그인</a>
		       	</c:when>
		        <c:otherwise>
		          	<a href="logout" id="btn-get-started" class="btn-get-started">로그아웃</a>
	       		</c:otherwise>
	       	</c:choose>
        </div>
      </div>
    </div>
  </section>
    
<!--==========================
  About Section
============================-->
  <section id="about">
    <div class="container wow">
           <article class="half">
	        <h1>Welcome</h1>
	        <div class="tabs">
		            <span class="tab signin active"><a href="#signin">Sign in</a></span>
		            <span class="tab signup"><a href="#signup">Sign up</a></span>
	        </div>
	        <div class="content">
		            <div class="signin-cont cont">
			                <form action="login" method="post" enctype="multipart/form-data">
			                
			                    <input type="text" name="id" id="id" class="inpt" required="required" placeholder="Your ID">
			                    <label for="text">Your email</label>
			                    
			                    <input type="password" name="password" id="password" class="inpt" required="required" placeholder="Your Password">
             						<label for="password">Your password</label>
             						    
			                    <input type="checkbox" id="remember" class="checkbox" checked>
			                    
			                    <div class="submit-wrap">
				                        <input type="submit" value="Sign in" class="submit">
				                        <a href="#" class="more">Forgot your password?</a>
			                    </div>
			                    
   					        </form>
 				      </div>
    				  <div class="signup-cont cont">
               				<form action="#" method="post" enctype="multipart/form-data">
            					
			                    <input type="text" name="id" id="id" class="inpt" required="required" placeholder="Your ID">
			                    <input type="button" value="id check" class="submit">
			                    
			                    <input type="password" name="password" id="password" class="inpt" required="required" placeholder="Your Password">
             						    
								<input type="password" name="passwordc" id="passwordc" class="inpt" required="required" placeholder="One more Password">
             						    
             					<input type="text" name="name" id="name" class="inpt" required="required" placeholder="Your Name">
             						    
             					<input type="text" name="email" id="email" class="inpt" required="required" placeholder="Your Email">
             					<input type="button" value="mail check" class="submit">
             						    
			                    <div class="submit-wrap">
				                	<input type="submit" value="Sign up" class="submit" style="margin-top: 25px;">
			                    </div>
						                    
        					  </form>
						</div>
			        </div>
		    </article>
		<div class="half bg" style="padding-right:0px;"></div>
    </div>
  </section>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> 
	<script>
	$('.tabs .tab').click(function(){
	    if ($(this).hasClass('signin')) {
	        $('.tabs .tab').removeClass('active');
	        $(this).addClass('active');
	        $('.cont').hide();
	        $('.signin-cont').show();
	    }
	    if ($(this).hasClass('signup')) {
	        $('.tabs .tab').removeClass('active');
	        $(this).addClass('active');
	        $('.cont').hide();
	        $('.signup-cont').show();
	    }
	});
	</script>
  
<!--==========================
  Footer
============================--> 
  <footer id="footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="copyright">
              &copy; Copyright <strong>Imperial Theme</strong>. All Rights Reserved
            </div>
            <div class="credits">
              <!-- 
                All the links in the footer should remain intact. 
                You can delete the links only if you purchased the pro version.
                Licensing information: https://bootstrapmade.com/license/
                Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=Imperial
              -->
              Bootstrap Themes by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>
          </div>
        </div>
      </div>
  </footer><!-- #footer -->
  
  <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
    
  <!-- Required JavaScript Libraries -->
  <script src="resources/lib/jquery/jquery.min.js"></script>
  <script src="resources/lib/jquery/jquery-migrate.min.js"></script>
  <script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
  <script src="resources/lib/superfish/hoverIntent.js"></script>
  <script src="resources/lib/superfish/superfish.min.js"></script>
  <script src="resources/lib/morphext/morphext.min.js"></script>
  <script src="resources/lib/wow/wow.min.js"></script>
  <script src="resources/lib/stickyjs/sticky.js"></script>
  <script src="resources/lib/easing/easing.js"></script>
  
  <!-- Template Specisifc Custom Javascript File -->
  <script src="resources/js/custom.js"></script>
  
</body>
</html>