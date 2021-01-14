<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<link rel="stylesheet" href="${contextPath}/resources/css/TIW/TIWListForm.css" type="text/css">

<style>
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		margin-top:100px; margin-bottom: 5%; min-width: 1000px;
		background-color:  #F6F6F6;
	}
.autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; }
.autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; cursor: pointer; }
.autocomplete-selected { background: blue; color: white; }
.autocomplete-suggestions strong { font-weight: bold; color: orange; }
.autocomplete-group { padding: 2px 5px; }
.autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	<div class="outer">
	
	<h2 class="txt_TIW" align="center">오늘은 나도 작가</h2>
	
	<h3 align="center">총 게시글 갯수 : ${ pi.listCount }</h3>
	
		<table id="TIWTable" align="center">
			<tr>
				<th>글 번호</th>
				<th>원작</th>
				<th>제목</th>
				<th>작가</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="b" items="${ list }">
			<tr class="contentTR">
				<td align="center">${ b.boardNo }</td>
				<td align="center">
					<c:url var="searchTIWCate" value="searchTIWCate.to">
						<c:param name="cate" value="${ b.cate }"/>
						<c:param name="userId" value="${ b.userId }"/>
					</c:url>
					<a href="${ searchTIWCate }">${ b.cate }</a>
				</td>
				<td align="left">
					<c:if test="${ !empty loginUser }">
						<c:url var="TIWdetail" value="TIWdetail.to">
							<c:param name="boardNo" value="${ b.boardNo }"/>
							<c:param name="page" value="${ pi.currentPage }"/>
							<c:param name="User" value="${ loginUser.id }"/>
						</c:url>
						<a href="${ TIWdetail }">${ b.bTitle }(${ b.comCount })	</a>
					</c:if>
					<c:if test="${ empty loginUser }">
						${ b.bTitle }(${ b.comCount })		
					</c:if>
				</td>
				
				<td align="center">${ b.userId }</td>
				<td align="center">${ b.enrollDay }</td>
				<td align="center">${ b.bCount }</td>
			</tr>
			</c:forEach>
		</table>
		
		<!-- 오늘은 나도 작가 리스트 페이징 부분 -->
			<div class="pagingArea" align="center">
				<!-- 이전으로 -->
				<c:if test="${ pi.currentPage <= 1 }">
					<
				</c:if>
				<c:if test="${ pi.currentPage > 1 }">
					<c:url var="blistBack" value="${ loc }">
						<c:param name="currentPage" value="${ pi.currentPage -1 }"/>
					</c:url>
					<a href="${ blistBack }"><</a>
				</c:if>
				
				<!-- [번호] -->
				<c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
					<c:if test="${ p eq pi.currentPage }">
						<font color="red" size="4"><b>${ p }</b></font>
					</c:if>
					<c:if test="${ p ne pi.currentPage}">
						<c:url var="blistCheck" value="${ loc }">
							<c:if test="${ searchValue ne null }">
								<c:param name="searchCondition" value="${ searchCondition }"/>
								<c:param name="searchValue" value="${ searchValue }"/>
							</c:if>
							<c:param name="currentPage" value="${ p }"></c:param>
						</c:url>
						<a href="${ blistCheck }">${ p }</a>
					</c:if>
				</c:forEach>
				<!-- 다음으로 -->
				<c:if test="${ pi.currentPage >= pi.maxPage }">
					>
				</c:if>
				<c:if test="${ pi.currentPage < pi.maxPage }">
					<c:url var="blistNext" value="${ loc }">
						<c:if test="${ searchValue ne null }">
							<c:param name="searchCondition" value="${ searchCondition }"/>
							<c:param name="searchValue" value="${ searchValue }"/>
						</c:if>
						<c:param name="currentPage" value="${ pi.currentPage + 1 }"/>
					</c:url>
					<a href="${ blistNext }">></a>
				</c:if>
			</div>
		<div class="insertbuttonArea" align="right">			
			<c:if test="${ loginUser ne null }">
				<input type="button" onclick="location.href='writeTIW.to';" id="writeTIWBtn" class="btn1" value="글쓰기">
			</c:if>
		</div>
		
		<!---------------- 3. 게시물 검색 ------------------>
		<div id="searchArea" align="center">
			<label>찾아보기</label>
			<select id="searchCondition" name="searchCondition">
				<option>선택하세요</option>
				<option value="writer">작가</option>
				<option value="title">글 제목</option>
				<option value="content">내용</option>
			</select>
			
			
			<input id=autocomplete type="text">
			<button onclick="searchBoard();">검색!</button>
			
		</div>
		<script src="//code.jquery.com/jquery.min.js"></script>
		<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.2.26/jquery.autocomplete.min.js'></script>
		<script type="text/javascript">
			function searchBoard(){
				var searchCondition = $("#searchCondition").val();
				var searchValue = $("#autocomplete").val();
				
				location.href="searchTIW.to?searchCondition="+searchCondition+"&searchValue="+searchValue;
			}
			
			$('#autocomplete').keyup(function serchTT(){
				var tTitle = $.trim($(this).val());
				var currencies;
				
				if(tTitle.length>0){
					$.ajax({
						type: 'POST',
						url: "searchTTitle.to",
						data: {tTitle:tTitle},
						dataType: 'json',
						success:function(data){		
							console.log(data);
							
							currencies  = data;
							
							$("#autocomplete").autocomplete({
								lookup: currencies
							});
						}
					});
				}
				
			});
		
		</script>
	</div>
	
	<%-- <%@ include file="../common/footer.jsp" %> --%>
</body>
</html>