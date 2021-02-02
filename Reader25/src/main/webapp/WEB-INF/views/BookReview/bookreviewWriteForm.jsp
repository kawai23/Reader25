<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/smartedit/js/service/HuskyEZCreator.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
  	section{
  		background:rgba(246, 246, 246, 1);
  		border: 1px solid rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  	}
	.title-div{
		width: 80%;
		margin: auto;
		margin-top: 10px;
		padding: 0;
	}
	.title{
		display:inline-block;
		background: rgba(235, 235, 235, 1);
		text-align: center;
		vertical-align:middle;
		width: 50px;
		height: 27px;
		border: 1px solid rgba(235, 235, 235, 1);
		border-radius: 3px 0px 0px 3px;
		color: rgba(85, 83, 83, 1);
	}
	.title-div>input{
		height: 25px;
		margin-left: -7px;
		width: 75%;
		border:  1px solid rgba(235, 235, 235, 1);
	}
	.title-div>select{
		height: 29px;
		border:  1px solid rgba(235, 235, 235, 1);
		margin-left: -6px;
		color: rgba(85, 83, 83, 1);		
	}
	.content{
		margin-top: 30px;
	}
	.file-div{
		width: 300px;
		margin:auto;
	}
	.file-img{
		height: 250px;
		line-height:250px;
		margin-top: 20px;
		background: lightgray;
		text-align: center;
	}
	input:focus{outline: 1px solid lightgray;}
	.file-img>img{
		max-height:100%;
		max-width: 100%;
		object-fit: cover;
		vertical-align: middle;
	}
	#input-file{
		border: 1px solid lightgray;
	}
	#file-img:hover{
		background: LightSalmon;
	}
	.tag{display:inline; color:rgba(245, 113, 92, 1);}
	.bookInfo{
		background: none;
 		border: none; 
	}
	.tag-div{
		height: 40px; 
		width: 400px; 
		margin:auto;
		margin-top: 10px;
	}
	.wise-div{
		width: 300px;
		margin: auto;
		margin-top: 10px;
		height: 40px;
		vertical-align: middle;
	}
	.wise-div>img{
		width: 40px;
	}
	.wise-div>input{
		background: none;
		position: relative;
		top:-15px;
		width: 190px;
		border: none;
		text-align: center;
	}
	.content-edit{
		width: 80%;
		margin:auto;
		margin-top: 20px;
		min-height: 300px;
	}
	.btn{
		width: 250px;
		height: 40px;
		margin: auto;
		margin-bottom: 20px;
		margin-top: 20px;
	}
	#submit-btn{
		width: 100%;
		height: 100%;
		color: white;
		background: rgba(85, 83, 83, 1);
		font-size: 18px;
	}
	#submit-btn:hover{
		background: rgba(75, 73, 73, 1);
		font-weight: bolder;
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
				<br>
				<button class="modal-close" value="Close">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="c-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>내용을 입력해 주세요</p>
				<br>
				<button class="modal-close" value="Close">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="book-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>책 제목, 작가, 명언을 입력하지 않으십니까??</p>
				<br>
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
				$('#write-book').submit();
			});
		});
	</script>
	<section>
		<form action="insert.re" id="write-book" method="post" enctype="multipart/form-data" >
			<div class="title-div">
				<div class="title">title</div>
				<input type="text" name="bTitle" id="bTitle" placeholder="제목을 작성하세요">
				<select name="cate">
					<option selected="selected" value="null">분류</option>
					<option value="총류">총류</option>
					<option value="철학">철학</option>
					<option value="종교">종교</option>
					<option value="사회과학">사회 과학</option>
					<option value="자연과학">자연 과학</option>
					<option value="기술과학">기술 과학</option>
					<option value="예술">예술</option>
					<option value="언어">언어</option>
					<option value="문학">문학</option>
					<option value="역사">역사</option>
				</select>
			</div>
			<div class="content">
				<div class="file-div">
					<input type="file" id="input-file" name="uploadFile" onchange="loadImg(this);" accept="image/jpg, image/jpeg, image/png">
					<div class="file-img" id="file-img">
						<img id="load-img" >
					</div>
				</div>
				<div class="wise-div">
					<img src="resources/images/bookreview/quote4.png">
					<input name="wise" type="text" id="wise"placeholder="명언을 작성해주세요" maxlength="50">
					<img src="resources/images/bookreview/quote3.png">
				</div>
				<div class="tag-div">
					<p class="tag">#</p><input type="text" class="bookInfo" name="booktitle" id="booktitle" placeholder="책제목">
					<p class="tag">#</p><input type="text" class="bookInfo" name="author" id="author" placeholder="작가">
				</div>
				<div class="content-edit" style="text-align:center;">
					<textarea name="bContent" id="smart_edit" style="width:100%;"></textarea>
				</div>
			</div>
			<div class="btn">
				<button id="submit-btn">등록하기</button>
			</div>
		</form>
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
				title = $('#bTitle').val();
				content = $('#smart_edit').val();
				booktitle = $('#booktitle').val();
				author = $('#author').val();
				wise = $('#wise').val();
				if(title == ''){
					event.preventDefault();
					this.blur();
					$('#t-modal').show();
					$('#t-modal .modal').show();
					return false;
				}else if(content == '<p><br></p>'){
					event.preventDefault();
					this.blur();
					$('#c-modal').show();
					$('#c-modal .modal').show();
				}else if(booktitle == ''|| wise == '' || author == ''){
					event.preventDefault();
					this.blur();
					$('#book-modal').show();
					$('#book-modal .modal').show();
				}else{
					$('#write-book').submit();
				}
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
					reader.readAsDataURL(value.files[0]);j
				}
			}
		</script>
	</section>
</body>
</html>