<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		.paging-div {
		width: 250px;
		margin: auto;
		margin-top: 30px;
	}
	.paging-div>button {
		width: 30px;
		height: 30px;
		color: rgba(85, 83, 83, 1);
		font-size: 15px;
		background: rgba(229, 229, 229, 1);
		border: none;
	}	

	.paging-div>button:hover {
		font-weight: bold;
		background: rgba(220, 220, 220, 1);
	}

	.paging-div>button:active {
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
				<%for(int i = 0; i < 10; i++){ %>
				<tr>
					<td><%=i %></td>
					<td class="left-td">천개의 태양</td>
					<td>10000</td>
					<td>user01</td>
					<td>user02</td>
					<td>2020.12.12</td>
				</tr>
				<%} %>
			</table>
		</div>
			<!-- 페이징 버튼 -->
		<div class="paging-div">
			<button>&lt;</button>
			<button>1</button>
			<button>2</button>
			<button>3</button>
			<button>4</button>
			<button>5</button>
			<button>&gt;</button>
		</div>
	</section>
</body>
</html>