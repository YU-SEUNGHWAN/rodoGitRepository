<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">
$(function()
{
	$("#save").on("click",function()
	{
		var id = $("loginId").val();
		var title = $("#qa_title").val();
		var content = $("#qa_content").val();
		
		if(title == "")
		{
			alert("제목을 입력해주세요.");
		}
		if(content == "")
		{
			alert("내용을 입력해주세요.");
		}
		
		var formData = new FormData();
			console.log($("#upload")[0].files.length);
			for(var index = 0; index < $("#upload")[0].files.length; index++)
			{
				formData.append("file"+index,$("#upload")[0].files[index]);
			}
			formData.append("loginId",id);
			formData.append("qa_title",title);
			formData.append("qa_content",content);
		
		$.ajax
		({
			type:"POST",						
			url:"qaboardwrite",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data)
		    {	
				console.log(data);
				alert("글 등록이 성공적으로 완료되었습니다.");
				if(data='success')
					location.href = "qaboardlist";
				else
					location.href = ""; 
		    },
			error: function(e){			
				console.log(e);
			}
		});
	});
});
</script>

<title>Q & A 게시판 게시글 작성</title>

</head>
<body>

<h1> Q & A 게시판 게시글 작성 </h1>

<table border = "1">
	<tr>
		<td>글 제목</td>
		<td><input type = "text" name = "qa_title" id = "qa_title"></td>
	</tr>
	<tr>
		<td>글 내용</td>
		<td><textarea rows = "20" cols = "50" id = "qa_content" name = "qa_content"></textarea></td>
	<tr>
		<td>파일첨부</td>
		<td><input type="file" id="upload" name="file-data" multiple></td>
	</tr>
	<tr>
		<td><input type="button" id="save" value="등록">
		<input type="button" id="qaboardlist"
			onclick="javascript:location.href='qaboardlist'" value="리스트">
		</td>
	</tr>
	
</table>

</body>
</html>