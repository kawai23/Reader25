<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<style>
/*화면*/
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		margin-bottom: 5%; min-width: 1000px;
		padding-top: 15px;
		background-color:  #F6F6F6; 
		font-family: 카페24 아네모네에어;
	}
/*테이블*/
#TIWTable{
	font-size:18px;
	font-family: 카페24 아네모네에어;
	text-align: center;
	margin: auto; 
	width: 850px;
}
#TIWTable th{
	background: #F7B45E;
}
/*검색*/
input, select{
	width: 130px;
	height: 30px;
	background: #EAEAEA;
	text-align: center; 
	border: none;
	font-size:17px; 
	font-family: 카페24 아네모네에어;
}
/*글자*/
.txt_TIW{
	font-size:40px;
	font-family: 카페24 아네모네;
	text-align: center;
}
#up{color:red;}
/*버튼*/
.btn1 {
	width:150px;
    height: 40px;
    margin-right: 50px;
	font-size: 17px; font-weight: bold;
	border: 1px solid  #FFC398;
    background-color:  #FFC398;
    font-family: 카페24 아네모네에어;
}
.btn2{
	width:100px;
    height: 30px;
    margin-right: 50px;
	font-size: 15px; font-weight: bold; color:#000000;
	border: 1px solid  #C4C4C4;
    background-color:  #C4C4C4;
    font-family: 카페24 아네모네에어;
}
/*페이징*/
.paging-div{
		width: 250px;
		margin: auto;
		margin-top: 30px;
		text-align: center;
}
.paging-div>a, .paging-div>p {
		padding:0;
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
/*자동완성 관련*/
.autocomplete-suggestions { border: 1px solid #999; background: #EAEAEA; overflow: auto; font-size:17px; font-family: 카페24 아네모네에어;}
.autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; cursor: pointer; }
.autocomplete-selected { background: #FFC6C6; color: white; }
.autocomplete-suggestions strong { font-weight: bold; color: orange; }
.autocomplete-group { padding: 2px 5px; }
.autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	<div class="outer">
	
	<h2 class="txt_TIW" align="center">오늘은 나도 작가</h2>
	
	<h3 align="center">총 게시글 갯수 : <a id="up">${todayListCount}</a> / ${ pi.listCount }</h3>
	
		<table id="TIWTable" align="center">
			<tr>
				<th>글 번호</th>
				<th>원작</th>
				<th width="350px">제목</th>
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
		<!-- 페이징 버튼 -->
		<div class="paging-div">
			<!------ 이전 --------->
			<c:if test="${ pi.currentPage <= 1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="goTIWList.to">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!------ 버튼 --------->
			<c:forEach  var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${pi.currentPage ne p }">
					<c:url var="pNo" value="goTIWList.to">
						<c:param name="page" value="${ p }"/>
					</c:url>
					<a href="${ pNo }">${ p }</a>
				</c:if>
				<c:if test="${ pi.currentPage eq p }">
					<p>${ p }</p>
				</c:if>
			</c:forEach>
			
			<!------ 다음 --------->
			<c:if test="${ pi.currentPage >= pi.maxPage }">
				<p>&gt;</p>
			</c:if>
			<c:if test="${ pi.currentPage < pi.maxPage }">
				<c:url var="Next" value="${ loc }">
					<c:param name="page" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<a href="${ Next }">&gt;</a>
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
			<button class="btn2" onclick="searchBoard();">검색!</button>
			
		</div>
		
		<br><br><br><br>
		
		<script src="//code.jquery.com/jquery.min.js"></script>
		<script src='//cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.2.26/jquery.autocomplete.min.js'></script>
		<script type="text/javascript">
			function searchBoard(){
				var searchCondition = $("#searchCondition").val();
				var searchValue = $("#autocomplete").val();
				
				location.href="searchTIW.to?searchCondition="+searchCondition+"&searchValue="+searchValue;
			}
			
			$('#autocomplete').keyup(function(){
				var searchCondition = $("#searchCondition").val();
				var tTitle = $.trim($(this).val());
				var currencies;
				
				if(tTitle.length>0){
					
					$.ajax({
						type: 'POST',
						url: "searchTIWsub.to",
						data: {tTitle:tTitle,searchCondition:searchCondition},
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