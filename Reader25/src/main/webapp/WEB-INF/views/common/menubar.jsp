<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${ contextPath }/resources/js/jquery-3.5.1.min.js"></script>
<title>Insert title here</title>
<style>
	.wrap{background: #F5715C; width: 80%; height: 50px; margin:auto; min-width: 1000px;}
	.small-menu{font-size: 10px; height: 20px; padding:0;width:80%; margin:auto;}
	.small-menu ul{margin:0;float: right;}
	.small-menu li{list-style:none; display:inline-block;}
	.small-menu li:hover{font-weight:bolder;}
	.small-menu a{text-decoration: none; color:black;}
	.small-menu .li-left{border-left: 1px solid black;padding-left: 5px;}
	.top_logo{clear:both;}
	.li{border-left: 1px solid black; border-right:1px solid black; padding-right: 5px;padding-left: 5px;}
	.menu{
		background: #F5715C; color: white; text-align: center; font-weight: bold; 
		vertical-align: middle; width: 150px; height: 50px; display: table-cell;
	}
	nav{width: 600px; margin-left: auto; margin-right: auto;}
	.menu:hover {background: beige; color:orangered; font-weight:bold; cursor:pointer;}
</style>
</head>
<body>



<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>

	<div class="menubar">
		<div class="small-menu">
			<ul>
				<c:if test="${ empty sessionScope.loginUser }">
					<li><a href="loginView.me">로그인</a></li>
					<li class="li"><a href="notice.no">공지사항</a></li>
					<li><a href="inquiry.in">문의사항</a></li>
				</c:if>
				<c:if test="${ !empty sessionScope.loginUser }">
					<li><a href="logout.me">로그아웃</a></li>
				<c:if test="${ sessionScope.loginUser.id eq 'admin'}">
					<li class="li-left"><a href="admin.ad">관리자창</a></li>
				</c:if>
				<c:if test="${ sessionScope.loginUser.id ne 'admin'}">
					<li class="li-left"><a href="myList.me?code=2">마이페이지</a></li>
				</c:if>
					<li class="li"><a href="notice.no">공지사항</a></li>
					<li><a href="inquiry.in">문의사항</a></li>
				</c:if>
			</ul>
		</div>
		<div class="top_logo">
			<img
				src="${ pageContext.servletContext.contextPath }/images/Logo2.png"
				style="display: block; margin: 0 auto;" width="210" height="45">
		</div>
		
		<br clear="all"> <br>
		<div class="wrap">
			<nav>
				<div class="menu" onclick="home();">HOME</div>
				<div class="menu" onclick="goDiscuss();">토론방</div>
				<div class="menu" onclick="goBookReview();">독서방</div>
				<div class="menu" onclick="goTIW();">작가방</div>
				<div class="menu" onclick="gobookr()">책방</div>
				<div class="menu" onclick="goAbout()">About</div>
			</nav>
		</div>
		
		
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
			<c:choose>
				<c:when test="${ userId != null }">
					${ userId }님 <a href="logout">로그아웃</a>하세요
				</c:when>
			</c:choose>
		
				
		
	</div>
	<script>
		function goBookReview(){
			location.href = "book.re";
		}
		function home(){
			location.href = "home.do";
		}
		function goTIW(){
			location.href = "goTIWList.to";
		}
		function goThumbnail1(){
			location.href= "gobooklist.bo";
		}
		function gobookr(){
			location.href= "gobookr.bo";
		}
		function goDiscuss(){
			location.href = "discuss.di";
		}
		function goAbout(){
			location.href="about.ab"
		}
	</script>
	
	
	
</body>
</html>