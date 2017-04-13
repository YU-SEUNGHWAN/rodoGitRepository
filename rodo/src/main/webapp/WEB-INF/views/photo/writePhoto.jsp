<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">
 $(function(){
	
		
	$("#save").on("click",function(){
		
		var id = $("loginId").val();
		var title = $("#photo_title").val();
		var content = $("#photo_content").val();
		var share = $("#photo_share").val();
		
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
			formData.append("photo_title",title);
			formData.append("photo_content",content);
			formData.append("photo_share",share);
		
		$.ajax({
			type:"POST",						
			url:"writePhoto",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data){	
				console.log(data);
				alert("글 등록이 성공적으로 완료되었습니다.");
				if(data='success')
					location.href = "photoBoard";
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
</head>
<body>
	글쓰기
	<table>
		<tr>
			<td>글 제목</td>
			<td><input type="text" name="photo_title" id="photo_title"></td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td><input type="text" name="photo_content" id="photo_content"></td>
		</tr>
		<tr>
			<td>공개여부</td>
			<td><select>
					<option value="0" id="photo_share" selected>공개</option>
					<option value="1" id="photo_share">비공개</option>
			</select></td>
		</tr>
	</table>
	<input type="file" id="upload" name="file-data" multiple accept = ".jpg">

	<!-- <input type="button" id="imgBtn" value="전송"> -->
	<input type="submit" id="save" value="글 등록">
	<input type="button" id="photoBoard"
		onclick="javascript:location.href='photoBoard'" value="글 리스트로">
</body>
</html>