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
	}
	.notice-div{
		min-height: 100px; 
		background: white;
		margin: auto;
		margin-top: 20px;
		border-radius: 2px;
		box-shadow: 0px 2px 2px 3px lightgray;
		padding: 20px;
		width: 80%;
		max-width: 1000px;
	}
	.notice-header{
		text-align: center;
		font-size: 25px;
		margin-bottom: 10px;
		font-weight: bolder;
	}
	#notice-contents{
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
	.images-div{
		width: 100%;
		margin-top: 20px;
	}
	.image{
		display:inline-block;
		width: 300px; 
		height: 300px;
		line-height: 300px;
		text-align: center;
		background: rgb(250,250,250);
	}
	.image img{
		max-height:100%;
		max-width: 100%;
		object-fit: cover;
		vertical-align: middle;
	}
	.contents{
		background: rgba(255, 195, 152, 0.13);
		min-height: 400px;
		margin-top: 20px;
		padding: 10px;
	}
	.comments{
		width: 80%;
		max-width: 800px;
		min-height: 100px;
		background: white;
		margin: auto;
		margin-top: 20px;
		padding: 20px;
	}
	.comment-date{color:rgb(180, 180, 180);display:inline-block; margin-left: 10px; font-size: 12px;}
	.comment-write{
		border: 1px solid rgb(200, 200, 200);
		background: white;
		height: 100px;
	}
	.comment{border-bottom: 1px solid rgb(230, 230, 230);margin:5px;}
	.comment-content{margin: 6px; font-size: 13px;color: rgba(85, 83, 83, 1);}
	.write-comment{
		margin:auto;
		margin-top: 20px;
	}
	#comment-input{
		height: 30px;
		width: 90%;
	}
	#comment-submit{
		height: 35px;
		background: white;
		border: 1px solid black;
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
	.list-btn:hover{cursor:pointer;}
	#modify-btn{
		background: rgba(103, 73, 44, 1);
	}
	#delete-btn{
		background: rgba(201, 95, 18, 1);
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
	#modal-ok{background:rgba(85, 83, 83, 1);}
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
				<button class="modal-close" value="Close" id="modal-ok">확인</button>
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
		<div class="notice-div">
			<div class="notice-header">공지사항</div>
			<div id="notice-contents">
				<div class="title">
					<span class="title-span">제목</span>
					<span>${board.bTitle }</span>
				</div>
				<div class="writer">
					<span class="title-span">작성자</span>
					<span>관리자</span>
				</div>
				<div class="writer">
					<span class="title-span">작성일</span>
					<span>${board.updateDay }</span>
				</div> 
				<script>
					$(function(){
						var updateDay = ${board.updateDay};
						console.log(updateDay);
					});
				</script>
				
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
									<img src="<%=request.getContextPath()%>/resources/buploadFiles/<%=at.getAtcName()%>">
								</div>
							<%} %>
						<%} %>
					</div>
				<%} %>
				<!-- ---------- -->
				
				<div class="contents">
					${board.bContent}
				</div>
			</div>
		</div>
		<form id="comments-form" action="<%=request.getContextPath()%>/write.no">
			<div class="comments">
				<div class="comment-list">
					<div class="commentList">
					</div>
					<div class="paging-btn" id="paging">
					</div>
				</div>
				<div class="write-comment">
					<input type="text" id="comment-input" name="comments" placeholder="댓글을 입력하세요">
					<input type="button" id="comment-submit" value="등록">
				</div>
			</div>
		</form>
		
		<script>
			$(function(){
				 getComments(1);
				 $('#comment-submit').click(function(){
					if('${loginUser}' == ''){
						$('#login-modal').show();
						$('#login-modal .modal').show();
					}else{
						addComments();
					}
				 });
				 setInterval(function(){
					 var page = $('.page-no').text();
					getComments(page);
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
						pi = data.pi0;
						$paging = $('#paging');
						$paging.html('');
						if(pi.currentPage <= 1){
							$before = $('<p>').text('<');
						}else{
							$before = $('<a>').on('click',function(){getComments(pi.currentPage - 1)}).text('<');
						}
						$paging.append($before);
	
						for(var i = pi.startPage; i <= pi.endPage; i++){
							if(pi.currentPage == i){
								$pNo = $('<p class="page-no">').text(i);
							}else{
								$pNo = $('<a>').on('click', function(){
									getComments($(this).text());
								}).text(i);
							}
							$paging.append($pNo);
						}
						if(pi.currentPage >= pi.endPage){
							$next = $('<p>').text(">");
						}else{
							$next = $('<a>').on("click", function(){getComments(pi.currentPage + 1)}).text('>');
						}
						$paging.append($next);
						
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
		<div class="btn-div">
			<c:if test="${loginUser.id eq 'admin' }">
				<button class="list-btn" id="modify-btn">수정하기</button>
				<button class="list-btn" id="delete-btn">삭제하기</button>
			</c:if>
			<button class="list-btn" id="to-list">목록으로</button>
		</div>
		<script>
			$('#to-list').click(function(){
				location.href = "notice.no?page=" + ${page}; // 이전으로 가기historyback
			});
		</script>
	</section>
</body>
</html>