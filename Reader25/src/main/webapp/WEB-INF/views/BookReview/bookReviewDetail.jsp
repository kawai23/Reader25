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
  	.list-info{
  		border-bottom: 1px solid rgb(200, 200, 200);
  		padding-top: 30px;
  		padding-bottom: 10px;
  		width: 80%;
		margin:auto;
		max-width: 1000px;
  	}
  	.list-info p{
  		display:inline-block;
  		color:rgb(100, 100, 100);
  		margin-left: 10px;
  	}
  	.count-p{float:right; margin-right: 10px}
	.bookreview-div{
		clear:both;
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
	.contents{width: 80%;margin:auto; margin-top: 10px; min-height: 200px; max-width: 1000px; border-bottom: 1px solid rgb(200, 200, 200);}
	.contents>p{margin:15px;}
	.list-box{
		width: 80%;
		margin:auto;
		margin-top:10px;
		max-width: 1000px;
		background: white;
		border-radius: 5px;
	}
	.list{
		margin: 10px;
	}
	.list-header{
		height: 35px;
		line-height: 35px;
		border-bottom: 1px solid rgb(200, 200, 200);
	}
	.list-header p{
		display:inline;
	}
	.list-table{
		width: 100%;
		border-collapse: collapse;
		margin:auto;
	}
	.list-table tr{border-bottom: 1px solid rgb(240, 240, 240);}
	.list-table tr:hover{
		cursor: pointer;
		background: rgb(240, 240, 240);
	}
	.list-table td{
		text-align: center;
		color:gray;
	}
	.list-table td[class=td-left]{text-align: left;}
	.list-table td[class=td-right]{text-align: right; color:rgb(180, 180, 180);}
	.paging-btn{
		width: 200px;
		height: 35px;
		margin: auto;
		padding: 0;
		text-align: center;
		font-size: 15px;
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
		margin-top: 10px;
		height: 25px;
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
	
	<section>
		<div class="list-info">
			<p>${ board.userId } ${board.updateDay }</p>
			<p class="count-p">조회수 : ${ board.bCount } </p>
		</div>
		<div class="bookreview-div">
			<div class="info">
				<div class="img-div">
					<c:if test="${at ne null}">
						<img src="resources/buploadFiles/${at.atcName}"/>
					</c:if>
					<c:if test="${at eq null }">
						<img />
					</c:if>
				</div>
				<div class="info-content">
					<h3 class="title">${ board.bTitle }</h3>
					<p class="tag">#제목</p>
					<span class="info" id="author">${booktitle }</span>
					<p class="tag">#작가</p>
					<span class="info" id="sort">${author }</span>
					<br>
					<p class="tag">#글쓴이</p>
					<span class="info" id="sort">${board.userId }</span>
					<div class="wise-saying">
						<div>
							<img class="quote-img" id="quote1" src="resources/images/bookreview/quote5.png"/>
							<div class="wise-content">${ wise }</div>
							<img class="quote-img" id="quote2"src="resources/images/bookreview/quote6.png"/>
						</div>
					</div>
				</div>
			</div>
			<div class="contents">
				${board.bContent}
			</div>
		</div>
		<div class="list-box">
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
									$tdDate = $('<td class="td-right">').text(reList[i].updateDay);
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
		
		<div class="list-box">
			<div class="list">
				<div class="list-header">
					<p>명대사</p>
				</div>
				<div class="list-contents">
					<table class="list-table" id="wiseTable">
					</table>
				</div>
			</div>
			<div class="paging-btn" id="wise-paging">
			</div>
		</div>
		
		<script>
			$(function(){
				getWiseList(1);
			});
			function getWiseList(value){
				var wise = "${wise}";
				var page2 = value;
				$.ajax({
					url: 'wiseList.re',
					data: {wise:wise, page2:page2},
					success: function(data){
						
						//1) 페이징 버튼 넣기
						pi2 = data.pi2;
						$wisepaging = $('#wise-paging');
						$wisepaging.html('');
						if(pi2.currentPage <= 1){
							$before = $('<p>').text('<');
						}else{
							$before = $('<a>').on('click',function(){getWiseList(pi2.currentPage - 1)}).text('<');
						}
						$wisepaging.append($before);
						for(var i = pi2.startPage; i <= pi2.endPage; i++){
							if(pi2.currentPage == i){
								$pNo = $('<p>').text(i);
							}else{
								$pNo = $('<a>').on('click', function(){getWiseList($(this).text())}).text(i);
							}
							$wisepaging.append($pNo);
						}
						if(pi2.currentPage >= pi2.endPage){
							$next = $('<p>').text(">");
						}else{
							$next = $('<a>').on('click',function(){getWiseList(pi2.currentPage + 1)}).text('>');
						}
						$wisepaging.append($next);
						
						//2) 게시물리스트 넣기
						wiseList = data.wiseList;
						wiseArr = data.wiseArr;
						
						$wiseTable = $('#wiseTable');
						$wiseTable.html('');
						if(wiseList.length <= 1){
							$tr = $('<tr>');
							$td = $('<td class="td-left" colspan=7>').text('다른 리뷰가 없습니다.');
							$tr.append($td);
							$wiseTable.append($tr);
						}else{
							for(var i in wiseList){
								if(wiseList[i].boardNo != '${board.boardNo}'){
									$tr = $('<tr>').on('click', function(){
										var boardNo = $(this).children('td').eq(0).text();
										location.href='redetail.re?boardNo='+boardNo+"&page=1";
									});
									$tdNo = $('<td>').text(wiseList[i].boardNo);
									$tdTitle = $('<td class="td-left">').text(wiseList[i].bTitle);
									$tdWriter = $('<td>').text(wiseList[i].userId);
									$tdDate = $('<td class="td-right">').text(wiseList[i].updateDay);
									$tdCount = $('<td>').text(wiseList[i].bCount);
									$tdWise = $('<td>').text(wiseArr[i]);

									$tr.append($tdNo);
									$tr.append($tdTitle);
									$tr.append($tdWise);
									$tr.append($tdWriter);
									$tr.append($tdCount);
									$tr.append($tdDate);

									$wiseTable.append($tr);
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