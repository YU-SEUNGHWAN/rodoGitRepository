<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>
<title>My Info</title>

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
			var html = 	"<table>"
				+ "<tr>"
				+ "<td>FreeBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
			
			$.each(data.freelist, function(index, item)
			{
				html += "<tr>"
						+ "<td>FreeBoard</td>"
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
			var html = 	"<table>"
				+ "<tr>"
				+ "<td>PhotoBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			$.each(data.photolist, function(index, item)
			{	
				html += "<tr>"
						+ "<td>PhotoBoard</td>"
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
			var html5 = 	"<table>"
				+ "<tr>"
				+ "<td>VideoBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			$.each(data.videolist, function(index, item)
			{	
				html5 += "<tr>"
						+ "<td>VideoBoard</td>"
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
			var html7 = 	"<table>"
				+ "<tr>"
				+ "<td>GpsBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			$.each(data.gpslist, function(index, item)
			{	
				html7 += "<tr>"
						+ "<td>GpsBoard</td>"
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
			
			var html = 	"<table>"
						+ "<tr>"
						+ "<td>FreeBoard</td>"
						+ "<td>게시글 제목</td>"
						+ "<td>게시글 날짜</td>"
						+ "</tr>";
						
			var html2 = "";
			
			
				$.each(data.freelist, function(index, item)
				{
					html += "<tr>"
							+ "<td>FreeBoard</td>"
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
				
				
			var html3 = "<tr>"
				+ "<td>PhotoBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			var html4 = "";
		
		
			$.each(data.photolist, function(index, item)
			{
				html3 += "<tr>"
						+ "<td>PhotoBoard</td>"
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
			
			
			var html5 = "<tr>"
				+ "<td>VideoBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			var html6 = "";
			
			
			$.each(data.videolist, function(index, item)
			{
				html5 += "<tr>"
						+ "<td>VideoBoard</td>"
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
			
			
			var html7 = "<tr>"
				+ "<td>GpsBoard</td>"
				+ "<td>게시글 제목</td>"
				+ "<td>게시글 날짜</td>"
				+ "</tr>";
				
			var html8 = "";
			
			
			$.each(data.gpslist, function(index, item)
			{
				html7 += "<tr>"
						+ "<td>GpsBoard</td>"
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

</head>
<body>


<table id = "myinfolist" style="width:800px;">
</table>

<table id = "freepaging" style="width:800px; text-align: center;">
</table><p>

<table id = "photolist" style="width:800px;">
</table>

<table id = "photopaging" style="width:800px; text-align: center;"> 
</table><p>

<table id = "videolist" style="width:800px;">
</table>

<table id = "videopaging" style="width:800px; text-align: center;">
</table><p>

<table id = "gpslist" style="width:800px;">
</table>

<table id = "gpspaging" style="width:800px; text-align: center;">
</table>

<input type = "hidden" name = "page" id = "page">

</body>
</html>