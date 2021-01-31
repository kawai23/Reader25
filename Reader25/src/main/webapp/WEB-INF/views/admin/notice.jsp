<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		background:rgba(246, 246, 246, 1);
	}
	section{
		display:inline-block;
		min-height: 700px;
		position: absolute;
		left:160px;
		margin-left: 10px;
 		width: 80%;
 		min-width: 700px; 
	}
	#logo-img:hover{cursor:pointer;}
	.notice-div{
		min-height: 100px; 
		background: white;
		margin: auto;
		margin-top: 20px;
		padding: 10px;
		max-width: 1100px;
	}
	#notice-table{
		width: 100%;
		height: 100%;
		border-top:2px solid rgba(245, 113, 92, 1);
		border-collapse: collapse;
		text-align: center;
	}
	#notice-table th{
		height: 30px;
		min-width: 50px;
		border-bottom: 1px solid rgba(245, 113, 92, 1);
	}
	#notice-table tr{
		height:50px;
		border-bottom: 1px solid rgba(230, 230, 230, 1);
	}
	.list-title{text-align: left;}
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
		top: 90%;
		right: 12%;
	}
	.write-btn>img {
		margin-top: 7px;
	}
	.write-btn:hover {
		cursor: pointer;
	}
	.paging{min-width: 150px; margin:auto;text-align: center; margin-top:12px;}
	.paging-div {
		display:inline-block;
		max-width: 250px;
		margin-top: 10px;
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
	#no-ad{
		font-weight: bolder;
		background: black;
	}
</style>
</head>
<body>
	<header>
		<img src="resources/images/logo/logo.png" id="logo-img" style="height:45px" onclick="goHome();"/>
		<h3 id="header-h2">공지 사항</h3>
	</header>
	<script>
		function goHome(){
			location.href="home.do";
		}
	</script>
	<%@ include file="header.jsp" %>
	<section>
		<div class="notice-div">
			<table id="notice-table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>댓글</th>
					<th>게시일</th>
					<th>수정일</th>
				</tr>
				<c:if test="${empty list}">
					<tr><td colspan="5">공지사항이 없습니다.</td></tr>
				</c:if>
				<c:if test="${!empty list}">
					<c:forEach var="l" items="${ list }" varStatus="vs">
						<tr class="contentTR">
							<td>
								<input type="hidden" value="${l.boardNo}" class="boardNo-input"/>
								${ listCount - vs.index }
							</td>
							<td class="list-title">${ l.bTitle }</td>
							<td>${ l.bCount }</td>
							<td>${ l.comCount }</td>
							<td>${ l.enrollDay }</td>
							<td>${ l.updateDay }</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<div class="write-btn">
			<img src="<%=request.getContextPath() %>/resources/images/bookreview/write.png"/>
		</div>
		<script>
		 	$(function(){
				$('.contentTR').mouseenter(function(){
					$(this).css({'background':'rgba(255, 246, 240, 0.5)','cursor':'pointer'});
				}).mouseout(function(){
					$(this).css({'background':'white'});
				}).click(function(){
					var boardNo = $(this).find('.boardNo-input').val();
					location.href='ndetail.no?boardNo=' + boardNo +'&page=' + ${pi.currentPage};
				});
			}); 
			$('.write-btn').click(function(){
				location.href="<%=request.getContextPath()%>/write.no";
			});
		</script>
		<!-- 페이징 버튼 -->
		<div class="paging">
		<div class="paging-div">
			<!------ 이전 --------->
			<c:if test="${ pi.currentPage <= 1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="notice.ad">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!------ 버튼 --------->
			<c:forEach  var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${pi.currentPage ne p }">
					<c:url var="pNo" value="notice.ad">
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
		</div>
	</section>
</body>
</html>