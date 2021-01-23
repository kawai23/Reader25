<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>
<script src=" https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
/*화면*/
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		min-width: 1000px;
		padding-top: 15px;
		background-color:  #F6F6F6; display: inline-block;
		font-family: 카페24 아네모네에어; font-size:17px;
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
/*글자*/
textarea{
	font-family: 카페24 아네모네에어; font-size:16px;
}
.txt_TIW{
	font-size:50px;
	font-family: 카페24 아네모네;
	text-align: center;
}
.title_txt{
	font-size:35px;
	font-family: 카페24 아네모네에어;
	margin-left: 100px; margin-right: 100px; 
	margin-top: 100px; margin-bottom: 100px;
}
#con_table2{
	background-color:#F1F1F1;
	font-size:18px;
	font-family: 카페24 아네모네에어;
	width: 60%;
	align: center;
	margin-top: 100px; margin-bottom: 100px;
	margin-left: auto; margin-right: auto; 
	padding-left: 50px; padding-right: 50px;
	padding-top: 100px; padding-bottom: 100px;
}
/*버튼*/
#btn1 {
	width:100px;
    height: 40px;
	font-size: 18px; color:#fff;
	border: 1px solid  #FFC398;
    background-color:  #FFC398;
    font-family: 카페24 아네모네에어;
}
#btn2{
	width:100px;
    height: 40px;
	font-size: 18px; color:#000000;
	border: 1px solid  #C95F12;
    background-color:  #C95F12;
    font-family: 카페24 아네모네에어;
}
#btn3{
	width:100px;
    height: 40px;
	font-size: 18px; color:#000000;
	border: 1px solid  #C4C4C4;
    background-color:  #C4C4C4;
    font-family: 카페24 아네모네에어;
}
/*테이블*/
#con_table{
			width: 80%;
			min-height: 200px;
		}
#con_table3{
			width: 80%;
		}
/*사진*/
#img_td{width:40%}
#heart, #unheart{max-width: 100px;}
#myimg{
		max-width: 300px;
		margin-left: 5%;
		margin-right: 10%;
		border-radius:100px;
	}
