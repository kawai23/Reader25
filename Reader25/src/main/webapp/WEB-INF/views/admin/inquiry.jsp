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
		min-height: 700px;
		position: absolute;
		left:160px;
		margin-left: 10px;
 		width: 80%;
 		min-width: 700px; 
	}
	#logo-img:hover{cursor:pointer;}
	.inquire-div{
		min-height: 100px; 
		background: white;
		max-width: 1100px;
		margin: auto;
		margin-top: 20px;
		border-radius: 5px;
		box-shadow: 0px 2px 3px 3px lightgray;
		padding: 10px;
	}
	#inquire-table{
		width: 100%;
		height: 100%;
		border-top:2px solid rgba(245, 113, 92, 1);
		border-collapse: collapse;
		text-align: center;
	}
	#inquire-table th{
		height: 30px;
		border-bottom: 1px solid rgba(245, 113, 92, 1);
	}
	#inquire-table tr{height:30px;}
	#write{
		margin-left:90%;
		cursor:pointer;
		position: fixed;
	}
	.paging{width: 150px; margin:auto;text-align: center; margin-top:12px;}
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
	#in-ad{
		font-weight: bolder;
		background: black;
	}
</style>
</head>
<body>
	<header>
		<img src="#logo" id="logo-img" onclick="goHome();"/>
		<h3 id="header-h2">문의 사항</h3>
	</header>
	<script>
		function goHome(){
			location.href="home.do";
		}
	</script>
	<%@ include file="header.jsp" %>
	<section>
		<div class="inquire-div">
			<table id="inquire-table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>댓글</th>
					<th>회원</th>
					<th>게시일</th>
				</tr>
				<c:if test="${ empty list }">
					<tr><td colspan="5">문의사항이 없습니다.</td></tr>
				</c:if>
				<c:if test="${ !empty list }">
					<c:forEach var="l" items="${list }">
						<tr class="contentTR">
							<td>${l.boardNo }</td>
							<td>${l.bTitle }</td>
							<td>${l.bCount }</td>
							<td>${l.comCount }</td>
							<td>${l.userId }</td>
							<td>${l.enrollDay }</td>
						</tr>
					</c:forEach>
				</c:if>
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
		
		<!-- 페이징 버튼 -->
		<div class="paging">
		<div class="paging-div">
			<!------ 이전 --------->
			<c:if test="${ pi.currentPage <= 1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="notice.no">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!------ 버튼 --------->
			<c:forEach  var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${pi.currentPage ne p }">
					<c:url var="pNo" value="notice.no">
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