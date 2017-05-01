<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=6b513317a557b95d9627ec6ce1303e51&libraries=services"></script>
<!-- ab43af777848bf1eb1bd3148b28cf31d -->
<script src="resources/js/maps.js"></script>
<script src="resources/js/chart.js"></script>
<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">

<style>
	
.pagingset
{
	color : white;
}

</style>

<script>


function gpsUpdate(boardnum)
{
	location.href="gpsUpdate?boardnum="+boardnum;
}

function deletegps()
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href="deletegps?gps_boardnum="+${gps_board.gps_boardnum}; 
	}
}

function deletereplywarp(replynum, boardnum)
{
	console.log(replynum);
	console.log(boardnum);
	
	var id = '${sessionScope.loginId}';
	
	$.ajax
	({
		type : "post",
		url : "deletegpsreply",
		
		data : 
		{
			gpsreply_replynum : replynum,
			gps_boardnum : boardnum
		},
		
		success : function(data)
		{
			var html =   "<table class='table-striped replyTable' id='replytable'>";
                
            var html2 = "";    
        
       
          $.each(data.gpsreplylist, function(index,item)
          {
	            html += "<tr class='repwtr'>"
	                     +"<td class='id'>"+item.gpsreply_id+"</td>"
	                     +"<td id='"+item.gpsreply_replynum+"' class='reply'>"+item.gpsreply_text+"</td>"
	                     +"<td class='repdate'>"+item.gpsreply_input_dt+"</td>"
	                     +"<td class='repdate'>"
	                 		  
	                     if (id == item.gpsreply_id)
	                     {
	                    	 html += "<a href='#none' onclick='deletereplywarp("+item.gpsreply_replynum+", "+item.gps_boardnum+")'>[삭제]</a>";
	                     }
	                           
	                     html += "</td>";
	                          + "</tr>"
      	 });
		
          	 html += "</table>";
	         $("#gpsreply_text").val("");
	         $(".reviewDiv").html(html);
	         
	         
	         html2+= '<tr>';
			   html2+= '<td style="text-align:center;">';
			   html2+= '<span class="page-navi">';
			   html2+= '<span class="btn-page">';
			   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - data.navi.pagePerGroup)+')">&lt;&lt;</a></span>';
			   html2+= '<span class="btn-page">';
			   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - 1)+')">&lt;</a></span>';
			  
			   
			   var j=0;
			   
			   for( var i = data.navi.startPageGroup ; i <= data.navi.endPageGroup ; i++)
			   {
			      j = j+1;
			      console.log(j);
			      
			      html2+='<span class="btn-page">'
			      html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+j+')">'+j+'</a>'; 
			  	  html2+='</span>'
			   }
			   
			   
			   html2+= '<span class="btn-page">';
			   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + 1)+')">&gt;</a></span>';
			   html2+= '<span class="btn-page">';
			   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + data.navi.pagePerGroup)+')">&gt;&gt;</a></span>';
			   
			   html2+='</td>';
			   html2+='</tr>'; 
			   
			   $("#pagetable").html(html2);
		},
		
		error : function(e)
		{
			console.log(e);
		}
	})
}
	
	
	
$(function()
{
	$("#regist").on("click", function()
	{
		var boardnum = $("#gps_boardnum").val();
		var reply = $("#gpsreply_text").val();
		
		var id = '${sessionScope.loginId}';
		
		$.ajax
		({
			type : "post",
			url : "writegpsreply",
			
			data : 
			{
				gps_boardnum : boardnum,
				gpsreply_text : reply
			},
			
			success : function(data)
			{
				var html =    "<table class='table-striped replyTable' id='replytable'>";
	                  
	            var html2 = "";      
	                  
	         
	            $.each(data.gpsreplylist, function(index,item)
	            {
		            html += "<tr class='repwtr'>"
		                     +"<td class='id'>"+item.gpsreply_id+"</td>"
		                     +"<td id='"+item.gpsreply_replynum+"' class='reply'>"+item.gpsreply_text+"</td>"
		                     +"<td class='repdate'>"+item.gpsreply_input_dt+"</td>"
		                     +"<td class='repdate'>"
		                   
		                     if (id == item.gpsreply_id)
		                     {
		                    	 html += "<a href='#none' onclick='deletereplywarp("+item.gpsreply_replynum+", "+item.gps_boardnum+")'>[삭제]</a>";
		                     }
		                           
		                     html += "</td>";
		                          + "</tr>"
	         	});
			
	             html += "</table>";
		         $("#gpsreply_text").val("");
		         $(".reviewDiv").html(html);
		         
		         
		         html2+= '<tr>';
				   html2+= '<td style="text-align:center;">';
				   html2+= '<span class="page-navi">';
				   html2+= '<span class="btn-page">';
				   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - data.navi.pagePerGroup)+')">&lt;&lt;</a></span>';
				   html2+= '<span class="btn-page">';
				   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - 1)+')">&lt;</a></span>';
				  
				   
				   var j=0;
				   
				   for( var i = data.navi.startPageGroup ; i <= data.navi.endPageGroup ; i++)
				   {
				      j = j+1;
				      console.log(j);
				      
				      html2+='<span class="btn-page">'
				      html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+j+')">'+j+'</a>'; 
				  	  html2+='</span>'
				   }
				   
				   
				   html2+= '<span class="btn-page">';
				   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + 1)+')">&gt;</a></span>';
				   html2+= '<span class="btn-page">';
				   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + data.navi.pagePerGroup)+')">&gt;&gt;</a></span>';
				   
				   html2+='</td>';
				   html2+='</tr>'; 
				   
				   $("#pagetable").html(html2);
			},
			
			error : function(e)
			{
				console.log(e);
			}
		})
	})
})
	
	
	