/*댓글*/
.comment-box{
		width: 80%;
		margin:auto;
		margin-top:10px;
		max-width: 1000px;
		border-bottom: 1px solid rgb(200, 200, 200);
		padding-bottom: 40px;
}
.comment-date{color:rgb(180, 180, 180);display:inline-block; margin-left: 10px; font-size: 12px;}
.comment-write{
		border: 1px solid rgb(200, 200, 200);
		background: white;
		height: 100px;
}
#comment-add{font-family: 카페24 아네모네에어;}
.comment-box button{
		font-size: 16px; 
		height: 35px;
		float: right;
		background:rgba(85, 83, 83, 1);
		width: 80px;
		margin: 5px;
		color:white;
}
.comment{border-bottom: 1px solid rgb(230, 230, 230);margin:5px;}
.comment-content{margin: 6px; font-size: 20px;color: rgba(85, 83, 83, 1);}
.user-div{width: 97%;margin:auto;}
.text-count{float:right; color:rgb(200, 200, 200); font-size:15px;}
.comment-box textarea{
		clear:both;
		margin: 8px;
		width: 97%;
		height: 55%;
		resize: none;
		border: none;
}
 textarea{
		clear:both;
		margin: 8px;
		width: 97%;
		height: 50%;
		resize: none;
		border: none;
}
/*댓글 페이징*/
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
/* 모달 */
.jquery-modal blocker current {
		visibility: none;
}
.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
		font-family: 카페24 아네모네에어; font-size:17px;
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
.modal-close{
	background-color: #C4C4C4;
	color:white; width: 80px;
	height: 30px; border:none;
	display:inline-block; left: 40%;
	font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-accept, .modal-yes, .modal-update{
	background-color: rgba(255,127,14,1);
	color:white; width: 80px;
	height: 30px; border:none;
	display:inline-block; left: 40%;
	font-family: 카페24 아네모네에어; font-size:15px;
}
.modal-accept{
		background-color: #C95F12;
		font-family: 카페24 아네모네에어; font-size:15px;
}
.modal p{
		display:inline-block;
}
.modal img{
		position:relative;
		top: 10px;
}
.no1{font-size:0px;}
#updateBtn{
	width:35px; height: 30px;
	display:inline-block;
	margin-right: 5px; font-size: 12px; 
	background-color: rgba(255,195,152,0.5); color:white;
	font-family: 카페24 아네모네에어; font-size:13px;
	border: 0px solid rgba(235, 235, 235, 1);
	border-radius:100px;
}
#deleteBtn{
	width:36px; height: 30px;
	display:inline-block; margin-left: 5px; 
	 font-size: 12px; 
	background-color: rgba(196,196,196,0.5); color:darkgray;
	font-family: 카페24 아네모네에어; font-size:13px;
	border: 0px solid rgba(235, 235, 235, 1);
	border-radius:100px;
}
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	<!-- 에러 모달창 -->
	<!-- 글 삭제 -->
	<div class="modal-back" id="del-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>정말로 이 게시글을 삭제하시겠습니까?</p>
				<br>
				<button class="modal-accept" value="accept">확인</button>
				<button class="modal-close" value="Close">취소</button>
			</div>
		</div>
	</div>
	<!-- 댓글 작성 -->
	<div class="modal-back" id="check-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/check.png" width="40px;"/>
				<p>댓글이 작성되었습니다.</p>
				<br>
				<button class="modal-close" value="Close">확인</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="up-che-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/check.png" width="40px;"/>
				<p>댓글이 작성이 실패했습니다.</p>
				<br>
				<button class="modal-close" value="Close">확인</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="de-che-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/check.png" width="40px;"/>
				<p>댓글이 삭제가 실패했습니다.</p>
				<br>
				<button class="modal-close" value="Close">확인</button>
			</div>
		</div>
	</div>
	<div class="modal-back" id="update-c-modal">
		<div class="modal">
			<div class="modal-content">
				<div class="comment-write">
					<div id="comNo" class="no1"></div>
					<div class="user-div" id="user">
					</div>
					<span class="text-count" id="counter">0/500</span>
					<textarea id="comment-input-up" maxlength="500" placeholder="댓글을 작성해주세요"></textarea>
				</div>
				<br>
				<button class="modal-update">수정</button>
				
				<script type="text/javascript">
				$(function(){
					 $('#comment-input-up').keyup(function(){
						 var content = $(this).val();
						 $('#counter').html(content.length +'/500');
					 });
				 });
				</script>
			</div>
		</div>
	</div>
	<div class="modal-back" id="del-c-modal">
		<div class="modal">
			<div class="modal-content"><div id="comNo" class="no1"></div><div id="bNo" class="no1"></div>
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>정말로 이 댓글을 삭제하시겠습니까?</p>
				<br>
				<button class="modal-yes" value="yes">확인</button>
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
			$('.modal-update').click(function(){
				var comNo=$('#comNo').text();
				var comment = $('#comment-input-up').val();
				var userId = $('#user').text();
				console.log(comNo);
				 
				$.ajax({ 
					type : "POST",
					url : 'commentUp.to',
					data:{comment:comment, userId:userId,comNo:comNo},
					success:function(data){
						if(data>0){
							console.log(data);
							$('.modal').hide();
							$('.modal-back').hide();
						} else{
							$('#up-che-modal').show();
							 $('#up-che-modal .modal').show();
						}
					}
				});
				
			});
			$('.modal-yes').click(function(){
				var comNo=$('#comNo').text();
				var bNo=$('#bNo').text();
				
				$.ajax({ 
					type : "POST",
					url : 'commentDe.to',
					data:{comNo:comNo,bNo:bNo},
					success:function(data){
						if(data>0){
							console.log(data);
							$('.modal').hide();
							$('.modal-back').hide();
						} else{
							$('#de-che-modal').show();
							 $('#de-che-modal .modal').show();
						}
					}
				});
			});
			
		});
	</script>
	
	<div class="outer">
		<input type="hidden" name="user" value="${ loginUser.id }">
			<div class="page">
			<br><br><br>
			<h2 class="txt_TIW" align="center">오늘은 나도 작가</h2>
			<input type="hidden" name="user" value="${ board.boardNo }">
			</div>
			<br>
			<div id ="content">
				<table id="con_table" align="center">
					<tr>
						<td colspan="3" rowspan="4" id="img_td"><img id="myimg" alt="기본이미지" src="resources/images/logo/Leader25.jpg"></td>
						<td width="55px">
							<div class="title">title</div>
						</td>
						<td class="title_txt" colspan="5">  ${ board.bTitle }</td>
					</tr>
					<tr>
						<td width="55px">
							<div class="cate1">cate</div>
						</td>
						<td colspan="2">${ categori }</td>
						<td width="55px">
							<div class="date">date</div>
						</td>
						<td colspan="2">${ board.enrollDay }</td>
					</tr>
					<tr>
						<td width="55px">
							<div class="cate2">원작</div>
						</td>
						<td colspan="5">${ bookname }</td>
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
				</table>
				
				<div id="con_table2">
					${ board.bContent }
				</div>
						
				<table id="con_table3" align="center">
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
								<button id="btn1" onclick="location.href='${ TIWUpdateView }'">수정하기</button>
								<button id="btn3" onclick="deleteTIWDelete();">삭제하기</button>
								<button id="btn2" onclick="location.href='${ goTIWList }'">목록으로</button>
							</td>
						</tr>
					</c:if>
					
					<script>
						function deleteTIWDelete(){
							$('#del-modal').show();
							 $('#del-modal .modal').show();
							 $('#del-modal .modal-accept').click(function(){
								location.href='TIWDelete.to?boardNo='+${board.boardNo};
							});
						}
					</script>
					
					<tr>
						<td colspan="9" align="center">
							<c:choose>
							  <c:when test="${heart eq '1'}">
							    <a class="heart"><img id="heart" src="resources/images/like/like.png"></a>
							  </c:when>
							  <c:otherwise>
							    <a class="heart"><img id="heart" src="resources/images/like/unlike.png"></a>
							  </c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>
			
				
			<div class="comment-box">
				<div class="commentList">
				</div>
				<div class="paging-btn" id="co-paging">
				</div>
				<div class="comment-write">
					<div class="user-div">
						<c:if test="${loginUser eq null }">
							로그인 시 댓글 등록이 가능합니다.
						</c:if>
						<c:if test="${loginUser ne null }">
							${loginUser.id}
						</c:if>
						<span class="text-count" id="counter">0/500</span>
					</div>
					<textarea id="comment-input" maxlength="500" placeholder="댓글을 작성해주세요"></textarea>
				</div>
				<button id="comment-add">댓글 등록</button>
				<br><br>
			</div>
			
			<script>
			 $(function(){
				 getComments();
				 $('#comment-input').keyup(function(){
					 var content = $(this).val();
					 $('#counter').html(content.length +'/500');
				 });
				 $('#comment-add').click(function(){
					if('${loginUser}' == ''){
						$('#login-modal').show();
						$('#login-modal .modal').show();
					}else{
						addComments();
					}
				 });
				 setInterval(function(){
					 var page0 = $('.page0-no').text();
					getComments(page0);
				 }, 1000); 
			 });
			 function addComments(){
				 var boardNo = ${board.boardNo};
				 var comment = $('#comment-input').val();
				 if(comment != ''){
					 $.ajax({
						url:  "addComments.to",
						data:{boardNo:boardNo,comment:comment},
						success: function(data){
							$('#comment-input').val('');
							if(data == 'success'){
								$('#check-modal').show();
								$('#check-modal .modal').show();
							}
							getComments(1);
						}
					});
				 }else{
					 $('#content-modal').show();
					 $('#content-modal .modal').show();
				 }
			 }
			 function getComments(value){
				 var boardNo = ${board.boardNo};
				 var page0 = value;
				 $.ajax({
					 url:'comments.re',
					 data:{boardNo:boardNo,page0:page0},
					 success: function(data){
						//1) 페이징 버튼 넣기
						pi0 = data.pi0;
						$copaging = $('#co-paging');
						$copaging.html('');
						if(pi0.currentPage <= 1){
							$before = $('<p>').text('<');
						}else{
							$before = $('<a>').on('click',function(){getComments(pi0.currentPage - 1)}).text('<');
						}
						$copaging.append($before);
	
						for(var i = pi0.startPage; i <= pi0.endPage; i++){
							if(pi0.currentPage == i){
								$pNo = $('<p class="page0-no">').text(i);
							}else{
								$pNo = $('<a>').on('click', function(){
									getComments($(this).text());
								}).text(i);
							}
							$copaging.append($pNo);
						}
						if(pi0.currentPage >= pi0.endPage){
							$next = $('<p>').text(">");
						}else{
							$next = $('<a>').on("click", function(){getComments(pi0.currentPage + 1)}).text('>');
						}
						$copaging.append($next);
						//2)값넣기
						cList = data.cList;
						$comments = $('.commentList');
						$comments.html('');
						
						for(var i in cList){
							$comment = $('<div class="comment">');
							
							$top = $('<div class="comment-top">')
							$idspan = $('<span class="comment-user">').text(cList[i].userId);
							$datespan = $('<span class="comment-date">').text(cList[i].comDate);
							$commentDiv = $('<div class="comment-content">').text(cList[i].comment);
							
							$btn1 = $('<button class="updateBtn" id="updateBtn" onclick="rUpdateFrom('+cList[i].comNo+');">').text("수정");
							$btn2 = $('<button class="deleteBtn" id="deleteBtn" onclick="rDeleteFrom('+cList[i].comNo+');">').text("삭제");
							
							$top.append($idspan);
							$top.append($datespan);
							
							$comment.append($top);
							$comment.append($commentDiv);
							$comments.append($comment);
							
							if('${loginUser.id}' == cList[i].userId){
								$top.append($btn2);
								$top.append($btn1);
							}
						}
					 }
				 });
			 }
			 
			 function rUpdateFrom(comNo){
				console.log(comNo);
				var id = ${loginUser.id};
				var comNo = comNo;
				$('#update-c-modal').show();
				$('#update-c-modal .modal').show();
				$('#comNo').html(comNo);	
				$('#user').html(id);
			 }
			 
			 function rDeleteFrom(comNo){
				 var boardNo = ${ board.boardNo };
				 	console.log(boardNo);
					console.log(comNo);
					var comNo = comNo;
					$('#del-c-modal').show();
					$('#del-c-modal .modal').show();
					$('#comNo').html(comNo);
					$('#bNo').html(boardNo);
			}
			 
			 
			</script>
	</div>
	<%@ include file="../common/footer.jsp" %>
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
	            data : {'boardNo' : '${ board.boardNo }','user':'${ loginUser.id }','heart':'${heart}', 'code':'${ board.code }'},
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