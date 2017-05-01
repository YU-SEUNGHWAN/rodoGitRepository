<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
  
<script>
	function pagingFormSubmit(currentPage) {
		var form = document.getElementById("pagingForm");
		var page = document.getElementById("page");
		page.value = currentPage;

		form.submit();
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
</style>

<script>
function pagingFormSubmit(currentPage)
{
	var form = document.getElementById("pagingForm");
	var page = document.getElementById("page");
	page.value = currentPage;
	
	form.submit();
}

$(function()
{
	$(".tcolor").on
	({
		mouseenter : function()
		{
			$(this).addClass("reverse");
		},
		
		mouseleave : function()
		{
			$(this).removeClass("reverse");
		}
	})
});
</script>

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
					<h3 class="section-title">FREE BOARD</h3>
					<div class="section-title-divider"></div>
				</div>
			</div>

   <div class="row" style="height: 600px;">
       <div class="col-md-12" style="padding-bottom:35px">
       	<table class = "table-striped" style="width : 100%; border-bottom: 2px solid gray;">
        		<tr>
        			<th style="text-align:center; width:8%;">		번호		</th>
        			<th style="text-align:center; width:3%;">		    	</th>
        			<th style="text-align:center; width:57%;">		제목		</th>
        			<th style="text-align:center; width:12%;">		글쓴이	</th>
        			<th style="text-align:center; width:10%;">		날짜		</th>
        			<th style="text-align:center; width:10%;">		조회		</th>
        		</tr>
        		
       	 <c:forEach var="board" items="${list}">
        		<tr class = "tcolor">
        			<td style="text-align:center; width:8%;"> ${board.free_boardnum}
        			</td>

       				<td style="text-align:center; width:3%;">
						 <c:forEach var ="fc" items= "${fList}" begin="${board.free_boardnum}" end="${board.free_boardnum}">
							<c:if test="${fc == null}">		<img src = "./resources/img/front.png">		</c:if>
							<c:if test="${fc != null}">		<img src = "./resources/img/picon.png">		</c:if>
						</c:forEach>
        			</td>

        			<td style="text-align:left; width:57%;">
        				<a href="read?free_boardnum=${board.free_boardnum}" class="title">
        				${board.free_title}	</a>	&nbsp; &nbsp;

 						<c:forEach var ="a"  items= "${reList}" 
 						begin="${board.free_boardnum}" end="${board.free_boardnum}">
							<c:if test="${a != null}">		[	${a}	]		</c:if>
							<c:if test="${a == null}">			　				</c:if>
						</c:forEach>
        			</td>
        			
        			<td style="text-align:center; width:12%;">${board.free_id}			</td>
        			<td style="text-align:center; width:10%;">${board.free_input_dt}	</td>
        			<td style="text-align:center; width:10%;">${board.free_hit}			</td>
        		</tr>
      	  </c:forEach>
        </table>
       </div> 
	</div>

		<table style="width: 100%" class="board-navi">
			<tr>
				<td style="width: 20%"></td>
				<td style="width: 60%; text-align: center;"><span
					class="page-navi"> <span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})"><a
							class="pagingset"
							href="#none">&lt;&lt;</a></span>
						<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage - 1})"><a class="pagingset"
							href="#none">&lt;</a></span>
		
						<c:forEach var="count" begin="${navi.startPageGroup}"
							end="${navi.endPageGroup}">
		
							<span class="btn-page" onclick="pagingFormSubmit(${count})"> <a class="pagingset"
								href="#none">${count}</a>
							</span>
		
						</c:forEach> <span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage + 1})"><a class="pagingset"
							href="#none">&gt;</a></span>
						<span class="btn-page" onclick="pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})"><a class="pagingset"
							href="#none">&gt;&gt;</a></span>
				</span></td>
				<td style="width: 20%"><a href="freeboardwrite" class="btn-write">Write</a></td>
			</tr>
		</table>

				<form action="freeboardlist" class="pull-right position"
					method="get" id="pagingForm">
					<div class="input-append">
						<input type="hidden" name="page" id="page"> <input
							type="text" class="sr-input" name="searchText" id="searchText"
							placeholder="Search Text" value="${searchText}">
						<button class="btn sr-btn" type="button"
							onclick="pagingFormSubmit(1)">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</form>

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