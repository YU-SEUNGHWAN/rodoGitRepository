<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복확인</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

		$(function()
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
//				var validFlag = validate_id(checkid);	//	유효성 검사 boolean 체크
				
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
		})

		
/* function validate_id(user_id)
{
	var pattern = new RegExp(/^[a-z0-9]+$/);
		
	return pattern.test(user_id);
} */

</script>

</head>
<body>

아이디 : <input type = "text" id = "checkid">

<input type = "button" id = "checkbtn" value = "검색">

<div>
	<input type = "button" id = "btn" value = "적용">
</div>

</body>
</html>