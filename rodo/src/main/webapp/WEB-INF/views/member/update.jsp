<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>
<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script>

var emailflag = true;
var numcheckflag = false;

$(function()
{
	if($("#rada").val()=="rada"){
		alert("수정 완료");
		window.close();
	}
	
	$("#emailcheck").on("click", function()
	{
		var email = $("#email").val();
		var dbmail = $("#nowmail").val();
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
		
		if(regex.test(email) === false || email == "") 
		{  
		    alert("잘못된 이메일 형식입니다.");
		    console.log("잘못된 이메일 형식입니다.");
		    
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
					if (data == "" || data == dbmail)
					{
						console.log("사용해도 괜찮은 이메일 입니다.");
						alert("사용해도 괜찮은 이메일 입니다.");
						emailflag = true;
						
						return true;
					}
					
					else
					{
						console.log("이미 존재하는 이메일 입니다.");
						alert("이미 존재하는 이메일 입니다.");
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
	})
})

$(function()
{
	$("#submit").on("click", function()
	{
		var password = $("#password").val();
		var passwordc = $("#passwordc").val();
		
		if (password == "" || password.length < 4)
		{
			alert("비밀번호는 4자리 이상 입력하세요.");
			return false;
		}
		
		if (password != passwordc)
		{
			alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return false;
		}
		
		if (emailflag == false)
		{
			alert("이메일을 확인하세요.");
			return false;
		}
		
		if (numcheckflag == false)
		{
			alert("인증번호를 확인하세요.");
			return false;
		}
	})
})

$(function()
{
	var email = $("#email").val();
	
	$("#checknumc").on("click", function()
	{	
		var checkbutton = $("#checknumc").val();
		var num = $("#checknum").val();
		
		if (checkbutton == "인증번호 전송")
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
						alert("메일로 인증번호가 발송되었습니다.");
						
						document.getElementById("checknumc").value = "인증번호 체크";
					}
					
					else
					{
						alert("이메일 인증이 완료되지 않았습니다. 이메일 인증을 완료하세요");
						return false;
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
			$.ajax
			({
				type : "post",
				url : "checknum",
				
				success : function(data)
				{
					if (num == data)
					{
						alert("인증에 성공하였습니다.");
						numcheckflag = true;
						
						return true;
					}
					
					else
					{
						alert("인증번호가 일치하지 않습니다.");
						numcheckflag = false;
						
						return false;
					}
				},
			
				error : function(e)
				{
					console.log(e);
				}
			})
		}
	})
})

</script>
<style>
	h3{
	   font-weight: bolder;
	   margin-left: 10px;
	   font-family: "Open Sans",sans-serif;
	}
	.slice{
	background: black;
	width: 460px;
	height: 3px;
	margin-bottom: 15px;
	margin-left: 5px;
	}
	.title{
		width: 120px;
		text-align: center;
		padding:7px;
	}
	.btn{
		border: 2px solid #313233;
		background: #313233;
		color:white;
		margin-left: 8px;
		margin-top: 8px;
	}
	.btn:hover{
		border: 2px solid #313233;
		background: white;
		color:#313233;
	}
	.submit{
		margin-left: 300px;
	}
	.dv{
		background: black;
		width: 460px;
		height: 1px;
		margin-top: 15px;
		margin-bottom: 10px;
		margin-left: 5px;
	}
</style>
</head>
<body>
<header>
	<h3>개인정보 수정</h3>
	<div class="slice"></div>
</header>
<form name = "update" id = "update" action = "update" method = "post">
	<table>
		<tr>
			<td class="title">ID</td>
			<td>
				<input type = "text" name = "id" id = "id" readonly = "readonly" value = "${member.id}">
			</td>
		</tr>
		
		<tr>
			<td class="title">비밀번호</td>
			<td> 
				<input type = "password" name = "password" id = "password" placeholder = "비밀번호는 4자리 이상">
			</td>
		</tr>
		
		<tr>	
			<td class="title">비밀번호 확인</td>
			<td> 
				<input type = "password" name = "passwordc" id = "passwordc" placeholder = "비밀번호와 동일하게 입력">
			</td>
		</tr>
		
		<tr>	
			<td class="title">email</td>
			<td>
				 <input type = "text" id = "email" name = "email" value = "${member.email}">
				<input type = "hidden" id = "nowmail" name = "nowmail" value = "${member.email}">
				<input type = "button" class="btn" name = "emailcheck" id = "emailcheck" value = "email확인" ><br>
			</td>
		</tr>	
		
		<tr>
			<td class="title">인증번호 입력</td>
			<td>
				<input type = "text" name = "checknum" id = "checknum" placeholder = "인증번호 입력">
				<input type = "button" class="btn" name = "checknumc" id = "checknumc" value = "인증번호 전송">
			</td>
		</tr>
		
	</table>
	<div class="dv"></div>
		<input type = "submit" value = "수정" class = "submit btn" id = "submit">
		<input type = "reset" class="btn" value = "다시쓰기">
</form>
<input type="hidden" id="rada" value="${rada}">
</body>
</html>