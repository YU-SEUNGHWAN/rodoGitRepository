<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
	
.pagingset
{
	color : white;
}

</style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<link href="resources/css/jquery.bxslider.css" rel="stylesheet" />

<title>Share Your Road</title>

  <!-- Place your favicon.ico and apple-touch-icon.png in the template root directory -->
  <link href="favicon.ico" rel="shortcut icon">
  
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet"> 
  
  <!-- Bootstrap CSS File -->
  <link href="resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Libraries CSS Files -->
  <link href="resources/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="resources/lib/animate-css/animate.min.css" rel="stylesheet">
  
  <!-- Main Stylesheet File -->
  <link href="resources/css/style.css" rel="stylesheet">
  <link href="resources/css/login.css" rel="stylesheet">


<script>

$(function()
{
	$("#replybtn").on("click", function()
	{
		var reply = $("#freereply_text").val();
		var boardnum = $("#free_boardnum").val();
		
		var id = '${sessionScope.loginId}';
		
		$.ajax
		({
			type : "post",
			url : "replywrite",
			
			data : 
			{
				free_boardnum : boardnum,
				freereply_text : reply
			},
			
			success : function(data)
			{
		         console.log(data);
		         var html =    "<table class='table-striped replyTable' id='replytable'>";
		         
		         var html2 = "";
		                  
		                  
		            $.each(data.freereplylist, function(index, item)
		            {
			            html += "<tr class='repwtr'>"
			                     +"<td class='id'>"+item.freereply_id+"</td>"
			                     +"<td id='"+item.freereply_replynum+"' class='reply'>"+item.freereply_text+"</td>"
			                     +"<td class='repdate'>"+item.freereply_input_dt+"</td>"
			                     +"<td class='repdate'>";
			                     
			            if (id == item.freereply_id)
	                    {
	                    	html += "</td><td><a href='#none' onclick='deletereplywarp("+item.freereply_replynum+", "+item.free_boardnum+")'>[삭제]</a>";
	                    }
	                       
	                   html += "</td>"
	                    + "</tr>";
		        	 });
		            
		         html += "</table>";
		         $("#freereply_text").val("");
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
	
	
	
function deletereplywarp(replynum, boardnum)
{
	console.log(replynum);
	console.log(boardnum);
	
	var id = '${sessionScope.loginId}';
	
	$.ajax
	({
		type : "get",
		url : "deletereply",
		
		data : 
		{
			freereply_replynum : replynum,
			free_boardnum : boardnum
		},
		
		success : function(data)
		{	
			console.log(data);
			
	         var html =    "<table class='table-striped replyTable' id='replytable'>";
	         
	         var html2 = "";
	                  
	                  
     		$.each(data.freereplylist, function(index, item)
            {
	            html += "<tr class='repwtr'>"
	                     +"<td class='id'>"+item.freereply_id+"</td>"
	                     +"<td id='"+item.freereply_replynum+"' class='reply'>"+item.freereply_text+"</td>"
	                     +"<td class='repdate'>"+item.freereply_input_dt+"</td>"
	                     +"<td class='repdate'>"
	                          
	                     if (id == item.freereply_id)
		                    {
		                    	html += "<a href='#none' onclick='deletereplywarp("+item.freereply_replynum+", "+item.free_boardnum+")'>[삭제]</a>";
		                    }
		                       
			            html += "</td>"
	                    + "</tr>";
        	 });
     		
     		 html += "</table>";
	         $("#freereply_text").val("");
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


function deletefreeboard(free_boardnum)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href="deletefreeboard?free_boardnum="+${board.free_boardnum};
	}
}

function updatePhoto(free_boardnum)
{
	location.href="updateboard?free_boardnum="+free_boardnum;
}

function pagingFormSubmit(currentPage)
{
	var boardnum = $("#free_boardnum").val();

	/* var form = document.getElementById("pagingForm"); */
	var page = currentPage;
	var id = '${sessionScope.loginId}';
	
	$.ajax
	({
		type : "post",
		url : "replypage",
		
		data : 
		{
			free_boardnum : boardnum,
			page : page
		},
		
		success : function(data)
		{
			console.log(data);
			
			 var html = "<table class='table-striped replyTable' id='replytable'>";
                 
             var html2 ="";
                 
            $.each(data.freereplylist, function(index, item)
            {
	            html += "<tr class='repwtr'>"
                    +"<td class='id'>"+item.freereply_id+"</td>"
                    +"<td id='"+item.freereply_replynum+"' class='reply'>"+item.freereply_text+"</td>"
                    +"<td class='repdate'>"+item.freereply_input_dt+"</td>"
                    +"<td class='repdate'>"
                    
                    if (id == item.freereply_id)
                    {
                    	html += "<a href='#none' onclick='deletereplywarp("+item.freereply_replynum+", "+item.free_boardnum+")'>[삭제]</a>";
                    }
                       
			            html += "</td>"
	                    + "</tr>";
		                 		 
        	 });
           			 html += "</table>";
				     $("#freereply_text").val("");
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

$(function(){
	$(".pagingset").css("color", "white");
	
	$(".btn-page").mouseover(function(){
		$(this).find(".pagingset").css("color", "black");
	});
		
	$(".btn-page").mouseout(function(){
		$(this).find(".pagingset").css("color", "white");			
	});	
});

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
		<div class="col-md-6 board-title">&nbsp;&nbsp;${board.free_title}</div>
		<div class="col-md-6 board-idDate">작성자:
			${board.free_id}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성일:
			${board.free_update_dt}&nbsp;&nbsp;</div>
	</div>
	<div class="board-title-divider"></div>


	<div style="margin-bottom: 100px;">
			<c:forEach items="${board.freefile_saved}" var="free">
				<img style="width: 600px;" src='freeLoad?origin=${free}'/>
				<br>
			</c:forEach>
	</div>

	<div id="content" class="board-content">
		<pre> ${board.free_content} </pre>
	</div>

	<div class="board-content-divider"></div>

	<div class='boardbtn'>
		<c:if test = "${sessionScope.loginId == board.free_id}">
			<input type="button" value="update" onclick="updatePhoto(${board.free_boardnum})">
			<input type="button" value="delete" onclick="deletefreeboard(${board.free_boardnum})">
		</c:if>
	</div>
	
	<div class="board-reply">
	
		<c:if test = "${sessionScope.loginId != null}">
	
			<input type="hidden" id="free_boardnum" value="${board.free_boardnum}">
		
				<b>reply</b> 
				<input type = "hidden" id = "replynum" value = "${reply.freereply_replynum}">
				<input type = "hidden" id = "boardnum" value = "${reply.free_boardnum}">
				<input class="inputReply" id="freereply_text" type="text"> <input
					style="margin-left: 10px; background: #353637; color: white;"
					type="button" id="replybtn" value="등록" />

		</c:if>

<div class="reviewDiv">

	<table class="table-striped replyTable" id="replytable">

		<c:forEach var="reply" items="${replylist}">
			<tr class="repwtr">
				<td class="id">${reply.freereply_id}</td>

				<td class="reply">${reply.freereply_text}</td>

				<td class="repdate">${reply.freereply_input_dt}</td>

				<td class="repdate"><c:if
						test="${sessionScope.loginId == reply.freereply_id}">
						<a href='#none'
							onclick="deletereplywarp('${reply.freereply_replynum}', '${reply.free_boardnum}')">[삭제]</a>
					</c:if></td>
			</tr>

		</c:forEach>

	</table>
	
	</div>
</div>


	<table style="width:100%; margin-bottom: 30px;" class="board-navi" id = "pagetable">
		<tr>
			<td style="text-align:center;">
				<span class="page-navi">
				<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})"><a class = "pagingset" href="#none">&lt;&lt;</a></span>
				<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})"><a class = "pagingset" href="#none">&lt;</a></span>
				
				<c:forEach var = "count" begin = "${navi.startPageGroup}" end = "${navi.endPageGroup}">
				
				<span class="btn-page" onclick="pagingFormSubmit(${count})">
						<a class = "pagingset" href="#none">${count}</a>
				</span>
				
				</c:forEach>
				
				<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage + 1})"><a class = "pagingset" href="#none">&gt;</a></span>
				<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})"><a class = "pagingset" href="#none">&gt;&gt;</a></span>
				</span>
			</td>
		</tr>
	</table>

</div>
</section>

<input type = "hidden" name = "page" id = "page">

	<footer id="footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="copyright">
              &copy; Copyright <strong>Imperial Theme</strong>. All Rights Reserved
            </div>
            <div class="credits">
              Bootstrap Themes by <a href="https://bootstrapmade.com/">BootstrapMade</a>
            </div>
          </div>
        </div>
      </div>
	</footer>
	
	<!--  Required JavaScript Libraries -->
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