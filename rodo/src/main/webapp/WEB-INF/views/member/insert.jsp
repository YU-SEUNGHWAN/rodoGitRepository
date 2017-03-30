<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 페이지</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script type="text/javascript">  

var emailflag = false;
var checknumflag = false;

function IDCheckFunction()
{
	window.open("idcheckbutton", "width=400, height=300");
}

$(function()
{
	$("#submmit").on("click", function()
	{
		var id = $("#id").val();
		var name = $("#name").val();
		
		//	입력된 ID 값이 없다면..
		if(id == "") 
		{
			alert("ID 중복확인 버튼을 눌러서 아이디를 입력하십시오.");
			
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
		
		if (name == "")
		{
			alert("이름을 입력하세요.");
			return false;
		}
		
		if (checknumflag == false)
		{
			alert("인증번호체크가 완료되지 않았습니다.");
			
			return false;
		}
	})
})


$(function()
{
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
			$("#checknumc").on("click", function()
			{	
				var email = $("#email").val();
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
								checknumflag = true;
								
								return true;
							}
							
							else
							{
								alert("인증번호가 일치하지 않습니다.");
								checknumflag = false;
								
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

</head>
<body>

	<h1> 회원가입 </h1>

<form name = "join" id = "memberjoin" action = "join" method = "post">
	<table>
		<tr>
			<td>
				ID <input type = "text" name = "id" id = "id" readonly = "readonly" placeholder = "ID 중복확인을 통해 ID입력">
					<div id = "id_message" style = "display:none;"></div>
					
					<input type = "button" name = "idcheck" id = "idcheck" value = "중복확인" onclick = "IDCheckFunction()">
			</td>
		</tr>
		
		<tr>
			<td>
				비밀번호 <input type = "password" name = "password" id = "password" placeholder = "비밀번호는 4자리 이상">
			</td>
		</tr>
		
		<tr>	
			<td>
				비밀번호 확인 <input type = "password" name = "passwordc" id = "passwordc" placeholder = "비밀번호와 동일하게 입력">
			</td>
		</tr>
		
		<tr>
			<td>
				이름 <input type = "text" name = "name" id = "name" placeholder = "이름 입력">
			</td>
		</tr>
		
		<tr>	
			<td>
				email <input type = "text" id = "email" name = "email" placeholder = "예)  asd123@naver.com">
						<label for="email"></label>
						
						<input type = "button" name = "emailcheck" id = "emailcheck" value = "email확인" ><br>
						
			</td>
		</tr>	
		
		<tr>
			<td>
				인증번호 입력 <input type = "text" name = "checknum" id = "checknum" placeholder = "인증번호 입력">
								<input type = "button" name = "checknumc" id = "checknumc" value = "인증번호 전송">
			</td>
		</tr>
	</table>
	
		<input type = "submit" value = "가입" class = "submit" id = "submmit"> <input type = "reset" value = "다시쓰기">
</form>


</body>
</html>