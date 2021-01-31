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
		background: rgba(246, 246, 246, 1);
		width: 80%;
		min-height: 750px;
		min-width: 1000px;
		margin:auto;
		padding-top: 20px;
	}
	.notice-div{
		min-height: 100px; 
		background: white;
		margin: auto;
		margin-top: 20px;
		padding: 20px;
		width: 80%;
		max-width: 1000px;
	}
	.notice-header{
		text-align: center;
		font-size: 25px;
		margin-bottom: 20px;
		font-weight: bolder;
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
		top: 76%;
		right: 12%;
	}
	.write-btn>img {
		margin-top: 7px;
	}
	.write-btn:hover {
		cursor: pointer;
	}
	.contentTR a{
		text-decoration: none;
		color:black;
	}
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
	
</style>
</head>
<body>
<%@ include file="../common/menubar.jsp" %>
	<section>
		<div class="notice-div">
			<div class="notice-header">공지사항</div>
			<table id="notice-table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>댓글</th>
					<th>등록일</th>
				</tr>
				<c:forEach var="b" items="${bList}" varStatus="vs">
					<tr class="contentTR">
						<td>
							<input type="hidden" value="${l.boardNo}" class="boardNo-input"/>
							${ listCount - vs.index}
						</td>
						<td class="list-title">
							<c:url var="noDetail" value="ndetail.no">
								<c:param name="boardNo" value="${ b.boardNo }"/>
								<c:param name="page" value="${pi.currentPage }"/>
							</c:url>
							<a href="${ noDetail }">${ b.bTitle }</a>
						</td>
						<td>${ b.bCount }</td>
						<td>${ b.comCount }</td>
						<td>${ b.enrollDay }</td>
					</tr>
				</c:forEach>
			</table>
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
		</script>
		
		<!-- 관리자 아이디일 시 보이게 -->
		<c:if test="${ loginUser.id  eq 'admin'}">
			<div class="write-btn">
				<img src="${contextPath }/resources/images/bookreview/write.png"/>
			</div>
		</c:if>
		<!-- ------- 글쓰기 버튼 --------- -->
		<script>
			$('.write-btn').click(function(){
				location.href="<%=request.getContextPath()%>/write.no";
			});
		</script>
		
		<!-- 페이징 버튼 -->
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
	</section>
	<%@include file="../common/footer.jsp" %>
</body>
</html>