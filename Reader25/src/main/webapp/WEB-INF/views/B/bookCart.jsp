<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<style>
#maindiv1 {
	margin: auto;
	width: 800px;
}

.writetitle1 {
	display: inline-block;
	margin-left: 400px;
	padding: 30px;
	font-size: 60px;
	font-family: 카페24 아네모네;
	min-width: 70%;
	min-height: 10%;
}

.btn-a {
	margin: auto
}

.btn-b {
	width: 350px;
	height: 50px;
	margin: auto
}

.allbuy {
	
	background-color: #F5715C;
	font-size: 17px;
	color: white;
	border-color: #F5F5DC;
	height: 50px;
	margin: 5px;
	border-width: 0.5px;
	border-style: solid;
	cursor: pointer;
	width: 150px;
	border-radius: 5px;
	
}
.allbuy:hover {
   background:linear-gradient(to bottom, #F99F93 5%, #F99F93 100%);
   background-color:#F99F93;
}
.allbuy:active {
   position:relative;
   top:1px;
}

.buy {
	background-color: white;
	font-size: 17px;
	border-color: #B3B2AF;
	height: 50px;
	margin: 5px;
	border-width: 0.5px;
	border-style: solid;
	cursor: pointer;
	width: 150px;
	border-radius: 5px;
}
.buy:hover {
   background:linear-gradient(to bottom, #D0D0D0 5%, #D0D0D0 100%);
   background-color:#D0D0D0;
}
.buy:active {
   position:relative;
   top:1px;
}

.list-table {
	width: 1300px;
	margin-top: 80px;
	margin-left: 280px;
	position: relative;
	overflow: hidden;
	white-space: nowrap;
	margin: auto;
}

.list-tableth {
	height: 50px;
	border-collapse: 0px;
	font-size: 17pt;
	text-align: center;
}

.list-tabletd {
	text-align: center;
	padding: 10px 0;
	border-bottom: 1px solid #CCC;
	height: 20px;
	font-size: 18pt;
}

.bak_item {
	height: 130px;
	margin-top: 10px;
}

.proquantity {
	width: 80px;
	height: 30px;
	padding: 15px;
	display: inline-block;
	border-color: #A4A4A4;
	background: white;
	border-style: solid;
	border-width: thin;
	border-radius: 3px;
	font-size: 13pt;
}

.list-A {
	min-height: 100px;
	background: white;
	margin-top: 100px;
	margin: auto;
	padding-top: 5%;
	padding-left: 2%;
	padding-right: 2%;
	padding-bottom: 3%;
	border-radius: 2px;
	box-shadow: 0px 2px 2px 3px lightgray;
	width: 70%;
}
.tdtop{
	border-top: 4px solid #F7B45E; border-bottom: 2px solid #F7B45E;
}
.tdbottom{
	border-bottom: 4px solid #F7B45E;
}
.tdbottom2{
	border-bottom: 2px solid #F7B45E;
}
</style>
</head>
<body id="body">
	<%@include file="../common/menubar.jsp"%>
	<div id="maindiv">
		<br> <br> <br> <br><div class="writetitle1">주문 목록</div>
		<section>
			<div id="listArea" class="list-A">
				
				<br>
				<table class="list-table" id="sbtable" style="border-spacing: 0px;">
					<tr class="list-tableth">
						<td width="10px;" class="tdtop">
							<input type="checkbox" id="allchecked">
						</td>
						<td width="200" class="tdtop">책 이미지</td>
						<td width="300" class="tdtop">책 제목</td>
						<td width="120" class="tdtop">판매가</td>
						<td width="180" class="tdtop">수량</td>
						<td width="100" class="tdtop">배송비</td>
						<td width="100" class="tdtop">합계</td>
						<td width="100" class="tdtop"></td>
					</tr>
					<tbody class="list-tabletd">
					<c:forEach var="b" items="${book}" varStatus="vs">
						<tr>
							<c:choose>
								<c:when test="${vs.last}">
									<td width="10" class="tdbottom"><input type="checkbox" class="prodelete1" value="${b.b_no }"></td>
									<td width="150" class="tdbottom">
									<c:choose>
										<c:when test="${ at[vs.index] eq null }">
											<p>등록된 이미지가 없습니다.<p>
										</c:when>
										<c:otherwise>
											<div class="bak_item">
												<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at[vs.index].atcName }" width="200" height="120">
											</div>
										</c:otherwise>
									</c:choose>
									</td>
									<td width="150" class="tdbottom">${b.b_name}</td>
									<td width="150" class="tdbottom">${b.b_price}원</td>
									<td width="150" class="tdbottom">${b.b_Q1}</td>
									<td width="150" class="tdbottom">2500원</td>
									<td width="150" class="tdbottom">${(b.b_price * b.b_Q1)+ 2500}원</td>
									<td width="50" class="tdbottom"></td>
								</c:when>
								<c:otherwise>
									<td width="10" class="tdbottom2"><input type="checkbox" class="prodelete1" value="${b.b_no }"></td>
									<td width="150" class="tdbottom2">
									<c:choose>
										<c:when test="${ at[vs.index] eq null }">
											<p>등록된 이미지가 없습니다.<p>
										</c:when>
										<c:otherwise>
											<div class="bak_item">
												<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at[vs.index].atcName }" width="200" height="120">
											</div>
										</c:otherwise>
									</c:choose>
									</td>
									<td width="150" class="tdbottom2">${b.b_name}</td>
									<td width="150" class="tdbottom2">${b.b_price}원</td>
									<td width="150" class="tdbottom2">${b.b_Q1}</td>
									<td width="150" class="tdbottom2">2500원</td>
									<td width="150" class="tdbottom2">${(b.b_price * b.b_Q1) + 2500}원</td>
									<td width="50" class="tdbottom2"></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<br> <br> <br>
			<div class="btn-a">
				<div class="btn-b">
					<input type="button" value="전체상품주문" class="allbuy"> 
					<input type="button" value="선택상품주문" class="buy">
				</div>
			</div>
			<script>
			//체크박스 부분
			$(document).ready(function(){
				$("#sbtable #allchecked").click(function () {
					if ($("#sbtable #allchecked").is(':checked')) {
						$("#sbtable input[type=checkbox]").each(function () {
				        	$(this).prop("checked", true);
				       	});

					} else {
				    	$("#sbtable input[type=checkbox]").each(function () {
				    		$(this).prop("checked", false);
				        });
					}
				});
				$(".prodelete1").on("click", function() {
					var is_checked = true;

					$(".prodelete1").each(function(){
						is_checked = is_checked && $(this).is(":checked");
					});

					$("#allchecked").prop("checked", is_checked);
				});
			});

			//주문하기 부분
			$(".allbuy").click(function(){
				var b_no = [];
				var book_v = [];
				<c:forEach var="b" items="${book}">
					 b_no.push(${b.b_no});
					 book_v.push(${b.b_Q1});
				</c:forEach>
				location.href="<%=request.getContextPath()%>/pcs.tr?b_no="+ b_no +"&book_v=" + book_v;
			});
			
			$(".buy").click(function(){
				var b_no = [];
				var book_v = [];
				 $('.prodelete1:checked').each(function(){
					 var bv = $(this).parent().parent().children().eq(4).text();
					 b_no.push(Number($(this).val()));
					 book_v.push(Number(bv));
				 });
				 location.href="<%=request.getContextPath()%>/pcs.tr?b_no="+ b_no +"&book_v=" + book_v;
			});
			
			</script>
		</section>
	</div>
	<br>
	<br>
	<br>
	<%@include file="../common/footer.jsp"%>
</body>
</html>