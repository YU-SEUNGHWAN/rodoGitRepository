<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.1.1.js"></script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBEwzJei2-iqsDihEB_3T5QGoV2yAEXrps"></script>
<style>
#map {
	width: 600px;
	height: 600px;
}
</style>
<script>
	var flightPlanCoordinates = new Array;
	
	$(function() {
		var x = 0;
		var y = 0;
		$.ajax({
			type : "GET",
			url : "getGpsList",
			success : function(data) {
				$.each(data, function(index, item) {
					var gpx = {
						lat : parseFloat(item.lat),
						lng : parseFloat(item.lng)
					};
					if(index==0){
						x = parseFloat(item.lat);
						y = parseFloat(item.lng);
					}
					flightPlanCoordinates.push(gpx);
				})
				initMap(flightPlanCoordinates, x, y);
				console.log(flightPlanCoordinates);
			},
			error : function(e) {
				console.log(e);
			}
		})
		
	});

	function initMap(flightPlanCoordinates, x, y) {

		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 14,
			center : {
				lat : x,
				lng : y
			},
			mapTypeId : google.maps.MapTypeId.ROADMAP
		});

		var flightPath = new google.maps.Polyline({
			path : flightPlanCoordinates,
			geodesic : true,
			strokeColor : '#FF0000',
			strokeOpacity : 1.0,
			strokeWeight : 2
		});

		flightPath.setMap(map);

	}
</script>
</head>
<body>
	<div id="map"></div>
</body>
</html>