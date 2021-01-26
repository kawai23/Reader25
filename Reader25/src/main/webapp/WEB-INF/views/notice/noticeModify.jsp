<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/smartedit/js/service/HuskyEZCreator.js"></script>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<!-- Remember to include jQuery :) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<style>
section {
	background: rgba(246, 246, 246, 1);
	min-height: 900px;
	width: 80%;
	min-width: 1000px;
	margin: auto;
}

.header-div {
	width: 80%;
	margin: auto;
	max-width: 1100px;
}

.header-div>h2 {
	display: inline-block;
}

.file-div {
	display: inline-block;
	float: right;
	margin-top: 40px;
}

.file-div label {
	display: inline-block;
	padding: .5em .75em;
	color: white;
	font-size: 12px;
	line-height: normal;
	vertical-align: middle;
	background-color: rgba(201, 95, 18, 1);
	border-radius: 5px;
	cursor: pointer;
}

.file-div input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
.image-box{border: 3px solid rgba(246, 246, 246, 1);display:inline-block; text-align: center;width: 200px; height: 200px;line-height:200px;background:rgba(235, 235, 235, 1);}
.image-box img {
	max-height:200px;
	max-width: 200px;
	vertical-align: middle;
	text-align: center;
}
.fileList{ list-style: none; font-size: 13px;}
.upload-name {
	display: inline-block;
	padding: .5em .75em; /* label의 패딩값과 일치 */
	font-size: 12px;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: 5px;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

.title-div {
	clear: both;
	width: 80%;
	max-width: 1100px;
	margin: auto;
	margin-top: 10px;
	padding: 0;
}

.title {
	display: inline-block;
	background: rgba(235, 235, 235, 1);
	text-align: center;
	vertical-align: middle;
	width: 50px;
	height: 27px;
	border: 1px solid rgba(235, 235, 235, 1);
	border-radius: 3px 0px 0px 3px;
	color: rgba(85, 83, 83, 1);
}

.title-div>input {
	height: 25px;
	margin-left: -7px;
	width: 91%;
	border: 1px solid rgba(235, 235, 235, 1);
}

.contents {
	width: 80%;
	margin: auto;
	margin-top: 20px;
	max-width: 1100px;
	min-height: 500px;
}

#smart_edit {
	height: 500px;
}

.btn-div {
	width: 80%;
	max-width: 1100px;
	margin: auto;
}

.btn {
	float: right;
	width: 100px;
	height: 40px;
	margin-top: 20px;
	margin-right: 10px;
	background: rgba(255, 195, 152, 1);
	border: none;
}

#submit-btn {
	background: rgba(201, 95, 18, 1);
}

.btn:hover {
	font-weight: bolder;
	color: white;
	cursor: pointer;
}

	.jquery-modal blocker current {
		visibility: none;
	}
	.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
	}
	.modal-back {
		display: none; 
		position: fixed; 
		z-index: 1;
		left: 0;
		top: 0;
		width: 100%; 
		height: 100%;
		overflow: auto; 
		background: rgba(0, 0, 0, 0.4); 
	}
	.modal-close ,.modal-accept{
		background-color: rgba(137, 18, 18, 1);
		color:white;
		width: 80px;
		height: 30px;
		border:none;
		display:inline-block;
		left: 40%;
	}
	.modal-accept{
		background-color: rgba(85, 83, 83, 1);
	}
	.modal p{
		display:inline-block;
	}
	.modal img{
		position:relative;
		top: 10px;
	}
