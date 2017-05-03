<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Share Your Road</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Facebook Opengraph integration: https://developers.facebook.com/docs/sharing/opengraph -->
<meta property="og:title" content="">
<meta property="og:image" content="">
<meta property="og:url" content="">
<meta property="og:site_name" content="">
<meta property="og:description" content="">

<!-- Twitter Cards integration: https://dev.twitter.com/cards/  -->
<meta name="twitter:card" content="summary">
<meta name="twitter:site" content="">
<meta name="twitter:title" content="">
<meta name="twitter:description" content="">
<meta name="twitter:image" content="">

<script src="resources/js/jquery-3.1.1.js"></script>

<!-- Place your favicon.ico and apple-touch-icon.png in the template root directory -->
<link href="favicon.ico" rel="shortcut icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800"
	rel="stylesheet">

<!-- Bootstrap CSS File -->
<link href="resources/lib/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Libraries CSS Files -->
<link href="resources/lib/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="resources/lib/animate-css/animate.min.css" rel="stylesheet">

<!-- Main Stylesheet File -->
<link href="resources/css/style.css" rel="stylesheet">
<link href="resources/css/login.css" rel="stylesheet">
  
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>


<style type="text/css">
.reverse
{
	color: #E31414;
	font-size: 11pt;
	font-weight: 900;
}

.reverse a
{
	color: #E31414;
	font-size: 11pt;
	font-weight: 900;
}

th
{
	border-top: 3px solid #6B6B6B;
	background-color: #E0E0E0;
	height: 38px;
	text-align: center;
	color: #000000;
}

td
{
	height: 30px;
}

.title{
	color:black;
}
.title:hover{
	color:red;
}

.pagingset
{
	color : white;
}

</style>


<script>

function freepagingFormSubmit(currentPage)
{
	var page = currentPage;
	
	$.ajax
	({
		type : "post",
		url : "loadmylist",
		
		data : 
		{
			page : page
		},
		
		success : function(data)
		{	
			var html = '<div class="point"><h3>FreeBoard</h3></div>'	
				
				+ '<table width="800">'
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ '</tr>';
			
			$.each(data.freelist, function(index, item)
			{
				html += "<tr>"
						+ "<td><a href='#none' onclick='warpfreeread("+item.free_boardnum+")'>"+item.free_title+"</a></td>"
						+ "<td>"+item.free_input_dt+"</td>"
						+ "</tr>";
			});
			
			html += "</table>";
			
			var html2 = "";
			
			html2+= '<tr>';
			html2+= '<td>';
			html2+= '<span class="page-navi">';
			html2+= '<span class="btn-page">';
			html2+= '<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage - data.freenavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html2+= '<span class="btn-page">';
			html2+= '<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.freenavi.startPageGroup ; i <= data.freenavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html2+='<span class="btn-page">'
				html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+j+')">'+j+'</a>'; 
				html2+='</span>'
			}
			
			
			html2+= '<span class="btn-page">';
			html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage + 1)+')">&gt;</a></span>';
			html2+= '<span class="btn-page">';
			html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage + data.freenavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html2+='</td>';
			html2+='</tr>'; 
			
			$("#myinfolist").html(html);
			$("#freepaging").html(html2);
		},
	
		error : function(e)
		{
			console.log(e);
		}
	})
}


function warpfreeread(boardnum)
{	
	location.href="read?free_boardnum="+boardnum;
}


