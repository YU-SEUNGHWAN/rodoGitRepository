<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="./resources/js/jquery-3.1.1.js"></script>
	<script type="text/javascript">
		$(function(){
			
			$("#imgBtn").on("click",function(){
				
				var formData = new FormData();
				
				console.log($("#upload")[0].files.length);
				
				for(var index = 0; index < $("#upload")[0].files.length; index++){
					formData.append("file"+index,$("#upload")[0].files[index]);
				}
				
				$.ajax({
					type:"POST",						
					url:"fileupload",				
					data:formData,
					processData: false,
				    contentType: false,
					dataType:"json",				
					success:function(data){	
						console.log(data);
						console.log(data.savedfile);
						console.log(data.tn);
						$("#imgDiv").empty();
						$("#imgDiv").html('<img alt="" src="download?origin='+data.savedfile+'&tn='+data.tn+'">');
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

<div id="imgDiv"></div>

<input type="file" style="width:300px" id="upload" name="file-data" multiple>	

<input type="button" id="imgBtn" value="전송">
<input type = "button" id = "photoBoard" value = "사진게시판으로">
</body>
</html>