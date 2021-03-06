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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<style>
section {
font-family: 카페24 아네모네에어;
	background: rgba(246, 246, 246, 1);
	width: 80%;
	margin: auto;
	min-width: 1000px;
	border: 1px solid rgba(246, 246, 246, 1);
}

.top-div {
	width: 500px;
	height: 50px;
	margin: auto;
}

select {
	font-family: inherit;
	font-size: 15px;
	background: url('${contextPath}/resources/images/bookreview/arrow3.png') no-repeat 100%
		50%;
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
	width: 70px;
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

#like-sort {
	border-left: 1px solid black;
	border-right: 1px solid black;
	padding-left: 5px;
	padding-right: 5px;
}

.list-all-div {
	width: 70%;
	max-width: 1000px;
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
	margin-top: 20px;
}

.img-div {
	background: rgba(229, 229, 229, 1);
	height: 200px; 
	width: 200px;
	display:flex;
	justify-content: center;
	align-items: center;
}
.img-div>img{
	max-height:100%;
	max-width: 100%;
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
	overflow: hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
	height: 18px;
	width: 180px;
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
	overflow:hidden;
	text-overflow:ellipsis;
	white-space: nowrap;
	height: 15px;
	width: 190px;
}
.paging{width: 150px; margin:auto;text-align: center; margin-bottom: 50px;}
.paging-div {
	display:inline-block;
	max-width: 250px;
	margin-top: 50px;
}
.paging-div>a, .paging-div>p {
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

.paging-div>p {
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
	<%
      int cate = (int)request.getAttribute("searchCate");
      String[] select = new String[6];   
      for(int i = 0; i < select.length; i++){
         switch(cate){
         case 1: select[0] = "selected"; break;
         case 2: select[1] = "selected"; break;
         case 3: select[2] = "selected"; break;
         case 4: select[3] = "selected"; break;
         case 5: select[4] = "selected"; break;
         case 6: select[5] = "selected"; break;
         }
      }
   %>
		<div class="top-div">
			<div class="search-div">
				<select class="search-option" name="searchCondition" id="searchCondition">
					<option <%=select[0] %> value="title">title</option>
					<option <%=select[1] %> value="author">author</option>
					<option <%=select[2] %> value="book">book</option>
					<option <%=select[3] %> value="writer">writer</option>
					<option <%=select[4] %> value="content">content</option>
					<option <%=select[5] %> value="category">분류</option>
				</select>
				<input type="text" id="search-input" value="${ searchValue }">
				<span class="img-span">
					<img src="<%=request.getContextPath() %>/resources/images/bookreview/search.png" id="search-icon"/>
				</span>
			</div>
			<!-- 자동완성 -->
			<script src="//code.jquery.com/jquery.min.js"></script>
			<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
			<script>
				$('#search-icon').click(function(){
					search();
				});
				$('#search-input').keydown(function(key){
					if(key.keyCode == 13){
						search();
					}
				});	
				function search(){
					var searchCondition = $('#searchCondition').val();
					var searchValue = $('#search-input').val();
					
					location.href="<%=request.getContextPath()%>/search.re?searchCondition=" + searchCondition +"&searchValue=" + searchValue;
				}
				$(function(){
					var sc = '';
					$('#searchCondition').change(function(){
						sc = $(this).val();
					});
					var category = ['총류','기술과학','역사','문학','자연과학','철학','종교','사회과학','예술','언어'];
					$('#search-input').keyup(function(){
						if(sc == 'category'){
							$('#search-input').autocomplete({
								source : category
							});
						}
					});
				});
			</script>
			<div class="sort-div">
				<% String sortValue = (String)request.getAttribute("sortValue"); %>
				<% if(sortValue != null){ %>
					<% if(sortValue.equals("lated")){ %>
						<h4 class="sort-h4" id="lated-sort" style="font-weight: bolder;" >최신순</h4>
					<%}else{ %>
						<h4 class="sort-h4" id="lated-sort">최신순</h4>
					<%} %>
					<% if(sortValue.equals("like")){ %>
						<h4 class="sort-h4" id="like-sort" style="font-weight: bolder;">좋아요</h4>
					<%}else{ %>			
						<h4 class="sort-h4" id="like-sort">좋아요</h4>
					<%} %>
					<% if(sortValue.equals("count")){ %>
						<h4 class="sort-h4" id="count-sort" style="font-weight: bolder;">조회순</h4>
					<%}else{ %>
						<h4 class="sort-h4" id="count-sort">조회순</h4>
					<%} %>
				<%}else{ %>
					<h4 class="sort-h4" id="lated-sort">최신순</h4>
					<h4 class="sort-h4" id="like-sort">좋아요</h4>
					<h4 class="sort-h4" id="count-sort">조회순</h4>
				<%} %>
			</div>
		</div>
		
		<script>
			$('#lated-sort').click(function(){sort('lated');});
			$('#like-sort').click(function(){sort('like');});
			$('#count-sort').click(function(){sort('count');});
			function sort(value){
				var searchCondition = $('#searchCondition').val();
				var searchValue = $('#search-input').val();
				
				location.href="searchsort.re?sortValue=" + value +"&searchCondition=" + searchCondition +"&searchValue=" + searchValue;
			}
		</script>
		
		<div class="list-all-div">
			
			<%
				ArrayList<Board> bList = (ArrayList<Board>)request.getAttribute("bList");
				ArrayList<Attachment> atList = (ArrayList<Attachment>)request.getAttribute("atList");
				String[] wiseArr = (String[])request.getAttribute("wiseArr");
				String[] contentArr = (String[])request.getAttribute("contentArr");
			%>
			<% for(int i = 0; i < bList.size();i++){ %>
				<div class="list-div">
					<div class="img-div">
						<%for(Attachment at: atList){%>
							<%if(bList.get(i).getBoardNo() == at.getBoardNo()){ %>
								<img class="list-img" src="resources/buploadFiles/<%=at.getAtcName()%>">
							<%}else{ %>
								<img class="list-img">
							<%} %>
						<%} %>
					</div>
					<input type="hidden" id="boardNo" value="<%=bList.get(i).getBoardNo()%>">
					<div class="content-div">
						<ul class="content-ul">
							<li class="title-li"><%=bList.get(i).getbTitle()%></li>
							<li class="tag-li">
								#<%=bList.get(i).getUserId() %> 
								<% if(!bList.get(i).getCate().equals("null")){ %>
								#<%=bList.get(i).getCate() %>
								<%} %>
							</li>
							<li class="writer-li"><%=bList.get(i).getUserId() %></li>
							<li class="wise-li">
								<%=wiseArr[i] %>
								<%if(wiseArr[i].equals("")){ %>
									<%=contentArr[i] %>
								<%} %>
							</li>
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
		<div class="paging">
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
				<c:if test="${ pi.currentPage < pi.endPage }">
					<c:url var="next" value="${ loc }">
						<c:param name="page" value="${ pi.currentPage + 1 }"/>
					</c:url>
					<a href="${next}">&gt;</a>
				</c:if>
				<c:if test="${pi.currentPage >= pi.endPage }">
					<p>&gt;</p>
				</c:if>
				
			</div>
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
	<%@include file="../common/footer.jsp" %>
</body>
</html>