function pagingFormSubmit(currentPage)
{
	var boardnum = $("#gps_boardnum").val();

	/* var form = document.getElementById("pagingForm"); */
	var page = currentPage;
	
	var id = '${sessionScope.loginId}';
	
	$.ajax
	({
		type : "post",
		url : "replygpspage",
		
		data : 
		{
			gps_boardnum : boardnum,
			page : page
		},
		
		success : function(data)
		{
			console.log(data);
			
			var html =  "<table class='table-striped replyTable' id='replytable'>";
                 
            var html2 ="";
                 
            $.each(data.gpsreplylist, function(index, item)
            {
	            html += "<tr class='repwtr'>"
                    +"<td class='id'>"+item.gpsreply_id+"</td>"
                    +"<td id='"+item.gpsreply_replynum+"' class='reply'>"+item.gpsreply_text+"</td>"
                    +"<td class='repdate'>"+item.gpsreply_input_dt+"</td>"
                    +"<td class='repdate'>"
                  
                    if (id == item.gpsreply_id)
                    {
                   	 html += "<a href='#none' onclick='deletereplywarp("+item.gpsreply_replynum+", "+item.gps_boardnum+")'>[삭제]</a>";
                    }
                          
                    html += "</td>";
                         + "</tr>"
        	 });
			
         	 html += "</table>";
	         $("#gpsreply_text").val("");
	         $(".reviewDiv").html(html);
		         
				     
				   html2+= '<tr>';
				   html2+= '<td style="text-align:center;">';
				   html2+= '<span class="page-navi">';
				   html2+= '<span class="btn-page">';
				   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - data.navi.pagePerGroup)+')">&lt;&lt;</a></span>';
				   html2+= '<span class="btn-page">';
				   html2+= '<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage - 1)+')">&lt;</a></span>';
				  
				  
				   var j = 0;
				   
				   for( var i = data.navi.startPageGroup; i <= data.navi.endPageGroup ; i++)
				   {
				      j = j+1;
				      console.log(j);
				      console.log(data.navi.startPageGroup);
				      html2+='<span class="btn-page">'
				      html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+j+')">'+j+'</a>'; 
				  	  html2+='</span>'
				   }
				   
				   
				   html2+= '<span class="btn-page">';
				   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + 1)+')">&gt;</a></span>';
				   html2+= '<span class="btn-page">';
				   html2+='<a class = "pagingset" href="javascript:pagingFormSubmit('+(data.navi.currentPage + data.navi.pagePerGroup)+')">&gt;&gt;</a></span>';
				   
				   html2+='</td>';
				   html2+='</tr>'; 
				   
				   $("#pagetable").html(html2);
		},
	
		error : function(e)
		{
			console.log(e);
		}
	})
}
	
	
</script>
</head>
<body>
<!--==========================
  Header Section
