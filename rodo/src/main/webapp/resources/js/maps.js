	var latlngList = new Array;
	var eleChart = new Array;
	var map, placeOverlay, contentNode, markers, currCategory, ps, overlayOn, container, mapWrapper, mapContainer, rvContainer,
	mapCenter, rv, rvClient, markImage, marker;
	var startLat, startLng, arriveLat, arriveLng;
	
	$(function(){
		$.ajax({
			type : "GET",
			data : { savedfile : $('#savedfile').val() },
			url : "getGpsList",
			success : function(data) {
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
					if(index%5==0){
						var ele = [new Date(item.time), parseFloat(item.ele), parseFloat(item.dist)];			
						eleChart.push(ele);
					}
				})
				var m = $('#myMarks').val();
				marks = JSON.parse(m);
				initMap(startLat, startLng, arriveLat, arriveLng, marks);
			},
			error : function(e) {
				console.log(e);
			}
		})
		
	});
	
   	function initMap(){
  	    var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
  	    mapOption = { 
  	        center: new daum.maps.LatLng(startLat, startLng), // 지도의 중심좌표
  	        level: 7 // 지도의 확대 레벨
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
  		    strokeWeight: 3, // 선의 두께 입니다
  		    strokeColor: '#9d00ff', // 선의 색깔입니다
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
   	
   		// 추천 마커
   		var positions = [];
	    
	    for(var i = 0; i < marks.length; i++){
	    	var mk = {
	    		content : "<div style='padding:5px; height:100px;'>"+marks[i].content+"</div>",
	    		latlng : new daum.maps.LatLng(parseFloat(marks[i].lng), parseFloat(marks[i].lat))
	    	}
	    	positions.push(mk);
	    }
	    
	    for (var i = 0; i < positions.length; i ++) {
	     // 마커를 생성합니다
	    	var myMarker = new daum.maps.Marker({
	    		map : map, // 마커를 표시할 지도
	    		position : positions[i].latlng // 마커의 위치
	    	});
	    	console.log(myMarker);
	  
	    	// 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new daum.maps.InfoWindow({
		        content: positions[i].content // 인포윈도우에 표시할 내용
		    });
		    
		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    daum.maps.event.addListener(myMarker, 'mouseover', makeOverListener(map, myMarker, infowindow));
		    daum.maps.event.addListener(myMarker, 'mouseout', makeOutListener(infowindow));
	    }
   		
   		
	    // 커스텀오버레이
   		placeOverlay = new daum.maps.CustomOverlay({zIndex:1}); 
   	    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
   	    markers = []; // 마커를 담을 배열입니다
   	    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

	   	// 장소 검색 객체를 생성합니다
	   	ps = new daum.maps.services.Places(map); 

    	// 지도에 idle 이벤트를 등록합니다
    	daum.maps.event.addListener(map, 'idle', searchPlaces);

    	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
    	contentNode.className = 'placeinfo_wrap';

    	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
    	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 daum.maps.event.preventMap 메소드를 등록합니다 
    	addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
    	addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);

    	// 커스텀 오버레이 컨텐츠를 설정합니다
    	placeOverlay.setContent(contentNode);  

    	// 각 카테고리에 클릭 이벤트를 등록합니다
    	addCategoryClickEvent();
    	
    	
    	
    //////////로드뷰///////////////	
    	
		overlayOn = false; // 지도 위에 로드뷰 오버레이가 추가된 상태를 가지고 있을 변수
		container = document.getElementById('container'); // 지도와 로드뷰를 감싸고 있는 div 입니다
		mapWrapper = document.getElementById('mapWrapper'); // 지도를 감싸고 있는 div 입니다
		mapContainer = document.getElementById('map'); // 지도를 표시할 div 입니다 
		rvContainer = document.getElementById('roadview'); //로드뷰를 표시할 div 입니다
		mapCenter = new daum.maps.LatLng(startLat, startLng); // 지도의 중심좌표

	    // 로드뷰 객체를 생성합니다 
	    rv = new daum.maps.Roadview(rvContainer); 
	    
	    // 좌표로부터 로드뷰 파노라마 ID를 가져올 로드뷰 클라이언트 객체를 생성합니다 
	    rvClient = new daum.maps.RoadviewClient(); 
	
	    // 로드뷰에 좌표가 바뀌었을 때 발생하는 이벤트를 등록합니다 
	    daum.maps.event.addListener(rv, 'position_changed', function() {
	        // 현재 로드뷰의 위치 좌표를 얻어옵니다 
	        var rvPosition = rv.getPosition();
	        
	        // 지도의 중심을 현재 로드뷰의 위치로 설정합니다
	        map.setCenter(rvPosition);
	
	        // 지도 위에 로드뷰 도로 오버레이가 추가된 상태이면
	        if(overlayOn) {
	            // 마커의 위치를 현재 로드뷰의 위치로 설정합니다
	            marker.setPosition(rvPosition);
	        }
    	});

	    // 마커 이미지를 생성합니다
	    markImage = new daum.maps.MarkerImage(
	        'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/roadview_wk.png',
	        new daum.maps.Size(35,39), {
	        //마커의 좌표에 해당하는 이미지의 위치를 설정합니다.
	        //이미지의 모양에 따라 값은 다를 수 있으나, 보통 width/2, height를 주면 좌표에 이미지의 하단 중앙이 올라가게 됩니다.
	        offset: new daum.maps.Point(14, 39)
    	});
    
	    // 드래그가 가능한 마커를 생성합니다
	    marker = new daum.maps.Marker({
	        image : markImage,
	        position: mapCenter,
	        draggable: true
	    });
	
	    // 마커에 dragend 이벤트를 등록합니다
	    daum.maps.event.addListener(marker, 'dragend', function(mouseEvent) {
	
	        // 현재 마커가 놓인 자리의 좌표입니다. 
	        var position = marker.getPosition();
	
	        // 마커가 놓인 위치를 기준으로 로드뷰를 설정합니다
	        toggleRoadview(position);
	    });
	
	    //지도에 클릭 이벤트를 등록합니다
	    daum.maps.event.addListener(map, 'click', function(mouseEvent){
	        
	        // 지도 위에 로드뷰 도로 오버레이가 추가된 상태가 아니면 클릭이벤트를 무시합니다 
	        if(!overlayOn) {
	            return;
	        }
	
	        // 클릭한 위치의 좌표입니다 
	        var position = mouseEvent.latLng;
	
	        // 마커를 클릭한 위치로 옮깁니다
	        marker.setPosition(position);
	
	        // 클락한 위치를 기준으로 로드뷰를 설정합니다
	        toggleRoadview(position);
	    });
	    
	    // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	    

  	}  // init 끝
   	
   	
   	
   	
   	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
   	function addEventHandle(target, type, callback) {
   	    if (target.addEventListener) {
   	        target.addEventListener(type, callback);
   	    } else {
   	        target.attachEvent('on' + type, callback);
   	    }
   	}

   	// 카테고리 검색을 요청하는 함수입니다
   	function searchPlaces() {
   	    if (!currCategory) {
   	        return;
   	    }
   	    
   	    // 커스텀 오버레이를 숨깁니다 
   	    placeOverlay.setMap(null);

   	    // 지도에 표시되고 있는 마커를 제거합니다
   	    removeMarker();
   	    
   	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
   	}

   	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
   	function placesSearchCB( status, data, pagination ) {
   	    if (status === daum.maps.services.Status.OK) {

   	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
   	        displayPlaces(data.places);
   	    } else if (status === daum.maps.services.Status.ZERO_RESULT) {
   	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

   	    } else if (status === daum.maps.services.Status.ERROR) {
   	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
   	        
   	    }
   	}

   	// 지도에 마커를 표출하는 함수입니다
   	function displayPlaces(places) {

   	    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
   	    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
   	    var order = document.getElementById(currCategory).getAttribute('data-order');

   	    

   	    for ( var i=0; i<places.length; i++ ) {

   	            // 마커를 생성하고 지도에 표시합니다
   	            var marker = addMarker(new daum.maps.LatLng(places[i].latitude, places[i].longitude), order);

   	            // 마커와 검색결과 항목을 클릭 했을 때
   	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
   	            (function(marker, place) {
   	                daum.maps.event.addListener(marker, 'click', function() {
   	                    displayPlaceInfo(place);
   	                });
   	            })(marker, places[i]);
   	    }
   	}

   	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
   	function addMarker(position, order) {
   	    var imageSrc = 'resources/img/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
   	        imageSize = new daum.maps.Size(27, 28),  // 마커 이미지의 크기
   	        imgOptions =  {
   	            spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
   	            spriteOrigin : new daum.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
   	            offset: new daum.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
   	        },
   	        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
   	            marker = new daum.maps.Marker({
   	            position: position, // 마커의 위치
   	            image: markerImage 
   	        });

   	    marker.setMap(map); // 지도 위에 마커를 표출합니다
   	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

   	    return marker;
   	}

   	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
   	function removeMarker() {
   	    for ( var i = 0; i < markers.length; i++ ) {
   	        markers[i].setMap(null);
   	    }   
   	    markers = [];
   	}

   	// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
   	function displayPlaceInfo (place) {
   	    var content = '<div class="placeinfo">' +
   	                    '   <a class="title" href="' + place.placeUrl + '" target="_blank" title="' + place.title + '">' + place.title + '</a>';   

   	    if (place.newAddress) {
   	        content += '    <span title="' + place.newAddress + '">' + place.newAddress + '</span>' +
   	                    '  <span class="jibun" title="' + place.address + '">(지번 : ' + place.address + ')</span>';
   	    }  else {
   	        content += '    <span title="' + place.address + '">' + place.address + '</span>';
   	    }                
   	   
   	    content += '    <span class="tel">' + place.phone + '</span>' + 
   	                '</div>' + 
   	                '<div class="after"></div>';

   	    contentNode.innerHTML = content;
   	    placeOverlay.setPosition(new daum.maps.LatLng(place.latitude, place.longitude));
   	    placeOverlay.setMap(map);  
   	}


   	// 각 카테고리에 클릭 이벤트를 등록합니다
   	function addCategoryClickEvent() {
   	    var category = document.getElementById('category'),
   	        children = category.children;

   	    for (var i=0; i<children.length; i++) {
   	        children[i].onclick = onClickCategory;
   	    }
   	}

   	// 카테고리를 클릭했을 때 호출되는 함수입니다
   	function onClickCategory() {
   	    var id = this.id,
   	        className = this.className;

   	    placeOverlay.setMap(null);

   	    if (className === 'on') {
   	        currCategory = '';
   	        changeCategoryClass();
   	        removeMarker();
   	    } else {
   	        currCategory = id;
   	        changeCategoryClass(this);
   	        searchPlaces();
   	    }
   	}

   	// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
   	function changeCategoryClass(el) {
   	    var category = document.getElementById('category'),
   	        children = category.children,
   	        i;

   	    for ( i=0; i<children.length; i++ ) {
   	        children[i].className = '';
   	    }

   	    if (el) {
   	        el.className = 'on';
   	    } 
   	}
   	
   	
