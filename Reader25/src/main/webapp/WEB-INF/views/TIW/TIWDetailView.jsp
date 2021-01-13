<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<link rel="stylesheet" href="${contextPath}/resources/css/TIW.css" type="text/css">

<style>
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		margin-top:100px; margin-bottom: 5%; min-width: 1000px;
		background-color:  #F6F6F6;
	}
#con_table{
			width: 80%;
			min-height: 500px;
		}
#img_td{width:40%}
#heart, #unheart{max-width: 100px;}
#myimg{
		max-width: 300px;
		margin-left: 5%;
		margin-right: 10%;
	}
.title, .cate1, .date, .cate2, .writer, .like, .count  {
	display: inline-block;
	background: rgba(235, 235, 235, 1);
	text-align: center;
	vertical-align: middle;
	width: 50px;
	height: 27px;
	border: 1px solid rgba(235, 235, 235, 1);
	border-radius: 3px 0px 0px 3px;
	color: rgba(85, 83, 83, 1);
}
.con_td{
		margin-left: 40%; margin-right: 40%;
		margin-top:15%; margin-bottom: 15%;
	}
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	<div class="outer">
	<input type="hidden" name="user" value="${ loginUser.id }">
		<div class="page">
		<h2 class="txt_TIW" align="center">오늘은 나도 작가</h2>
		<h5 align="center">${ board.boardNo }번 글 상세보기</h5>
		</div>
		<br>
		<div id ="content">
			<table id="con_table" align="center">
				<tr>
					<td colspan="3" rowspan="4" id="img_td"><img id="myimg" alt="기본이미지" src="resources/images/logo/Leader25.jpg"></td>
					<td width="55px">
						<div class="title">title</div>
					</td>
					<td colspan="5">${ board.bTitle }</td>
				</tr>
				<tr>
					<td width="55px">
						<div class="cate1">cate</div>
					</td>
					<td colspan="2">${ board.cate }</td>
					<td width="55px">
						<div class="date">date</div>
					</td>
					<td colspan="2">${ board.enrollDay }</td>
				</tr>
				<tr>
					<td width="55px">
						<div class="cate2">원작</div>
					</td>
					<td colspan="5">${ board.cate }</td>
				</tr>
				<tr>
					<td id="w_td" width="55px">
						<div class="writer">작가</div>
					</td>
					<td>${ board.userId }</td>
					<td id="l_td" width="55px">
						<div class="like">좋아요</div>
					</td>
					<td>${ board.bLike }</td>
					<td id="c_td" width="55px">
						<div class="count">조회수</div>
					</td>
					<td>${ board.bCount }</td>
				</tr>
				<tr>
					<td colspan="9">
						<div id="con_td">
							${ board.bContent }
						</div>
					</td>
				</tr>
				
				<c:url var="TIWUpdateView" value="TIWUpdateView.to">
					<c:param name="boardNo" value="${ board.boardNo }"/>
					<c:param name="page" value="${ page }"/>
				</c:url>
				<c:url var="TIWDelete" value="TIWDelete.to">
					<c:param name="boardNo" value="${ board.boardNo }"/>
				</c:url>
				<c:url var="goTIWList" value="goTIWList.to">
					<c:param name="page" value="${ page }"/>
				</c:url>
				
				<c:if test="${ loginUser.id eq board.userId }">
					<tr>
						<td colspan="9" align="center">
							<button class="btn1" onclick="location.href='${ TIWUpdateView }'">수정하기</button>
							<button class="btn2" onclick="location.href='${ TIWDelete }'">삭제하기</button>
							<button class="btn3" onclick="location.href='${ goTIWList }'">목록으로</button>
						</td>
					</tr>
				</c:if>
				
				<tr>
					<td colspan="9" align="center">
						<!-- <div style="text-align: right;">
					       <a class="heart">
					           <img id="heart" src="">
					       </a>
					   </div> -->
						<c:choose>
						  <c:when test="${heart eq '1'}">
						    <a class="heart"><img id="heart" src="resources/images/like/like.png"></a>
						  </c:when>
						  <c:otherwise>
						    <a class="heart"><img id="heart" src="resources/images/like/unlike.png"></a>
						  </c:otherwise>
						</c:choose>
						<dd id="likecnt" style="margin-left:5px;">${board.bLike}</dd>
					</td>
				</tr>
				
				
			</table>
		</div>
		
			
		<table class="commentsTable"  align="center">
			<tr>
				<td rowspan="2"><textarea rows="3" cols="55" id="comment" placeholder="댓글을 입력해 주세요"></textarea></td>
				<td><input type="text" name="userId" id="writer" readonly value="${ loginUser.id }"></td>
			</tr>
			<tr>
				<td><button id="cSubmit">등록하기</button></td>
			</tr>
		</table>
			
		<table class="commentsTable" id="ctb"  align="center">
			<thead>
				<tr>
					<td colspan=2><b id="cCount"></b></td>
				</tr>
			</thead>
			<tbody></tbody> 
		</table>
		
		<div class="paging-btn" id="re-paging" align="center">
		<!-- 댓글 페이징 -->
		</div>
		
		
		<script>
		
		//댓글 등록
		$('#cSubmit').on('click', function(){
			var comment = $('#comment').val();
			var boardNo = ${board.boardNo};
			
			$.ajax({
				url: "addComments.to",
				data: {comment:comment, boardNo:boardNo},
				success: function(data){
					console.log(data);
					if(data=="success"){
						$("#comment").val("");
						getCList();
						alert("댓글이 등록되었습니다.");
					}
				}
			});
		});		
				
		// 댓글 리스트 불러오기
		var cList;
		$(function(){
			getCList(1);
		})
		function getCList(value){
			var boardNo = ${ board.boardNo };
			var page1= value;
			//console.log(value);
			
			$.ajax({
				url: "cList.to",
				data: {boardNo:boardNo, page1:page1},
				success: function(data){
					//1)페이징 버튼 넣기
					pi1 = data.pi1;
			
					$repaging = $('#re-paging');
					$repaging.html('');
					
					if(pi1.currentPage <= 1){
						$before = $('<p>').text('<');
					}else{
						$before = $('<a>').on('click',function(){getCList(pi1.currentPage - 1)}).text('<');
					}
					
					$repaging.append($before);

					for(var i = pi1.startPage; i <= pi1.endPage; i++){
						if(pi1.currentPage == i){
							$pNo = $('<p>').text(i);
						}else{
							$pNo = $('<a>').on('click', function(){
								getCList($(this).text());
							}).text(i);
						}
						
						$repaging.append($pNo);
					}
					
					if(pi1.currentPage >= pi1.endPage){
						$next = $('<p>').text(">");
					}else{
						$next = $('<a>').on("click", function(){getCList(pi1.currentPage + 1)}).text('>');
					}
					
					$repaging.append($next);
			
					
					//2)댓글 리스트 넣기
					cList = data.cList;
					
					$tableBody = $("#ctb tbody");
					$tableBody.html('');
					
					var $tr;
					var $userId;
					var $comment;
					var $comDate;
					
					$('#cCount').text('댓글 (' + cList.length + ')');
					
					if(cList.length <= 1){
						$tr = $('<tr>');
						$cContent = $('<td colspan=3>').text('등록된 댓글이 없습니다.');
						$tr.append($td);
						$tableBody.append($tr);
						} else {
							for(var i in cList){
									$tr = $('<tr>');
									$userId = $('<td width="100">').text(cList[i].userId);
									$comment = $('<td>').text(cList[i].comment);
									$comDate = $('<td width="100">').text(cList[i].comDate);
									
									$tr.append($userId);
									$tr.append($comment);
									$tr.append($comDate);
									$tableBody.append($tr);
									
									$tableBody.append($tr);
							}
						}
					}
				});
			}

		$(function(){
			getCList();
			 setInterval(function(){
				getCList(1);
			}, 1000); 
		});
		</script>
	</div>