function photopagingFormSubmit(currentPage)
{
	var page = currentPage;
	
	$.ajax
	({
		type : "post",
		url : "loadmylist",
		
		data : 
		{
			page : page
		},
		
		success : function(data)
		{	
			var html = 	'<div class="point"><h3>PhotoBoard</h3></div>'	
				+ "<table>"
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			$.each(data.photolist, function(index, item)
			{	
				html += "<tr>"
						+ "<td><a href='#none' onclick='warpphotoread("+item.photo_boardnum+")'>"+item.photo_title+"</a></td>"
						+ "<td>"+item.photo_input_dt+"</td>"
						+ "</tr>";
			});
			
			html += "</table>";
			
			var html2 = "";
			
			html2+= '<tr>';
			html2+= '<td>';
			html2+= '<span class="page-navi">';
			html2+= '<span class="btn-page">';
			html2+= '<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage - data.photonavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html2+= '<span class="btn-page">';
			html2+= '<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.photonavi.startPageGroup ; i <= data.photonavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html2+='<span class="btn-page">'
				html2+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+j+')">'+j+'</a>'; 
				html2+='</span>'
			}
			
			
			html2+= '<span class="btn-page">';
			html2+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage + 1)+')">&gt;</a></span>';
			html2+= '<span class="btn-page">';
			html2+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage + data.photonavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html2+='</td>';
			html2+='</tr>'; 
			
			$("#photolist").html(html);
			$("#photopaging").html(html2);
		},
	
		error : function(e)
		{
			console.log(e);
		}
	})
}


function warpphotoread(boardnum)
{
	location.href="readPhoto?photo_boardnum="+boardnum;
}


function videopagingFormSubmit(currentPage)
{
	var page = currentPage;
	
	$.ajax
	({
		type : "post",
		url : "loadmylist",
		
		data : 
		{
			page : page
		},
		
		success : function(data)
		{	
			var html5 = '<div class="point"><h3>VideoBoard</h3></div>'	
				+ "<table>"
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			$.each(data.videolist, function(index, item)
			{	
				html5 += "<tr>"
						+ "<td><a href='#none' onclick='warpvideoread("+item.video_boardnum+")'>"+item.video_title+"</a></td>"
						+ "<td>"+item.video_input_dt+"</td>"
						+ "</tr>";
			});
			
			html5 += "</table>";
			
			var html6 = "";
			
			html6+= '<tr>';
			html6+= '<td>';
			html6+= '<span class="page-navi">';
			html6+= '<span class="btn-page">';
			html6+= '<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage - data.videonavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html6+= '<span class="btn-page">';
			html6+= '<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.videonavi.startPageGroup ; i <= data.videonavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html6+='<span class="btn-page">'
				html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+j+')">'+j+'</a>'; 
				html6+='</span>'
			}
			
			
			html6+= '<span class="btn-page">';
			html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage + 1)+')">&gt;</a></span>';
			html6+= '<span class="btn-page">';
			html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage + data.videonavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html6+='</td>';
			html6+='</tr>'; 
			
			$("#videolist").html(html5);
			$("#videopaging").html(html6);
		},
	
		error : function(e)
		{
			console.log(e);
		}
	})
}


function warpvideoread(boardnum)
{
	location.href="readVideo?video_boardnum="+boardnum;
}


function gpspagingFormSubmit(currentPage)
{
	var page = currentPage;
	
	$.ajax
	({
		type : "post",
		url : "loadmylist",
		
		data : 
		{
			page : page
		},
		
		success : function(data)
		{	
			var html7 = '<div class="point"><h3>GpsBoard</h3></div>'	
				+ "<table>"
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			$.each(data.gpslist, function(index, item)
			{	
				html7 += "<tr>"
						+ "<td><a href='#none' onclick='warpgpsread("+item.gps_boardnum+")'>"+item.gps_title+"</a></td>"
						+ "<td>"+item.gps_input_dt+"</td>"
						+ "</tr>";
			});
			
			html7 += "</table>";
			
			var html8 = "";
			
			html8+= '<tr>';
			html8+= '<td>';
			html8+= '<span class="page-navi">';
			html8+= '<span class="btn-page">';
			html8+= '<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage - data.gpsnavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html8+= '<span class="btn-page">';
			html8+= '<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.gpsnavi.startPageGroup ; i <= data.gpsnavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html8+='<span class="btn-page">'
				html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+j+')">'+j+'</a>'; 
				html8+='</span>'
			}
			
			
			html8+= '<span class="btn-page">';
			html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage + 1)+')">&gt;</a></span>';
			html8+= '<span class="btn-page">';
			html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage + data.gpsnavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html8+='</td>';
			html8+='</tr>'; 
			
			$("#gpslist").html(html7);
			$("#gpspaging").html(html8);
		},
	
		error : function(e)
		{
			console.log(e);
		}
	})
}


