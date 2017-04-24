<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> GPS 글쓰기 </title>

<script src="resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=6b513317a557b95d9627ec6ce1303e51&libraries=services"></script>
<!-- ab43af777848bf1eb1bd3148b28cf31d -->
<script src="resources/js/writemaps.js"></script>
<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">

<script>
var arr = [];

function gpsUpdate()
{	
	var formData = new FormData();
	
	for(var i=0; i<positions.length; i++){
		var ctid = "#"+markerids[i];
		var susume = {
			lat : positions[i].gb,
			lng : positions[i].hb,
			content  : $(ctid).val()
		}
		arr.push(susume)
	}
	
	var jarr = JSON.stringify(arr);
	
	formData.append("file", $("#upload")[0].files[0]);
	formData.append("gps_title", $("#gps_title").val());
	formData.append("gps_content", $("#gps_content").val());
	formData.append("gps_marker", jarr);
	formData.append("gps_boardnum", $("#gps_bn").val());
	
	$.ajax({
		
		type : "POST",						
		url : "updateGps",
		data : formData,
		processData : false,
	    contentType : false,
		success : function(data){

			location.href="gpsread?gps_boardnum="+$("#gps_bn").val();
			
		},
		error : function(e){
			console.log(e);
		}
	
	});
	
}

$(function(){
	$("#upload").change(function(){
		var formData = new FormData();
		formData.append("file",$("#upload")[0].files[0]);
				
		if($("#upload")[0].files[0] != undefined){
			$.ajax({
				type : "POST",						
				url : "getTempMap",
				data : formData,
				processData : false,
			    contentType : false,
				success : function(data){
					
					var html = "<div id='mapWrapper'>"
							 	+"<div id='map'></div>"
								+"</div>"
								+"<p>"
							    +"<button id='hideMarkers'>마커 전체 삭제</button>"
								+"</p>"; 

						$("#mapDiv").empty();
						$("#mapDiv").html(html);
					
					$.each(data, function(index, item) {
						var latlng = new daum.maps.LatLng(parseFloat(item.lat), parseFloat(item.lng));
						if(index==0){
							startLat = parseFloat(item.lat);
							startLng = parseFloat(item.lng);
						}if(index==data.length-1){
							arriveLat = parseFloat(item.lat);
							arriveLng = parseFloat(item.lng);
						}
						latlngList.push(latlng);
					})
					
					initMap(startLat, startLng, arriveLat, arriveLng);
						
				},
				error : function(e){
					
					console.log(e);
					
				}
			});
		}
		else{
			
		  $("#mapDiv").empty();
		  latlngList = new Array;
		  
		}
 
	})
})

</script>

</head>
<body>

<style>

#gps_content
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
	          <span class="board-title">Update</span>
	          <div class="board-title-divider"></div>
	        </div>
	      </div> 

			<div>
				<div>TITLE <input type="text" name = "gps_title" id = "gps_title" value="${gpsboard.gps_title}"></div>

				<div id="contents">
					
					<table><tr>
						<td>GPX 파일 첨부</td>
						<td><input type="file" id="upload" name="upload" size="30"></td>
					</tr></table>
					
					<div id = "mapDiv"></div>					
						
					<div class="contentDiv">
						CONTENTS <br><textarea id = "gps_content" name = "gps_content">${gpsboard.gps_content}</textarea>
						<input type="hidden" id="gps_bn" value="${gpsboard.gps_boardnum}">
					</div>
					
				</div>
			
			</div>

			<div>
				<input type="button" id="videoWrite" value="write" onclick="gpsUpdate()">
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