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
			var html =    "<tr class='repwtr'>"
                +"<td class='id'>아이디</td>"
                +"<td class='reply'>댓글</td>"
                +"<td class='repdate'>날짜</td>"
                +"<td></td>"
                +"</tr>"; 
       
          $.each(data, function(index,item)
          {
	            html += "<tr class='repwtr'>"
	                     +"<td class='id'>"+item.videoreply_id+"</td>"
	                     +"<td id='"+item.videoreply_replynum+"' class='reply'>"+item.videoreply_text+"</td>"
	                     +"<td class='repdate'>"+item.videoreply_input_dt+"</td>"
	                     +"<td class='repdate'>"
	                 		    +"<a href='javascript:replyUpdateForm("+item.videoreply_replynum+","+item.video_boardnum+")'>[수정]</a>"
	                           +"<a href='#none' onclick='deletereplywarp("+item.videoreply_replynum+", "+item.video_boardnum+")'>[삭제]</a>"
	                     +"</td>"
	                  +"</tr>";
       	});
		
	         $("#videoreply_text").val("");
	         $("#replytable").html(html);
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
				var html =    "<tr class='repwtr'>"
	                  +"<td class='id'>아이디</td>"
	                  +"<td class='reply'>댓글</td>"
	                  +"<td class='repdate'>날짜</td>"
	                  +"<td></td>"
	                  +"</tr>"; 
	         
	            $.each(data, function(index,item)
	            {
		            html += "<tr class='repwtr'>"
		                     +"<td class='id'>"+item.videoreply_id+"</td>"
		                     +"<td id='"+item.videoreply_replynum+"' class='reply'>"+item.videoreply_text+"</td>"
		                     +"<td class='repdate'>"+item.videoreply_input_dt+"</td>"
		                     +"<td class='repdate'>"
		                     +"<a href='javascript:replyUpdateForm("+item.videoreply_replynum+","+item.video_boardnum+")'>[수정]</a>"
		                           +"<a href='#none' onclick='deletereplywarp("+item.videoreply_replynum+", "+item.video_boardnum+")'>[삭제]</a>"
		                     +"</td>"
		                  +"</tr>";
	         	});
			
		         $("#videoreply_text").val("");
		         $("#replytable").html(html);
			},
			
			error : function(e)
			{
				console.log(e);
			}
		})
	})
})


</script>

<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

</head>
<body>
<!--==========================
  Header Section
============================-->
<%@ include file="../header.jsp" %>
		
<section id="portfolio" style="background-color: #f6f6f6;">
    <div class="container wow fadeInUp board-main">   
     
      <div class="row">
        <div class="col-md-12" style="padding-bottom:35px; padding-top: 40px;">
          <span class="board-title">${videoBoard.video_title }</span>
          <div class="board-title-divider"></div>
        </div>
      </div> 
      <div style="margin-bottom:150px; border:1px solid black; width:60%; height:40%">
	  	 <video height='100%' id='videoForm' controls='controls'>
   	   		<source src="${videoBoard.video_savedfile}" />
   	     </video>
      </div>
		<div id="content" class="board-content"><pre>${videoBoard.video_content}</pre>
		</div>
	
		
		<input type="button" class="delbtn" value="글 삭제" onclick="deleteVideo()"/>
		<input type="button" class="updatebtn" value="글 수정" onclick="updateVideo()"/>
	
	
	<div class="board-reply">
	
		<input type = "hidden" id = "video_boardnum" value = "${videoBoard.video_boardnum}">
			reply <input class="inputReply" type="text" id = "videoreply_text">
			
			<input type = "hidden" id = "replynum" value = "${reply.videoreply_replynum}">
			<input type = "hidden" id = "boardnum" value = "${reply.video_boardnum}">
			
			<input style="margin-left:10px;" type="button" id="regist" value="등록" />
		
		
		<div class="reviewDiv ">
			<table class="table-striped replyTable" id = "replytable">
			
				<tr class="repwtr">
					<td class="id">아이디</td>
					<td class="reply">댓글</td>
					<td class="repdate">날짜</td>
					<td></td>
				</tr>
				
				<c:forEach var = "reply" items = "${replylist}">
				
					<tr class="repwtr">
						<td class="id">
							${reply.videoreply_id}
						</td>
						
						<td class="reply">
							${reply.videoreply_text}
						</td>
							
						<td class="repdate">
							${reply.videoreply_input_dt}
						</td>
						
						<td class="repdate">
							<c:if test = "${sessionScope.loginId == reply.videoreply_id}">
									<a href= "">[수정]</a>
									<a href='#none' onclick="deletereplywarp('${reply.videoreply_replynum}', '${reply.video_boardnum}')">[삭제]</a>
							</c:if>
						</td>

					</tr>
					
				</c:forEach>

			</table>
		</div>
		
	</div>
	
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