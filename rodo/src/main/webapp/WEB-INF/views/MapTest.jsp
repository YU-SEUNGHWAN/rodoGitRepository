<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.1.1.js"></script>
<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBEwzJei2-iqsDihEB_3T5QGoV2yAEXrps"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
#map{
	width: 800px;
	height: 600px;
}
#chart_div{
	width: 700px;
	height: 500px;
}
</style>
<script>
	var flightPlanCoordinates = new Array;
	var eleChart = new Array;
	
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(drawAxisTickColors);
	
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
					var ele = [index, parseFloat(item.ele)];			
					if(index==0){
						x = parseFloat(item.lat);
						y = parseFloat(item.lng);
					}
					flightPlanCoordinates.push(gpx);
					eleChart.push(ele);
				})
				initMap(x, y);
				drawAxisTickColors();
				console.log(eleChart);
			},
			error : function(e) {
				console.log(e);
			}
		})
		
	});

	function initMap(x, y) {

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
	
	function drawAxisTickColors() {
	      var data = new google.visualization.DataTable();
	      data.addColumn('number', 'time');
	      data.addColumn('number', 'ele');
/* 	      data.addColumn('number', 'Cats');*/
/* 	      data.addRows([
	        [0, 0, 0],    [1, 10, 5],   [2, 23, 15],  [3, 17, 9],   [4, 18, 10],  [5, 9, 5],
	        [6, 11, 3],   [7, 27, 19],  [8, 33, 25],  [9, 40, 32],  [10, 32, 24], [11, 35, 27],
	        [12, 30, 22], [13, 40, 32], [14, 42, 34], [15, 47, 39], [16, 44, 36], [17, 48, 40],
	        [18, 52, 44], [19, 54, 46], [20, 42, 34], [21, 55, 47], [22, 56, 48], [23, 57, 49],
	        [24, 60, 52], [25, 50, 42], [26, 52, 44], [27, 51, 43], [28, 49, 41], [29, 53, 45],
	        [30, 55, 47], [31, 60, 52], [32, 61, 53], [33, 59, 51], [34, 62, 54], [35, 65, 57],
	        [36, 62, 54], [37, 58, 50], [38, 55, 47], [39, 61, 53], [40, 64, 56], [41, 65, 57],
	        [42, 63, 55], [43, 66, 58], [44, 67, 59], [45, 69, 61], [46, 69, 61], [47, 70, 62],
	        [48, 72, 64], [49, 68, 60], [50, 66, 58], [51, 65, 57], [52, 67, 59], [53, 70, 62],
	        [54, 71, 63], [55, 72, 64], [56, 73, 65], [57, 75, 67], [58, 70, 62], [59, 68, 60],
	        [60, 64, 56], [61, 60, 52], [62, 65, 57], [63, 67, 59], [64, 68, 60], [65, 69, 61],
	        [66, 70, 62], [67, 72, 64], [68, 75, 67], [69, 80, 72]
	      ]); */
	      data.addRows(eleChart);
	      
	      var options = {
	        hAxis: {
	          title: 'Time',
	          textStyle: {
	            color: '#01579b',
	            fontSize: 20,
	            fontName: 'Arial',
	            bold: true,
	            italic: true
	          },
	          titleTextStyle: {
	            color: '#01579b',
	            fontSize: 16,
	            fontName: 'Arial',
	            bold: false,
	            italic: true
	          }
	        },
	        vAxis: {
	          title: 'elevation',
	          textStyle: {
	            color: '#1a237e',
	            fontSize: 24,
	            bold: true
	          },
	          titleTextStyle: {
	            color: '#1a237e',
	            fontSize: 24,
	            bold: true
	          }
	        },
	        colors: ['#a52714']
	      };
	      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	      chart.draw(data, options);
	    }
	
</script>
</head>
<body>
	<div id="map"></div>
	<div id="chart_div"></div>
</body>
</html>