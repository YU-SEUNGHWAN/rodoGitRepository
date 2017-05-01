<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="./resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">
 $(function(){
	
		
	$("#save").on("click",function(){

		var id = $("#loginId").val();
		var title = $("#photo_title").val();
		var content = $("#photo_content").val();
		var boardnum = $("#photo_boardnum").val();

		if(title==""){
			alert("제목을 입력해주세요.");
		}
		if(content==""){
			alert("내용을 입력해주세요.");
		}
		
		var formData = new FormData();
			console.log($("#upload")[0].files.length);
			for(var index = 0; index < $("#upload")[0].files.length; index++){
				formData.append("file"+index,$("#upload")[0].files[index]);
			}
			formData.append("loginId",id);
			formData.append("photo_title",title);
			formData.append("photo_content",content);
			formData.append("photo_boardnum",boardnum);
		
		$.ajax({
			type:"POST",						
			url:"updatePhoto",				
			data:formData,
			processData: false,
		    contentType: false,
		    dataType:"text",				
		    success:function(data){	
				console.log(data);
				alert("글 수정이 성공적으로 완료되었습니다.");
				if(data='success')
					location.href = "photoBoard";
				else
					location.href = "";
		    },
			error: function(e){			
				console.log(e);
			}
		});
	});
});
	</script>

<style>
#services {
	font-size:16px;
}

#filetable{
	margin-bottom: 15px;
}

.filetitle{
	font-weight: bolder;
}

#upload{
	margin-left: 20px;
}

#photo_content{
	height:449px;
	width:86%;
	margin-top: 5px;
	resize: none;
	border: 3px solid;
}

#hideMarkers{
	font-weight:bolder;
	margin-top: 10px;
	padding: 5px;
	border: 3px solid #4f5051;
	background: white;
	color: #4f5051;
	font-weight: bolder;
	width: 120px;
	height: 40px;
}

#hideMarkers:hover{
	border: 3px solid #4f5051;
	background: #4f5051;
	color: white;
}

#photo_title{
	border : 0px;
	border-bottom: 3px solid;
	margin-left: 15px;
	margin-bottom: 30px;
	width: 80%;
}

.gpsbutton{
	margin-top: 15px;
	margin-bottom: 30px;
	margin-left: 15px;
	margin-right: 15px;
	border: 3px solid #4f5051;
	background: #4f5051;
	font-size:20px;
	color: white;
	width: 80px;
	height: 40px;
	font-family: "Raleway", sans-serif";
	text-transform: uppercase;
}
.gpsbutton:hover{
	border: 3px solid #4f5051;
	background: white;	
	color: #4f5051;
	font-weight: bolder;
}

b{
	font-size: 20px;
}
#buttontable{
	width: 86%
}
#gpswrite{
	text-align: right;
}
</style>	
	
</head>
<body>

	<%@ include file="../header.jsp" %>
	
	<section id="services" style="background-color: #f6f6f6;">
	    <div class="container wow fadeInUp board-main">  
	      <div class="row">
	        <div class="col-md-12" style="padding-bottom:35px; padding-top: 40px;">
	          <span class="board-title">photo Write</span>
	          <div class="board-title-divider"></div>
	        </div>
	      </div> 

			<div>
				<div><b>TITLE</b><input type="text" name = "photo_title" id = "photo_title" value="${board.photo_title}"></div>

				<div id="contents">
					
					<table id="filetable"><tr>
						<td class="filetitle">PHOTO FILE</td>
						<td><input type="file" id="upload" name="file-data" size="30" accept=".png,.jpg,.gif" multiple = "multiple"></td>
					</tr></table>
					
					<div class="contentDiv">
						<b>CONTENTS</b><br><textarea id = "photo_content" name = "photo_content">${board.photo_content}</textarea>
					</div>
					<input type ="hidden" id="photo_boardnum" name="photo_boardnum" value="${board.photo_boardnum }">
					<input type ="hidden" id="loginId" value="${board.photo_id}">
				</div>
			
			</div>

			<div>
				<table id="buttontable"><tr>
					<td><input type="button" class="gpsbutton" value="back" onclick="javascript:history.back()"></td>
					<td id="gpswrite"><input type="submit" id="save" class="gpsbutton" value="update"></td>
				</tr></table>
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