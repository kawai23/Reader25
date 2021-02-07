<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
  		border: 1px solid rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  		font-family: 카페24 아네모네에어;
  		background: #F6F6F6;
  	}
  	pre{font-family: 카페24 아네모네에어;line-height:170%}
  	#first{
  		text-align: center;
  	}
  	#title{margin:auto; text-align: center; width: 80%;}
  	b{font-size:45px;}
  	#info{
  		margin:auto;
  		padding:5px;
  		width: 80%;
  		background: #F5715C;
  		font-size:20px;
  		color: white;
  	}
  	.head{margin:auto; text-align: center; width: 80%;}
  	.body{margin:auto; width: 80%;}
  	.dradio{margin-left: 50px;}
  	button{font-family: 카페24 아네모네에어;font-size: 20px;}
  	.btn{
  		width:150px;
  		height:50px;
  		float: right;
  		margin: 5px;
  	}
  	#btn1{background: #FFC398; color:white;}
  	#btn2{background: #67492C; color:white;}
  	#btn3{margin: 5px; float: right; color:white; background: #C95F12; font-size:16px;}
  	#load-img{wdith:713px; height:427px;}
  	hr{border: 2px solid #F5715C}
  	#contentP{font-size:20px;}
  	.Argument{
  		background: #FFC398;
  		width:100%;
  		min-height:100px;
  	}
  	#stime{float:right;}
   	ol{list-style: none;}
  	.Atext{float:left; margin-right: 20px; max-width:890px;}
  	#text{background: white; border: 1px solid black; width:85%; border-radius: 5px; padding: 10px;}
  	#user-icon{wdith:50px; height:50px; border-radius:10%;}
  	.wid{width:98%; margin: 3px;}
  	.wid2{width:98%; margin: 3px; border:none;}
  	.rBtn1{float: right; margin: 3px; color: white; background: #FFC398;}
  	.rBtn2{float: right; margin: 3px; color: white; background: #67492C;}
  	.comment-box{
		margin:auto;
		margin-top:10px;
		padding-bottom: 40px;
	}
	.comment-write{
		border: 1px solid rgb(200, 200, 200);
		background: white;
		height: 230px;
	}
	#area1{height: 130px;}
	select{font-family: 카페24 아네모네에어;}
	.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
		font-family: 카페24 아네모네에어;
		font-size:17px;
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
			background: rgba(0, 0, 0, 0.3); 
			font-family: 카페24 아네모네에어; font-size:17px;
	}
	.modal-close, .modal-close-r{
		background-color: #C4C4C4;
		color:white; width: 80px;
		height: 30px; border:none;
		display:inline-block; 
		font-family: 카페24 아네모네에어; font-size:17px;
	}
	.modal-content{text-align: center;}
	.modal p{
			display:inline-block;
	}
	.modal img{
			position:relative;
			top: 10px;
	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
</head>
<body>
	<div class="modal-back" id="delete-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p> 정말로 토론방을 끝내겠습니까? </p>
				<br>
				<button class="modal-close-r" id="success">확인</button>
				<button class="modal-close" id="cancel">취소</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="delete2-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p> 정말로 댓글을 끝내겠습니까? </p>
				<br>
				<button class="modal-close-r" id="success2">확인</button>
				<button class="modal-close" id="cancel2">취소</button>
			</div>
		</div>
	</div>
	<%@ include file="../common/menubar.jsp" %>
	<section>
		<br>
		<div id="title">
			<b>${d.getdTitle()}</b>
		</div>
		<c:if test="${d.dStatus=='N' }"><br>
			<div class="head" id="info">
				토론이 끝난 주제로 댓글을 작성할수 없습니다.
			</div>
		</c:if>
		<c:if test="${d.dStatus=='Y' }"><br>
			<div class="head" id="info">
				의견을 내주시면 감사하겠습니다. 글을 읽어본 뒤 <br>
				찬성인지 반대인지 아래를 클릭하여 선택 후 자신의 주장을 펼치시면 됩니다!
			</div>
			<div class="head">
				<input type="radio"  name="discuss" value="찬성"> 찬성
				<input type="radio" class="dradio" name="discuss" value="중립" checked> 중립
				<input type="radio" class="dradio" name="discuss" value="반대"> 반대
			</div>
		</c:if>
		<br>
		<div class="head">
			<c:if test="${ d.atcNo == at.atcNo }">
				<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at.atcName }" id="load-img"/>
			</c:if>
			<c:if test="${ d.atcNo != at.atcNo }">
				<img src="<%=request.getContextPath() %>/resources/images/img/discuss.jpg" id="load-img"/>
			</c:if>
		</div><br><br>
		<div class="body">
		<h2>토론주제</h2>
		<hr>
		<p id="contentP">${d.dContent}</p>
		
		<c:url var="dupdate" value="dUpdateForm.di">
			<c:param name="dNo" value="${d.dNo}"/>
			<c:param name="page" value="${ page }"/>
		</c:url>
		<c:url var="dDelete" value="dDelete.di">
			<c:param name="dNo" value="${d.dNo}"/>
		</c:url>
		<c:if test="${ d.dWriter eq loginUser.id  && d.dStatus=='Y'}">
			<button class="btn" id="btn1" onclick="location.href='${ dupdate }'">토론방 수정</button>
			<button class="btn" id="btn2" onclick="javascript:ddelete();">토론방 끝내기</button>
		</c:if>
		<br><br>
		<h2>주장</h2>
		<hr>
		<div class="Argument">
			<select id="stime">
				<option value="1" selected>오래된순</option>
				<option value="2">최신순</option>
			</select><br>
			<ol id="rol"><!-- 댓글달릴부분 -->
			</ol>
		</div>
		<c:if test="${d.dStatus == 'Y' }">
			<div class="comment-box">
				<div class="comment-write">
					<select class="wid" id="dis">
						<option value="P">찬성</option>
						<option selected value="N">중립</option>
						<option value="C">반대</option>
					</select><br>
					<c:if test="${ !empty loginUser }">
						<input type="text" class="wid2" id="id" readonly value="${loginUser.id }"><br>
					</c:if>
					<c:if test="${ empty loginUser }">
						<input type="text" class="wid2" id="id" readonly value="로그인이 필요한 기능입니다."><br>
					</c:if>
					<textarea id="area1" class="wid2" placeholder="주장을 작성해주세요"></textarea><br>
					<button id="btn3">작성하기</button>
				</div>
			</div>
		</c:if>
		</div>
		<script>	
			// 라디오버튼으로 댓글작성시 찬성,중립,반대 자동으로 체크
			$("input:radio[name=discuss]").click(function(){
				var discuss = $("input[name=discuss]:checked").val();
				if(discuss == '찬성'){
					$('#dis').val("P").prop("selected", true);
				} else if(discuss== '반대'){
					$('#dis').val("C").prop("selected", true);
				} else{
					$('#dis').val("N").prop("selected", true);
				}
			});
			//페이지 로드 후 바로 댓글리스트 가져온다.
			$(function(){
				getRList();
			});
			// 최신, 오래된 선택시
			$('#stime').on('change', function(){
				getRList();
			});
			// 댓글 작성하기
			$('#btn3').click(function(){
				var id = $('#id').val();
				var content = $('#area1').val();
				var dNo = ${d.dNo};
				var dis = $('#dis option:selected').val();
				if(${empty loginUser}){
					alert("로그인이 필요한 기능입니다.");
				} else{
					$.ajax({
						url: 'addReply.di',
						data: {rContent:content, rWriter:id, rWhether:dis, dNo:dNo},
						success: function(data){
							$('#area1').val('');
							getRList();
						}
					});
				}
			});
			// 댓글 리스트 불러오기
			function getRList(){
				var dNo = ${d.dNo};
				var cho = $('#stime').val();
				$.ajax({
					url:"rList.di",
					data: {dNo:dNo, cho:cho},
					success: function(data){
						$olBody = $('#rol');
						$olBody.html('');
						var $li;
						var $div1;
						var $img;
						var $div2;
						var $div2_1;
						var $id;
						var $rContent;
						var $div3;

						var $btn1;
						var $btn2;
						if(data.length > 0){
							for(var i in data){
								$li = $('<li id="comment-'+ data[i].rNo +'">');
								$div1 = $('<div class="Atext">');
								$img = $('<img src="<%=request.getContextPath() %>/resources/images/rank/rank'+data[i].rank+'.png" id="user-icon">');
								$rContent = $('<pre>').text(data[i].rContent);
								$div2 = $('<div class="Atext" id="text">');
								$div2_1 = $('<div id="div-'+ data[i].rNo +'">');
								$div3 = $('<div style="clear:both;"><br>');

								$btn1 = $('<button class="rBtn1" value="'+data[i].dNo+'" onclick="rUpdateFrom('+ data[i].rNo+');">').text("수정하기");
								$btn2 = $('<button class="rBtn2" onclick="rDelete('+ data[i].rNo+');">').text("삭제하기");
								
								if(data[i].rWhether == 'C'){
									$id = $('<h3>').html(data[i].rWriter + " 님의 <span>반대</span> 의견");
									$div1.append($img);
									$div2.append($id);
									$div2.append('<hr style="border: 1px solid #F5715C;">');
									$div2.append($rContent);

									if('${loginUser.id}' == data[i].rWriter){
										$div2.append($btn1);
										$div2.append($btn2);
									}
									$div2_1.append($div2);
									
									$li.append($div2_1);
									$li.append($div1);
									$li.append($div3);
									$olBody.append($li);
								} else {
									if(data[i].rWhether == 'P'){
										$id = $('<h3>').html(data[i].rWriter + " 님의 <span>찬성</span> 의견");
									}else{
										$id = $('<h3>').html(data[i].rWriter + " 님의 <span>중립</span> 의견");
									}
									$div1.append($img);
									$div2.append($id);
									$div2.append('<hr style="border: 1px solid #F5715C;">');
									$div2.append($rContent);
									
									if('${loginUser.id}' == data[i].rWriter){
										$div2.append($btn1);
										$div2.append($btn2);
									}
									$div2_1.append($div2);
									
									$li.append($div1);
									$li.append($div2_1);
									$li.append($div3);
									$olBody.append($li);
								}
							}
						} else{
							$li = $('<li>');
							$div1 = $('<div class="Atext">').text('등록된 댓글이 없습니다.');
							$li.append($div1);
							$olBody.append($li);
						}
					}
				});
			}
			//버튼 클릭 css
			$('.btn').mouseenter(function(){
				$(this).css({'cursor':'pointer'});
			});
			
			$('.rBtn1').mouseenter(function(){
				$(this).css({'cursor':'pointer'});
			});

			var dup = 0;
			// 댓글 수정 폼 생성
			function rUpdateFrom(rNo){
				if(dup == 0){
					dup = rNo;
				var PCN = $('#div-'+rNo).children().children().children().text();
				$div = $('#div-'+rNo);
				
				var $rid = $('<input type="text" class="wid" readonly>').val('${loginUser.id}');
				var $tarea = $('<textarea id="area-'+rNo+'" class="wid"- rows="10" cols="55"><br>').val($div.children().children().eq(2).text());
				var $dselect = $('<select class="wid" id="select-'+rNo+'">');
				var $option1 = $('<option value="P">').text("찬성");
				var $option2 = $('<option value="N">').text("중립");
				var $option3 = $('<option value="C">').text("반대");
				var $closeBtn = $('<button class="rBtn2" onclick="Reclose();">').text("취소");
				var PCN2 = 1;
				var $div1 = $div.children().eq(0);
				
				if(PCN == '반대'){
					$option3 = $('<option value="C" selected>').text("반대");
				} else{
					if(PCN == '찬성'){
						$option1 = $('<option value="P" selected>').text("찬성");
						PCN2 = 0;
					} else{
						$option2 = $('<option value="N" selected>').text("중립");
						PCN2 = 2;
					}
				}
				var $commitBtn = $('<button class="rBtn1" onclick="rUpdate('+ rNo +','+PCN2+');">').text("등록하기");
				$div.children().children().eq(0).remove();
				$div.children().children().eq(0).remove();
				$div.children().children().eq(0).remove();
				$div.children().children().eq(0).remove();
				$div.children().children().eq(0).remove();

				$dselect.append($option1);
				$dselect.append($option2);
				$dselect.append($option3);

				$div1.append($rid);
				$div1.append($dselect);
				$div1.append($tarea);
				$div1.append($commitBtn);
				$div1.append($closeBtn);
				$div.append($div1);
				} else {
					getRList(); 
					dup = 0;
					setTimeout(function() { rUpdateFrom(rNo);}, 10);
				}
			}
			
			// 댓글 수정
			function rUpdate(rNo, PCN){
				dup = 0;
				var rWriter = '${loginUser.id}';
				var rContent = $('#area-'+rNo).val();
				var rWhether = $('#select-'+rNo).val();
				var check = "패스";
				var dNo = ${d.dNo};
				if(PCN == 0){
					if(!(rWhether == 'P')){
						check="찬성";
					}
				} else if(PCN == 1){
					if(!(rWhether == 'C')){
						check="반대";
					}
				} else if(PCN == 2){
					if(!(rWhether == 'N')){
						check="중립";
					}
				}
				$.ajax({
					url: "rUpdate.di",
					data: {rNo:rNo, rWriter:rWriter, rContent:rContent, rWhether:rWhether, check:check, dNo:dNo},
					success: function(data){
						getRList();
					}
				});
				
			}
			
			// 댓글 수정 취소
			function Reclose(){
				dup = 0;
				getRList();
			}

			// 댓글 삭제
			var REPLY = 0;
			function rDelete(rNo){
				$('#delete2-modal').show();
				$('#delete2-modal .modal').show();
				REPLY = rNo;
			}
			$('#success2').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
				var PCN = $('#comment-'+REPLY).children().children().children().children().eq(0).text();
				var dNo = $('#comment-'+REPLY).children().children().children().eq(3).val();
				$.ajax({
					url: 'rDelete.di',
					data:{rNo:REPLY, rWhether: PCN, dNo: dNo},
					success: function(data){
						if(data == "success"){
							getRList();
						}
					}
				});
			});
			
			// 토론방 삭제
			function ddelete(){
				$('#delete-modal').show();
				$('#delete-modal .modal').show();
			}
			$('.modal-close').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
			});
			$('#success').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
				location.href="${dDelete}";
			});
			
		</script>
	</section>
	<%@include file="../common/footer.jsp" %>
</body>
</html>