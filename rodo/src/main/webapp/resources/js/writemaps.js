	var latlngList = new Array;
	var map;
	var startLat, startLng, arriveLat, arriveLng;
	var markers = [];
	var infowindows = [];
	var positions = [];
	var markerids = [];
	
   	function initMap(){
  	    var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
  	    mapOption = { 
  	        center: new daum.maps.LatLng(startLat, startLng), // 지도의 중심좌표
  	        level: 5 // 지도의 확대 레벨
  	    };

  		map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
  		
  		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
  		var mapTypeControl = new daum.maps.MapTypeControl();

  		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
  		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
  		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

  		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
  		var zoomControl = new daum.maps.ZoomControl();
  		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
  		
  		
  		// 선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
  		var linePath = latlngList;
  		
  		// 지도에 표시할 선을 생성합니다
  		var polyline = new daum.maps.Polyline({
  		    path: linePath, // 선을 구성하는 좌표배열 입니다
  		    strokeWeight: 5, // 선의 두께 입니다
  		    strokeColor: '#ff2a00', // 선의 색깔입니다
  		    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
  		    strokeStyle: 'solid' // 선의 스타일입니다
  		});
  		
  		// 지도에 선을 표시합니다 
  		polyline.setMap(map);
  		
  		
  		var startSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 출발 마커이미지의 주소입니다    
  	    startSize = new daum.maps.Size(50, 45), // 출발 마커이미지의 크기입니다 
  	    startOption = { 
  	        offset: new daum.maps.Point(15, 43) // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  	    };
  		var arriveSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png', // 도착 마커이미지 주소입니다    
  		arriveSize = new daum.maps.Size(50, 45), // 도착 마커이미지의 크기입니다 
  		arriveOption = { 
  		    offset: new daum.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
  		}; 

   	
   	// 출발, 도착 마커 이미지를 생성합니다
   		var startImage = new daum.maps.MarkerImage(startSrc, startSize, startOption);
   		var arriveImage = new daum.maps.MarkerImage(arriveSrc, arriveSize, arriveOption);
   	
	// 출발, 도착 마커가 표시될 위치입니다 
   		var startPosition = new daum.maps.LatLng(startLat, startLng);
   		var arrivePosition = new daum.maps.LatLng(arriveLat, arriveLng);
   		
   	// 출발, 도착 마커를 생성합니다
   		var startMarker = new daum.maps.Marker({
   		    map: map, // 출발 마커가 지도 위에 표시되도록 설정합니다
   		    position: startPosition,
   		    image: startImage // 출발 마커이미지를 설정합니다
   		})	   	
   		var arriveMarker = new daum.maps.Marker({  
   		    map: map, // 도착 마커가 지도 위에 표시되도록 설정합니다
   		    position: arrivePosition,
   		    image: arriveImage // 도착 마커이미지를 설정합니다
   		});
   		
   		daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
   		    // 클릭한 위치에 마커를 표시합니다 
   		    addMarker(mouseEvent.latLng);             
   		});
   		
  	};
  	
  	function addMarker(position) {
		    
		    // 마커를 생성합니다
		    var marker = new daum.maps.Marker({
		        position : position
		    });
		    
		    // 마커가 지도 위에 표시되도록 설정합니다
		    marker.setMap(map);
		    
		    marker.setDraggable(true); 
		    
	   		var ps = position+"";
	   		ps = ps.replace(",","");
	   		ps = ps.replace(".","");
	   		ps = ps.replace(".","");
	   		ps = ps.replace(" ","");
	   		ps = ps.replace("(","");
	   		ps = ps.replace(")","");
		    
		   	// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
	   		var iwContent = "<div><textarea id='"+ps+"' style='height:100px; width:200px;'></textarea></div>", // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	   		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다.
	   		
	   		
	   		// 인포윈도우를 생성합니다
	   		var infowindow = new daum.maps.InfoWindow({
	   		    content : iwContent,
	   		    removable : iwRemoveable
	   		});

	   		daum.maps.event.addListener(marker, 'click', function() {
	   		    // 마커 위에 인포윈도우를 표시합니다
	   		    infowindow.open(map, marker);
	   		});
	   		
	   		daum.maps.event.addListener(marker, 'rightclick', function() {
	   			
	   			var index = -1;
	   			
			    for (var i = 0; i < markers.length; i++) {
			       if(markers[i] == marker){
			    	   index = i;
			       }
			    }
			    infowindow.close(map, marker);
			    setMarkers(null);
			    markers.splice(index,1);
			    setMarkers(map);
			    infowindows.splice(index,1);
			    positions.splice(index,1);
			    markerids.splic(index,1);
	   		});
	   		
	   		$('#hideMarkers').on('click', function(){
	   			for (var i = 0; i < markers.length; i++) {
			        infowindows[i].close(map, markers[i]);
			    }   
				setMarkers(null);
				markers = [];
				infowindows = [];
				positions = [];
				markerids = [];
	   		})
	   		
		    // 생성된 마커를 배열에 추가합니다
		    markers.push(marker);
	   		infowindows.push(infowindow);
	   		positions.push(position);
	   		markerids.push(ps);
		}

		// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
		function setMarkers(map) {
		    for (var i = 0; i < markers.length; i++) {
		        markers[i].setMap(map);
		    }            
		}