<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 / 비밀번호 찾기</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

$(function()
{
	$("#findid").on("click", function()
	{
		var email = $("#email").val();
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
				
		if(regex.test(email) === false) 
		{
			alert("잘못된 이메일 형식입니다.");
			return false;
		}
		
		$.ajax
		({
			type : "POST",
			url : "findid",
			
			data : 
			{
				email : email
			},
			
			success : function(data)
			{
				if (data == "")		// 여기 data 는 일치한 email 을 통해서 찾아온 ID
				{
					alert("일치하는 email 이 없습니다.");
					return false;
				}
				
				else
				{
					$.ajax
					({
						type : "post",
						url : "sendid",
						
						data :
						{
							user : email,	// 이건 검색한 email
							id : data		// 여기 data 는 일치한 email 을 통해서 찾아온 ID
						},

						success : function(data)
						{
							alert("메일로 ID가 전송되었습니다.");
							console.log("메일로 ID가 전송되었습니다.");
							return true;
						},
						
						success : function(e)
						{
							console.log(e);
						}
					})
				}
			},
			
			error : function(e)
			{
				console.log(e);
			}
		})
	})
})

$(function()
{
	$("#findpw").on("click", function()
	{
		var id = $("#id").val();
		
		$.ajax
		({
			type : "post",
			url : "findpw",
			
			data : 
			{
				id : id
			},
			
			success : function(data)
			{
				if (data == "")
				{
					alert("일치하는 아이디가 존재하지 않습니다.");
					return false;
				}
				
				else
				{
			//		console.log(data);	// 검색해서 찾고 리턴받은 member 객체가 잘 왔는지 확인
					
					$.ajax
					({
						type : "post",
						url : "sendpw",
						
						data :
						{
							id : data.id,
							password : data.password,
							name : data.name,
							email : data.email
						},
						
						success : function(data)	// 여기에 data 는 리턴되서 받은 임시 비밀번호
						{
							console.log(data);	// 비밀번호 왔는지 체크
							
							$.ajax
							({
								type : "post",
								url : "updatepw",
								
								data :
								{
									id : id,
									password : data
								},
								
								success : function(data)
								{							
									if (data == "")
									{
										alert("메일 전송에 실패하였습니다.");
										return false;
									}
									
									else
									{
										alert("메일로 임시 비밀번호가 전송되었습니다.");
										console.log("메일로 임시 비밀번호가 전송되었습니다.");
										return true;
									}
								},
								
								error : function(e)
								{
									console.log(e);
								}
							})
						},
						
						error : function(e)
						{
							console.log(e);
						}
					})
				}
			},
			
			error : function(e)
			{
				console.log(e);
			}
		})
	})
})


</script>

</head>
<body>

<h1> 아이디 / 비밀번호 찾기 </h1>

<p> <h3> 아이디 찾기 </h3>

<label for = "email">email 입력</label>
<input type = "text" id = "email" name = "email">
<input type = "button" id = "findid" value = "id찾기"> <br><br><br><br>


<p> <h3> 비밀번호 찾기 </h3>

<label for = "id">아이디 입력</label>
<input type = "text" id = "id" name = "id">
<input type = "button" id = "findpw" value = "email로 전송">

<br><br>
<p><a href = "./">메인으로</a>

</body>
</html>