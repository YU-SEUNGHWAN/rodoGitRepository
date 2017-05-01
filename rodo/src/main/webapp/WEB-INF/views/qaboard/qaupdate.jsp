<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">
 $(function(){
	$("#save").on("click",function()
	{
		var id = $("loginId").val();
		var title = $("#qa_title").val();
		var content = $("#qa_content").val();
		var boardnum = $("#qa_boardnum").val();

		if(title==""){
			alert("제목을 입력해주세요.");
		}
		if(content==""){
			alert("내용을 입력해주세요.");
		}
		
		var formData = new FormData();
			console.log($("#upload2")[0].files.length);

			for(var index = 0; index < $("#upload2")[0].files.length; index++)
			{
				formData.append("file"+index,$("#upload2")[0].files[index]);
			}
			
			formData.append("loginId",id);
			formData.append("qa_title",title);
			formData.append("qa_content",content);
			formData.append("qa_boardnum",boardnum);
		
		$.ajax
		({
			type:"POST",						
			url:"updateqaboard",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data)
		    {	
				console.log(data);
				alert("글 수정이 성공적으로 완료되었습니다.");
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


<title>게시글 수정</title>
</head>
<body>

<h1> 게시글 수정 </h1>

<table border = "1">
	<tr>
		<td>제목</td>
		<td><input type = "text" name = "qa_title" id = "qa_title" value = "${board.qa_title}"></td>
	</tr>
	<tr>
		<td>본문</td>
		<td><textarea rows = "20" cols = "50" id = "qa_content" name = "qa_content">${board.qa_content}</textarea>
		</td>
	</tr>
	<tr>
		<td>파일첨부</td>
		<td><input type = "file" name = "upload2" id = "upload2" size = "30" multiple = "multiple"></td>
	</tr>
	<tr>
		<td><input type = "hidden" name = "qa_boardnum" id = "qa_boardnum" value = "${board.qa_boardnum}">
		</td>
	</tr>
	<tr>
		<td><input type="submit" id="save" value="글 수정">
	<input type="button" id="qaboardlist"
		onclick="javascript:location.href='qaboardlist'" value="글 리스트로"></td>
	</tr>
</table>

</body>
</html>