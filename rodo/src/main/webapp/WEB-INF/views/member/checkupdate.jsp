<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 수정 확인</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>


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
						location.href="update"
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

</head>
<body>

<form action = "update" method = "post">

	<table>
		<tr>
			<td>
				<label for = "id">아이디</label>
				<input type = "text" id = "id" name = "id" readonly = "readonly" placeholder = "${sessionScope.id}">
			</td>
		</tr>
		
		<tr>
			<td>
				<label for = "password">비밀번호</label>
				<input type = "password" id = "password" name = "password">
			</td>
		</tr>
		
		<tr>
			<td>
				<input type = "button" id = "button" name = "button" value = "확인">
			</td>
		</tr>
		
		<tr>
			<td>
				<a href = "./">메인으로</a>
			</td>
		</tr>
	</table>
	
</form>

</body>
</html>