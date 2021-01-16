<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
		display:inline-block;
		min-height: 700px;
		position: relative;
		margin-left: 10px;
		width: 80%;
	}
	.paylist-div{
		min-height: 100px; 
		background: white;
		margin: auto;
		margin-top: 20px;
		border-radius: 5px;
		box-shadow: 0px 2px 3px 3px lightgray;
		padding: 10px;
	}
	#paylist-table{
		width: 100%;
		height: 100%;
		border-top:2px solid rgba(245, 113, 92, 1);
		border-collapse: collapse;
		text-align: center;
	}
	#paylist-table th{
		height: 30px;
		border-bottom: 1px solid rgba(245, 113, 92, 1);
	}
	#paylist-table tr{
		height: 30px;
	}
	.left-td{
		text-align: left;
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
</style>
</head>
<body>
	<header>
		<img src="#logo"/>
		<h3 id="header-h2">결제 내역 조회</h3>
	</header>
	<%@ include file="header.jsp" %>
	<section>
		<div class="paylist-div">
			<table id="paylist-table">
				<tr>
					<th>주문번호</th>
					<th>상품</th>
					<th>결제내역</th>
					<th>구매한 회원</th>
					<th>판매한 회원</th>
					<th>거래날짜</th>
				</tr>
				<c:if test="${empty payList }">
					<tr>
						<td colspan="6">결제 내역이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty payList }">
					<c:forEach var="p" items="${payList }">
						<tr>
							<td>${p. pay_no}</td>
							<td>${p. book_name}</td>
							<td>${p. pay_no}</td>
							<td>${p. pay_no}</td>
							<td>${p. pay_no}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
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