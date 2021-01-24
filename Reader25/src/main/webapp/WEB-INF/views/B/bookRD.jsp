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
section {
	border: 1px solid rgba(246, 246, 246, 1);
	background: rgba(246, 246, 246, 1);
	width: 80%;
	margin: auto;
	min-width: 1000px;
}

.list-info {
	border-bottom: 1px solid rgb(200, 200, 200);
	padding-top: 30px;
	padding-bottom: 10px;
	width: 80%;
	margin: auto;
	max-width: 1000px;
}

.list-info p {
	display: inline-block;
	color: rgb(100, 100, 100);
	margin-left: 10px;
}

.count-p {
	float: right;
	margin-right: 10px
}

.book-box {
	margin-top: 20px;
	margin: auto;
	max-width: 1000px;
	width: 80%;
}
*{border:1px solid pink;}
.img-div{
	height: 250px;
	width: 300px;
	box-sizing: border-box;
	text-align: center;
	margin:auto;
	background:lightgray;
}
.slide {
	font-size: 0;
	white-space: nowrap;
	overflow: hidden;
}

.slide ul {
	white-space: nowrap;
	overflow: hidden;
	display: inline-block;
	
}
.slide ul li {
	display: inline-block;
}
.slide ul li img{
	max-height: 250px;
	max-width: 300px;
}
#back {
	position: absolute;
	top: 380px;
	left: 30%;
	cursor: pointer;
	z-index: 1;
}

#next {
	position: absolute;
	top: 380px;
	right: 30%;
	cursor: pointer;
	z-index: 1;
}

/* 책제목  */
.info-box {
	clear:both;
	width: 80%;
}

.info-contents {
	width: 80%;
	margin: auto;
	max-width: 1000px;
}

.title {
	display: inline-block;
	margin: auto;
	margin-top: 80px;
	width: 100%;
	font-size: 30px;
}

.tag {
	display: inline;
	margin: 10px;
	margin-right: 0px;
	color: gray;
	font-size: 13px;
}

#quote1 {
	float: left;
}

#quote2 {
	float: right;
}

.wise-content {
	display: inline-block;
	margin-top: 10px;
}
/* 내용박스*/
.rectangle-box {
	margin: auto;
	line-height: 600px;
	max-width: 1000px;
	height: 364.58px;
	position: relative;
	border-bottom: 1px solid rgb(200, 200, 200);
}
/*  내용  */
.contents {
	width: 80%;
	height: 448px;
	left: 344px;
	top: 1633px;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 47px;
	color: #000000;
	border-bottom: 1px solid rgb(200, 200, 200);
}

.contents>p {
	margin: 15px;
}

.paging-btn {
	width: 200px;
	margin: auto;
	margin-top: 10px;
	text-align: center;
}

.paging-btn a, .paging-btn p {
	display: inline-block;
	margin-left: 6px;
}

.paging-btn a:hover {
	font-weight: bolder;
	cursor: pointer;
}

.btns-div {
	font-size: 18px;
	height: 25px;
	position: relative;
	float: right;
	margin-right: 10%;
	top: -30px;
}

.write-btn {
	background: rgba(255, 195, 152, 1);
	width: 80px;
	border: none;
	height: 25px;
	color: white;
}

.delete-btn {
	background: rgba(103, 73, 44, 1);
	width: 80px;
	border: none;
	height: 25px;
	color: white;
}

.modify-btn {
	background: rgba(201, 95, 18, 1);
	width: 80px;
	border: none;
	height: 25px;
	color: white;
}

.list-btn {
	background: rgba(196, 196, 196, 1);
	width: 80px;
	border: none;
	height: 25px;
	color: white;
}

