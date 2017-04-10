<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복확인</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

		/* $(function()
		{
			$("#btn").on("click", function()
			{
				var idc = $("#checkid").val();
				
				opener.document.getElementById('id').value = idc;
				window.close();
			})
		})
		
		 $(function()
		{
			$("#btn").css("display", "none");
			
			$("#checkbtn").on("click", function()
			{
				var checkid = $("#checkid").val();
				var validFlag = validate_id(checkid);	//	유효성 검사 boolean 체크
				
				if (checkid == "")
				{
					alert("아이디를 입력하십시오.");
					return false;
				}

				else
				{
					$.ajax
					({
						type : "post",
						url : "checkidajax",
						data : 
						{
							id : checkid
						},
						
						success : function(data)
						{
							if(data == "")
							{
								$("#checkid").val(checkid);
								alert("사용할 수 있는 ID 입니다.");
								$("#btn").css("display", "");
							}
							
							else
							{
								$("checkid").val("");
								alert("사용중인 ID 입니다.");
								$("#btn").css("display", "none");
							}
						},
						
						error : function(e)
						{
							console.log(e);
						}	
					})
				}
				
				if( !validFlag ) 
				{
					alert("아이디는 영문 또는 숫자 로 입력하세요");
					
					return false;
				}
			})
		})  */


/* $(function()
{
	$("#checkbutton").on("click", function()
	{	
	//	var email = $("#email").val();
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
}) */


$(function()
{
	$("#checkbutton").on("click", function()
	{
		var num = $("#checknum").val();
		
		$.ajax
		({
			type : "post",
			url : "checknum",
			
			success : function(data)
			{
				if (num == data)
				{
					alert("인증에 성공하였습니다.");
					
					window.opener.Checknumfunction();
					window.close();
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
	})
})


</script>

</head>
<body>

인증번호 : <input type = "text" id = "checknum">

<input type = "button" id = "checkbutton" value = "인증번호 확인">

<!-- <div>
	<input type = "button" id = "btn" value = "적용">
</div> -->

</body>
</html>