<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src=" https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
	 section{
  		border: 1px solid rgba(246, 246, 246, 1);
  		background: rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  	}
	.bookreview-div{
		margin-top: 20px;
	}
	.info{
		width: 80%;
		margin:auto;
		max-width: 1000px;
	}
	.img-div{
		display:inline-block;
		width: 50%;
		line-height: 350px;
		float: left;
		background: rgba(229, 229, 229, 1);
		text-align: center;
	}
	.img-div img{
		clear: both;
		max-width: 350px;
		max-height:400px;
		margin:auto;
		vertical-align: middle;
		text-align: center;
	}
	
	.info-content{
		display:inline-block;
		width: 47%;
		height: 350px;
		margin-left: 15px;
	}
	.title{
		display:inline-block;
		margin: 10px;
		margin-top: 80px;
		width: 100%;
		font-size: 30px;
	}
	.tag{
		display:inline;
		margin: 10px;
		margin-right: 0px;
		color: gray;
		font-size: 13px;
	}
	.wise-saying{
		height: 100px;
		width: 100%;
		margin-top: 10px;
	}
	.wise-saying>div{
		width: 80%;
		margin: auto;
		text-align: center;
	}
	.wise-saying img{
	}
	#quote1{float:left;}
	#quote2{float:right;}
	.wise-content{display:inline-block; margin-top: 10px;}
	.contents{width: 80%;margin:auto; margin-top: 10px; min-height: 200px; max-width: 1000px;}
	.contents>p{margin:15px;}
	.list{
		width: 80%;
		margin:auto;
		margin-top:10px;
		max-width: 1000px;
	}
	.list-header{
		background:rgba(247, 180, 94, 1);
		padding-left: 20px;
		height: 35px;
		line-height: 35px;
	}
	.list-header p{
		display:inline;
	}
	.list-contents{
		background: rgba(229, 229, 229, 1);
		padding: 10px;
	}
	.list-table{
		width: 95%;
		border-collapse: collapse;
		margin:auto;
	}
	.list-table tr:hover{
		background: white;
		cursor: pointer;
	}
	.list-table td{
		text-align: center;
	}
	.list-table td[class=td-left]{
		text-align: left;
	}
	.paging-btn{
		width: 200px;
		margin: auto;
		margin-top: 10px;
		text-align: center;
	}
	.paging-btn a, .paging-btn p{
		display:inline-block;
		margin-left: 6px;
	}
	.paging-btn a:hover{
		font-weight:bolder;
		cursor:pointer;
	}
	.btns-div{
		font-size: 18px;
		height: 25px;
		position: relative;
		float: right;
		margin-right: 10%;
		top: -30px;
	}
	.write-btn{
		background:rgba(255, 195, 152, 1);
		width: 80px;
		border: none;
		height: 25px;
		color: white;
	}
	.delete-btn{
		background:rgba(103, 73, 44, 1);
		width: 80px;
		border: none;
		height: 25px;
		color: white;
	}
	.modify-btn{
		background:rgba(201, 95, 18, 1);
		width: 80px;
		border: none;
		height: 25px;
		color: white;
	}
	.list-btn{
		background:rgba(196, 196, 196, 1);
		width: 80px;
		border: none;
		height: 25px;
		color: white;
	}
	.write-btn:hover{
		background:rgba(245, 185, 142, 1);
		cursor:pointer;
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
	.modal-close, .modal-accept{
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
	<div class="modal-back">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>정말로 삭제하시겠습니까?</p>
				<br>
				<button class="modal-accept" value="accept">확인</button>
				<button class="modal-close" value="Close">취소</button>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('.modal-close').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
			});
		});
	</script>
