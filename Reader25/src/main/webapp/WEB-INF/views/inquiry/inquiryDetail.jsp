<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
		background: rgba(246, 246, 246, 1);
		width: 80%;
		min-height: 900px;
		min-width: 1000px;
		margin:auto;
		padding-top: 20px;
	}
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
	.comments{
		width: 80%;
		max-width: 800px;
		min-height: 100px;
		background: white;
		margin: auto;
		margin-top: 20px;
		padding: 20px;
	}
	#comment-table{
		margin: auto;
		width: 95%;
	}
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
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
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
				</div>
				
				<!-- 이미지 파일 넣기 -->
				<div class="image-div">
					<img src="<%=request.getContextPath()%>/buploadFiles/${ Attachment.atcName }">
				</div>
				<!-- ---------- -->
				
				<div class="contents">
					<span>${ board.bContent }</span>
				</div>
				
				<div class="reply-writer" id="acuserId">
					<span ></span>
				</div>
				<div class="reply-div" id="acComment">
					<span ></span>
				</div>
				
				<div class="adminComments">
					<c:if test="${ loginUser.id eq 'admin' }">
						<table class="adminCommentsTable"  align="center">
							<tr>
								<td rowspan="2"><textarea rows="3" cols="55" id="comment" placeholder="댓글을 입력해 주세요"></textarea></td>
								<td><input type="text" name="userId" id="writer" readonly value="${ loginUser.id }"></td>
							</tr>
							<tr>
								<td><button id="cSubmit">등록하기</button></td>
							</tr>
						</table>
					</c:if>
				</div>
				
				<script>
				
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
								alert("댓글이 등록되었습니다.");
							}
						}
					});
				});
				
				//관리자 댓글 리스트 불러오기
				function getACList(){
					var boardNo = ${ board.boardNo };
					var userId = 'admin';
					//console.log(value);
					var $acuserId;
					var $acComment;
					
					$.ajax({
						url: "aCList.in",
						data: {boardNo:boardNo, userId:userId},
						success: function(data){
							console.log(data)
							//댓글 넣기
							
							
							if(data.length > 0){
								for(var i in data){
									$userId = text(data[i].userId);
									$Comment = text(data[i].comment);
								}
							} else {
								$acuserId = $('');
								$acComment = $('아직 답변이 없습니다');
							}
							$acuserId.append($userId);
							$acComment.append($Comment);
						}
					});
				}
				
				$(function(){
					getACList();
					 setInterval(function(){
						 getACList(1);
					}, 1000); 
				});
				
				</script>
				
			</div>
		</div>
		<form id="comments-form" action="<%=request.getContextPath()%>/write.co">
			<div class="comments">
				<div class="comment-list">
					<table id="comment-table">
						<tr>
							<td>user01</td>
							<td>좋은 아이디어에요!</td>
							<td>2020-12-20</td>
						</tr>
					</table>
				</div>
				<div class="write-comment">
					<input type="text" id="comment-input" name="comments" placeholder="댓글을 입력하세요">
					<input type="submit" id="comment-submit" value="등록">
				</div>
			</div>
		</form>
		<div class="btn-div">
			<!-- 관리자아이디  또는 글쓴이  -->
			<button class="list-btn" id="modify-btn">수정하기</button>
			<button class="list-btn" id="delete-btn">삭제하기</button>
			<!-- ------- -->
			<button class="list-btn">목록으로</button>
		</div>
		<script>
			$('#list-btn').click(function(){
				//location.href = ${loc}; // 이전으로 가기historyback
			});
		</script>
	</section>
</body>
</html>