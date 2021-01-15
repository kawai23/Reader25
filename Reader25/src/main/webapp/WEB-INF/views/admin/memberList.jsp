<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	.content{
		clear: both;
		margin:auto;
		margin-top: 10px;
		padding: 12px;
		background: white;
		border-radius: 3px;
		box-shadow: 3px 3px 3px 1px lightgray;
		max-width: 1100px;
	}
	.title {
		font-size: 20px;
		font-weight: 400;
		margin: 15px;
		padding-bottom: 10px;
		border-bottom: 2px solid gray;
	}
	.mem-list-table{
		text-align: center;
		padding: 5px;
		width: 95%;
		border-collapse: collapse;
		margin:auto;
	}
	.tr-header th{
		background: rgba(234, 234, 234, 1);
		height: 20px;
		border: 1px solid rgba(215, 215, 215, 1);
	}
	.mem-list-table tr{height: 30px;}
	.mem-list-table td{
		font-size: 14px;
		height: 20px;
		border-bottom: 1px solid lightgray; 
	}
	.paging{width: 200px; margin:auto;text-align: center;}
	.paging-div {
		display:inline-block;
		max-width: 200px;
		margin-top: 10px;
	}
	.paging-div>a, .paging-div>p {
		padding: 0;
		margin: 0;
		display: inline-block;
		width: 20px;
		height: 20px;
		color: rgba(85, 83, 83, 1);
		font-size: 13px;
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
		<h3 id="header-h2">회원 정보 조회</h3>
	</header>
	<%@ include file="header.jsp" %>
	<section id="member-section">
		<div class="member-li-div">
			<div class="content">
				<div class="title">회원 정보</div>
				<table class="mem-list-table">
					<tr class="tr-header">
						<th><input type="checkbox" id="del-mem-all"></th>
						<th>회원 ID</th>
						<th>이름</th>
						<th>성별</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>회원 등급</th>
						<th>상태</th>
					</tr>
					<c:if test="${empty memList}">
						<tr>
							<td colspan="8">회원이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty memList}">
						<c:forEach items="${memList}" var="mem">
							<tr>
								<td><input type="checkbox" class="delete-mem"></td>
								<td>${mem.id }</td>
								<td>${mem.name }</td>
								<td>${mem.gender }</td>
								<td>${mem.address }</td>
								<td>${mem.phone }</td>
								<td>${mem.grantId}</td>
								<td>${mem.mStatus}</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
		<!-- 페이징 버튼 -->
		<div class="paging">
			<div class="paging-div">
				<!-- 이전페이지 -->
				<c:if test="${pi.currentPage <= 1 }">
					<p>&lt;</p>
				</c:if>
				<c:if test="${pi.currentPage > 1 }">
					<c:url var="berfore" value="${loc}">
						<c:param name="page" value="${pi.currentPage - 1 }"/>
					</c:url>
					<a href="${before }">&lt;</a>
				</c:if>
				
				<c:forEach var="p" begin="${pi.startPage }" end="${ pi.endPage}">
				 	<c:if test="${ pi.currentPage ne p }">
				 		<c:url var="pNum" value="${loc}">
				 			<c:param name="page" value="${p }"/>
				 		</c:url>
				 		<a href=${pNum }>${p }</a>
				 	</c:if>
				 	<c:if test="${ pi.currentPage eq p }">
				 		<p>${ p }</p>
				 	</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${pi.currentPage >= pi.maxPage }">
					<p>&gt;</p>
				</c:if>
				<c:if test="${pi.currentPage < pi.maxPage }">
					<c:url var="next" value="${loc }">
						<c:param name="page" value="${pi.currentPage + 1 }"/>
					</c:url>
					<a href="${next }">&gt;</a>
				</c:if>
			</div>
		</div>
		<div class="member-li-div">
			<div class="content">
				<div class="title">탈퇴한 회원 관리 </div>
				<table class="mem-list-table">
					<tr class="tr-header">
						<th><input type="checkbox" id="del-all"></th>
						<th>회원 ID</th>
						<th>이름</th>
						<th>회원 등급</th>
						<th>이메일</th>
						<th>탈퇴일</th>
					</tr>
					<c:if test="${empty delList}">
						<tr>
							<td colspan="6">탈퇴한 회원이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${!empty delList}">
						<c:forEach var="dlist" items="${delList }">
							<tr>
								<td><input type="checkbox" class="delete-del"></td>
								<td>${dlist.id }</td>
								<td>${dlist.name}</td>
								<td>${dlist.grantId }</td>
								<td>${dlist.email }</td>
								<td>${dlist.status }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>

		</div>
		<!-- 페이징 버튼 -->
		<div class="paging">
			<div class="paging-div">
				<c:if test="${pi2.currentPage <= 1 }">
					<p>&lt;</p>
				</c:if>
				<c:if test="${pi2.currentPage > 1 }">
					<c:url var="berfore" value="${loc}">
						<c:param name="page2" value="${pi2.currentPage - 1 }"/>
					</c:url>
					<a href="${before }">&lt;</a>
				</c:if>
				
				<c:forEach var="p" begin="${pi2.startPage }" end="${ pi2.endPage}">
				 	<c:if test="${ pi2.currentPage ne p }">
				 		<c:url var="pNum" value="${loc}">
				 			<c:param name="page2" value="${p }"/>
				 		</c:url>
				 		<a href=${pNum }>${p }</a>
				 	</c:if>
				 	<c:if test="${ pi2.currentPage eq p }">
				 		<p>${ p }</p>
				 	</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${pi2.currentPage >= pi2.maxPage }">
					<p>&gt;</p>
				</c:if>
				<c:if test="${pi2.currentPage < pi2.maxPage }">
					<c:url var="next" value="${loc }">
						<c:param name="page2" value="${pi2.currentPage + 1 }"/>
					</c:url>
					<a href="${next }">&gt;</a>
				</c:if>
			</div>
		</div>
			<script>
				var memlist = $('.delete-mem');
				var ownlist = $('.delete-del');
					
					
				$('#del-mem-all').click(function(){
					var isChecked = $(this).is(':checked');
					if(isChecked){
						memlist.prop('checked',true);
					}else{
						memlist.prop('checked',false);
					}
				});
						
				$(".delete-mem").click(function(){
					var count = 0;
					for(var i = 0; i < memlist.length; i++){
						if(memlist[i].checked){
							count++;
						}
					}
					if(count != memlist.length){
						$('#del-mem-all').prop('checked',false);
					}else{
						$('#del-mem-all').prop('checked',true);
					}
							
				});
						
	
				$('#del-all').click(function() {
					var isChecked = $(this).is(':checked');
					if (isChecked) {
						ownlist.prop('checked', true);
					} else {
						ownlist.prop('checked', false);
					}
				});

				$(".delete-del").click(function() {
					var count = 0;
					for (var i = 0; i < ownlist.length; i++) {
						if (ownlist[i].checked) {
							count++;
						}
					}
					if (count != ownlist.length) {
						$('#del-all').prop('checked', false);
					} else {
						$('#del-all').prop('checked', true);
					}
				});
			</script>
	</section>
</body>
</html>