<!-- ================================================================ -->	
	<section>
		<div class="bookreview-div">
			<div class="info">

				<div class="img-div">
					<div id="banner_container">
						<div id="banner_wrapper">
							<c:if test="${atlist ne null}">
								<c:forEach items="${ atlist }" var="at">
									<img src="resources/buploadFiles/${at.atcName}" />
									<!-- ${at.atcName} at에 있는 atcName 이라는 필드명의 값을 담아온다  ${at.atcName}으로 설정이 된 이미지를 가져온다-->
								</c:forEach>

							</c:if>
							<c:if test="${atlist eq null }">
								<img />
							</c:if>
						</div>
					</div>
				</div>
				<div id="banner_navi">
					<button id="btn_left">left</button>
					<button id="btn_right">right</button>
				</div>
				<script type="text/javascript">
					var BANNER_INDEX = 1;
					var BANNER_LEN = 0;
					var BANNER_WIDTH = 102;
					var SHOW_DURATION = 200;
					$(document).ready(function() {

						bannerInit();

						$("btn_left").unbind();
						$("btn_left").bind("click", function() {
							var nIndex = BANNER_INDEX - 1;
							// n번째 배너 보이기. 
							showBannerAt(nIndex);
						});
						$("btn_right").unbind();
						$("btn_right").bind("click", function() {
							// 이동할 이전 배너 인덱스 값 구하기.
							var nIndex = BANNER_INDEX + 1;

							// n번째 배너 보이기.
							showBannerAt(nIndex);
						});
					});
					// nIndex에 해당하는 배너 보이기.
					function showBannerAt(nIndex) {
						if (nIndex != BANNER_INDEX) {

							//  n번째 배너 위치 값 구하기.
							var nPosition = -BANNER_WIDTH * nIndex;

							// 배너 메뉴의 위치 값을 업데이트 시킴.
							//showBannerDotAt(nIndex);

							// 슬라이드 시작.
							$("banner_wrapper").stop();
							$("banner_wrapper").animate({
								left : nPosition
							}, SHOW_DURATION, function() {
								// 이전 내용이 없는 경우 마지막 배너 인덱스 값으로 설정하기.
								if (nIndex < 1) {
									nIndex = BANNER_LEN;
									nPosition = -BANNER_WIDTH * nIndex;
									$("banner_wrapper").css({
										"left" : nPosition + "px"
									});
								}

								// 다음 내용이 없는 경우, 첫 번째 배너 인덱스 값으로 설정하기.
								if (nIndex > BANNER_LEN) {
									nIndex = 1;
									nPosition = -BANNER_WIDTH * nIndex;
									$("banner_wrapper").css({
										"left" : nPosition + "px"
									});
								}

								//현재 배너 인덱스 업데이트 시키기.
								BANNER_INDEX = nIndex;
							});
						}
					}

					function bannerInit() {
						BANNER_LEN = $("banner_wrapper .page").length;
						$("banner_wrapper").css({
							"left" : -BANNER_WIDTH
						});
					}
				</script>

				<!-- ================================================================ -->

				<div class="info-content">
					<h3 class="title">${ board.bTitle }</h3>
					<p class="tag">#제목</p>
					<span class="info" id="author">${booktitle }</span>
					<p class="tag">#작가</p>
					<span class="info" id="sort">${author }</span> <br>
					<p class="tag">#거래자</p>
					<span class="info" id="sort">${board.userId }</span>
					<div class="wise-saying">
						<div>
							<img class="quote-img" id="quote1"
								src="resources/images/bookreview/quote5.png" />
							<div class="wise-content">${ wise }</div>
							<img class="quote-img" id="quote2"
								src="resources/images/bookreview/quote6.png" />
						</div>
					</div>
				</div>
			</div>
			<div class="contents">
				${board.bContent}
			</div>
		</div>
		<div class="list">
			<div class="list-header">
				<p>이 책의 다른 리뷰</p>
			</div>
			<div class="list-contents">
				<table class="list-table" id="reTable">
					<!-- 리뷰 게시뮬 -->
				</table>
			</div>
		</div>

		<div class="paging-btn" id="re-paging">
		<!-- 다른 리뷰 페이징 -->
		</div>
		<script>
			var reList;
			$(function(){
				getReList(1);
				$('.modal').hide();
			});
			function getReList(value){
				var booktitle = "${booktitle}";
				var page1 = value;
				$.ajax({
					url: 'reList.re',
					data: {booktitle:booktitle, page1:page1},
					success: function(data){
						
						//1) 페이징 버튼 넣기
						pi1 = data.pi1;
						$repaging = $('#re-paging');
						$repaging.html('');
						if(pi1.currentPage <= 1){
							$before = $('<p>').text('<');
						}else{
							$before = $('<a>').on('click',function(){getReList(pi1.currentPage - 1)}).text('<');
						}
						$repaging.append($before);

						for(var i = pi1.startPage; i <= pi1.endPage; i++){
							if(pi1.currentPage == i){
								$pNo = $('<p>').text(i);
							}else{
								$pNo = $('<a>').on('click', function(){
									getReList($(this).text());
								}).text(i);
							}
							$repaging.append($pNo);
						}
						
						if(pi1.currentPage >= pi1.endPage){
							$next = $('<p>').text(">");
						}else{
							$next = $('<a>').on("click", function(){getReList(pi1.currentPage + 1)}).text('>');
						}
						
						$repaging.append($next);
						
						//2) 게시물리스트 넣기
						reList = data.reList;
						
						
						$reTable = $('#reTable');
						$reTable.html('');
						if(reList.length <= 1){
							$tr = $('<tr>');
							$td = $('<td class="td-left" colspan=6>').text('다른 리뷰가 없습니다.');
							$tr.append($td);
							$reTable.append($tr);
						}else{
							for(var i in reList){
								if(reList[i].boardNo != '${board.boardNo}'){
									$tr = $('<tr>').on('click', function(){
										var boardNo = $(this).children('td').eq(0).text();
										location.href='redetail.re?boardNo='+boardNo+"&page=1";
									});
									$tdNo = $('<td>').text(reList[i].boardNo);
									$tdTitle = $('<td class="td-left">').text(reList[i].bTitle);
									$tdWriter = $('<td>').text(reList[i].userId);
									$tdDate = $('<td>').text(reList[i].updateDay);
									$tdCount = $('<td>').text(reList[i].bCount);
									$tr.append($tdNo);
									$tr.append($tdTitle);
									$tr.append($tdWriter);
									$tr.append($tdCount);
									$tr.append($tdDate);

									$reTable.append($tr);
								}
							}
						}
					}
				});
			}
		</script>
		

		<div class="btns-div">
		<c:if test="${loginUser ne null }">
			<c:if test="${ loginUser.id eq board.userId }">
				<button class="modify-btn" onclick="location.href='modify.re?boardNo='+${board.boardNo}+'&page='+${page}">수정하기</button>
				<button class="delete-btn" onclick="deleteReview();">삭제하기</button>
			</c:if>
			<c:if test="${loginUser.id ne board.userId }">
				<button class="write-btn" onclick='location.href="write.re"'>리뷰쓰기</button>
			</c:if>
		</c:if>
		<button class="list-btn" onclick='location.href="book.re?page="+${page}'>목록보기</button>
		</div>
		<script>
			function deleteReview(){
				$('.modal-back').show();
				 $('.modal').show();
				 $('.modal-accept').click(function(){
					location.href='delete.re?boardNo='+${board.boardNo}
				});
			}
		</script>
	</section>
</body>
</html>