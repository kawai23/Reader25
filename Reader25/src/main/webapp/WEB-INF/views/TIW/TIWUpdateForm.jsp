<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<script src="<%=request.getContextPath()%>/smartedit/js/service/HuskyEZCreator.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />


<style>
/*화면*/
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		min-width: 1000px;
		padding-top: 15px;
		background-color:  #F6F6F6; display: inline-block;
		font-family: 카페24 아네모네에어; font-size:17px;
	}
/*글자*/
input{font-family: 카페24 아네모네에어; font-size:17px;}
select{font-family: 카페24 아네모네에어; font-size:17px;}
.txt_TIW{
	font-size:40px;
	font-family: 카페24 아네모네;
	text-align: center;
}
/*버튼*/
#submit-btn {
	width:100px;
    height: 40px;
	font-size: 18px; color:#fff;
	border: 1px solid  #FFC398;
    background-color:  #FFC398;
    font-family: 카페24 아네모네에어;
}
#btn2{
	width:100px;
    height: 40px;
	font-size: 18px; color:#000000;
	border: 1px solid  #C4C4C4;
    background-color:  #C4C4C4;
    font-family: 카페24 아네모네에어;
}
.title-div {
	clear: both;
	width: 80%;
	max-width: 1100px;
	margin: auto;
	margin-top: 10px;
	padding: 0;
}

.title, .cate {
	display: inline-block;
	background: rgba(235, 235, 235, 1);
	text-align: center;
	vertical-align: middle;
	width: 80px;
	height: 27px;
	border: 1px solid rgba(235, 235, 235, 1);
	border-radius: 3px 0px 0px 3px;
	color: rgba(85, 83, 83, 1);
}

.title-div>input {
	height: 25px;
	margin-left: -7px;
	width: 60%;
	border: 1px solid rgba(235, 235, 235, 1);
}
.title-div>select{
		height: 29px;
		border:  1px solid rgba(235, 235, 235, 1);
		margin-left: -6px;
		color: rgba(85, 83, 83, 1);		
	}
#book{
		height: 29px; width: 230px;
		border:  1px solid rgba(235, 235, 235, 1);
		margin-left: -6px;
		color: rgba(85, 83, 83, 1);	
}
.writer {
	display: inline-block;
	background: rgba(235, 235, 235, 1);
	text-align: center;
	vertical-align: middle;
	width: 80px;
	height: 27px;
	border: 1px solid rgba(235, 235, 235, 1);
	border-radius: 3px 0px 0px 3px;
	color: rgba(85, 83, 83, 1);
	 margin-left: 10%;
}
.writer-div>input {
	height: 25px;
	margin-left: -7px;
	width: 20%;
	border: 1px solid rgba(235, 235, 235, 1);
}
.contents{
	width: 80%;
	margin: auto;
	margin-top: 20px;
	max-width: 1100px;
	min-height: 500px;
}

.content-edit{
		width: 80%;
		margin:auto;
		margin-top: 20px;
		min-height: 300px;
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

.modal-close, .modal-accept {
	background-color: rgba(137, 18, 18, 1);
	color: white;
	width: 80px;
	height: 30px;
	border: none;
	display: inline-block;
	left: 40%;
}

.modal-accept {
	background-color: rgba(85, 83, 83, 1);
}

.modal p {
	display: inline-block;
}

.modal img {
	position: relative;
	top: 10px;
}
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
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
				location.href = "javascript:history.go(-1)";
			});
		});
	</script>
	
	<div class="outer">
	
		<form id="TIW_form" method="post" enctype="Multipart/form-data" action="TIWupdate.to">
	
			<h2 class="txt_TIW" align="center">오늘은 나도 작가</h2>
			
			<div class="title-div">
				<div class="title">title</div>
				<input type="text" name="bTitle" id="title" value="${ board.bTitle }">
				<input type="hidden" name="page" value="${ page }">
				<input type="hidden" name="boardNo" value="${ board.boardNo }">
			</div>
			<br>
			<div class="title-div">
				<div class="cate">카테고리</div>
				<select name="code1">
					<option selected="selected">분류</option>
					<option>총류</option>
					<option>철학</option>
					<option>종교</option>
					<option>사회 과학</option>
					<option>자연 과학</option>
					<option>기술 과학</option>
					<option>예술</option>
					<option>언어</option>
					<option>문학</option>
					<option>역사</option>
				</select>
				<input type="text" name="code2" id="code2" value="${ board.code }">
			</div>
			<br>
			<div class="writer-div">
				<div class="writer">작가</div>
				<input type="text" name="userId" id="writer" readonly value="${ board.userId }">
			</div>
			<br>
			<div class="content-edit" style="text-align:center;">
					<textarea name="bContent"id="smart_edit" style="width:70%;">${ board.bContent }</textarea>
				</div>
			<br><br>
			
			<div class="btn-div" align="center">
				<button type="submit" id="submit-btn">작성완료</button>
				<input type="reset" id="btn2" value="작성취소">
				
			</div>
			<br><br>
		
		</form>
	
	</div>
	<script>
			var fileCheck = false;
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
				
				$('#write-book').submit();
			});
			$('#file-img').click(function(){
				$('#input-file')[0].click();
			});
			
			function loadImg(value) {
				if (value.files[0]) {
					var reader = new FileReader();
					fileCheck = true;
					reader.onload = function(e) {
 						$('#load-img').attr('src', e.target.result);
					}
					reader.readAsDataURL(value.files[0]);
				}
			}
			
			$('#submit-btn').click(function(){
				oEditors.getById["smart_edit"].exec("UPDATE_CONTENTS_FIELD",[]);

				// validate 검증하기
				 var title = $('#title').val()
				 var bname = $('#code2').val()
				 
				 if(title == ""){
					 event.preventDefault();
					 this.blur();
					 $('#t-modal').show();
					 $('#t-modal .modal').show();
					return false;
				} else if(bname == ""){
					event.preventDefault();
					 this.blur();
					 $('#b-modal').show();
					 $('#b-modal .modal').show();
					return false;
				} else{
					$('#TIW_form').submit();
				}
			});
			
			$(function(){
				$('#btn2').click(function(){
					event.preventDefault();
					$('#c-modal').show();
					$('#c-modal .modal').show();
				});
			});
		</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>