function warpgpsread(boardnum)
{
	location.href="gpsread?gps_boardnum="+boardnum;
}

	$.ajax
	({
		type : "post",
		url : "loadmylist",
		
		success : function(data)
		{	
			
			var html = 	'<div class="point"><h3>FreeBoard</h3></div>'
						+ '<tr style="background-color:#E0E0E0;">'
						+ '<td width = "450"><strong>게시글 제목</strong></td>'
						+ '<td width = "200"><strong>게시글 날짜</strong></td>'
						+ "</tr>";
						
			var html2 = "";
			
			
				$.each(data.freelist, function(index, item)
				{
					html += "<tr>"
							+ "<td><a href='#none' onclick='warpfreeread("+item.free_boardnum+")'>"+item.free_title+"</a></td>"
							+ "<td>"+item.free_input_dt+"</td>"
							+ "</tr>";
				});
				
				html += "</table>";
				
				html2+= '<tr>';
				html2+= '<td>';
				html2+= '<span class="page-navi">';
				html2+= '<span class="btn-page">';
				html2+= '<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage - data.freenavi.pagePerGroup)+')">&lt;&lt;</a></span>';
				html2+= '<span class="btn-page">';
				html2+= '<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage - 1)+')">&lt;</a></span>';
				
				
				var j=0;
				
				for( var i = data.freenavi.startPageGroup ; i <= data.freenavi.endPageGroup ; i++)
				{
				   j = j+1;
				   
					html2+='<span class="btn-page">'
					html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+j+')">'+j+'</a>'; 
					html2+='</span>'
				}
				
				
				html2+= '<span class="btn-page">';
				html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage + 1)+')">&gt;</a></span>';
				html2+= '<span class="btn-page">';
				html2+='<a class = "pagingset" href="javascript:freepagingFormSubmit('+(data.freenavi.currentPage + data.freenavi.pagePerGroup)+')">&gt;&gt;</a></span>';
				
				html2+='</td>';
				html2+='</tr>'; 
				
				$("#myinfolist").html(html);
				$("#freepaging").html(html2);
				
				
		/* ======================================== 포토 게시판 ======================================== */
				
				
			var html3 = '<div class="point"><h3>PhotoBoard</h3></div>'
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			var html4 = "";
		
		
			$.each(data.photolist, function(index, item)
			{
				html3 += "<tr>"
						+ "<td><a href='#none' onclick='warpphotoread("+item.photo_boardnum+")'>"+item.photo_title+"</a></td>"
						+ "<td>"+item.photo_input_dt+"</td>"
						+ "</tr>";
			});
			
			html4+= '<tr>';
			html4+= '<td>';
			html4+= '<span class="page-navi">';
			html4+= '<span class="btn-page">';
			html4+= '<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage - data.photonavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html4+= '<span class="btn-page">';
			html4+= '<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.photonavi.startPageGroup ; i <= data.photonavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html4+='<span class="btn-page">'
				html4+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+j+')">'+j+'</a>'; 
				html4+='</span>'
			}
			
			
			html4+= '<span class="btn-page">';
			html4+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage + 1)+')">&gt;</a></span>';
			html4+= '<span class="btn-page">';
			html4+='<a class = "pagingset" href="javascript:photopagingFormSubmit('+(data.photonavi.currentPage + data.photonavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html4+='</td>';
			html4+='</tr>'; 
			
			$("#photolist").html(html3);
			$("#photopaging").html(html4);

			
		/* ======================================== 비디오 게시판 ======================================== */
			
			
			var html5 = '<div class="point"><h3>VideoBoard</h3></div>'
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			var html6 = "";
			
			
			$.each(data.videolist, function(index, item)
			{
				html5 += "<tr>"
						+ "<td><a href='#none' onclick='warpvideoread("+item.video_boardnum+")'>"+item.video_title+"</a></td>"
						+ "<td>"+item.video_input_dt+"</td>"
						+ "</tr>";
			});
			
			html6+= '<tr>';
			html6+= '<td>';
			html6+= '<span class="page-navi">';
			html6+= '<span class="btn-page">';
			html6+= '<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage - data.videonavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html6+= '<span class="btn-page">';
			html6+= '<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.videonavi.startPageGroup ; i <= data.videonavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html6+='<span class="btn-page">'
				html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+j+')">'+j+'</a>'; 
				html6+='</span>'
			}
			
			
			html6+= '<span class="btn-page">';
			html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage + 1)+')">&gt;</a></span>';
			html6+= '<span class="btn-page">';
			html6+='<a class = "pagingset" href="javascript:videopagingFormSubmit('+(data.videonavi.currentPage + data.videonavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html6+='</td>';
			html6+='</tr>'; 
			
			$("#videolist").html(html5);
			$("#videopaging").html(html6);
			

			/* ======================================== GPS 게시판 ======================================== */
			
			
			var html7 = '<div class="point"><h3>GpsBoard</h3></div>'
				+ '<tr style="background-color:#E0E0E0;">'
				+ '<td width = "450"><strong>게시글 제목</strong></td>'
				+ '<td width = "200"><strong>게시글 날짜</strong></td>'
				+ "</tr>";
				
			var html8 = "";
			
			
			$.each(data.gpslist, function(index, item)
			{
				html7 += "<tr>"
						+ "<td><a href='#none' onclick='warpgpsread("+item.gps_boardnum+")'>"+item.gps_title+"</a></td>"
						+ "<td>"+item.gps_input_dt+"</td>"
						+ "</tr>";
			});
			
			html8+= '<tr>';
			html8+= '<td>';
			html8+= '<span class="page-navi">';
			html8+= '<span class="btn-page">';
			html8+= '<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage - data.gpsnavi.pagePerGroup)+')">&lt;&lt;</a></span>';
			html8+= '<span class="btn-page">';
			html8+= '<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage - 1)+')">&lt;</a></span>';
			
			
			var j=0;
			
			for( var i = data.gpsnavi.startPageGroup ; i <= data.gpsnavi.endPageGroup ; i++)
			{
			   j = j+1;
			   
				html8+='<span class="btn-page">'
				html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+j+')">'+j+'</a>'; 
				html8+='</span>'
			}
			
			
			html8+= '<span class="btn-page">';
			html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage + 1)+')">&gt;</a></span>';
			html8+= '<span class="btn-page">';
			html8+='<a class = "pagingset" href="javascript:gpspagingFormSubmit('+(data.gpsnavi.currentPage + data.gpsnavi.pagePerGroup)+')">&gt;&gt;</a></span>';
			
			html8+='</td>';
			html8+='</tr>'; 
			
			$("#gpslist").html(html7);
			$("#gpspaging").html(html8);
			
			},

			error : function(e)
			{
				console.log(e);
			}
	})
	

