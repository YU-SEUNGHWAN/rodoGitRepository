<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> GPS 글쓰기 </title>

<script src="resources/js/maps.js"></script>
<script src="resources/js/jquery-3.1.1.js"></script>

<script>

$(function()
{
	$("#upload").on("change", function()
	{
		<div id="mapWrapper">
			<div id="map"></div>
			<div id="roadviewControl" onclick="setRoadviewRoad()"><span>로드뷰</span></div>
		</div>
	})
})

</script>

</head>
<body>
	
	<div id="mapWrapper">
		<div id="map"></div>
		<div id="roadviewControl" onclick="setRoadviewRoad()"><span>로드뷰</span></div>
	</div>
	
	
	
	<h1> Gps 게시글작성 </h1>

<form action = "writeGps" method = "post" enctype = "multipart/form-data">

<table border = "1">
	<tr>
		<td>
			제목
		</td>
		
		<td>
			<input type = "text" name = "gps_title" id = "gps_title">
		</td>
	</tr>
	
	<tr>
		<td>
			본문
		</td>
	
		<td>
			<textarea rows = "20" cols = "50" id = "gps_content" name = "gps_content"></textarea>
		</td>
	</tr>
	
	<tr>
		<td>
			파일첨부
		</td>
		
		<td>
			<input type = "file" name = "upload" id = "upload" size = "30" multiple = "multiple">
		</td>
	</tr>
	
	<tr>
		<td>
			<input type = "submit" value = "작성완료">
		</td>
	</tr>
	
</table>

</form>

</body>
</html>