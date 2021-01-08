<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/smartedit/js/service/HuskyEZCreator.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
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
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<section>
		<form action="insert.re" id="write-book" method="post" enctype="multipart/form-data" >
			<div class="title-div">
				<div class="title">title</div>
				<input type="text" name="bTitle" placeholder="제목을 작성하세요">
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
					<input name="wise" type="text" placeholder="명언을 작성해주세요">
					<img src="resources/images/bookreview/quote3.png">
				</div>
				<div class="tag-div">
					<p class="tag">#</p><input type="text" class="bookInfo" name="booktitle" placeholder="책제목">
					<p class="tag">#</p><input type="text" class="bookInfo" name="author" placeholder="작가">
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
		</script>
	</section>
</body>
</html>