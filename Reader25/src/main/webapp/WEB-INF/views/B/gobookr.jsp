<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	/*line-height: 180px;  이미지 가운데로 넣기 */
	height: 200px; 
	text-align: center;
}
.img-div>img{
	max-height:200px;
	max-width: 200px;
  	object-fit: cover;
  	vertical-align: middle;
}

.list-img {
	display:inline-block;
	height: auto;
	margin:auto;
}

.content-div {
	background: white;
	height: 100px;
}

.content-ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	padding: 5px;
}

.content-ul>li {
	margin: 0;
	margin-top: 2px;
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
 	padding: 0;
	margin: 0;
	display: inline-block;
	width: 30px;
	height: 30px;
	color: rgba(85, 83, 83, 1);
	font-size: 17px;
	background: rgba(229, 229, 229, 1);
	border: none;
	text-decoration: none;
	text-align: center;
	vertical-align: middle;
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
			<%	ArrayList<Board> bList = (ArrayList<Board>)request.getAttribute("bList");
				ArrayList<Attachment> atList = (ArrayList<Attachment>)request.getAttribute("atList");%>
			<% for(Board b : bList){ %>
				<div class="list-div">
					<div class="img-div">
						<%for(Attachment at: atList){%>
							<%if(b.getBoardNo() == at.getBoardNo()){ %>
								<img class="list-img" src="resources/buploadFiles/<%=at.getAtcName()%>">
							<%}else{ %>
								<img class="list-img">
							<%} %>
						<%} %>
					</div>
					<input type="hidden" id="boardNo" value="<%=b.getBoardNo()%>">
					<div class="content-div">
						<ul class="content-ul">
							<li class="title-li"><%=b.getbTitle()%></li>
							<li class="tag-li">#작가 #분야</li>
							<li class="writer-li"><%=b.getUserId() %></li>
							<li class="wise-li">명언</li>
						</ul>
					</div>
				</div>
			<%} %>
		</div>
      <script>
  			$('.list-div').on('click',function(){
				var boardNo = $(this).children('#boardNo').val();
				location.href = "redetail.re?boardNo="+boardNo+"&page="+${pi.currentPage};
			}).mouseenter(function(){
				$(this).css({'cursor':'pointer','box-shadow':'2px 2px 2px 2px lightgray', });
			}).mouseout(function(){
				$(this).css('box-shadow','none');
			});
      </script>
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
				<a href="${next}">&gt;</a>
			</c:if>
			<c:if test="${pi.currentPage < pi.endPage }">
				<p>&gt;</p>
			</c:if>
			
		</div>
		<c:if test="${ !empty loginUser }">
			<div class="write-btn">
				<img src="${contextPath}/resources/images/bookreview/write.png"/>
			</div>
			<script>
				$('.write-btn').click(function(){
					location.href="<%=request.getContextPath()%>/write.re";
				});
			</script>
		</c:if>
	</section>
</body>
</html>