// 전달받은 좌표(position)에 가까운 로드뷰의 파노라마 ID를 추출하여
// 로드뷰를 설정하는 함수입니다
function toggleRoadview(position){
    rvClient.getNearestPanoId(position, 50, function(panoId) {
        // 파노라마 ID가 null 이면 로드뷰를 숨깁니다
        if (panoId === null) {
            toggleMapWrapper(true, position);
        } else {
         toggleMapWrapper(false, position);

            // panoId로 로드뷰를 설정합니다
            rv.setPanoId(panoId, position);
        }
    });
}

// 지도를 감싸고 있는 div의 크기를 조정하는 함수입니다
function toggleMapWrapper(active, position) {
    if (active) {

        // 지도를 감싸고 있는 div의 너비가 100%가 되도록 class를 변경합니다 
        container.className = '';

        // 지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
        map.relayout();

        // 지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
        map.setCenter(position);
    } else {

        // 지도만 보여지고 있는 상태이면 지도의 너비가 30%가 되도록 class를 변경하여
        // 로드뷰가 함께 표시되게 합니다
        if (container.className.indexOf('view_roadview') === -1) {
            container.className = 'view_roadview';

            // 지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
            map.relayout();

            // 지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
            map.setCenter(position);
        }
    }
}

// 지도 위의 로드뷰 도로 오버레이를 추가,제거하는 함수입니다
function toggleOverlay(active) {
    if (active) {
        overlayOn = true;

        // 지도 위에 로드뷰 도로 오버레이를 추가합니다
        map.addOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);

        // 지도 위에 마커를 표시합니다
        marker.setMap(map);

        // 마커의 위치를 지도 중심으로 설정합니다 
        marker.setPosition(mapCenter);

        // 로드뷰의 위치를 지도 중심으로 설정합니다
        toggleRoadview(mapCenter);
    } else {
        overlayOn = false;
        
        clearInterval(interval);
    	viewIndex=0;

        // 지도 위의 로드뷰 도로 오버레이를 제거합니다
        map.removeOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);

        // 지도 위의 마커를 제거합니다
        marker.setMap(null);
    }
}

