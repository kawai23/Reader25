<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<img src="#logo"/>
		<h3 id="header-h2">통계 자료</h3>
	</header>
	<%@ include file="header.jsp" %>
	<section>
		전체 방문자 수 : ${sessionScope.totalCount }<br>
		오늘 방문자 수 : ${sessionScope.todayCount }
	</section>
	<!--  1. 방문자 수 -->
	<!--  2. 인기 글 -->
	<!--  3. 회원 유입 수  -->
</body>
</html>