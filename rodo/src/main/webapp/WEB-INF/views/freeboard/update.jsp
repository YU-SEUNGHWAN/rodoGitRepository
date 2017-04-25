<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">
 $(function(){
	
		
	$("#save").on("click",function(){
		
		var id = $("loginId").val();
		var title = $("#free_title").val();
		var content = $("#free_content").val();
		var boardnum = $("#free_boardnum").val();

		if(title==""){
			alert("제목을 입력해주세요.");
		}
		if(content==""){
			alert("내용을 입력해주세요.");
		}
		
		var formData = new FormData();
			console.log($("#upload")[0].files.length);
			for(var index = 0; index < $("#upload")[0].files.length; index++){
				formData.append("file"+index,$("#upload")[0].files[index]);
			}
			formData.append("loginId",id);
			formData.append("free_title",title);
			formData.append("free_content",content);
			formData.append("free_boardnum",boardnum);
		
		$.ajax({
			type:"POST",						
			url:"updateFree",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data){	
				console.log(data);
				alert("글 수정이 성공적으로 완료되었습니다.");
				if(data='success')
					location.href = "freeboardlist";
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
		<td><input type = "text" name = "free_title" id = "free_title" value = "${board.free_title}"></td>
	</tr>
	<tr>
		<td>본문</td>
		<td><textarea rows = "20" cols = "50" id = "free_content" name = "free_content">${board.free_content}</textarea>
		</td>
	</tr>
	<tr>
		<td>파일첨부</td>
		<td><input type = "file" name = "upload" id = "upload" size = "30" multiple = "multiple"></td>
	</tr>
	<tr>
		<td><input type = "hidden" name = "free_boardnum" id = "free_boardnum" value = "${board.free_boardnum}">
		</td>
	</tr>
	<tr>
		<td><input type="submit" id="save" value="글 수정">
	<input type="button" id="freeboardlist"
		onclick="javascript:location.href='freeboardlist'" value="글 리스트로"></td>
	</tr>
	
</table>


</body>
</html>