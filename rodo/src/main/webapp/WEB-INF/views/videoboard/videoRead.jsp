<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=6b513317a557b95d9627ec6ce1303e51&libraries=services"></script>
<!-- ab43af777848bf1eb1bd3148b28cf31d -->
<script src="resources/js/maps.js"></script>
<script src="resources/js/chart.js"></script>
<link href="resources/css/ReadGps.css" rel="stylesheet" type="text/css">
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
          <span class="board-title">북한산 등반 다녀왔습니다 (17.03.21)</span>
          <div class="board-title-divider"></div>
        </div>
      </div> 
		<div id="container" class="map_wrap">
		    <div id="rvWrapper">
	        <div id="roadview" style="width:100%;height:100%;"></div> <!-- 로드뷰를 표시할 div 입니다 -->
	    </div>
	    <div id="mapWrapper">
	      	<div id="map"></div>
	        <div id="roadviewControl" onclick="setRoadviewRoad()"><span>로드뷰</span></div>
	    </div>
		    <ul id="category" style="padding-left:0px;margin-top 0px;margin-bottom: 0px;">
		        <li id="BK9" data-order="0"> 
		            <span class="category_bg bank"></span>
		            은행
		        </li>       
		        <li id="MT1" data-order="1"> 
		            <span class="category_bg mart"></span>
		            마트
		        </li>  
		        <li id="HP8" data-order="2"> 
		            <span class="category_bg hospital"></span>
		            병원
		        </li>  
		       <li id="AT4" data-order="3">
		            <span class="category_bg sights"></span>
		            관광명소
		        </li>  
		        <li id="CE7" data-order="4"> 
		            <span class="category_bg cafe"></span>
		            카페
		        </li>  
		        <li id="CS2" data-order="5"> 
		            <span class="category_bg store"></span>
		            편의점
		        </li>
		    </ul>
		</div>
		<div class="autoview">
			<img style="width:220px" src="resources/img/roadview.png">
			<input type="button" id="ajaxTest" onclick="viewStart()" value="start">
			<input type="button" id="ajaxTest" onclick="viewPause()" value="pause">
			<input type="button" id="ajaxTest" onclick="viewStop()" value="stop">
		</div>
		<div id="chart_div"></div>
		<div id="content" class="board-content"><pre>넘나 재밌었삼
담에는 가족들하고 같이 오고싶은것</pre></div>
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