.write-btn:hover {
	background: rgba(245, 185, 142, 1);
	cursor: pointer;
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

.modal-close, .modal-accept {
	background-color: rgba(137, 18, 18, 1);
	color: white;
	width: 80px;
	height: 30px;
	border: none;
	display: inline-block;
	left: 40%;
}

.modal-accept {
	background-color: rgba(85, 83, 83, 1);
}

.modal p {
	display: inline-block;
}

.modal img {
	position: relative;
	top: 10px;
}

.comment-box {
	width: 80%;
	margin: auto;
	margin-top: 10px;
	max-width: 1000px;
	border-bottom: 1px solid rgb(200, 200, 200);
	padding-bottom: 40px;
}

.comment-date {
	color: rgb(180, 180, 180);
	display: inline-block;
	margin-left: 10px;
	font-size: 12px;
}

.comment-write {
	border: 1px solid rgb(200, 200, 200);
	background: white;
	height: 100px;
}

.comment-box button {
	font-size: 13px;
	height: 25px;
	float: right;
	background: rgba(85, 83, 83, 1);
	width: 80px;
	margin: 5px;
	color: white;
}

.comment {
	border-bottom: 1px solid rgb(230, 230, 230);
	margin: 5px;
}

.comment-content {
	margin: 6px;
	font-size: 13px;
	color: rgba(85, 83, 83, 1);
}

.user-div {
	width: 97%;
	margin: auto;
}

.text-count {
	float: right;
	color: rgb(200, 200, 200);
}

.comment-box textarea {
	clear: both;
	margin: 8px;
	width: 97%;
	height: 55%;
	resize: none;
	border: none;
}

.purchase-btn {
	clear:both;
	width: 80%;
	margin: auto;
	margin-top: 50px;
	max-width: 1000px;
}

.a {
	width: 210px;
	margin: auto;
	margin-top: 30px;
}

.pcs-btn {
	box-shadow: inset 0px 1px 0px 0px #cf866c;
	background: linear-gradient(to bottom, #C95F12 5%, #C95F12 100%);
	background-color: #d0451b;
	border-radius: 3px;
	border: 1px solid #942911;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 13px;
	padding: 6px 24px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #854629;
}

.pcs-btn:hover {
	background: linear-gradient(to bottom, #bc3315 5%, #d0451b 100%);
	background-color: #bc3315;
}

.pcs-btn:active {
	position: relative;
	top: 1px;
}

.cart-btn {
	box-shadow: inset 0px 1px 0px 0px #cf866c;
	background: linear-gradient(to bottom, #F09661 5%, #F09661 100%);
	background-color: #d0451b;
	border-radius: 3px;
	border: 1px solid #942911;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 13px;
	padding: 6px 24px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #854629;
}

.cart-btn:hover {
	background: linear-gradient(to bottom, #bc3315 5%, #d0451b 100%);
	background-color: #bc3315;
}

.cart-btn:active {
	position: relative;
	top: 1px;
}
<!--
============================
여기까지
 
슬라이드
 
배너
  
============================
-->
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
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
		});
	</script>
<!-- ================================================================ -->
	<section>
		<div class="list-info">
			<p>${ board.userId } ${board.updateDay }</p>
			<p class="count-p">조회수 : ${ board.bCount } </p>
		</div>
		<!---------------------------------- 작성자 이미지 ------------------------------------>
      <div class="book-box">
           <div class="img-div">
               <c:if test="${atlist ne null}">
                  <div class="slide">
                     <img id="back" src="resources/images/bookreview/back.png" alt=""
                        width="100">
                     
                        <ul>
                        <c:forEach items="${ atlist }" var="at">
                           <li><img src="resources/buploadFiles/${at.atcName}" /></li>
                        </c:forEach>
                        </ul>
                     
                     <img id="next" src="resources/images/bookreview/next.png" alt=""
                        width="100" >
                  </div>
               </c:if>
         </div>
         <div class="purchase-btn">
            <div class="a">
               <span class="pcs-btn">구매하기</span> 
               <span class="cart-btn">장바구니</span>
            </div>
         </div>
         <script type="text/javascript">
            $(document).ready(function() {
               var imgs;
               var img_count;
               var img_position = 1;
               imgs = $(".slide ul");
               img_count = ${atlist.size()};
               //버튼을 클릭했을 때 함수 실행
               $('#back').click(function() {
                  back();
               });
               $('#next').click(function() {
                  next();
               });
               function back() {
                  if (1 < img_position) {
                     imgs.animate({
                        left : '+=1000px'
                     });
                     img_position--;
                  }
               }
               function next() {
                  if (img_count > img_position) {
                     imgs.animate({
                        left : '-=1000px'
                     });
                     img_position++;
                  }
               }
            });
         $('.cart-btn').click(function(){
             var sb_v = 1;
             var user_id = '${loginUser.id}';
             var book_no = 1;
             var price = 10000;
             $.ajax({
                url: 'insertCart.tr',
                data:{price:price, book_no:book_no, sb_v:sb_v, user_id:user_id},
                success: function(data){
                	console.log(data);
		        	var check = confirm("장바구니 추가가 되었습니다. 장바구니로 이동하겠습니까?");
					if(check){
						location.href="<%=request.getContextPath()%>/cart.bo";
					}
                }
             });
         });
         
         $('.pcs-btn').click(function(){
            location.href="<%=request.getContextPath()%>/pcs.bo";
         });
         </script>
      </div>
      <!---------------------------------- 책제목 ------------------------------------>
      <div class="info-box">
	      <div class="info-contents">
	         <h3 class="title">책제목: ${ board.bTitle }</h3>
	         <p class="tag">#제목</p>
	         <span class="info" id="author">${booktitle }</span>
	         <p class="tag">#작가</p>
	         <span class="info" id="sort">${author }</span> <br>
	         <p class="tag">거래자</p>
	         <span class="info" id="sort">${board.userId }</span>
	         <%-- <p class="tag">금액</p>
	         <span class="info" id="sort">${board.userAmount }</span> --%>
	         
	      </div>
      </div>
      <!---------------------------------- 내용박스 ------------------------------------>
      <div class="rectangle-box"> 
         <div class="contents">${board.bContent}</div>
      </div>
	
		
		<!---------------------------------- 리뷰 ------------------------------------>
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
		</div>
		<script>
		 $(function(){
			 getComments(1);
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
		
		
		<div class="btns-div">
		<c:if test="${loginUser ne null }">
			<c:if test="${ loginUser.id eq board.userId }">
				<button class="modify-btn" onclick="location.href='modify.bo?boardNo='+${board.boardNo}+'&page='+${page}">수정하기</button>
				<button class="delete-btn" onclick="deleteReview();">삭제하기</button>
			</c:if>
			<c:if test="${loginUser.id ne board.userId }">
				<button class="write-btn" onclick='location.href="write.re"'>리뷰쓰기</button>
			</c:if>
		</c:if>
		<button class="list-btn" onclick='location.href="book.bo?page="+${page}'>목록보기</button>
		</div>
		<script>
			function deleteReview(){
				$('#del-modal').show();
				 $('#del-modal .modal').show();
				 $('#del-modal .modal-accept').click(function(){
					location.href='delete.bo?boardNo='+${board.boardNo};
				});
			}
		</script>
   </section>
</body>
</html>