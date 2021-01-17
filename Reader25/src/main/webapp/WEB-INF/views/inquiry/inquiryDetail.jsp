<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.kh.Reader25.board.model.vo.*, java.util.ArrayList" %>
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
		background: rgba(246, 246, 246, 1);
		width: 80%;
		min-height: 900px;
		min-width: 1000px;
		margin:auto;
		padding-top: 20px;
		font-family: 카페24 아네모네에어;
	}
	#myimg{max-width: 250px;}
	.inquiry-div{
		min-height: 100px; 
		background: white;
		margin: auto;
		margin-top: 20px;
		border-radius: 2px;
		box-shadow: 0px 2px 2px 3px lightgray;
		padding: 20px;
		width: 80%;
		min-width: 500px;
		max-width: 800px;
	}
	.inquiry-header{
		text-align: center;
		font-size: 25px;
		margin-bottom: 10px;
		font-weight: bolder;
	}
	#inquiry-contents{
		border-top: 2px solid rgba(245, 113, 92, 1);
		border-bottom: 2px solid rgba(245, 113, 92, 1);
		min-height: 500px;
		padding: 10px;
	}
	.title{
		margin-top: 10px;
	}
	.title-span{
		display:inline-block;
		width: 100px;
		font-weight: bold;
	}
	.image-div{
		width: 500px;
		margin-top: 20px;
	}
	.image-div>img{
		width: 100%;
	}
	.contents{
		background: rgba(255, 195, 152, 0.13);
		min-height: 200px;
		margin-top: 20px;
		padding: 10px;
	}
	.reply-writer{
		height: 40px;
		margin-top: 20px;
		padding-top: 20px;
		padding-bottom: 0px;
		border-top: 2px solid rgba(245, 113, 92, 1);
	}
	.reply-div{
		background: rgba(229, 229, 229, 0.37);
		min-height: 200px;
		padding: 10px;
	}
	.comment-box, .adminComments{
		width: 80%;
		margin:auto;
		margin-top:10px;
		max-width: 1000px;
		border-bottom: 1px solid rgb(200, 200, 200);
		padding-bottom: 40px;
	}
	.comment-date{color:rgb(180, 180, 180);display:inline-block; margin-left: 10px; font-size: 12px;}
	.comment-write, .adminCommentsTable{
		border: 1px solid rgb(200, 200, 200);
		background: white;
		height: 100px;
	}
	.comment-box button, .adminComments button{
		font-size: 13px;
		height: 25px;
		float: right;
		background:rgba(85, 83, 83, 1);
		width: 80px;
		margin: 5px;
		color:white;
	}
	.comment{border-bottom: 1px solid rgb(230, 230, 230);margin:5px;}
	.comment-content{margin: 6px; font-size: 13px;color: rgba(85, 83, 83, 1);}
	.user-div{width: 97%;margin:auto;}
	.text-count, .text-count-c{float:right; color:rgb(200, 200, 200);}
	.comment-box textarea, .adminComments textarea{
		clear:both;
		margin: 8px;
		width: 97%;
		height: 55%;
		resize: none;
		border: none;
	}
	.btn-div{
		width: 80%;
		max-width:800px;
		margin:auto;
		height: 50px;
	}
	.list-btn{
		background: rgba(196, 196, 196, 1);
		float: right;
		color: white;
		border: none;
		margin-top: 10px;
		height: 35px;
		width: 100px;
		margin-right: 5px;
	}
	#modify-btn{
		background: rgba(103, 73, 44, 1);
	}
	#delete-btn{
		background: rgba(201, 95, 18, 1);
	}
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
	/* modal */
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
	<%@ include file="../common/menubar.jsp" %>
	
	<!-- 에러 모달창 -->
	<div class="modal-back" id="del-modal">
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
	<div class="modal-back" id="login-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>로그인이 필요한 서비스입니다.</p>
				<br>
				<button class="modal-accept" value="accept">로그인하기</button>
				<button class="modal-close" value="Close">취소</button>
			</div>
		</div>
	</div>
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
	<div class="modal-back" id="content-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>내용을 입력해주세요</p>
				<br>
				<button class="modal-close" value="Close">확인</button>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('.modal-close').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
			});
			$('#login-modal .modal-accept').click(function(){
				location.href="loginView.me";
			});
		});
	</script>
	
	<section>
		<div class="inquiry-div">
			<div class="inquiry-header">문의사항</div>
			<h8 align="center">${ board.boardNo }번 글 상세보기</h8>
			<div id="inquiry-contents">
				<div class="title">
					<span class="title-span">제목</span>
					<span>${ board.bTitle }</span>
				</div>
				<div class="writer">
					<span class="title-span">작성자</span>
					<span>${ board.userId }</span>
					<input type="hidden" name="userId" value="${ board.userId }">
				</div>
				
				<!-- 이미지 파일 넣기 -->
				<% 
					ArrayList<Attachment> atList = (ArrayList<Attachment>)request.getAttribute("atList");
				%>
				<%if(atList != null){ %>
					<div class="file-list">
						<%for(Attachment at: atList){ %>
						<% String ext = at.getAtcName().substring(at.getAtcName().lastIndexOf(".") +1 ); %>
							<%if(!ext.equals("jpg") && !ext.equals("jepg") && !ext.equals("png")) { %>
								<a href="resources/buploadFiles/<%=at.getAtcName()%>" download="<%=at.getAtcOrigin()%>"><%=at.getAtcOrigin()%></a>
							<%} %>
						<%} %>
					</div>
					<div class="images-div">
						<%for(Attachment at: atList){ %>
						<% String ext = at.getAtcName().substring(at.getAtcName().lastIndexOf(".") +1 ); %>
							<%if(ext.equals("jpg") || ext.equals("jepg") || ext.equals("png")) { %>
								<div class="image">
									<img id="myimg" src="<%=request.getContextPath()%>/resources/buploadFiles/<%=at.getAtcName()%>">
								</div>
							<%} %>
						<%} %>
					</div>
				<%} %>
				<!-- ---------- -->
				
				<div class="contents">
					<span>${ board.bContent }</span>
				</div>
				
				<div class="reply-writer" id="acuserId">
					
				</div>
				<div class="reply-div" id="acComment">
					
				</div>
				
				<div class="adminComments">
					<c:if test="${ loginUser.id eq 'admin' }">
						<div class="adminCommentsTable">
							<div class="user-div" name="userId" id="writer">
								<c:if test="${loginUser ne null }">
									${loginUser.id}
								</c:if>
								<span class="text-count-c" id="counter-c">0/500</span>
							</div>
							<textarea id="comment" maxlength="500" placeholder="댓글을 작성해주세요"></textarea>
						</div>
						<button id="cSubmit">댓글 등록</button>
					</c:if>
				</div>
				
				<script>
				
				$('#comment').keyup(function(){
					 var content = $(this).val();
					 $('#counter-c').html(content.length +'/500');
				 });
				
				//관리자 댓글 등록
				$('#cSubmit').on('click', function(){
					var comment = $('#comment').val();
					var boardNo = ${board.boardNo};
					
					$.ajax({
						url: "addAdminComments.in",
						data: {comment:comment, boardNo:boardNo},
						success: function(data){
							console.log(data);
							if(data=="success"){
								$("#comment").val("");
								getACList();
								$('#check-modal').show();
								$('#check-modal .modal').show();
							}
						}
					});
				});
				
				//관리자 댓글 리스트 불러오기
				function getACList(){
					var boardNo = ${ board.boardNo };
					var userId = 'admin';
					//console.log(value);
					$acuserId = $('#acuserId');
					$acComment = $('#acComment');
					
					$.ajax({
						url: "aCList.in",
						data: {boardNo:boardNo, userId:userId},
						success: function(data){
							console.log(data)
							//댓글 넣기
							
							
							if(data.length > 0){
								for(var i in data){
									$userId = data[i].userId;
									$Comment = data[i].comment;
									
									$acuserId.html($userId);
									$acComment.html($Comment);
								}
							} else {
								$acuserId = $('');
								$acComment = $('아직 답변이 없습니다');
							}
							
						}
					});
				}
				
				$(function(){
					getACList();
					 setInterval(function(){
						 getACList(1);
					}, 10000); 
				});
				
				</script>
				
			</div>
		</div>
		<c:if test="${ loginUser.id eq board.userId || loginUser.id eq 'admin' }">
		<div  class="inquiry-div">
			
				<div class="comment-box">
					<div class="commentList">
					</div>
					<div class="paging-btn" id="co-paging">
					</div>
					<div class="comment-write">
						<div class="user-div">
							<c:if test="${loginUser ne null }">
								${loginUser.id}
							</c:if>
							<span class="text-count" id="counter">0/500</span>
						</div>
						<textarea id="comment-input" maxlength="500" placeholder="댓글을 작성해주세요"></textarea>
					</div>
					<button id="comment-add">댓글 등록</button>
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
			 var userId = '${board.userId}';
			 $.ajax({
				 url:'userComments.in',
				 data:{boardNo:boardNo,page0:page0,userId:userId},
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
						
						$top.append($idspan);
						$top.append($datespan);
						
						$comment.append($top);
						$comment.append($commentDiv);
						$comments.append($comment);
					}
				 }
			 });
		 }
		</script>
			
		</div>
		
		
		
		</c:if>
		<div class="btn-div">
			<c:url var="inquiryUpdate" value="inquiryUpView.in">
				<c:param name="boardNo" value="${ board.boardNo }"/>
				<c:param name="page" value="${ page }"/>
			</c:url>
			<c:url var="inquiryDelete" value="inquiryDel.in">
				<c:param name="boardNo" value="${ board.boardNo }"/>
			</c:url>
			<c:url var="goInquiryList" value="inquiry.in">
				<c:param name="page" value="${ page }"/>
			</c:url>
			<c:if test="${ loginUser.id eq board.userId || loginUser.id eq 'admin' }">
				<button class="list-btn" id="modify-btn" onclick="location.href='${ inquiryUpdate }'">수정하기</button>
				<button class="list-btn" id="delete-btn" onclick="deleteinquiry();">삭제하기</button>
			</c:if>
			<button class="list-btn"  onclick="location.href='${ goInquiryList }'">목록으로</button>
		</div>
		<script>
			function deleteinquiry(){
				$('#del-modal').show();
				 $('#del-modal .modal').show();
				 $('#del-modal .modal-accept').click(function(){
					location.href='inquiryDel.in?boardNo='+${board.boardNo};
				});
			}
		</script>
	</section>
</body>
</html>