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
		margin: auto;
		min-height: 900px;
		width: 80%;
		min-width:1000px;
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
		max-width: 1000px;
	}
	.inquiry-header{
		text-align: center;
		font-size: 25px;
		margin-bottom: 10px;
		font-weight: bolder;
	}
	#inquiry-table{
		width: 100%;
		height: 100%;
		border-top:2px solid rgba(245, 113, 92, 1);
		border-collapse: collapse;
		text-align: center;
	}
	#inquiry-table th{
		height: 30px;
		border-bottom: 1px solid rgba(245, 113, 92, 1);
	}
	#inquiry-table tr{
		height:30px;
	}
	#write{
		margin-left:90%;
		cursor:pointer;
		position: fixed;
	}
	.write-btn {
		position: fixed;
		border-radius: 50%;
		background: rgba(245, 113, 92, 1);
		width: 50px;
		height: 50px;
		text-align: center;
		top: 70%;
		right: 12%;
	}
	.write-btn>img {
		margin-top: 7px;
	}
	.write-btn:hover {
		cursor: pointer;
	}
	.paging-div {
		width: 250px;
		margin: auto;
		margin-top: 30px;
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

	.paging-div>p {
		background: rgba(39, 50, 56, 1);
		color: white;
	}	
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>

	<section>
		<div class="inquiry-div">
			<div class="inquiry-header">문의사항</div>
			<table id="inquiry-table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="b" items="${iList}">
					<tr class="contentTR">
						<td>
							<c:url var="inDetail" value="idetail.in">
								<c:param name="boardNo" value="${ iList.boardNo }"/>
								<c:param name="page" value="${pi.currentPage }"/>
							</c:url>
							<a href="${ inDetail }">${ iList.boardNo }</a>
						</td>
						
						<td>${ iList.bTitle }</td>
						<td>${ iList.bCount }</td>
						<td>${ iList.userId }</td>
						<td>${ iList.enrollDay }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<script>
		 	$(function(){
				$('.contentTR').mouseenter(function(){
					$(this).css({'background':'rgba(234, 234, 234, 1)','cursor':'pointer'});
				}).mouseout(function(){
					$(this).css({'background':'white'});
				}).click(function(){
					var boardNo = $(this).children('td').eq(0).text();
					location.href='idetail.in?boardNo=' + boardNo +'&page=' + ${pi.currentPage};
				});
			}); 
		</script>
		
		<!-- 1. 로그인 시 -------------->
<%-- 		<c:if test="${ !empty loginUser }"> --%>
		<div class="write-btn">
			<img src="${ contextPath }/resources/images/bookreview/write.png"/>
		</div>
<%-- 		</c:if> --%>
		
		<script>
			$('.write-btn').click(function(){
				location.href="<%=request.getContextPath()%>/write.in";
			});
		</script>
		
		<!-- 페이징 버튼 -->
		<div class="paging-div">
			<!------ 이전 --------->
			<c:if test="${ pi.currentPage <= 1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="inquiry.in">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!------ 버튼 --------->
			<c:forEach  var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${pi.currentPage ne p }">
					<c:url var="pNo" value="inquiry.in">
						<c:param name="page" value="${ p }"/>
					</c:url>
					<a href="${ pNo }">${ p }</a>
				</c:if>
				<c:if test="${ pi.currentPage eq p }">
					<p>${ p }</p>
				</c:if>
			</c:forEach>
			
			<!------ 다음 --------->
			<c:if test="${ pi.currentPage >= pi.endPage }">
				<p>&gt;</p>
			</c:if>
			<c:if test="${ pi.currentPage < pi.endPage }">
				<c:url var="Next" value="${ loc }">
					<c:param name="page" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<a href="${ Next }">&gt;</a>
			</c:if>
		</div>
	</section>
</body>
</html>