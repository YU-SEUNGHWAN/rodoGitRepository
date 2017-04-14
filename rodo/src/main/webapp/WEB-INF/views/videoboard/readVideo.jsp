<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(document).ready(function(){
	$('.bxslider').bxSlider();
});

function deleteVideo(){
	location.href="deleteVideo?video_boardnum="+${videoBoard.video_boardnum}; 
}

function updateVideo(){
	location.href="updateVideo?video_boardnum="+${videoBoard.video_boardnum}; 
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
	
		<form>
			reply <input class="inputReply" type="text">
			<input style="margin-left:10px;" type="button" id="regist" value="등록" />
		</form>
		
		<div class="reviewDiv ">
			<table class="table-striped replyTable">
				<tr class="repwtr">
					<td class="id">홍길동</td>
					<td class="reply">정말 재밌어보여요 저도 한번 다녀와야겠어요</td>
					<td class="repdate">2017.04.03</td>
					<td><input type="button" class="delbtn" value="삭제" /></td>
				</tr>
				<tr class="repwtr">
					<td class="id">schasd51</td>
					<td class="reply">정말 재밌어보여요 저도 한번 다녀와야겠어요</td>
					<td class="repdate">2017.04.03</td>
					<td><input type="button" class="delbtn" value="삭제" /></td>
				</tr>
				<tr class="repwtr">
					<td class="id">홍길동</td>
					<td class="reply">정말 재밌어보여요 저도 한번 다녀와야겠어요</td>
					<td class="repdate">2017.04.03</td>
					<td><input type="button" class="delbtn" value="삭제" /></td>
				</tr>
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