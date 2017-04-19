<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판 작성</title>
<script src="resources/js/jquery-3.1.1.js"></script>
<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<link href="resources/css/jquery.bxslider.css" rel="stylesheet" />
<script>

	var video, $output1;
	var scale = 0.5;
	var canvas;
	
	function cap1() {
		$output1 = $("#output1");
		video = $("#videoForm").get(0);

		canvas = document.createElement("canvas");
		canvas.width = video.videoWidth * scale;
		canvas.height = video.videoHeight * scale;
		canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

		var img = document.createElement("img");
		img.src = canvas.toDataURL();
		$output1.empty();
		$output1.prepend(img);
	};

	function del1() {
		$("#output1").empty();
	}
	
	function videoWrite()
	{	
		var formData = new FormData();
		formData.append("file", $("#upload")[0].files[0]);
		formData.append("video_thumbnail", canvas.toDataURL());
		formData.append("video_title", $("#title").val());
		formData.append("video_content", $("#content").val());
		
		
		$.ajax({
			
			type : "POST",						
			url : "writeVideo",
			data : formData,
			processData : false,
		    contentType : false,
			success : function(data){

				location.href="videoBoard";
				
			},
			error : function(e){
				console.log(e);
			}
		
		});
		
	}
	

	$(function()
	{
		$("#upload").change(function()
		{
			var formData = new FormData();
			formData.append("file",$("#upload")[0].files[0]);
			
			if($("#upload")[0].files[0] != undefined)
			{
				$.ajax
				({
					type : "POST",						
					url : "getTempVideo",
					
					data : formData,
					
					processData : false,
				    contentType : false,
				    
					dataType : "text",
					
					success : function(data)
					{
						alert(data);
						
						var html = "<div>"
						   		   +"<video height='380' id='videoForm' controls='controls'>"
	 						   	   +"<source src='"+data+"' />"
	 						   	   +"</video></div>"
	 						       +"<div id='output1' height='360'></div>"
	 						       +"<div>"
		 						   +"<input type='button' onclick='cap1()' value='썸네일 선택'>"
		 						   +"<input type='button' onclick='del1()' value='삭제'>"
	 						       +"</div></div>"
		  						   
							$("#videoDiv").empty();
							$("#videoDiv").html(html);	
					},
					
					error : function(e)
					{
						console.log(e);
					}
				
				});
			}
			
			else
			{
			  $("#videoDiv").empty();
			}
	 
		})
	})

</script>

<style>

.contentDiv
{
	
}
#content
{
	height:400px;
	width:700px;
}

</style>

</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<section id="portfolio" style="background-color: #f6f6f6; height:100%;">
	    <div class="container wow fadeInUp board-main">  
	      <div class="row">
	        <div class="col-md-12" style="padding-bottom:35px; padding-top: 40px;">
	          <span class="board-title">Write</span>
	          <div class="board-title-divider"></div>
	        </div>
	      </div> 

			<div>
				<div>제목 <input type="text" name="title" id="title"></div>
				<br>
				내용
				
				<div id="contents">
			
					<div id="videoDiv">
					</div>
					
					<div class="contentDiv">
						<textarea id="content"></textarea>
					</div>
					
				</div>
			
			</div>
			<div>
				동영상 첨부
				<input type="file" id="upload" name="upload" size="30">
			</div>
			<div>
				<input type="button" id="videoWrite" value="write" onclick="videoWrite()">
			</div>			
		</div>
	</section>
	
	<footer id="footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="copyright">
              &copy; Copyright <strong>Imperial Theme</strong>. All Rights Reserved
            </div>
            <div class="credits">
              Bootstrap Themes by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>
          </div>
        </div>
      </div>
	</footer>
</body>
</html>