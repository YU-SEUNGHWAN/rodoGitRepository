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
		$("#output1").html("<img src='resources/img/sample.png'>");
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
						var html = "<div class='row'>"
								   +"<div class='col-md-6'>"
						   		   +"<video height='380' id='videoForm' controls='controls'>"
	 						   	   +"<source src='"+data+"' />"
	 						   	   +"</video></div>"
	 						       +"<div class='col-md-4' height='160'>"
	 						   	   +"<table><tr><td>"
	 						       +"<div id='output1'>"
	 						       +"<img src='resources/img/sample.png'></div></td></tr>"
		 						   +"<tr><td class='tnbtn'>"
	 						       +"<input type='button' onclick='cap1()' value='썸네일 선택'>"
		 						   +"<input type='button' onclick='del1()' value='삭제'>"
	 						       +"</td></tr></table>"
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
			  $("#output1").html("<img src='resources/img/sample.png'>");
			}
	 
		})
	})

</script>

<style>
#services {
	font-size:16px;
}

#filetable{
	margin-bottom: 15px;
}

.filetitle{
	font-weight: bolder;
}

#upload{
	margin-left: 20px;
}

#content{
	height:449px;
	width:86%;
	margin-top: 5px;
	resize: none;
	border: 3px solid;
}

#hideMarkers{
	font-weight:bolder;
	margin-top: 10px;
	padding: 5px;
	border: 3px solid #4f5051;
	background: white;
	color: #4f5051;
	font-weight: bolder;
	width: 120px;
	height: 40px;
}

#hideMarkers:hover{
	border: 3px solid #4f5051;
	background: #4f5051;
	color: white;
}

#title{
	border : 0px;
	border-bottom: 3px solid;
	margin-left: 15px;
	margin-bottom: 30px;
	width: 80%;
}

.gpsbutton{
	margin-top: 15px;
	margin-bottom: 30px;
	margin-left: 15px;
	margin-right: 15px;
	border: 3px solid #4f5051;
	background: #4f5051;
	font-size:20px;
	color: white;
	width: 80px;
	height: 40px;
	font-family: "Raleway", sans-serif";
	text-transform: uppercase;
}
.gpsbutton:hover{
	border: 3px solid #4f5051;
	background: white;	
	color: #4f5051;
	font-weight: bolder;
}

b{
	font-size: 20px;
}
#buttontable{
	width: 86%
}
#gpswrite{
	text-align: right;
}
#output1{
	margin-top : 80px;
}
img{
	height:180px;
}
.tnbtn{
	padding-top: 15px;
	padding-left: 35px;
}
</style>	

</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<section id="services" style="background-color: #f6f6f6;">
	    <div class="container wow fadeInUp board-main">  
	      <div class="row">
	        <div class="col-md-12" style="padding-bottom:35px; padding-top: 40px;">
	          <span class="board-title">video Write</span>
	          <div class="board-title-divider"></div>
	        </div>
	      </div> 

			<div>
				<div><b>TITLE</b><input type="text" name = "title" id = "title"></div>

					<table id="filetable"><tr>
						<td class="filetitle">VIDEO FILE</td>
						<td><input type="file" id="upload" name="upload" size="30" accept=".mp4">
						</td>
					</tr></table>
					
					<div id="videoDiv"></div>
	
					<div id="contents">				
						<div class="contentDiv">
							<b>CONTENTS</b><br><textarea id = "content" name = "content"></textarea>
						</div>
					</div>
			</div>

			<div>
				<table id="buttontable"><tr>
					<td><input type="button" class="gpsbutton" value="back" onclick="javascript:location.href='videoBoard'"></td>
					<td id="gpswrite"><input type="button" class="gpsbutton" id="videoWrite" value="write" onclick="videoWrite()"></td>
					
				</tr></table>
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
	
	<!--  Required JavaScript Libraries -->
	<script src="resources/lib/jquery/jquery.min.js"></script>
	<script src="resources/lib/jquery/jquery-migrate.min.js"></script>
	<script src="resources/lib/bootstrap/js/bootstrap.min.js"></script>
	<script src="resources/lib/superfish/hoverIntent.js"></script>
	<script src="resources/lib/superfish/superfish.min.js"></script>
	<script src="resources/lib/morphext/morphext.min.js"></script>
	<script src="resources/lib/wow/wow.min.js"></script>
	<script src="resources/lib/stickyjs/sticky.js"></script>
	<script src="resources/lib/easing/easing.js"></script>
	<!-- Template Specisifc Custom Javascript File -->
	<script src="resources/js/custom.js"></script>

</body>
</html>