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

function gpsWrite()
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
	formData.append("gps_location", $("#gps_location").val());
	
	$.ajax({
		
		type : "POST",						
		url : "writeGps",
		data : formData,
		processData : false,
	    contentType : false,
		success : function(data){

			location.href="logBoard";
			
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

#gps_content{
	height:400px;
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

#gps_title{
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
</style>

</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<section id="services" style="background-color: #f6f6f6;">
	    <div class="container wow fadeInUp board-main">  
	      <div class="row">
	        <div class="col-md-12" style="padding-bottom:35px; padding-top: 40px;">
	          <span class="board-title">GPS Write</span>
	          <div class="board-title-divider"></div>
	        </div>
	      </div> 

			<div>
				<div><b>TITLE</b><input type="text" name = "gps_title" id = "gps_title"></div>

				<div id="contents">
					
					<table id="filetable"><tr>
						<td class="filetitle">GPX FILE</td>
						<td><input type="file" id="upload" name="upload" size="30" accept=".gpx" multiple = "multiple"></td>
					</tr></table>
					
					<div id = "mapDiv"></div>					
						
						<div id = "designlocation">
						<select id = "gps_location" name = "location">
							<option name = "서울" selected="selected">서울</option>
							<option name = "경기">경기</option>
							<option name = "인천">인천</option>
							<option name = "강원">강원</option>
							<option name = "대전">대전</option>
							<option name = "세종">세종</option>
							<option name = "충북">충북</option>
							<option name = "충남">충남</option>
							<option name = "광주">광주</option>
							<option name = "전북">전북</option>
							<option name = "전남">전남</option>
							<option name = "대구">대구</option>
							<option name = "부산">부산</option>
							<option name = "울산">울산</option>
							<option name = "경북">경북</option>
							<option name = "경남">경남</option>
							<option name = "제주">제주</option>
						</select>
					</div>
						
					<div class="contentDiv">
						<b>CONTENTS</b><br><textarea id = "gps_content" name = "gps_content"></textarea>
					</div>
					
				</div>
			
			</div>

			<div>
				<table id="buttontable"><tr>
					<td><input type="button" class="gpsbutton" value="back" onclick="javascript:location.href='photoBoard'"></td>
					<td id="gpswrite"><input type="button" class="gpsbutton" id="videoWrite" value="write" onclick="gpsWrite()"></td>
					
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