</script>
<style>
</style>
</head>
<body>


<!--==========================
  Header Section
============================-->
	<%@ include file="../header.jsp"%>

	<!--==========================
  Porfolio Section
============================-->

<section id="services">
	<div class="container wow fadeInUp">
	
	<div class="row">
	<div class="col-md-12" style="padding-bottom: 35px">
		<h3 class="section-title">MY LIST</h3>
		<div class="section-title-divider"></div>
	</div>
</div>
	
<table id = "gpslist" class = "table-striped" style="width : 70%; border-bottom: 2px solid gray; margin:auto; ">
</table>

<table id = "gpspaging" style="width:800px; text-align: center; margin:auto; margin-bottom:80px;">
</table>

<table id = "photolist" class = "table-striped" style="width : 70%; border-bottom: 2px solid gray; margin:auto;">
</table>

<table id = "photopaging" style="width:800px; text-align: center; margin:auto; margin-bottom:80px;"> 
</table><p>

<table id = "videolist" class = "table-striped" style="width : 70%; border-bottom: 2px solid gray; margin:auto;">
</table>

<table id = "videopaging" style="width:800px; text-align: center; margin:auto; margin-bottom:80px;">
</table><p>

<table id = "myinfolist" class = "table-striped" style="width : 70%; border-bottom: 2px solid gray; margin:auto;">
</table>

<table id = "freepaging" style="width:800px; text-align: center; margin:auto;">
</table><p>


<input type = "hidden" name = "page" id = "page">

</div>
</section>

<!--==========================
  Footer
============================-->
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
	<!-- #footer -->

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