<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!-- =======================================================
  Theme Name: Imperial
  Theme URL: https://bootstrapmade.com/imperial-free-onepage-bootstrap-theme/
  Author: BootstrapMade.com
  Author URL: https://bootstrapmade.com
======================================================= -->

<style>
.pagingset {
	color: white;
}
</style>

<script type="text/javascript">
	function pagingFormSubmit(currentPage) {
		var form = document.getElementById("pagingForm");
		var page = document.getElementById("page");
		page.value = currentPage;

		form.submit();
	}

	$(function(){
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

	<!--==========================
  Services Section
============================-->
	<section id="services">
		<div class="container wow fadeInUp">
			<div class="row">
				<div class="col-md-12" style="padding-bottom: 35px">
					<h3 class="section-title">LOG BOARD</h3>
					<div class="section-title-divider"></div>
				</div>
			</div>

			<div class="row" style="height: 600px;">
			
				<c:forEach items="${gpslist}" var="gps">
					<div class="col-md-6 service-item">

						<div class="service-icon">
							<i class="fa fa-bicycle"></i>
						</div>

						<h4 class="service-title">
							<a href="gpsread?gps_boardnum=${gps.gps_boardnum}">${gps.gps_title}</a>
						</h4>
						<p class="service-description">
							작성자 : ${gps.gps_id}<br>작성일 : ${gps.gps_input_dt}<br>지역
							: ${gps.gps_location}
						</p>

					</div>
				</c:forEach>
				
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
						<td style="width: 20%"><a href="writeGps" class="btn-write">Write</a></td>
					</tr>
				</table>

				<div class="inbox-head">

					<form action="logBoard" class="pull-right position" method="get"
						id="pagingForm">
						<div class="input-append">
							<input type="hidden" name="page" id="page"> <input
								type="text" class="sr-input" name="searchText" id="searchText"
								placeholder=" Search Text" value="${searchText}">
							<button class="btn sr-btn" type="button"
								onclick="pagingFormSubmit(1)">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</form>

				</div>
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
						Bootstrap Themes by <a href="https://bootstrapmade.com/">BootstrapMade</a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- #footer -->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

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