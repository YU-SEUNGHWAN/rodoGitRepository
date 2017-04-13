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
		alert("asdfa");
		
		var id = $("loginId").val();
		var title = $("#photo_title").val();
		var content = $("#photo_content").val();
		var share = $("#photo_share").val();
		var boardnum = $("#photo_boardnum").val();

		if(title==""){
			alert("제목을 입력해주세요.");
		}
		if(content==""){
			alert("내용을 입력해주세요.");
		}
		
		alert("asdfasdfasdf");
		
		var formData = new FormData();
			console.log($("#upload")[0].files.length);
			for(var index = 0; index < $("#upload")[0].files.length; index++){
				formData.append("file"+index,$("#upload")[0].files[index]);
			}
			formData.append("loginId",id);
			formData.append("photo_title",title);
			formData.append("photo_content",content);
			formData.append("photo_share",share);
			formData.append("photo_boardnum",boardnum);
		
		$.ajax({
			type:"POST",						
			url:"updatePhoto",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data){	
				console.log(data);
				alert("글 수정이 성공적으로 완료되었습니다.");
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
			<td><input type="text" name="photo_title" id="photo_title" value="${board.photo_title }"></td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td><input type="text" name="photo_content" id="photo_content" value="${board.photo_content }"></td>
		</tr>
		<tr>
			<td>공개여부</td>
			<td><select>
					<option value="0" id="photo_share" selected>공개</option>
					<option value="1" id="photo_share">비공개</option>
			</select></td>
		</tr>
	</table>
	<input type ="hidden" id="photo_boardnum" name="photo_boardnum" value="${board.photo_boardnum }">
	<input type="file" id="upload" name="file-data" multiple>

	<!-- <input type="button" id="imgBtn" value="전송"> -->
	<input type="submit" id="save" value="글 수정">
	<input type="button" id="photoBoard"
		onclick="javascript:location.href='photoBoard'" value="글 리스트로">
</body>
</html>