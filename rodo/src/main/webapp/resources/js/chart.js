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
	   
   }else{
		if(chartFlag == 1){
			$("#chart_div").html("");
			chartFlag = 0;
		}	   
   }
}

