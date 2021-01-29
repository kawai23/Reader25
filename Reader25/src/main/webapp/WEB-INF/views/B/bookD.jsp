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
	input:focus{outline:none;}
	.content{
		min-width: 1000px;
		width: 80%;
		margin-top: 30px;
		margin:auto;
	}
	#input-file{margin-left: 20%;margin-top: 20px;}
	.file-div{
		min-width: 300px;
		margin:auto;
	}
	.file-upload{
		min-height: 250px;
		line-height:250px;
		margin-top: 20px;
		text-align: center;
		width: 60%;
		margin:auto;
	} 
	.image-box {
		border: 3px solid rgba(246, 246, 246, 1);
		display: inline-block;
		text-align: center;
		min-width: 200px;
		min-height: 200px;
		line-height: 200px;
		background: rgba(235, 235, 235, 1);
	}
	.image-box img {
		display:inline-block;
		max-height: 200px;
		max-width: 200px;
		vertical-align: middle;
		text-align: center;
	}
	#input-file{
		border: 1px solid lightgray;
	}
	.file-upload:hover{
		background: lightgray;
	}
	.book-box{
		min-height: 130px; 
		margin:auto;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	.book-table{
		width: 60%; margin:auto;
		border-left: 2px solid rgb(200, 200, 200);
		padding-left: 12px;
	}
	.book-table tr{ height: 40px; margin-top: 10px;}
	.book-table td{ width: 100px;}
	.book-input{width: 400px;height: 30px; border: none;}
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
	.cofirm-info{
		width: 80%;
		margin:auto;
		margin-top: 20px;
	}
	.confirm-content{
		padding-left: 20px;
		color:red;
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
				<button class="modal-close" value="bTitle">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="c-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>내용을 입력해 주세요</p>
				<br>
				<button class="modal-close" value="submit-btn">Close</button>
			</div>
		</div>
	</div>
		<div class="modal-back" id="b-title-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>책 제목을 입력해 주세요</p>
				<br>
				<button class="modal-close" value="booktitle">Close</button>
			</div>
		</div>
	</div>
		<div class="modal-back" id="b-author-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>작가를 입력해 주세요</p>
				<br>
				<button class="modal-close" value="author">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="b-publisher-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>출판사를 입력해 주세요</p>
				<br>
				<button class="modal-close" value="publisher">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="b-price-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>금액를 입력해 주세요</p>
				<br>
				<button class="modal-close" value="price">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="b-amount-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>수량은 최소 1개 부터 등록 가능합니다</p>
				<br>
				<button class="modal-close" value="amount">Close</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="info-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>상기 내용을 확인해 주세요</p>
				<br>
				<button class="modal-close" value="confirm-check">Close</button>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('.modal-close').click(function(){
				var num = $(this).val();
				console.log(num);
				$('.modal').hide();
				$('.modal-back').hide();
				document.getElementById(num).focus();
			});
			$('.modal-accept').click(function(){
				$('#write-book').submit();
			});
		});
	</script>
	<section>
		<form action="insert.bo" id="write-book" method="post" enctype="multipart/form-data" >
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
						<input type="file" id="input-file" name="uploadFile" onchange="loadImg(this);" accept="image/jpg, image/jpeg, image/png" multiple="multiple">
						<div class="file-upload">
					</div>
				</div>
				
				<div class="book-box">
					<table class="book-table">
					<tr>
						<td>책 제목 </td>
						<td><input type="text" class="book-input" name="b_name" id="booktitle" placeholder="책제목을 입력하세요"></td>
					</tr>
					<tr>
						<td>작가</td>
						<td><input type="text" class="book-input" name="author" id="author" placeholder="작가를 입력하세요"></td>
					</tr>
					<tr>
						<td>출판사</td>
						<td><input type="text" class="book-input" name="b_Q2" id="publisher" placeholder="출판사를 입력하세요"></td>
					</tr>
					<tr>
						<td>금액</td>
						<td><input type="number" class="book-input" name="b_price" id="price" placeholder="금액을 입력하세요" min="0"></td>
					</tr>
					<tr>
						<td>수량</td>
						<td><input type="number" class="book-input" name="b_Q1" id="amount" value="1" min="1"></td>
					</tr>
					</table>
				</div>
				<div class="content-edit" style="text-align:center;">
					<textarea name="bContent" id="smart_edit" style="width:100%;"></textarea>
				</div>
			</div>
			<div class="cofirm-info">
				<div class="confirm-content">구매자가 해당 제품 선택 시 판매자 해당 이메일로 내용이 전송됩니다. 상기 내용에 확인하셔야 등록이 가능합니다.</div>
				<input type="checkbox" id="confirm-check"> 위 내용을 확인하였습니다.
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
				publisher = $('#publisher').val();
				amount = $('#amount').val();
				price = $('#price').val();
				amount = $('#amount').val();
				if(title == ''){
					event.preventDefault();
					this.blur();
					$('#t-modal').show();
					$('#t-modal .modal').show();
				}else if(content == '<p><br></p>'){
					event.preventDefault();
					this.blur();
					$('#c-modal').show();
					$('#c-modal .modal').show();
				}else if(booktitle == ''){
					event.preventDefault();
					this.blur();
					$('#b-title-modal').show();
					$('#b-title-modal .modal').show();
				}else if(author == ''){
					event.preventDefault();
					this.blur();
					$('#b-author-modal').show();
					$('#b-author-modal .modal').show();
				}else if(publisher == ''){
					event.preventDefault();
					this.blur();
					$('#b-publisher-modal').show();
					$('#b-publisher-modal .modal').show();
				}else if(price == ''){
					event.preventDefault();
					this.blur();
					$('#b-price-modal').show();
					$('#b-price-modal .modal').show();
				}else if(amount < 1){
					event.preventDefault();
					this.blur();
					$('#b-amount-modal').show();
					$('#b-amount-modal .modal').show();
				}else if($('#confirm-check').is(":checked")!= true){
					event.preventDefault();
					this.blur();
					$('#info-modal').show();
					$('#info-modal .modal').show();
				}else{
					$('#write-book').submit();
				}
			});
			$('.file-upload').click(function(){
				$('#input-file').click();
			});
			function loadImg(value) {
				if (value.files) {
					$uploadImage = $('.file-upload')
					$uploadImage.html('')
					for(var i = 0; i < value.files.length; i++){
						var reader = new FileReader();
						reader.onload = function(e) {
							$imgBox = $('<div class="image-box">');
							$img = $('<img>').attr('src', e.target.result);
							$imgBox.append($img);
							$uploadImage.append($imgBox);
						}
						reader.readAsDataURL(value.files[i]);
					}
				}
			}
		</script>
	</section>
</body>
</html>