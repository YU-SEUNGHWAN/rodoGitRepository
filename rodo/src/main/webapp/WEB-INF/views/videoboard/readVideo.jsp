<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>
<link href="resources/css/jquery.bxslider.css" rel="stylesheet" />

<style>
	
.pagingset
{
	color : white;
}

</style>

<script>

$(document).ready(function()
		{
			$('.bxslider').bxSlider();
		});

		function deleteVideo()
		{
			if(confirm("정말 삭제하시겠습니까?"))
			{
				location.href="deleteVideo?video_boardnum="+${videoBoard.video_boardnum}; 
			}
		}

		function updateVideo(){
			location.href="updateVideo?video_boardnum="+${videoBoard.video_boardnum}; 
		}



		function deletereplywarp(replynum, boardnum)
		{
			console.log(replynum);
			console.log(boardnum);
			
			var id = '${sessionScope.loginId}';
			
			$.ajax
			({
				type : "post",
				url : "deletevideoreply",
				
				data : 
				{
					videoreply_replynum : replynum,
					video_boardnum : boardnum
				},
				
				success : function(data)
				{
					var html =  "<table class='table-striped replyTable' id='replytable'>";
		                
		                
		            var html2 = "";    
		                
		       
		          $.each(data.videoreplylist, function(index,item)
		          {
			            html += "<tr class='repwtr'>"
			                     +"<td class='id'>"+item.videoreply_id+"</td>"
			                     +"<td id='"+item.videoreply_replynum+"' class='reply'>"+item.videoreply_text+"</td>"
			                     +"<td class='repdate'>"+item.videoreply_input_dt+"</td>"
			                     +"<td class='repdate'>"
			                 		  
			                     if (id == item.videoreply_id)
			                     {
			                    	 html += "<a href='#none' onclick='deletereplywarp("+item.videoreply_replynum+", "+item.video_boardnum+")'>[삭제]</a>";
			                     }
			                         
			                    html += "</td>";
								+ "</tr>"
		      	 });
				
		             html += "</table>";
			         $("#videoreply_text").val("");
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
				var boardnum = $("#video_boardnum").val();
				var reply = $("#videoreply_text").val();
				
				var id = '${sessionScope.loginId}';
				
				$.ajax
				({
					type : "post",
					url : "writevideoreply",
					
					data : 
					{
						video_boardnum : boardnum,
						videoreply_text : reply
					},
					
					success : function(data)
					{
				        var html =  "<table class='table-striped replyTable' id='replytable'>";
			                  
			            var html2 = "";      
			                  
			         
			            $.each(data.videoreplylist, function(index,item)
			            {
				            html += "<tr class='repwtr'>"
				                     +"<td class='id'>"+item.videoreply_id+"</td>"
				                     +"<td id='"+item.videoreply_replynum+"' class='reply'>"+item.videoreply_text+"</td>"
				                     +"<td class='repdate'>"+item.videoreply_input_dt+"</td>"
				                     +"<td class='repdate'>"
				                   
				                     if (id == item.videoreply_id)
				                     {
				                    	 html += "<a href='#none' onclick='deletereplywarp("+item.videoreply_replynum+", "+item.video_boardnum+")'>[삭제]</a>";
				                     }
				                         
				                    html += "</td>";
									+ "</tr>"
			         	});
					
			             html += "</table>";
				         $("#videoreply_text").val("");
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
			var boardnum = $("#video_boardnum").val();

			/* var form = document.getElementById("pagingForm"); */
			var page = currentPage;
			
			var id = '${sessionScope.loginId}';
			
			$.ajax
			({
				type : "post",
				url : "replyvideopage",
				
				data : 
				{
					video_boardnum : boardnum,
					page : page
				},
				
				success : function(data)
				{
					console.log(data);
					
			        var html =  "<table class='table-striped replyTable' id='replytable'>";
		                 
		            var html2 ="";
		                 
		            $.each(data.videoreplylist, function(index, item)
		            {
			            html += "<tr>"
		                    +"<td class='rename'>"+item.videoreply_id+"</td>"
		                    +"<td id='"+item.videoreply_replynum+"' class='reply'>"+item.videoreply_text+"</td>"
		                    +"<td class='repdate'>"+item.videoreply_input_dt+"</td>"
		                    +"<td class='repdate'>"
		                        
		                    if (id == item.videoreply_id)
		                     {
		                    	 html += "<a href='#none' onclick='deletereplywarp("+item.videoreply_replynum+", "+item.video_boardnum+")'>[삭제]</a>";
		                     }
		                         
		                    html += "</td>";
							+ "</tr>"
		        	 });
					
		             html += "</table>";
			         $("#videoreply_text").val("");
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

<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

</head>
<body>
<!--==========================
  Header Section
============================-->
<%@ include file="../header.jsp" %>

	<section id="services" style="background-color: #f6f6f6;">

		<div class="container wow fadeInUp board-main">

			<div class="row">
				<div class="col-md-6 board-title">&nbsp;&nbsp;${videoBoard.video_title}</div>
				<div class="col-md-6 board-idDate">작성자:
					${videoBoard.video_id}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성일:
					${videoBoard.video_update_dt}&nbsp;&nbsp;</div>
			</div>
			<div class="board-title-divider"></div>

		    <div style="margin-bottom:150px; height:50%; text-align: center;">
			   <video height='100%' id='videoForm' controls='controls'>
		   	  	 <source src="${videoBoard.video_savedfile}" />
		   	   </video>
		    </div>

			<div id="content" class="board-content">
				<pre> ${videoBoard.video_content} </pre>
			</div>

			<div class="board-content-divider"></div>

			<div class='boardbtn'>
				<c:if test = "${sessionScope.loginId == videoBoard.video_id}">
					<input type="button" value="update" onclick="updateVideo()">
					<input type="button" value="delete" onclick="deleteVideo()">
				</c:if>
			</div>

			<div class="board-reply">
				
				<c:if test = "${sessionScope.loginId != null}">
				
					<input type = "hidden" id = "video_boardnum" value = "${videoBoard.video_boardnum}">
			
					<input type = "hidden" id = "replynum" value = "${reply.videoreply_replynum}">
					<input type = "hidden" id = "boardnum" value = "${reply.video_boardnum}">
				
						<b>reply</b> <input class="inputReply" id="videoreply_text" type="text"> <input
							style="margin-left: 10px; background: #353637; color: white;"
							type="button" id="regist" value="등록" />
				
				</c:if>

			<div class="reviewDiv">

					<table class="table-striped replyTable" id="replytable">

						<c:forEach var="reply" items="${replylist}">
							<tr class="repwtr">
								<td class="id">${reply.videoreply_id}</td>

								<td class="reply">${reply.videoreply_text}</td>

								<td class="repdate">${reply.videoreply_input_dt}</td>

								<td class="repdel">
									<c:if test="${sessionScope.loginId == reply.videoreply_id}">
										<a href='#none'
											onclick="deletereplywarp('${reply.videoreply_replynum}', '${reply.video_boardnum}')">[삭제]</a>
									</c:if></td>

							</tr>

						</c:forEach>

					</table>
					
				</div>

			</div>

				<table style="width:100%; margin-bottom: 30px;" class="board-navi" id = "pagetable">
					<tr>
						<td style="text-align: center;"><span class="page-navi">
								<span class="btn-page"><a class="pagingset"
									href="javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})">&lt;&lt;</a></span>
								<span class="btn-page"><a class="pagingset"
									href="javascript:pagingFormSubmit(${navi.currentPage - 1})">&lt;</a></span>

								<c:forEach var="count" begin="${navi.startPageGroup}"
									end="${navi.endPageGroup}">

									<span class="btn-page"> <a class="pagingset"
										href="javascript:pagingFormSubmit(${count})">${count}</a>
									</span>

								</c:forEach> <span class="btn-page"><a class="pagingset"
									href="javascript:pagingFormSubmit(${navi.currentPage + 1})">&gt;</a></span>
								<span class="btn-page"><a class="pagingset"
									href="javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})">&gt;&gt;</a></span>
							</span>
						</td>
					</tr>
				</table>

	
		</div>

	</section>

<footer id="footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="copyright">
              &copy; Copyright <strong>Imperial Theme</strong>. All Rights Reserved
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
<script src="resources/js/jquery.bxslider.min.js"></script>
<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
    
</body>
</html>