</style>
</head>
<body>
<%@include file="../common/menubar.jsp" %>
	
	<!-- 에러 모달창 -->
	<div class="modal-back" id="t-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>제목을 입력해 주세요</p>
				<button class="modal-close" value="Close">Close</button>
			</div>
		</div>
	</div>
		<div class="modal-back" id="c-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>
					작성한 내용이 사라집니다. 작성 취소하시겠습니까? 
				</p>
				<button class="modal-accept" value="accept">네</button>
				<button class="modal-close" value="Close">아니오</button>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('.modal-close').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
			});
			$('.modal-accept').click(function(){
				location.href = "notice.no";
			});
		});
	</script>
	<section>
	<form id="notice-form" method="post" enctype="multipart/form-data" action="update.no">	
		<input type="hidden" name="page" value="${page}">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<div class="header-div">
			<h2>공지사항 작성</h2>
			<div class="file-div">
				<input class="upload-name" value="파일선택" disabled="disabled">
				<label for="file-input">파일 업로드</label>
				<input type="file" id="file-input" name="uploadFile"  onchange="loadImg(this);" multiple="multiple">
			</div>
			<!-- 파일업로드- -->
			<% 
				ArrayList<Attachment> atList = (ArrayList<Attachment>)request.getAttribute("atList");
			%>
			<div  class="fileList" id="fileList">
				<%if(atList != null){ %>
					<%
					for(Attachment at: atList){
						String filename = at.getAtcOrigin();
						String ext = filename.substring(filename.lastIndexOf(".") + 1);
					%>
						<%if(!ext.equals("png") && !ext.equals("jpeg") && !ext.equals("jpg")){ %>
							<li><%=at.getAtcName() %></li>
						<%} %>
					<%} %>
				<%} %>
			</div>
			<%
				String[] originArr = new String[atList.size()];
				String[] nameArr = new String[atList.size()];
			%>
			<div class="file-upload">
				<%if(atList != null){ %>
					<%
					for(int i = 0; i < atList.size(); i++){ 
						String filename = atList.get(i).getAtcOrigin();
						String ext = filename.substring(filename.lastIndexOf(".")+1);
						originArr[i] = atList.get(i).getAtcOrigin();
						nameArr[i] = atList.get(i).getAtcName();
					%>
						<%if(ext.equals("png") || ext.equals("jpeg") || ext.equals("jpg")){ %>
						<div class="image-box">
							<img src="resources/buploadFiles/<%=atList.get(i).getAtcName()%>"/>
						</div>
						<%} %>
					<%} %>
				<%} %>
			</div>
			
			<input type="hidden" name="originArr" value="<%=originArr %>"/>
			<input type="hidden" name="nameArr" value="<%=nameArr%>"/>
			<!-- - -->
			<script>
				function loadImg(value){
					if (value.files){
						$('#fileList').html('');
						$uploadImage = $('.file-upload')
						$uploadImage.html('')
						for(var i = 0; i < value.files.length; i++){
							if(window.FileReader){ // modern browser 
								var filename = value.files[i].name; 
							} else { // old IE 
								var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
							}
							$('.upload-name').val(filename);
	
							// 확장자
							var extension = filename.substring(filename.lastIndexOf(".") + 1);
							console.log(extension);
							var reader = new FileReader();
							if(extension == "png" || extension == "jpg" || extension == "jpeg"){
								reader.onload = function(e) {
									$imgBox = $('<div class="image-box">');
									$img = $('<img>').attr('src', e.target.result);
									$imgBox.append($img);
									$uploadImage.append($imgBox);
								}
								reader.readAsDataURL(value.files[i]);
							}else{
								$li = $('<li>').text(filename);
								$('#fileList').append($li);
							}
						}
					}
				}
				$(function(){
					$('.modal').hide();
				});
			</script>
		</div>
		
			<div class="title-div">
				<div class="title">title</div>
				<input type="text" name="bTitle" id="bTitle" value="${ board.bTitle}">
				<input type="hidden" name="userId" value="${ loginUser.id }">
			</div>
			<div class="contents">
					<textarea name="bContent" id="smart_edit" style="width:100%;">${board.bContent }</textarea>
			</div>
			<div class="btn-div">
				<button id="submit-btn" class="btn">수정완료</button>
				<button class="btn" id="reset-btn">수정취소</button>
			</div>
		</form>
		<script>
			$(function(){
				$('#reset-btn').click(function(){
					event.preventDefault();
					$('#c-modal').show();
					$('#c-modal .modal').show();
				});
			});
			var oEditors = [];
			//스마트 에디터 생성 함수
			 nhn.husky.EZCreator.createInIFrame({
			      oAppRef :oEditors,
			      elPlaceHolder : "smart_edit", 
			      sSkinURI : "<%=request.getContextPath()%>/smartedit/SmartEditor2Skin.html",
			      fCreator: "createSEditor2"
			});
			$('#submit-btn').click(function(){
				oEditors.getById["smart_edit"].exec("UPDATE_CONTENTS_FIELD",[]);

				// validate 검증하기
				 var title = $('#bTitle').val()
				 if(title == ""){
					 event.preventDefault();
					 this.blur();
					 $('#t-modal').show();
					 $('#t-modal .modal').show();
					return false;
				}else{
					$('#notice-form').submit();
				}
			});

		</script>
	</section>
</body>
</html>