// 지도 위의 로드뷰 버튼을 눌렀을 때 호출되는 함수입니다
function setRoadviewRoad() {
    var control = document.getElementById('roadviewControl');

    // 버튼이 눌린 상태가 아니면
    if (control.className.indexOf('active') === -1) {
        control.className = 'active';

        // 로드뷰 도로 오버레이가 보이게 합니다
        toggleOverlay(true);
    } else {
        control.className = '';

        // 로드뷰 도로 오버레이를 제거합니다
        toggleOverlay(false);
        
     	// 로드뷰를 지도 뒤로 숨기는 함수입니다
        var position = marker.getPosition();
        toggleMapWrapper(true, position);
    }
}

var interval;
var viewIndex=0;
function viewStart(){
	var length = latlngList.length;
	var control = document.getElementById('roadviewControl');
	
	if (control.className.indexOf('active') === -1) {
		control.className = 'active';
        toggleOverlay(true);
	}
	interval = setInterval(function(){
		if(viewIndex<length){
			moveRoadview(latlngList[viewIndex++]);
		}
	}, 500);
}
function moveRoadview(laylng){
	marker.setPosition(laylng);				
	toggleRoadview(laylng);
}
function viewPause(){
	clearInterval(interval);
}
function viewStop(){
	clearInterval(interval);
	viewIndex=0;
    marker.setPosition(mapCenter);
    toggleRoadview(mapCenter);
}

//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}   