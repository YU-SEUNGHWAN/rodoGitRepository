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
<title>자유게시판</title>

<link href="resources/css/boardstyle.css" rel="stylesheet">


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


<script type = "text/javascript" src = "./resources/js/jquery-3.1.1.js"></script>

<script>

function pagingFormSubmit(currentPage)
{
	var form = document.getElementById("pagingForm");
	var page = document.getElementById("page");
	page.value = currentPage;
	
	form.submit();
}

</script>

</head>
<body>
	
	
<p>전체 글 수 : ${navi.totalRecordsCount}</p>

<%-- <table border = "1">
<c:forEach var = "board" items = "${list}">
	<tr>
		<td class = "list">
			<p>작성자 : ${board.free_id}</p>
			<p>제목 : <a href = "read?free_boardnum=${board.free_boardnum}">${board.free_title}</a></p>
		<c:if test = "${sessionScope.id!=null}">
			
			<c:if test = "${sessionScope.id == board.free_id}">
				<a href = "delete?free_boardnum=${board.free_boardnum}">삭제</a>
			</c:if>
			
		</c:if>
		
		</td>
	</tr>
</c:forEach> 
</table>    --%>                    





<div class="container">
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>
 <div class="mail-box">
                  <aside class="sm-side">
                      <div class="user-head">
                          <a class="inbox-avatar" href="javascript:;">
                              <img  width="64" hieght="60" src="http://bootsnipp.com/img/avatars/ebeb306fd7ec11ab68cbcaa34282158bd80361a7.jpg">
                          </a>
                          <div class="user-name">
                              <h5><a href="#">Alireza Zare</a></h5>
                              <span><a href="#">Info.Ali.Pci@Gmail.com</a></span>
                          </div>
                          <a class="mail-dropdown pull-right" href="javascript:;">
                              <i class="fa fa-chevron-down"></i>
                          </a>
                      </div>
                      <div class="inbox-body">
                          <a href="#myModal" data-toggle="modal"  title="Compose"    class="btn btn-compose">
                              Compose
                          </a>
                          <!-- Modal -->
                          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade" style="display: none;">
                              <div class="modal-dialog">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                                          <h4 class="modal-title">Compose</h4>
                                      </div>
                                      <div class="modal-body">
                                          <form role="form" class="form-horizontal">
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label">To</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputEmail1" class="form-control">
                                                  </div>
                                              </div>ㅅ
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label">Cc / Bcc</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="cc" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label">Subject</label>
                                                  <div class="col-lg-10">
                                                      <input type="text" placeholder="" id="inputPassword1" class="form-control">
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <label class="col-lg-2 control-label">Message</label>
                                                  <div class="col-lg-10">
                                                      <textarea rows="10" cols="30" class="form-control" id="" name=""></textarea>
                                                  </div>
                                              </div>

                                              <div class="form-group">
                                                  <div class="col-lg-offset-2 col-lg-10">
                                                      <span class="btn green fileinput-button">
                                                        <i class="fa fa-plus fa fa-white"></i>
                                                        <span>Attachment</span>
                                                        <input type="file" name="files[]" multiple="">
                                                      </span>
                                                      <button class="btn btn-send" type="submit">Send</button>
                                                  </div>
                                              </div>
                                          </form>
                                      </div>
                                  </div><!-- /.modal-content -->
                              </div><!-- /.modal-dialog -->
                          </div><!-- /.modal -->
                      </div>
                      <ul class="inbox-nav inbox-divider">
                          <li class="active">
                              <a href="#"><i class="fa fa-inbox"></i> Inbox <span class="label label-danger pull-right">2</span></a>

                          </li>
                          <li>
                              <a href="#"><i class="fa fa-envelope-o"></i> Sent Mail</a>
                          </li>
                          <li>
                              <a href="#"><i class="fa fa-bookmark-o"></i> Important</a>
                          </li>
                          <li>
                              <a href="#"><i class=" fa fa-external-link"></i> Drafts <span class="label label-info pull-right">30</span></a>
                          </li>
                          <li>
                              <a href="#"><i class=" fa fa-trash-o"></i> Trash</a>
                          </li>
                      </ul>
                      <ul class="nav nav-pills nav-stacked labels-info inbox-divider">
                          <li> <h4>Labels</h4> </li>
                          <li> <a href="#"> <i class=" fa fa-sign-blank text-danger"></i> Work </a> </li>
                          <li> <a href="#"> <i class=" fa fa-sign-blank text-success"></i> Design </a> </li>
                          <li> <a href="#"> <i class=" fa fa-sign-blank text-info "></i> Family </a>
                          </li><li> <a href="#"> <i class=" fa fa-sign-blank text-warning "></i> Friends </a>
                          </li><li> <a href="#"> <i class=" fa fa-sign-blank text-primary "></i> Office </a>
                          </li>
                      </ul>
                      <ul class="nav nav-pills nav-stacked labels-info ">
                          <li> <h4>Buddy online</h4> </li>
                          <li> <a href="#"> <i class=" fa fa-circle text-success"></i>Alireza Zare <p>I do not think</p></a>  </li>
                          <li> <a href="#"> <i class=" fa fa-circle text-danger"></i>Dark Coders<p>Busy with coding</p></a> </li>
                          <li> <a href="#"> <i class=" fa fa-circle text-muted "></i>Mentaalist <p>I out of control</p></a>
                          </li><li> <a href="#"> <i class=" fa fa-circle text-muted "></i>H3s4m<p>I am not here</p></a>
                          </li><li> <a href="#"> <i class=" fa fa-circle text-muted "></i>Dead man<p>I do not think</p></a>
                          </li>
                      </ul>

                      <div class="inbox-body text-center">
                          <div class="btn-group">
                              <a class="btn mini btn-primary" href="javascript:;">
                                  <i class="fa fa-plus"></i>
                              </a>
                          </div>
                          <div class="btn-group">
                              <a class="btn mini btn-success" href="javascript:;">
                                  <i class="fa fa-phone"></i>
                              </a>
                          </div>
                          <div class="btn-group">
                              <a class="btn mini btn-info" href="javascript:;">
                                  <i class="fa fa-cog"></i>
                              </a>
                          </div>
                      </div>

                  </aside>
                  <aside class="lg-side">
                      <div class="inbox-head">
                          <h3>Free Board</h3>
                          
                          <form action="freeboardlist" class="pull-right position" method = "get" id = "pagingForm">
                              <div class="input-append">
                              	<input type = "hidden" name = "page" id = "page">
                                  <input type="text" class="sr-input" name = "searchText" id = "searchText" placeholder="Search Text" value = "${searchText}">
                                  <button class="btn sr-btn" type="button" onclick = "pagingFormSubmit(1)"><i class="fa fa-search"></i></button>
                              </div>
                          </form>
                                          
						<%-- <form action = "freeboardlist" method = "get" id = "pagingForm">

							<input type = "hidden" name = "page" id = "page">
							제목 : <input type = "text" name = "searchText" id = "searchText" value = "${searchText}">
								<input type = "button" value = "검색" onclick = "pagingFormSubmit(1)">
								검색을 실행하고 난 결과가 무조건 첫페이지에 돌아오게 하기 위해서 1을 적음
								
						</form> --%>
                          
                      </div>
                      <div class="inbox-body">
                         <div class="mail-option">
                             <div class="chk-all">
                                 <input type="checkbox" class="mail-checkbox mail-group-checkbox">
                                 <div class="btn-group">
                                     <a data-toggle="dropdown" href="#" class="btn mini all" aria-expanded="false">
                                         All
                                         <i class="fa fa-angle-down "></i>
                                     </a>
                                     <ul class="dropdown-menu">
                                         <li><a href="#"> None</a></li>
                                         <li><a href="#"> Read</a></li>
                                         <li><a href="#"> Unread</a></li>
                                     </ul>
                                 </div>
                             </div>

                             <div class="btn-group">
                                 <a data-original-title="Refresh" data-placement="top" data-toggle="dropdown" href="#" class="btn mini tooltips">
                                     <i class=" fa fa-refresh"></i>
                                 </a>
                             </div>
                             <div class="btn-group hidden-phone">
                                 <a data-toggle="dropdown" href="#" class="btn mini blue" aria-expanded="false">
                                     More
                                     <i class="fa fa-angle-down "></i>
                                 </a>
                                 <ul class="dropdown-menu">
                                     <li><a href="#"><i class="fa fa-pencil"></i> Mark as Read</a></li>
                                     <li><a href="#"><i class="fa fa-ban"></i> Spam</a></li>
                                     <li class="divider"></li>
                                     <li><a href="#"><i class="fa fa-trash-o"></i> Delete</a></li>
                                 </ul>
                             </div>
                             <div class="btn-group">
                                 <a data-toggle="dropdown" href="#" class="btn mini blue">
                                     Move to
                                     <i class="fa fa-angle-down "></i>
                                 </a>
                                 <ul class="dropdown-menu">
                                     <li><a href="#"><i class="fa fa-pencil"></i> Mark as Read</a></li>
                                     <li><a href="#"><i class="fa fa-ban"></i> Spam</a></li>
                                     <li class="divider"></li>
                                     <li><a href="#"><i class="fa fa-trash-o"></i> Delete</a></li>
                                 </ul>
                             </div>

                             <!-- <ul class="unstyled inbox-pagination">
                                 <li><span>1-50 of 234</span></li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-left  pagination-left"></i></a>
                                 </li>
                                 <li>
                                     <a class="np-btn" href="#"><i class="fa fa-angle-right pagination-right"></i></a>
                                 </li>
                             </ul> -->
                             
                         </div>
                         
                <table class="table table-inbox table-hover">
					<tbody>
						<c:forEach var = "board" items = "${list}">
					    <tr class="unread">  <!-- unread -->
					        <td class="inbox-small-cells">
					            <input type="checkbox" class="mail-checkbox">
					        </td>
					        <td class="inbox-small-cells"><i class="fa fa-star"></i></td>
					        <td class="view-message  dont-show">${board.free_id}</td>
					        <td class="view-message "><a href = "read?free_boardnum=${board.free_boardnum}">${board.free_title}</a></td>
					        <td class="view-message  inbox-small-cells"><i class="fa fa-paperclip"></i></td>
					        <td class="view-message  text-right">${board.free_input_dt}</td>
					    </tr>
					    </c:forEach>
					    
					</tbody>
				</table>
                         
                      </div>
                  </aside>
              </div>
</div>



<div class="container wow fadeInUp"> 
	<table style="width:100%" class="board-navi">
		<tr>
			<td style="width:20%"></td>
			<td style="width:60%; text-align:center;">
				<span class="page-navi">
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})">&lt;&lt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage - 1})">&lt;</a></span>
				
				<c:forEach var = "count" begin = "${navi.startPageGroup}" end = "${navi.endPageGroup}">
				
				<span class="btn-page">
						<a class = "pagingset" href = "javascript:pagingFormSubmit(${count})">${count}</a>
				</span>
				
				</c:forEach>
				
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + 1})">&gt;</a></span>
				<span class="btn-page"><a class = "pagingset" href = "javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})">&gt;&gt;</a></span>
				</span>
			</td>
		<td style="width:20%"><a href="freeboardwrite" class="btn-write">Write</a></td></tr>
	</table>
</div>



<%-- <c:if test = "${sessionScope.id!=null}">
	<p><a href = "freeboardwrite">글쓰기</a></p>
</c:if> --%>



</body>
</html>