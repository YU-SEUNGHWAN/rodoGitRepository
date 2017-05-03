google.charts.load('current', {'packages':['line', 'corechart']});

var chartFlag = 0;

function drawChart() {
	if(chartFlag == 0){
	  var chartDiv = document.getElementById('chart_div');
	
	  var data = new google.visualization.DataTable();
	  data.addColumn('datetime', '시간');
	  data.addColumn('number', '고도(m)');
	  data.addColumn('number', '속도(km/h)');
	
	  data.addRows(eleChart);
	
	  var materialOptions = {
	    chart: {
	      title: ' ',
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
	
	   var materialChart = new google.charts.Line(chartDiv);
	   materialChart.draw(data, materialOptions);
	   chartFlag = 1; 
	   
	   $("#chart_div2").html("<table style='border-top:2px solid black; border-bottom:2px solid black;width:200px; text-align:center;'><tr><td>최대고도&nbsp;&nbsp;:&nbsp;&nbsp;<b>"+ highele +"</b></td></tr>"
 	   					+"<tr><td>평균고도&nbsp;&nbsp;:&nbsp;&nbsp;<b>" + arele + "</b></td></tr>"
						+ "<tr><td>최대속도&nbsp;&nbsp;:&nbsp;&nbsp;<b>" + highdist + "</b></td></tr>"
						+ "<tr><td>평균속도&nbsp;&nbsp;:&nbsp;&nbsp;<b>" + ardist + "</b></td></tr>"
						+ "</table>");
	   
   }else{
		if(chartFlag == 1){
			$("#chart_div").html("");
			 $("#chart_div2").html("");
			chartFlag = 0;
		}	   
   }
}

