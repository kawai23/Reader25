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
  	font-family: 카페24 아네모네에어;	
  		background:rgba(246, 246, 246, 1);
  		border: 1px solid rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  	}
	input{font-family: 카페24 아네모네에어;	}
	h1{font-family: 카페24 아네모네;font-size:40px;}
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
	.title-div>select{
		height: 32px;
		width: 190px;
		border:  1px solid rgba(235, 235, 235, 1);
		margin-left: -6px;
		color: rgba(85, 83, 83, 1);		
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
	button{font-family: 카페24 아네모네에어;	}
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
		<form action="dUpdate.di" id="write-discuss" method="post" enctype="multipart/form-data">
			<div class="title-div">
				<h1>토론방 수정</h1>
				<input type="text" id="dTitle" name="dTitle" value="${ d.dTitle }"><br>
				<input type="hidden" name="page" value="${ page }">
				<input type="hidden" name="dNo" value="${ d.dNo }">
				<input type="hidden" name="atcNo" value="${ d.atcNo }">
				<input type="hidden" name="atcName" value="${ at.atcName }">
				<input type="file" id="input-file" name="reloadFile" onchange="loadImg(this);" accept="image/jpg, image/jpeg, image/png">
				<c:if test="${ d.atcNo == 0 }">
					현재 업로드 된 참부파일 :<span id="s"> 없음 </span>
				</c:if>
				<c:if test="${ d.atcNo != 0 }">
					현재 업로드 된 첨부파일 :<span id="s"> ${ at.atcName }</span>
				</c:if>
			</div>
			<div class="file-div">
				<div class="file-img" id="file-img">
					<c:if test="${ d.atcNo == 0 }">
						<img src="#" id="load-img" >
					</c:if>
					<c:if test="${ d.atcNo != 0 }">
						<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at.atcName }" id="load-img" >
					</c:if>
				</div>
			</div>
			<div class="content">
				<div class="content-edit">
					<textarea name="dContent" id="smart_edit">${d.dContent }</textarea>
				</div>
				<div style="text-align:right; width:90%; padding:0;">
					<input type="button"class="btn" id="btn3" onclick="history.back(-1);" value="토론방 취소">
					<input type="button" class="btn" id="btn2" value="토론방 수정">
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
			$('#btn2').click(function(){
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