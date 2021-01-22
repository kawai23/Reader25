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
  	}
  	#first{
  		text-align: center;
  	}
  	#title{text-align: center;}
  	b{font-size:60px;}
  	#info{
  		width: 100%;
  		background: #F5715C;
  		font-size:20px;
  		text-align: center;
  	}
  	.head{text-align: center;}
  	.dradio{margin-left: 50px;}
  	.btn{
  		width:100px;
  		height:50px;
  		float: right;
  		margin: 5px;
  	}
  	#btn1{background: #FFC398;}
  	#btn2{background: #67492C;}
  	#btn3{background: #C95F12;}
  	#load-img{wdith:713px; height:427px;}
  	hr{border: 2px solid #F5715C}
  	p{font-size:20px;}
  	.Argument{
  		background: #FFC398;
  		width:100%;
  		min-height:100px;
  	}
  	#stime{float:right;}
   	ol{list-style: none;}
  	.Atext{float:left; margin-right: 20px;}
  	#text{background: white; border: 1px solid black; width:85%;}
  	#user-icon{wdith:50px; height:50px; border-radius:50%;}
  	.wid{width:99%; margin: 3px;}
  	.rBtn1{float: right; margin: 3px;background: #FFC398;}
  	.rBtn2{float: right; margin: 3px;background: #67492C;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<br><br>
	<section>
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
				의견을 내주시면 감사하겠습니다. 글을 읽어본 뒤 찬성인지 반대인지 아래를 클릭하여 선택 후 자신의 주장을 펼치시면 됩니다!
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
				<img src="<%=request.getContextPath() %>/resources/images/bookreview/book.jpg" id="load-img"/>
			</c:if>
		</div><br><br>
		<h2>토론주제</h2>
		<hr>
		<p>${d.dContent}</p>
		
		<c:url var="dupdate" value="dUpdateForm.di">
			<c:param name="dNo" value="${d.dNo}"/>
			<c:param name="page" value="${ page }"/>
		</c:url>
		<c:url var="dDelete" value="dDelete.di">
			<c:param name="dNo" value="${d.dNo}"/>
		</c:url>
		<c:if test="${ d.dWriter eq loginUser.id }">
			<button class="btn" id="btn1" onclick="location.href='${ dupdate }'">토론방 수정</button>
			<button class="btn" id="btn2" onclick="javascript:ddelete();">토론방 끝내기</button>
		</c:if>	
		<script>
			function ddelete(){
				var check = confirm("정말로 토론방을 끝내갰습니까?");
				if(check){
					location.href="${dDelete}";
				}
			}
		</script>
		<br><Br>
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
		<select class="wid" id="dis">
			<option selected value="P">찬성</option>
			<option value="N">중립</option>
			<option value="C">반대</option>
		</select><br>
			<c:if test="${ !empty loginUser }">
				<input type="text" class="wid" id="id"  readonly value="${loginUser.id }"><br>
			</c:if>
			<c:if test="${ empty loginUser }">
				<input type="text" class="wid" id="id" placeholder="아이디을 작성하세요"><br>
			</c:if>
			<textarea id="area1" class="wid" rows="10" cols="55"></textarea><br>
			<button class="btn" id="btn3">작성하기</button>
		</c:if>
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
				$.ajax({
					url: 'addReply.di',
					data: {rContent:content, rWriter:id, rWhether:dis, dNo:dNo},
					success: function(data){
						$('#area1').val('');
						getRList();
					}
				});
			});
			// 댓글 리스트 불러오기
			function getRList(){
				var dNo = ${d.dNo};
				var cho = $('#stime').val();
				$.ajax({
					url:"rList.di",
					data: {dNo:dNo, cho:cho},
					success: function(data){
						console.log(data);
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
								$img = $('<img src="<%=request.getContextPath() %>/resources/images/icon/usericon.png" id="user-icon">');
								$rContent = $('<p>').text(data[i].rContent);
								$div2 = $('<div class="Atext" id="text">');
								$div2_1 = $('<div id="div-'+ data[i].rNo +'">');
								$div3 = $('<div style="clear:both;"><br>');

								$btn1 = $('<button class="rBtn1" value="'+data[i].dNo+'" onclick="rUpdateFrom('+ data[i].rNo+');">').text("수정하기");
								$btn2 = $('<button class="rBtn2" onclick="rDelete('+ data[i].rNo+');">').text("삭제하기");
								
								if(data[i].rWhether == 'C'){
									$id = $('<h3>').html(data[i].rWriter + " 님의 <span>반대</span> 의견");
									$div1.append($img);
									$div2.append($id);
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
			
			// 댓글 수정 폼 생성
			function rUpdateFrom(rNo){
				console.log(rNo);
				var PCN = $('#div-'+rNo).children().children().children().text();
				$div = $('#div-'+rNo);
				
				var $rid = $('<input type="text" class="wid" readonly>').val('${loginUser.id}');
				var $tarea = $('<textarea id="area-'+rNo+'" class="wid"- rows="10" cols="55"><br>').val($div.children().children().eq(1).text());
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
				
				$dselect.append($option1);
				$dselect.append($option2);
				$dselect.append($option3);

				$div1.append($rid);
				$div1.append($dselect);
				$div1.append($tarea);
				$div1.append($commitBtn);
				$div1.append($closeBtn);
				$div.append($div1);
			}
			
			// 댓글 수정
			function rUpdate(rNo, PCN){
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
				console.log(check);
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
				getRList();
			}
			
			// 댓글 삭제
			function rDelete(rNo){
				var check = confirm("정말로 댓글을 끝내갰습니까?");
				var PCN = $('#comment-'+rNo).children().children().children().eq(0).text();
				var dNo = $('#comment-'+rNo).children().children().eq(3).val();
				if(PCN == '반대'){
					dNo = $('#comment-'+rNo).children().children().eq(2).val();
				}
				if(check){
					$.ajax({
						url: 'rDelete.di',
						data:{rNo:rNo, rWhether: PCN, dNo: dNo},
						success: function(data){
							if(data == "success"){
								getRList();
							}
						}
					});
				}
			}
			
		</script>
	</section>
</body>
</html>