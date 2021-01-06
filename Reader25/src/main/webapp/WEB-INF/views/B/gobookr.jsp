<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookReview</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
<style>
section {
	background: rgba(246, 246, 246, 1);
	width: 80%;
	margin:auto;
	min-width: 1000px;
}
.dddd{
text-align: center;

}

.top-div {
	width: 500px;
	height: 50px;
	margin: auto;
}

select {
	font-family: inherit;
	font-size: 15px;
	background: url('/Reader25/images/bookreview/arrow3.png') no-repeat 100% 50%;
	border-radius: 0px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	padding: 2px;
}

select::-ms-expand {
	display: none;
}

.search-div {
	margin: 0px;
	padding: 0px;
	display: inline-block;
	border-bottom: 1px solid black;
}

.search-option {
	border: none;
	width: 50px;
}

#search-input {
	background: none;
	border: none;
	width: 220px;
}

#search-icon {
	float: right;
	width: 20px;
}

#search-icon:hover {
	cursor: pointer;
}

.sort-div {
	margin-left: 13px;
}

.sort-div, .sort-div>h4 {
	clear: both;
	display: inline-block;
}

.sort-div>h4 {
	font-size: 15px;
	font-weight: normal;
}

.sort-div>h4:hover {
	font-weight: bolder;
	cursor: pointer;
}

#like-h4 {
	border-left: 1px solid black;
	border-right: 1px solid black;
	padding-left: 5px;
	padding-right: 5px;
}

.list-all-div {
	width: 90%;
	min-height: 800px;
	margin: auto;
	margin-top: 20px;
	text-align: center; /*  */
}

.list-div {
	text-align: left;
	width: 200px;
	height: 300px;
	display: inline-block;
	margin-left: 1%;
}

.img-div {
	background: rgba(229, 229, 229, 1);
	line-height: 180px; /* 이미지 가운데로 넣기 */
}

.list-img {
	height: auto;
	width: 100%;
	vertical-align: middle;
}

.content-div {
	background: white;
}

.content-ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	padding: 5px;
}

.content-ul>li {
	margin: 0;
	width: 100%;
}

.title-li {
	font-weight: bold;
}

.tag-li {
	font-size: 13px;
	color: rgba(245, 113, 92, 1);
}

.writer-li {
	font-size: 10px;
}

.wise-li {
	font-size: 13px;
}

.paging-div {
	width: 250px;
	margin: auto;
	margin-top: 10px;
}

.paging-div>a, .paging-div>p{
	width: 30px;
	height: 30px;
	color: rgba(85, 83, 83, 1);
	font-size: 15px;
	background: rgba(229, 229, 229, 1);
	border: none;
}

.paging-div>a:hover {
	font-weight: bold;
	background: rgba(220, 220, 220, 1);
}

.paging-div>p{
	background: rgba(39, 50, 56, 1);
	color: white;
}

.write-btn {
	position: fixed;
	border-radius: 50%;
	background: rgba(245, 113, 92, 1);
	width: 50px;
	height: 50px;
	text-align: center;
	top: 90%;
	right: 12%;
}

.write-btn>img {
	margin-top: 7px;
}

.write-btn:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<section>
		<br>
		<h4 class="dddd">중고 책 거래</h4>
		
		
		<div class="top-div">
			<div class="search-div">
				<select class="search-option">
					<option selected="selected">title</option>
					<option>author</option>
					<option>writer</option>
				</select>
				<input type="text" id="search-input">
				<span class="img-span">
					<img src="<%=request.getContextPath() %>/resources/images/bookreview/search.png" id="search-icon"/>
				</span>
			</div>
			<script>
				$('#search-icon').click(function(){
					location.href="<%=request.getContextPath()%>/search";
				});				
			</script>
			<div class="sort-div">
				<h4 class="sort-h4">최신순</h4>
				<h4 class="sort-h4" id="like-h4">좋아요</h4>
				<h4 class="sort-h4">북마크</h4>
			</div>
		</div>
		
		      <div class="list-all-div">
         <c:forEach items="${bList}" var="b">
            <div class="list-div">
               <div class="img-div">
               <c:forEach items="${atList}" var="a">
                  <c:if test="${a.boardNo == b.boardNo }">
                     <img class="list-img" src="${ contextPath }/resources/buploadFiles/${a.atcName}">
                  </c:if>
                  <c:if test="${a.boardNo != b.boardNo }">
                     <img class="list-img" src="#">
                  </c:if>
               </c:forEach>
               </div>
               <input type="hidden" id="boardNo" value="${ b.boardNo }">
               <div class="content-div">
                  <ul class="content-ul">
                     <li class="title-li">${b.bTitle }</li>
                     <li class="tag-li">#작가 #분야</li>
                     <li class="writer-li">${b.userId }</li>
                     <li class="wise-li">명언</li>
                  </ul>
               </div>
            </div>
         </c:forEach>
      </div>
      
      <script>
         $('.list-div').click(function(){
            var boardNo = $(this).children('#boardNo').val();
            location.href = "bookroomD.bo?boardNo="+boardNo+"&page="+${pi.currentPage}; 
            //location.href =페이지를 넘겨주는것 게시물 번호   게시물번호를 받아온것  페이지 값을 넘겨준다  ${pi.currentPage}; = pi에 있는 커런트페이지 를 가져오는것
         });
      </script>
	<%-- 	<div class="list-all-div">
			<% for(int i = 0; i < 12; i++){ %>
			<div class="list-div">
			
				<div class="img-div" >
					<img class="list-img" src="${ contextPath }/resources/images/bookreview/book.jpg">
				</div>
				<div class="content-div">
					<ul class="content-ul">
						<li class="title-li">제목</li>
						<li class="tag-li">#작가 #분야</li>
						<li class="writer-li">회원ID</li>
						<li class="wise-li">명언</li>
					</ul>
				</div>
			</div>
			<%} %>
		</div> --%>
		<div class="paging-div">
			<!-- 이전 -->
			<c:if test="${ pi.currentPage <=1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="${ loc }">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!-- 번호 -->
			<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
				<c:if test="${ pi.currentPage eq p }">
					<p>${ p }</p>
				</c:if>
				<c:if test="${ pi.currentPage ne p }">
					<c:url var="pNo" value="${ loc }">
						<c:param name="page" value="${ p }"/>
					</c:url>
					<a href="${ pNo }">${ p }</a>
				</c:if>
			</c:forEach>
			
			<!-- 다음 -->
			<c:if test="${ pi.currentPage >= pi.endPage }">
				<c:url var="next" value="${ loc }">
					<c:param name="page" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<a href="${next }">&gt;</a>
			</c:if>
			<c:if test="${pi.currentPage < pi.endPage }">
				<p>&gt;</p>
			</c:if>
			
		</div>
<%-- 		<c:if test="${ !empty loginUser }"> --%>
			<div class="write-btn">
				<img src="${contextPath}/resources/images/bookreview/write.png"/>
			</div>
			<script>
				$('.write-btn').click(function(){
					location.href="<%=request.getContextPath()%>/write.re";
				});
			</script>
<%-- 		</c:if> --%>
	</section>
</body>
</html>