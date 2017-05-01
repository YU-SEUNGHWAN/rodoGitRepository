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
  
<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>
<script src="resources/js/message.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head>



<style>
a:hover{
	text-decoration: none;
}


.modal-header, h4, .close {
      background-color: rgb(50,50,50);
      color:white !important;
      text-align: center;
      font-size: 30px;
  }
  .modal-footer {
      background-color: #f9f9f9;
  }
  
  #btnsubmit
  {
  	background-color: rgb(50,50,50);;
  	border-color: rgb(50,50,50);;
  }
  
  .moto
  {	
  	color: blue;
  }


</style>

<script>

var emailflag = false;
var checknumflag = false;
var idflag = false;


var joincomplete = '${joincomplete}';

var loginerror = '${loginErr}';

if (joincomplete == "complete")
{	
	$(function()
	{
		alert("가입이 완료되었습니다.");
	})
}

if(loginerror == "error")
{
	$(function()
	{
		alert("로그인 정보를 확인하세요.");
	})
}


$(function() {
	
	if($("#loginId").val() != ""){
		
		$('html, body').css({'overflow': 'hidden', 'height': '100%'});

		$('#element').on('scroll touchmove mousewheel', function(e) {
		   e.preventDefault();
		   e.stopPropagation(); 
		   return false;
		});
	}
	
	$("#submmit").on("click", function()
	{
		
		//	입력된 ID 값이 없다면..
		if(idflag == false) 
		{
			alert("아이디를 확인해 주세요.");
			
			return false;
		}
		
		//	비밀번호 유효성 체크
		var pwd = $("#password").val();
		var pwd1 = $("#passwordc").val();

		if( pwd != pwd1 ) {	//	비밀번호 와 비밀번호 확인이 다르다면 ... 
			
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			
			return false;
		}
		
		if (pwd == "" || pwd.length < 4)
		{
			alert("비밀번호는 4자리 이상 입력하여야 합니다.");	
			
			//	이벤트 중지하기
			return false;
		}
		
		if (emailflag == false)
		{
			alert("email 체크를 하고 인증번호를 발급 받으세요.")
			
			return false;
		}
		
		if (checknumflag == false)
		{
			alert("인증번호체크가 완료되지 않았습니다.");
			
			return false;
		}
	})
	
	var checkAjaxSetTimeout;
	
	$("#id").keyup(function()
	{
		clearTimeout(checkAjaxSetTimeout);
        checkAjaxSetTimeout = setTimeout(function()
        {
		
			if ( $("#id").val().length <= 6 && $("#id").val().length > 0 )
			{
				$("#idlabel").css("color", "red");
				$("#idlabel").html("사용 불가능한 아이디 입니다.");
			}
			
			else if ( $("#id").val() == "" )
			{
				$("#idlabel").css("color", "red");
				$("#idlabel").html("");
			}
			
			else if ( $("#id").val().length > 6 )
			{
				var id = $("#id").val();
				
				$.ajax
				({
					type : "post",
					url : "checkidajax",
					
					data :
					{
						id : id
					},
					
					success : function(data)
					{
						if (data == "")
						{
							$("#idlabel").css("color", "blue");
							$("#idlabel").html("사용 가능한 아이디 입니다.");
							idflag = true;
						}
						
						else
						{
							$("#idlabel").css("color", "red");
							$("#idlabel").html("사용 불가능한 아이디 입니다.");
						}
					},
					
					error : function(e)
					{
						console.log(e);
					}
				})
			}
        }, 500)
	})

	var checkAjaxSetTimeout;
	
	$("#email").keyup(function()
	{
		var email = $("#email").val();
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		
		clearTimeout(checkAjaxSetTimeout);
        checkAjaxSetTimeout = setTimeout(function()
        {
			
        	if (email == "")
			{
				$("#maillabel").css("color", "red");
				$("#maillabel").html("");

				emailflag = false;
    		    return false;
			}
        	
        	else if(regex.test(email) === false)
    		{
        		$("#maillabel").css("color", "red");
				$("#maillabel").html("사용 불가능한 이메일 입니다.");
    		    
    		    emailflag = false;
    		    return false;
    		}
			
			
			else
			{	
				$.ajax
				({
					type : "post",
					url : "emailcheck2",
					
					data :
					{
						email : email
					},
					
					success : function(data)
					{
						if (data == "")
						{
							$("#maillabel").css("color", "blue");
							$("#maillabel").html("사용 가능한 이메일 입니다.");
							
							emailflag = true;
							return true;
						}
						
						else
						{
							$("#maillabel").css("color", "red");
							$("#maillabel").html("사용 불가능한 이메일 입니다.");
							
							emailflag = false;
							return false;
						}
					},
					
					error : function(e)
					{
						console.log(e);
					}
				})
			}
        }, 500)
	})

	$("#mailcheck").on("click", function()
	{
		var email = $("#email").val();
		
		if(emailflag == true)
		{
			$.ajax
			({
				type : "post",
				url : "emailcheck",
				
				data : 
				{
					user : email
				},
				
				success : function(data)
				{
					if (emailflag == true)
					{
						console.log("메일로 인증번호가 전송되었습니다.");
					}
				},
				
				error : function(e)
				{
					console.log(e);
				}
			})
		}
		
		else
		{
			alert("이메일을 확인하세요.");
			console.log("이메일을 확인하세요.");
			
			return false;
		}
		
	})

	$("#btnsubmit").on("click", function()
	{
		var checknum = $("#checknumber").val();
		
		$.ajax
		({
			type : "post",
			url : "checknum",
			
			success : function(data)
			{
				if (checknum == data)
				{	
					checknumflag = true;
					
					$("#myModal").modal('hide');
					document.getElementById("checknumber").value = "";
					$("#kakunin").html("");
				}
				
				else
				{
					$("#kakunin").css("color", "red");
					$("#kakunin").html("인증번호가 일치하지 않습니다.");
				}
			},
			
			error : function(e)
			{
				console.log(e);
			}
		})
	})
	
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
	$(".messagestatus").on("click", function(){
		$(".messagestatus").html("");		
	})
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

    	  <a href='#hero'><img src="resources/img/logo.png" alt="" title="" /></img></a>
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
	          	<li style="padding-left:100px;"><a href="#about">login</a></li>
	       	</c:when>
	        <c:otherwise>
			 <li class="menu-has-children" style="padding-left:100px;"><a class="loginstatus" href="#none">${loginId} 님</a>
		        <ul>
		             <li><a href="checkupdate">my info</a></li>
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
 
<body>

<div class="container">
  <!-- <h2>Modal Login Example</h2> -->
  <!-- Trigger the modal with a button -->

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Certification</h4>
        </div>
      
        <div class="modal-body" style="padding:40px 50px;">
       
          <form role="form">
           
            <div class="form-group">
              <label for="checknumber"><span class="glyphicon glyphicon-user"></span> Check Number</label>
              <input type="text" class="form-control" id="checknumber" placeholder="Input Number">
            </div>
            
        
        <button type="button" id = "btnsubmit" class="btn btn-success btn-block"><span class="glyphicon glyphicon-off"></span> OK</button>
       
          </form>
          
        </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
          <span class="glyphicon glyphicon-remove"></span> Cancel</button>
          
          
          <p class = "moto" id = "kakunin"> 메일로 전송된 인증번호를 입력해 주세요. </p>

        </div>
        
      </div>
      
    </div>
  </div> 
</div>
 
<script>

$(document).ready(function()
{
    $("#mailcheck").click(function()
    {
    	if (emailflag == true)
    	{
    		$("#myModal").modal();
    	}
    });
});
	
</script>



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
			                
			                    <input type="text" name="loginid" id="loginid" class="inpt" required="required" placeholder="Your ID">
			                    <label for="text">Your email</label>
			                    
			                    <input type="password" name="loginpassword" id="loginpassword" class="inpt" required="required" placeholder="Your Password">
             						<label for="password">Your password</label>
             						    
			                    <input type="checkbox" id="remember" class="checkbox" checked>
			                    
			                    <div class="submit-wrap">
				                        <input type="submit" value="Sign in" class="submit">
				                        <a href="find" class="more">Forgot your password?</a>
			                    </div>
			                    
   					        </form>
 				      </div>
    				  <div class="signup-cont cont">
               				<form action="join" method="post" enctype="multipart/form-data">
            					
			                    <input type="text" name="id" id="id" class="inpt" required="required" placeholder="Your ID">
			                   	<div class = "id2" id = "idlabel"></div>
			                    
			                    <input type="password" name="password" id="password" class="inpt" required="required" placeholder="Your Password">
             						    
								<input type="password" name="passwordc" id="passwordc" class="inpt" required="required" placeholder="One more Password">
             						    
             					<input type="text" name="email" id="email" class="inpt" required="required" placeholder="Your Email">
             					<div class = "maillabel2" id = "maillabel"></div>
             					
             					<div class = "modal" id = "modal"><div class = "modal-dialog" ></div></div>
             					
             					<input type="button" value="check number" id = "mailcheck" class="submit">
             					
             					<input type = "hidden" id = "numcheckflag" value = "false">
             					
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