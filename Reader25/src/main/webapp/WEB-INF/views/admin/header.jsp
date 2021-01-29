<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>관리자 페이지</title>
<style type="text/css">
	header{
		background: rgba(245, 113, 92, 1);
		height: 50px;
		width:100%;
		min-width: 700px;
	}
	header h3, header>img{
		display:inline-block;
		color:white;
	}
	header h3{ position:relative; top:-15px; left:30px;}
	nav{
		display:inline-block;
		background:rgba(39, 50, 56, 1);
		min-height: 1000px;
		width: 150px;
		border: 1px solid rgba(39, 50, 56, 1);
		float:left;
	}
	.nav-ul{
		list-style-type:none;
		margin:0;
		padding:0;
	}
	.nav-ul>li{
		border-bottom: 2px solid black;
		font-size: 15px;
		height: 40px;
		text-align: center;
	}
	.nav-a{
		display: inline-block;
		text-decoration: none;
		color:white;
		margin-top: 10px;
	}
	.nav-ul>li:hover{
		font-weight: bolder;
		background: black;
	}
	.naviSelect{
		font-weight: bolder;
		background: black;
	}
</style>
</head>
<body>
	<nav>
		<ul class="nav-ul">
			<li id="mem-ad"><a href="admin.ad" class="nav-a" >회원 관리</a></li>
			<li id="pay-ad"><a href="paylist.ad" class="nav-a" id="pay-ad">결제 내역 조회</a></li>
			<li id="in-ad"><a href="inquiry.ad" class="nav-a" >문의 사항</a></li>
			<li  id="no-ad"><a href="notice.ad" class="nav-a">공지 사항</a></li>
			<li id="st-ad"><a href="statistic.ad" class="nav-a" >방문자 관리</a></li>
		</ul>
	</nav>
</body>
</html>