============================-->
	<%@ include file="../header.jsp"%>

	<section id="services" style="background-color: #f6f6f6;">

	<div class="container wow fadeInUp board-main">

		<div class="row">
			<div class="col-md-6 board-title">&nbsp;&nbsp;${gps_board.gps_title}</div>
			<div class="col-md-6 board-idDate">작성자:
				${gps_board.gps_id}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성일:
				${gps_board.gps_input_dt}&nbsp;&nbsp;</div>
		</div>
		<div class="board-title-divider"></div>

		<div id="container" class="map_wrap">
			<div id="rvWrapper">
				<div id="roadview" style="width: 100%; height: 100%;"></div>
				<!-- 로드뷰를 표시할 div 입니다 -->
			</div>

			<div id="mapWrapper">
				<div id="map"></div>
				<div id="roadviewControl" onclick="setRoadviewRoad()">
					<span>로드뷰</span>
				</div>
			</div>

			<ul id="category"
				style="padding-left: 0px; margin-top 0px; margin-bottom: 0px;">

				<li id="BK9" data-order="0"><span class="category_bg bank"></span>
					은행</li>

				<li id="MT1" data-order="1"><span class="category_bg mart"></span>
					마트</li>

				<li id="HP8" data-order="2"><span class="category_bg hospital"></span>
					병원</li>

				<li id="AT4" data-order="3"><span class="category_bg sights"></span>
					관광명소</li>

				<li id="CE7" data-order="4"><span class="category_bg cafe"></span>
					카페</li>

				<li id="CS2" data-order="5"><span class="category_bg store"></span>
					편의점</li>

			</ul>

		</div>
		<div class="row">
			<div class="col-md-6 chartview">
				<input type="button" onclick="drawChart()" class='chartbtn' value="chart">
			</div>
			<div class="col-md-6 autoview">

				<img style="width: 220px" src="resources/img/roadview.png"> <input
					type="button" id="viewStart" onclick="viewStart()" value="start">
				<input type="button" id="viewPause" onclick="viewPause()"
					value="pause"> <input type="button" id="viewStop"
					onclick="viewStop()" value="stop">

			</div>
		</div>
		<div id="chart_div"></div>

		<div id="content" class="board-content">
			<pre> ${gps_board.gps_content} </pre>
			<input type='hidden' id='savedfile'
				value='${gps_board.gpsfile_saved}'>
		</div>

		<div class="board-content-divider"></div>

		<div class='boardbtn'>
			<c:if test = "${sessionScope.loginId == gps_board.gps_id}">
				<input type="button" value="update"
					onclick="gpsUpdate(${gps_board.gps_boardnum})"> <input
					type="button" value="delete" onclick="deletegps(${gps_board.gps_boardnum})">
			</c:if>
		</div>

		<div class="board-reply">
			
			<c:if test = "${sessionScope.loginId != null}">
			
				<b>reply</b>
				
				<input type = "hidden" id = "gps_boardnum" value = "${gps_board.gps_boardnum}">
				 <input class="inputReply" id = "gpsreply_text" type="text"> 
				 <input
					style="margin-left: 10px; background: #353637; color: white;"
					type="button" id="regist" value="등록" />

			</c:if>
			
		<div class="reviewDiv ">
	
				<table class="table-striped replyTable" id="replytable">

					<c:forEach var="reply" items="${gpsreplylist}">
						<tr class="repwtr">
							<td class="id">${reply.gpsreply_id}</td>

							<td class="reply">${reply.gpsreply_text}</td>

							<td class="repdate">${reply.gpsreply_input_dt}</td>

							<td class="repdate"><c:if
									test="${sessionScope.loginId == reply.gpsreply_id}">
			
									<a href='#none'
										onclick="deletereplywarp(${reply.gpsreply_replynum}, ${reply.gps_boardnum})">[삭제]</a>
								</c:if></td>
						</tr>
					</c:forEach>
				</table>
	</div>

	<table style="width:100%; margin-bottom: 30px;" class="board-navi" id = "pagetable">
		<tr>
			<td style="text-align:center;">
				<span class="page-navi">
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})">&lt;&lt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - 1})">&lt;</a></span>
				
				<c:forEach var = "count" begin = "${navi.startPageGroup}" end = "${navi.endPageGroup}">
				
				<span class="btn-page">
						<a class = "pagingset" href = "javascript:pagingFormSubmit(${count})">${count}</a>
				</span>
				
				</c:forEach>
				
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + 1})">&gt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})">&gt;&gt;</a></span>
				</span>
			</td>
		</tr>
	</table>
				
				
	</div>
		<input type = "hidden" name = "page" id = "page">
		<input type='hidden' id='myMarks' value='${myMarks}'>
	</div>

	</section>

	<footer id="footer">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="copyright">
					&copy; Copyright <strong>Imperial Theme</strong>. All Rights
					Reserved
				</div>
				<div class="credits">
					<!-- 
                All the links in the footer should remain intact. 
                You can delete the links only if you purchased the pro version.
                Licensing information: https://bootstrapmade.com/license/
                Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=Imperial
              -->
					Bootstrap Themes by <a href="https://bootstrapmade.com/">BootstrapMade</a>
				</div>
			</div>
		</div>
	</div>
	</footer>

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<!-- Required JavaScript Libraries -->
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