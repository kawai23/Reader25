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
  	.Atext{float:left; margin-right: 10px;}
  	#text{background: white; border: 1px solid black; width:85%;}
  	#people-img{wdith:50px; height:50px;}
  	.wid{width:100%; margin: 3px;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<br><br>
	<section>
		<div id="title">
			<b>${d.getdTitle()}</b>
		</div>
		<div class="head" id="info">
			의견을 내주시면 감사하겠습니다. 글을 읽어본 뒤 찬성인지 반대인지 아래를 클릭하여 선택 후 자신의 주장을 펼치시면 됩니다!
		</div>
		<div class="head">
			<input type="radio"  name="discuss" value="찬성"> 찬성
			<input type="radio" class="dradio" name="discuss" value="중립" checked> 중립
			<input type="radio" class="dradio" name="discuss" value="반대"> 반대
		</div><br>
		<div class="head">
			<c:if test="${ d.atcNo == at.atcNo }">
				<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at.atcName }" id="load-img"/></td>
			</c:if>
			<c:if test="${ d.atcNo != at.atcNo }">
				<img src="<%=request.getContextPath() %>/resources/images/bookreview/book.jpg" id="load-img"/></td>
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
			<script>
				$(function(){
					getRList();
				});
				$('#stime').on('change', function(){
					getRList();
				});
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
							var $div2;
							var $img;
							var $id;
							var $rContent;
							var $div3;

							if(data.length > 0){
								for(var i in data){
									$li = $('<li>');
									$div1 = $('<div class="Atext">');
									$img = $('<img src="<%=request.getContextPath() %>/resources/images/bookreview/book.jpg"id="people-img">');
									$rContent = data[i].rContent;
									$div2 = $('<div class="Atext"id="text">');
									$div3 = $('<div style="clear:both;"><br>');
									if(data[i].rWhether == 'C'){
									$id = $('<h3>').text(data[i].rWriter + "님의 반대 의견");
										$div1.append($img);
										$div2.append($id);
										$div2.append($rContent);
										$li.append($div2);
										$li.append($div1);
										$li.append($div3);
										$olBody.append($li);
									} else {
										if(data[i].rWhether == 'P'){
											$id = $('<h3>').text(data[i].rWriter + "님의 찬성 의견");
										}else{
											$id = $('<h3>').text(data[i].rWriter + "님의 중립 의견");
										}
										$div1.append($img);
										$div2.append($id);
										$div2.append($rContent);
										$li.append($div1);
										$li.append($div2);
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
				$('.btn').mouseenter(function(){
					$(this).css({'cursor':'pointer'});
				});
			</script>
	</section>
</body>
</html>