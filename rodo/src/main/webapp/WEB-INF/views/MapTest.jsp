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
	height: 300px;
}
</style>
<script>
	var flightPlanCoordinates = new Array;
	var eleChart = new Array;
	
	google.charts.load('current', {packages: ['corechart', 'line']});
//	google.charts.setOnLoadCallback(drawAxisTickColors);
	
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
					var ele = [new Date(item.time), parseFloat(item.ele), parseFloat(item.dist)];			
					if(index==0){
						x = parseFloat(item.lat);
						y = parseFloat(item.lng);
					}
					flightPlanCoordinates.push(gpx);
					eleChart.push(ele);
				})
				initMap(x, y);
			},
			error : function(e) {
				console.log(e);
			}
		})
		
	});

	function initMap(x, y) {

		var map = new google.maps.Map(document.getElementById('map'), {
			zoom : 13,
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
	
/* 	function drawAxisTickColors() {
	      var data = new google.visualization.DataTable();
	      data.addColumn('datetime', '시간');
	      data.addColumn('number', '고도');
	      data.addColumn('number', '속도');
	      
	      data.addRows(eleChart);
	      
	      var date_format = new google.visualization.DateFormat("yyyy-MM-dd HH:mm:ss");
	      date_format.format(data,1);
	      
	      var options = {
	        hAxis: {
	          title: '',
	          textStyle: {
	            color: '#01579b',
	            fontSize: 16,
	            fontName: 'Arial',
	            bold: true,
	            italic: false
	          },
	          titleTextStyle: {
	            color: '#01579b',
	            fontSize: 16,
	            fontName: 'Arial',
	            bold: true,
	            italic: false
	          }
	        },
	        vAxis: {
	          title: '',
	          textStyle: {
	            color: '#ff025f',
	            fontSize: 20,
	            bold: true,
	            italic: false
	          },
	          titleTextStyle: {
	            color: '#ff025f',
	            fontSize: 16,
	            bold: true,
	            italic: false
	          }
	        },
	        colors: ['#ff025f','blue']
	      };
	      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	      chart.draw(data, options);
	    } */

	    google.charts.load('current', {'packages':['line', 'corechart']});
	    google.charts.setOnLoadCallback(drawChart);

	    function drawChart() {

	      var chartDiv = document.getElementById('chart_div');

	      var data = new google.visualization.DataTable();
	      data.addColumn('datetime', '');
	      data.addColumn('number', '고도(m)');
	      data.addColumn('number', '속도(km/h)');

	      data.addRows(eleChart);

	      var materialOptions = {
	        chart: {
	          title: '시간별 고도 및 속도',
	        },
	        series: {
	          0: {axis: 'ele'},
	          1: {axis: 'distance'}
	        },
	        axes: {
	          y: {
	            Temps: {label: 'ele'},
	            Daylight: {label: 'distance'}
	          }
	        },
		    colors: ['#ff025f','#008c25']
	      };

	      function drawMaterialChart() {
	        var materialChart = new google.charts.Line(chartDiv);
	        materialChart.draw(data, materialOptions);
	      }

	      drawMaterialChart();

	    }
	    
</script>
</head>
<body>
	<div id="map"></div>
	<div id="chart_div"></div>
</body>
</html>