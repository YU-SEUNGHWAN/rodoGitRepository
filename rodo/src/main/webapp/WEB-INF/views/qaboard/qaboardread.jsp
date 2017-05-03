<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 읽기</title>

<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

$(function()
{
	$("#replybtn").on("click", function()
	{
		var reply = $("#qareply_text").val();
		var boardnum = $("#qa_boardnum").val();
		var id = '${sessionScope.loginId}';
		
		$.ajax
		({
			type : "post",
			url : "qareplywrite",
			
			data : 
			{
				qa_boardnum : boardnum,
				qareply_text : reply
			},
			
			success : function(data)
			{
		         console.log(data);
		         var html =    "<table class='table-striped replyTable' id='replytable'>";
		         
		            $.each(data, function(index,item)
		            {
			            html += "<tr>"
			                     +"<td class='id'>"+item.qareply_id+"</td>"
			                     +"<td id='"+item.qareply_replynum+"' class='reply'>"+item.qareply_text+"</td>"
			                     +"<td class='repdate'>"+item.qareply_input_dt+"</td>"
			                     +"<td class='repdate'>";
						          if (id == item.qareply_id)
				                    {
				                    	html += "<a href='#none' onclick='deletereplywarp("+item.qareply_replynum+", "+item.qa_boardnum+")'>[삭제]</a>";
				                    }			                  
			           	html += "</td>"
			                    +"</tr>";
		         });
				
			         html += "</table>";
			         $("#qareply_text").val("");
			         $("#replytable").html(html);
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

	var id = '${sessionScope.loginId}';
	
	$.ajax
	({
		type : "get",
		url : "qadeletereply",
		
		data : 
		{
			qareply_replynum : replynum,
			qa_boardnum : boardnum
		},
		
		success : function(data)
		{	
			console.log(data);
			
			  var html =    "<table class='table-striped replyTable' id='replytable'>";
	         
	            $.each(data, function(index,item)
			            {
				            html += "<tr>"
				                     +"<td class='id'>"+item.qareply_id+"</td>"
				                     +"<td id='"+item.qareply_replynum+"' class='reply'>"+item.qareply_text+"</td>"
				                     +"<td class='repdate'>"+item.qareply_input_dt+"</td>"
				                     +"<td class='repdate'>";
							          if (id == item.qareply_id)
					                    {
					                    	html += "<a href='#none' onclick='deletereplywarp("+item.qareply_replynum+", "+item.qa_boardnum+")'>[삭제]</a>";
					                    }			                  
				           	html += "</td>"
				                    +"</tr>";
			         });
			
		         html += "</table>";
		         $("#qareply_text").val("");
		         $("#replytable").html(html);
		},
		
		error : function(e)
		{
			console.log(e);
		}
	})
}


function deleteqaboard (qa_boardnum)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href="deleteqaboard?qa_boardnum="+${board.qa_boardnum};
	}
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
		<div class="col-md-6 board-title">&nbsp;&nbsp;${board.qa_title}</div>
		<div class="col-md-6 board-idDate">작성자:
			${board.qa_id}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성일:
			${board.qa_input_dt}&nbsp;&nbsp;</div>
	</div>
	<div class="board-title-divider"></div>


	<div style="margin-bottom: 100px;">
			<c:forEach items="${board.qafile_saved}" var="qa">
				<img style="width: 600px;" src='qaLoad?origin=${qa}'/>
				<br>
			</c:forEach>
	</div>

	<div id="content" class="board-content">
		<pre> ${board.qa_content} </pre>
	</div>

	<div class="board-content-divider"></div>

	<div class='boardbtn'>
		<c:if test = "${sessionScope.loginId == board.qa_id}">
			<input type="button" value="update" onclick="javascript:location.href='updateqaboard?qa_boardnum=${board.qa_boardnum}'">
			<input type="button" value="delete" onclick="deleteqaboard('${board.qa_boardnum}')">
		</c:if>
	</div>
	
	<div class="board-reply">
	
		<c:if test = "${sessionScope.loginId != null}">
	
			<input type="hidden" id="qa_boardnum" value="${board.qa_boardnum}">
		
				<b>reply</b> 
				<input type = "hidden" id = "replynum" value = "${reply.qareply_replynum}">
				<input type = "hidden" id = "boardnum" value = "${reply.qa_boardnum}">
				<input class="inputReply" id="qareply_text" type="text"> <input
					style="margin-left: 10px; background: #353637; color: white;"
					type="button" id="replybtn" value="등록" />

		</c:if>

<div class="reviewDiv">

	<table class="table-striped replyTable" id="replytable">

		<c:forEach var="reply" items="${replylist}">
			<tr class="repwtr">
				<td class="id">${reply.qareply_id}</td>

				<td class="reply">${reply.qareply_text}</td>

				<td class="repdate">${reply.qareply_input_dt}</td>

				<td class="repdate"><c:if
						test="${sessionScope.loginId == reply.qareply_id}">
						<a href='#none'
							onclick="deletereplywarp('${reply.qareply_replynum}', '${reply.qa_boardnum}')">[삭제]</a>
					</c:if></td>
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