<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- jqyery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
	body{
		background:rgba(246, 246, 246, 1);
	}
	#logo-img:hover{cursor:pointer;}
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
	.title span{
		float:right;
	}
	#deleteMem, #backMem{background:rgba(85, 83, 83, 1); color:white; border-color: rgba(85, 83, 83, 1);}
	.mem-list-table{
		clear:both;
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
		.jquery-modal blocker current {
		visibility: none;
	}
	.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
	}
	.modal-back {
		display: none; 
		position: fixed; 
		z-index: 1;
		left: 0;
		top: 0;
		width: 100%; 
		height: 100%;
		overflow: auto; 
		background: rgba(0, 0, 0, 0.4); 
	}
	.modal-close ,.modal-accept{
		background-color: rgba(137, 18, 18, 1);
		color:white;
		width: 80px;
		height: 30px;
		border:none;
		display:inline-block;
		left: 40%;
	}
	.modal-accept{
		background-color: rgba(85, 83, 83, 1);
	}
	.modal p{
		display:inline-block;
	}
	.modal img{
		position:relative;
		top: 10px;
	}
</style>
</head>
<body>
	<header>
		<img src="#logo" id="logo-img" onclick="goHome();"/>
		<h3 id="header-h2">회원 관리</h3>
	</header>
	<script>
		function goHome(){
			location.href="home.do";
		}
	</script>
	<%@ include file="header.jsp" %>
	<div class="modal-back" id="del-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>회원 계정을 중지시키겠습니까?</p>
				<br>
				<button class="modal-accept" id="modal-accept" value="accept">네</button>
				<button class="modal-close" value="Close">아니오</button>
			</div>
		</div>
	</div>
		<div class="modal-back" id="re-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>회원 계정을 복구시키겠습니까?</p>
				<br>
				<button class="modal-accept" id="re-accept" value="accept">네</button>
				<button class="modal-close" value="Close">아니오</button>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$('.modal-close').click(function(){
				$('.modal').hide();
				$('.modal-back').hide();
			});
		});
	</script>
	<section id="member-section">
		<div class="member-li-div">
			<div class="content">
				<div class="title">회원 관리<span><button id="deleteMem">계정 중지</button></span></div>
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
								<td><input type="checkbox" name="delete-mem" class="delete-mem"></td>
								<td>${mem.id }</td>
								<td>${mem.name }</td>
								<td>${mem.gender }</td>
								<td>${mem.email }</td>
								<td>${mem.phone }</td>
								<td>${mem.grantId}</td>
								<td>${mem.mStatus}</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
		<script>
			$(function(){
			
				$('#deleteMem').click(function(){
					
					$('#del-modal').show();
					$('#del-modal .modal').show();
					$('#modal-accept').click(function(){
						var idValue = [];
						$('input[name=delete-mem]:checked').each(function(){
							var tr = $(this).parent('td').parent('tr');
							var id = $(this).parents('td').siblings().eq(0).text();
							idValue.push(id);
							tr.remove();
						});
						location.href="deleteAll.me?idArr=" + idValue;
						$('#del-modal').hide();
						$('#del-modal .modal').hide();
					});
				});
			});
		</script>
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
				<div class="title">탈퇴한 회원 관리 <span><button id="backMem">계정 복구</button></span></div>
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
								<td><input type="checkbox" name="recovery-mem" class="delete-del"></td>
								<td>${dlist.id }</td>
								<td>${dlist.name}</td>
								<td>${dlist.grantId }</td>
								<td>${dlist.email }</td>
								<td>${dlist.mStatus }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
		<script>
			$(function(){
			
				$('#backMem').click(function(){
					
					$('#re-modal').show();
					$('#re-modal .modal').show();
					$('#re-accept').click(function(){
						var idValue = [];
						$('input[name=recovery-mem]:checked').each(function(){
							var tr = $(this).parent('td').parent('tr');
							var id = $(this).parents('td').siblings().eq(0).text();
							idValue.push(id);
							tr.remove();
						});
						location.href="recoveryAll.me?idArr=" + idValue;
						$('#re-modal').hide();
						$('#re-modal .modal').hide();
					});
				});
			});
		</script>
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