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
	#dTitle{
		height: 32px;
		margin-left: -7px;
		width: 100%;
		border:  1px solid rgba(235, 235, 235, 1);
	}
	.file-div{
		width: 300px;
		margin:auto;
	}
	.file-img{
		min-height: 250px;
		margin-top: 20px;
/* 		background: lightgray; */
		text-align: center;
		position: relative;
	}
	#input-file{border: 1px solid lightgray;}
	#load-img{width: 300px;}
	.content{
		margin-top: 30px;
	}
	.content-edit{
		width: 80%;
		margin:auto;
		margin-top: 20px;
		min-height: 300px;
		text-align:center;
	}
	#smart_edit{
		width:99%;
		min-height:600px;
		background: white;
		color: black;
	}
	.btn{
		width: 165px;
		height: 40px;
		margin-bottom: 20px;
		margin-top: 20px;
		font-size: 25px;
	}
	.btn0{
		width: 110px;
		height: 32px;
		padding: 5px;
		background: #C95F12;
	}
	#btn1{background: #C95F12;}
	#btn2{background: #FFC398;}
	#btn3{background: #67492C;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<section>
		<form action="discussInsert.di" id="write-discuss" method="post" enctype="multipart/form-data">
			<div class="title-div">
				<h1>토론방 열기</h1>
				<input type="text" id="dTitle" name="dTitle" placeholder="제목을 작성하세요"><br>
				<input type="file" id="input-file" name="uploadFile" onchange="loadImg(this);" 
				accept="image/jpg, image/jpeg, image/png">
			</div>
<!-- 			<div class="file-div"> -->
<!-- 				<div class="file-img" id="file-img"> -->
<!-- 					<img src="#" id="load-img" > -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 				<span class="btn0" id="spanbtn">이미지 추가</span> -->
			<div class="content">
				<div class="content-edit">
					<textarea name="dContent" id="smart_edit"></textarea>
				</div>
				<div style="text-align:right; width:90%; padding:0;">
					<input type="button"class="btn" id="btn3" onclick="history.back(-1);" value="토론방 취소">
					<input type="button" class="btn" id="btn1" value="토론방 열기">
				</div>
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
			$('#btn1').click(function(){
				oEditors.getById["smart_edit"].exec("UPDATE_CONTENTS_FIELD",[]);
				
				$('#write-discuss').submit();
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