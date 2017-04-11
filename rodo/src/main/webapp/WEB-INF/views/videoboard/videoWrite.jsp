<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판 작성</title>
<script src="resources/js/jquery-3.1.1.js"></script>
<script>

	var video, $output1, $output2, $output3;
	var scale = 0.25;
	var test1, test2;

	function cap1() {
		$output1 = $("#output1");
		video = $("#video").get(0);

		var canvas = document.createElement("canvas");
		canvas.width = video.videoWidth * scale;
		canvas.height = video.videoHeight * scale;
		canvas.getContext('2d').drawImage(video, 0, 0, canvas.width,
				canvas.height);

		var img = document.createElement("img");
		img.src = canvas.toDataURL();
		$output1.empty();
		$output1.prepend(img);
	};

	function cap2() {
		$output2 = $("#output2");
		video = $("#video").get(0);

		var canvas = document.createElement("canvas");
		canvas.width = video.videoWidth * scale;
		canvas.height = video.videoHeight * scale;
		canvas.getContext('2d').drawImage(video, 0, 0, canvas.width,
				canvas.height);

		var img = document.createElement("img");
		img.src = canvas.toDataURL();
		$output2.empty();
		$output2.prepend(img);
	};

	function cap3() {
		$output3 = $("#output3");
		video = $("#video").get(0);

		var canvas = document.createElement("canvas");
		canvas.width = video.videoWidth * scale;
		canvas.height = video.videoHeight * scale;
		canvas.getContext('2d').drawImage(video, 0, 0, canvas.width,
				canvas.height);

		var img = document.createElement("img");
		img.src = canvas.toDataURL();
		console.log(canvas)
		$output3.empty();
		$output3.prepend(img);
	};

	function del1() {
		$("#output1").empty();
	}
	function del2() {
		$("#output2").empty();
	}
	function del3() {
		$("#output3").empty();
	}
	
	

	$(function(){
		
		
		$("#upload").change(function(){
			
			
			var formData = new FormData();
			formData.append("file",$("#upload")[0].files[0]);
			
			$.ajax({
				
				type : "POST",						
				url : "getTempVideo",
				data : formData,
				processData : false,
			    contentType : false,
				dataType : "text",
				success : function(data){

					var html = "<video width='760' height='380' id='video' controls='controls'>"
	  						   +"<source src='"+data+"' />"
	  						   +"</video>"
	  						   
			        //setTimeout(function(){
						$("#videoDiv").empty();
						$("#videoDiv").html(html);
			        //}, 10000)
				
				},
				error : function(e){
					console.log(e);
				}
			});		
			
		})
		
	})

	
</script>
</head>
<body>
	<h2>미디어</h2>

	<div>
		<div>제목 <input type="text" name="title" id="title"><div>
		<br>
		내용
		<div id="content">
	
			<div id="videoDiv">
			</div>
		
			<table>
		
				<tr>
					<td>
						<input type="button" onclick="cap1()" value="캡쳐1">
						<input type="button" onclick="del1()" value="삭제">
					</td>

					<td>
						<input type="button" onclick="cap2()" value="캡쳐2">
						<input type="button" onclick="del2()" value="삭제">
					</td>
					<td>
						<input type="button" onclick="cap3()" value="캡쳐3">
						<input type="button" onclick="del3()" value="삭제">
					</td>
				</tr>
				
				<tr>
					<td id="output1"></td>
					<td id="output2"></td>
					<td id="output3"></td>
				</tr>

			</table>

		</div>
		<br>
		<div>
		동영상 첨부
		<form><input type="file" id="upload" name="upload" size="30"></form>
		</div>
	</div>
</body>
</html>