</body>

<script>

	//좋아요 클릭 ajax
	$(document).ready(function () {
	
		
		
// 	    var heartval = ${heart};
	
// 	    if(heartval>0) {
// 	        console.log(heartval);
// 	        $("#heart").prop("src", "resources/images/like/like.png");
// 	        $(".heart").prop('name',heartval)
// 	    }
// 	    else {
// 	        console.log(heartval);
// 	        $("#heart").prop("src", "resources/images/like/unlike.png");
// 	        $(".heart").prop('name',heartval)
// 	    }
	    

		var heartval = ${heart};
		
	    if(heartval>0) {
	        console.log(heartval);
	        $("#heart").prop("src", "resources/images/like/like.png");
	        $(".heart").prop('name',heartval)
	    }
	    else {
	        console.log(heartval);
	        $("#heart").prop("src", "resources/images/like/unlike.png");
	        $(".heart").prop('name',heartval)
	    }
	
	    
	    
	    
	    $(".heart").on("click", function () {
	    	
	    	
	    	console.log('?');
	
	        var that = $(".heart");
	        console.log("클릭");
	        
	        $.ajax({
	            url :'heart.to',
	            type :'POST',
	            data : {'boardNo' : '${ board.boardNo }','user':'${ loginUser.id }','heart':'${heart}'},
	            success : function(data){
	                that.prop('name',data);
	                if(data==1) {
	                    $('#heart').prop("src","resources/images/like/like.png");
	                    location.reload();
	                }
	                else{
	                    $('#heart').prop("src","resources/images/like/unlike.png");
	                    location.reload();
	                }
	
	
	            }
	        });
	    });
	});
	
	
</script>

</html>