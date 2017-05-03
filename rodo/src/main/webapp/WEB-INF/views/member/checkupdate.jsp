<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 수정 확인</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>
<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
<link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script>

	$(function()
	{
		$("#button").on("click", function()
		{
			var password = $("#password").val();
			
			$.ajax
			({
				type : "post",
				url : "beforeupdate",
				
				data :
				{
					password : password
				},
				
				success : function(data)
				{
					if (password == data)
					{
						location.href="update";
						window.resizeTo(500, 440);
					}
					
					else
					{
						console.log("비밀번호가 일치하지 않습니다.");
						alert("비밀번호가 일치하지 않습니다.");
						
						return false;
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
<style>
h3
{
   font-weight: bolder;
   margin-left: 10px;
   font-family: "Open Sans",sans-serif;
}
h5{
	margin-left: 10px;
	color: red;
}
.slice{
background: black;
width: 310px;
height: 3px;
margin-bottom: 15px;
margin-left: 5px;
}
table{
	margin-left: 10px;
	padding : 5px;
}
table label{
	text-align:center;
	width: 60px;
}
table #id, table #password{
	border: 1px solid black;
	width:200px;
}
#button{
	border: 2px solid #313233;
	background: #313233;
	color:white;
	margin-left: 250px;
	margin-top: 8px;
}
#button:hover{
	border: 2px solid #313233;
	background: white;
	color:#313233;
}
</style>
</head>
<body>
<header>
	<h3>개인정보 수정</h3>
	<div class="slice"></div>
</header>
	<h5>비밀번호를 입력해 본인인증을 해 주세요</h5>
	<form action = "update" method = "post">
	<table>
		<tr>
			<td>
				<label for = "id">아이디</label>
				<input type = "text" id = "id" name = "id" readonly = "readonly" placeholder = "${sessionScope.loginId}">
			</td>
		</tr>
		
		<tr>
			<td>
				<label for = "password">비밀번호</label>
				<input type = "password" id = "password" name = "password">
			</td>
		</tr>
	</table>
	<input type = "button" id = "button" name = "button" value = "확인">
</form>

</body>
</html>