<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" href="${contextPath}/resources/css/member/login.css" type="text/css">

<style>
.outer{
		width: 900px; min-height: 400px; margin-left: auto; margin-right: auto; 
		margin-top:20px; margin-bottom: 5%;
	}
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>

	<div class="outer">
		<form action="login.me" method="post" id="login">
		
			<h2 class="txt_login" align="center">로그인</h2>
			<br>
			<table class="login_put">
				<tr>
					<td width="200px">
						<div class="txt_login_div">
							아이디
						</div>
					</td>
					<td width="400px">
						<div class="input_id">
							<input type="text" name="id" size="20" tabindex="1" placeholder="아이디를 입력하세요" required>
						</div>
					</td>
				</tr>
				<tr>
					<td width="200px">
						<div class="txt_login_div">
							비밀번호
						</div>
					</td>
					<td>
						<div class="input_pw">
							<input type="password" name="pwd" size="20" tabindex="2" placeholder="비밀번호를 입력하세요" required>
						</div>
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td>
						<div class="login_search">
							<a class="link" style="cursor:pointer" onclick="location.href='searchUserForm.me'">아이디 | 비밀번호 찾기 </a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button style="cursor:pointer" id="btn2" type="submit" class="btn2"><span class="txt_type">로그인</span></button>
					</td>
				</tr>
			</table>

		</form>
			<table class="login_put">
				<tr>
					<td width="200px">
					</td>
					<td colspan="2" align="center">
						<button style="cursor:pointer" id="btn1" class="btn1" onclick="location.href='signUpForm.me'"><span class="txt_type">회원가입</span></button>
						<button style="cursor:pointer" id="btn3" class="btn3" onclick="location.href='home.do'"><span class="txt_type">메인으로</span></button>
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td colspan="2">
						<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
						<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
						<div id="naver_id_login" style="text-align:center">
							<a href="${url}">
								<img width="350" src="resources/images/login/naverB.jpg"/>
							</a>
						</div>
					</td>
				</tr>
			</table>
			
			
			<br>
			
			<br>
	</div>
	<br><br><br><br><br><br><br><br><br>
	
	

	<%-- <%@ include file="../common/footer.jsp" %> --%>
	
</body>
</html>