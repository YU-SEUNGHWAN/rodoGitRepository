<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%--
	Title : 멀티파일 업로드, 프로그레스바
	Author : 박인성
--%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.wapforum.org/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>	
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<meta name="viewport" content="minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<title>FileUpload Test Form</title>
<style type="text/css">
body{padding:0;margin:0;font-size:13px;font-family:'나눔고딕',NanumGothic,'맑은 고딕','Malgun Gothic','돋움',Dotum,'굴림',Gulim,Helvetica,AppleGothic,sans-serif;}
div.fileUploadSection{float:left;width:100%;}
div.fileUploadSection div.fileUpWrapper{text-align:center;margin:6px 0 0 4px;}
div.fileUploadSection div.fileUpWrapper div.uploadPathDiv{float:left;line-height:23px;height:25px;width:70%;border:1px solid #ccc;}

/*파일 추가 삭제*/
div.addAttachFileSection{float:left;width:100%;margin:5px 0 0 0;}
div.addAttachFileSection ul.attachFileList{float:left;list-style-type:none;padding:0;margin:0;width:100%;word-break:break-all;word-wrap:break-word;whilte-space:pre-wrap;}
div.addAttachFileSection ul.attachFileList li{float:left;width:100%;border:1px solid #ccc;margin:0 0 2px 0;text-align:left;}
div.addAttachFileSection ul.attachFileList li span.removeAttach{border:1px solid #ccc;line-height:25px;padding:0 7px 0 7px;margin:0 4px 0 4px;}
div.addAttachFileSection ul.attachFileList li span.attachFileName{vertical-align:middle;line-height:25px;}
span.fileUp{font-size:13px;line-height:25px;}

div#viewLoading {text-align:center;padding-top:120px;filter:alpha(opacity=60);opacity: alpha*0.6;background-color:#222222;color:#bcbfc4;}
div#viewLoading div.progressTitle{text-align:left;border:2px solid #111111;border-bottom:1px solid #111111;padding:15px 0 15px 0;width:99.2%;}
div#viewLoading div.progressTitle span{padding-left:3px;padding-bottom:5px;}
div#viewLoading div.progressWrapper{border:1px solid #111111;width:99.2%;text-align:center;}
div#viewLoading div.progressWrapper div.progresspercent{background-color:#1a1a1a;height:40px;border:1px solid #000000;}
div#viewLoading div.progressWrapper div.progresspercent span.percentwrapper{line-height:38px;}
div#viewLoading div.progressWrapper div.progresspercent span.percentwrapper span.pgbar{display:block;float:left;background-color:#fecf23;width:90%;}
div#viewLoading div.progressWrapper div.progresspercent span.percentwrapper span.pgpercent{position:absolute;left:30%;right:30%;color:#c0c0c0;}
div#viewLoading div.progressWrapper div.progresspercent span.percentwrapper span.pgpercent strong{font-weight:bold;}
div#viewLoading div.progressfilereadsize{margin:0 0 5px 0;height:40px;border:1px solid #111111;}
div#viewLoading div.progressfilereadsize span{line-height:40px;}
div#viewLoading div.progressfilereadsize span.divider strong{font-weight:400;}
div#viewLoading div.progressSpeed{margin:0 0 5px 0;height:40px;border:1px solid #111111;text-align:center;}
div#viewLoading div.progressSpeed span.kbps{line-height:40px;}
div#viewLoading div.progressSpeed span.kbps strong{font-weight:400;}

.pgbarbgcolor{background-color:#fecf23;}
</style>
<script type="text/javascript" src="../js/lib/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="../js/lib/jquery.form.js"></script>
<script type="text/javascript">
//input file의 인덱스번호로 쓰임(전역변수)
var fileIndex = 0;	

$(function(){
	var fileUploadElem = $("input.file");
	var fileUploadBtnElem = $("span.sendData");
	var fileUploadFrm = $("#fileform");	
		
	//ajax Progress image view Elem
	var viewLoadingImgElem = $("div#viewLoading");
	$(viewLoadingImgElem).hide();	//초기로딩시에는 이미지를 숨긴다.
	
	var intervalID = 0;
	//ajax 요청시작과 완료시의 프로그레스 이미지 element의 동작
	$(viewLoadingImgElem).ajaxStart(function(){
		// 로딩이미지의 위치 및 크기조절	
		$(viewLoadingImgElem).css('position', 'absolute');
		$(viewLoadingImgElem).css('left', $("body").offset().left);
		$(viewLoadingImgElem).css('top', $("body").offset().top);
		$(viewLoadingImgElem).css('width', $(document).width());
		$(viewLoadingImgElem).css('height', $(document).height());
		
		
		intervalID = setInterval(function(){			
			getFileUploadProgress();	//ajax요청중에 파일업로드 상태를 주기적으로 요청한다.	
		},50);
		$(this).fadeIn(250);
	}).ajaxStop(function(){		
		clearInterval(intervalID); //Stop updating		
		$(this).fadeOut(250);
	});					

	$(fileUploadBtnElem).click(function(){
		$(fileUploadFrm).ajaxSubmit({			
			url : '/testproj/fileupload.do',
			type : 'POST',
			data : $(fileUploadFrm).serialize(),
			success : function(data){
				deleteFileListAndFileElems();											
				clearInterval(intervalID); //Stop updating
				//alert("전송 완료 되었습니다.");
			},error : function(){
				deleteFileListAndFileElems();
				clearInterval(intervalID); //Stop updating	
				//alert("전송 실패 했습니다.");
			}
		});	
	});
    
	//파일업로드 상태를 주기적으로 확인해서 가져온다.
	var getFileUploadProgress = function(){
		$.ajax({
			url : '/testproj/uploadstatus.do',
			success : function(data){
				var jsonData = eval('('+ data +')');

				$(viewLoadingImgElem).html(										
						"<div class='progressTitle'>" +
						"	<span><strong>업로드 진행상태</strong></span>" +		
						"</div>" +
						"<div class='progressWrapper'>" +
						"	<div class='progresspercent'>" +
						"		<span class='percentwrapper'>"+
						"			<span class='pgbar'>&nbsp;</span>"+
						"			<span class='pgpercent'><strong>"+ jsonData.percent+"%</strong></span>" +				
						"		</span>" +
						"	</div>"+
						"	<div class='progressfilereadsize'>"+
						"		<span class='readsize'>" + jsonData.bytesread + "<strong> bytes</strong></span>" +
						"		<span class='divider'><strong>/</strong></span>" +
						"		<span class='filelength'>" + jsonData.contentlength + "<strong> bytes</strong></span>" +
						"	</div>" +
						"	<div class='progressSpeed'>" +
						"		<span class='kbps'>" + jsonData.kbps + "<strong> kbps</strong></span>" +
						"	</div>" +								
						"</div>"	);										
				$(viewLoadingImgElem).find("div.progresspercent span.pgbar").width(jsonData.percent+"%").addClass("pgbarbgcolor");				
			}
		});
	};	
});


//업로드 파일 지정
var makeUploadElem = function(fileElemObj){
	fileIndex++;	//global var	
	var addAttachFileSectionElem = $("div").filter(".addAttachFileSection");
	var attachFileListElem = $(addAttachFileSectionElem).find("ul");	
	
	var targetElem=$("div#fileUpBtnWrapper");
	var fileElem=$("<input id='file"+fileIndex+"' class='file' type='file' name='upFile[]' style='position: absolute;right:0px;top:0px; opacity:0; filter: alpha(opacity=0);cursor: pointer;outline:none;'/>");
	var fileUpBtnElem = $("<span class='fileUp'>&nbsp;파일</span>");
	
	$(fileElem).change(function(){
		makeUploadElem(this);	//recursive				
	});
	
	$(targetElem).append(fileElem);
	$(targetElem).append(fileUpBtnElem);
	$(fileElemObj).hide();	
	
	//파일 목록 추가 / 삭제
	var fileElemObjVal = $(fileElemObj).val();	
	$(attachFileListElem).append(
		"<li>" +			
			"<span class='removeAttach' onClick='deleteFileList(this,"+fileIndex+");'>x</span>" +
			"<span class='attachFileName'>"+fileElemObjVal+"</span>" +
		"</li>"
	);			
	
	$("div#debug").text($("div.fileUploadSection").html());
};
//업로드 파일 리스트 삭제
var deleteFileList = function(fileListElem,fileElemIndex){
	//기본으로 마크업된 input file의 인덱스 번호가 0으로 시작되는데
	//전역변수로 증가 시킨 상태이므로 -1을 시켜서 인덱스 번호를 맞춰준다.
	var fileElemIdx = fileElemIndex - 1;
	var fileUpBtnWrapElem = $("div").filter("#fileUpBtnWrapper");
	
	$(fileUpBtnWrapElem).find("input:file").filter("#file"+fileElemIdx).remove();	
	$(fileListElem).parent().remove();
	
	$("div#debug").text($("div.fileUploadSection").html());
};

//전송이 완료되거나 실패시에도 input file과 li를 모두삭제 시켜주고
//전역변수로 사용된 인덱스를 초기화 시켜준다.
var deleteFileListAndFileElems = function(){
	var fileUploadSectionElem = $("div").filter(".fileUpWrapper");
	var addAttachFileSectionElem = $("div").filter(".addAttachFileSection").find("ul");
	$(fileUploadSectionElem).children().remove();
	$(addAttachFileSectionElem).children().remove();
	fileIndex = 0;
};
</script>
</head>
<body>
<div class="fileUploadSectionWrapper">
	<form id="fileform" enctype="multipart/form-data" method="post">
		<!-- 첨부파일 -->
		<div class="fileUploadSection">			
			<div class="fileUpWrapper">	
				<div id="fileUpBtnWrapper" class="fileUpBtnWrapper" style="position:relative; left: 2px; width:40px;height:25px; overflow:hidden;border:1px solid #ccc;text-align:center;">				 								
					<%-- input의 id명 뒤의 숫자를 변경하지 말것(인덱스 번호로 사용됨) --%>				
					<input id="file0" onchange="makeUploadElem(this)" class='file' type="file" name="upFile[]" style="position: absolute;right:0px;top:0px; opacity:0; filter: alpha(opacity=0);cursor: pointer;outline:none;"/>					 				
					<span class="fileUp">파일</span>
				 </div>
			</div>
		</div>		
		<!-- 첨부추가/제거 -->
		<div class="addAttachFileSection">
			<ul class="attachFileList">
			</ul>
		</div>				
	</form>			
</div>

<div style="float:left;width:100%;height:40px;margin-top:30px;border:1px solid #ccc;text-align:center;">
	<span class="sendData" style="border:1px solid #ccc;line-height:40px;vertical-align:middle;padding:4px 15px 4px 15px;">전송</span>
</div>
<!-- Ajax Progress Status -->
<div id="viewLoading">
	<!-- 
	<div class='progressTitle'>
		<span><strong>업로드 진행상태</strong></span>		
	</div>
	<div class='progressWrapper'>
		<div class='progresspercent'>
			<span class='percentwrapper'>
				<span class='pgbar'>&nbsp;</span>
				<span class='pgpercent'><strong> 40% </strong></span>				
			</span>
		</div>
		<div class='progressfilereadsize'>
			<span class='readsize'> 20000000000 <strong> bytes</strong></span>
			<span class='divider'><strong>/</strong></span>
			<span class='filelength'> 3000000000000  <strong> bytes</strong></span>
		</div>
		<div class='progressSpeed'>
			<span class='kbps'> 2000 <strong> kbps</strong></span>
		</div>		
	</div>
 	-->
</div>
<div id="debug" style="float:left;width:100%;border:1px solid red;margin-top:30px;">
</div>
</body>
</html>