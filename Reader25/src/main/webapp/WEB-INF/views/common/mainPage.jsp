<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

input[id*="slide"] {
	display: none;
}

.slide-wrap {
	float: left;
	height: 400px;
	width: 45%;
	margin-left: 18%;
	border: 1px solid #000000;
	box-sizing: border-box;
	border-radius: 50px;
}

.slidelist {
	white-space: nowrap;
	font-size: 0;
	overflow: hidden;
	box-sizing: border-box;
	border-radius: 50px;
}

.slidelist>li {
	display: inline-block;
	vertical-align: middle;
	width: 100%;
	transition: all .5s;
}

.slidelist>li>a {
	display: block;
	position: relative;
}

.slidelist>li>a img {
	width: 100%;
	height: 398px;
	object-fit: fill;
}

.slidelist label {
	position: absolute;
	z-index: 10;
	top: 50%;
	transform: translateY(-50%);
	padding: 50px;
	cursor: pointer;
}

.slidelist .left {
	left: 30px;
	background:
		url('<%=request.getContextPath()%>/resources/images/img/left.png')
		center center/100% no-repeat;
}

.slidelist .right {
	right: 30px;
	background:
		url('<%=request.getContextPath()%>/resources/images/img/right.png')
		center center/100% no-repeat;
}

.slidelist .textbox {
	position: absolute;
	z-index: 1;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	line-height: 1.6;
	text-align: center;
}

.slidelist .textbox h3 {
	font-size: 50px;
	color: #fff;
	opacity: 0;
	transform: translateY(30px);
	transition: all .5s;
}

.slidelist .textbox p {
	font-size: 24px;
	color: #fff;
	opacity: 0;
	transform: translateY(30px);
	transition: all .5s;
}

input[id="slide01"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(0%);
}

input[id="slide02"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(-100%);
}

input[id="slide03"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(-200%);
}

input[id="slide01"]:checked ~ .slide-wrap li:nth-child(1) .textbox h3 {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .2s;
}

input[id="slide01"]:checked ~ .slide-wrap li:nth-child(1) .textbox p {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .4s;
}

input[id="slide02"]:checked ~ .slide-wrap li:nth-child(2) .textbox h3 {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .2s;
}

input[id="slide02"]:checked ~ .slide-wrap li:nth-child(2) .textbox p {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .4s;
}

input[id="slide03"]:checked ~ .slide-wrap li:nth-child(3) .textbox h3 {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .2s;
}

input[id="slide03"]:checked ~ .slide-wrap li:nth-child(3) .textbox p {
	opacity: 1;
	transform: translateY(0);
	transition-delay: .4s;
}

.font_black {
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 23px;
	text-align: center;
	color: #000000;
}

.news {
	float: left;
	height: 100%;
	width: 45%;
	margin-left: 18%;
	border: 1px solid #000000;
	box-sizing: border-box;
	border-radius: 50px;
}

.login_place {
	float: right;
	height: 100%;
	width: 13%;
	margin-left: 2%;
	margin-right: 18%;
	background: #FFFFFF;
	border: 1px solid #000000;
	box-sizing: border-box;
	border-radius: 50px;
}

.news_login {
	width: 100%;
	height: 400px;
	margin-top: 50px;
}

.r_timebook {
	margin-top: 3%;
	width: 100%;
	height: 400px;
}

#button_brown {
	float: left;
	width: 33%;
	height: 30px;
	margin-left: auto;
	background: #A84E19;
	outline : 0;
	border: 1px solid #000000;
	box-sizing: border-box;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 23px;
	text-align: center;
	color: #FFFFFF;
}

#button_pink {
	float: left;
	width: 33%;
	height: 30px;
	margin-left: auto;
	background: #F5715C;
	outline : 0;
	border: 1px solid #000000;
	box-sizing: border-box;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 23px;
	text-align: center;
	color: #FFFFFF;
}

.bookreco {
	float: left;
	width: 12.5%;
	height: 100%;
	margin-left: 19%;
	text-align: center;
}

.bestreview {
	float: left;
	width: 12.5%;
	height: 100%;
	margin-left: 4%;
	text-align: center;
}

.rt_debate {
	float: left;
	width: 12.5%;
	height: 100%;
	margin-left: 4%;
	text-align: center;
}

.tiw_t {
	float: left;
	width: 12.5%;
	height: 100%;
	margin-left: 4%;
	text-align: center;
}

.loginbtn {
	text-align: center;
	margin-top: 24%;
	margin-left: 25%;
	width: 50%;
	height: 16%;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 29px;
	color: #FFFFFF;
	background: #C95F12;
}

.enrollbtn {
	text-align: center;
	margin-top: 3%;
	margin-left: 25%;
	width: 50%;
	height: 16%;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 29px;
	color: #000000;
	background: #FFC398;
}

#UserImage {
	float: left;
	width: 35%;
	height: 40%;
	margin-top: 15%;
	margin-left: 11%;
	border: 1px solid #000000;
}

#UserInfomation {
	text-align: center;
	float: left;
	margin-top: 15%;
	margin-left: 9%;
	width: 40%;
	height: 25%;
}

#Userpagelogout {
	text-align: center;
	margin-top: 90%;
	width: 100%;
	cursor: pointer
}

.ellipsis_r {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: left;
}
.ellipsis_v {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: left;
}
.ellipsis_d {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: left;
}
.ellipsis_t {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	text-align: left;
}
</style>
</head>
<body>
	<div class="news_login">
		<!-- 로그인 공지사항 알리미 div -->
		<input type="radio" name="slide" id="slide01" checked> <input
			type="radio" name="slide" id="slide02"> <input type="radio"
			name="slide" id="slide03">
		<div class="slide-wrap">
			<ul class="slidelist">
				<li><a> <label for="slide03" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/slide01.jpg">
						<label for="slide02" class="right"></label>
				</a></li>
				<li><a> <label for="slide01" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/slide02.jpg">
						<label for="slide03" class="right"></label>
				</a></li>
				<li><a> <label for="slide02" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/slide03.jpg">
						<label for="slide01" class="right"></label>
				</a></li>
			</ul>
		</div>
		<div class="login_place">
			<c:if test="${ empty sessionScope.loginUser }">
				<button class="loginbtn" onclick="location.href='loginView.me'">로그인하기</button>
				<button class="enrollbtn" onclick="location.href='signUpForm.me'">회원가입</button>
				<div
					style="margin-top: 40%; text-align: center; width: 100%; cursor: pointer">
					<span id="find_pwd" onclick="location.href='searchUserForm.me'"><a>아이디
							찾기 | 비밀번호 찾기</a></span>
				</div>
			</c:if>
			<c:if test="${ !empty sessionScope.loginUser  }">
				<div id="UserImage">사진</div>
				<div id="UserInfomation">
					<h2>
						<c:out value="${loginUser.name}" />
					</h2>
					<h4>${loginUser.rank }</h4>
				</div>

				<div id="Userpagelogout">
					<c:url var="mypage" value="myList.me?code=2" />
					<c:url var="logout" value="logout.me" />
					<span id="mypage" onclick="location.href='${mypage}'"><a>마이페이지</a></span>|
					<span id="logout" onclick="location.href='${logout}'"><a>로그아웃</a></span>
				</div>
			</c:if>
		</div>
	</div>
	<div class="r_timebook">
		<!--  실시간 현황 div 알리미 -->

		<div class="bookreco">
			<h2>이달의 책 추천</h2>
			<button class="b_reco" id="button_brown" onclick="clickbutton1()">일간</button>
			<button class="b_reco" id="button_pink" onclick="clickbutton2()">주간</button>
			<button class="b_reco" id="button_pink" onclick="clickbutton3()">월간</button>
			<div class = "recommend_t"  style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="r" items="${ views }" begin="0" end="13" varStatus="status">
						<div id="recommend<c:out value='${status.count}'/>" style = "text-align : left">
						<p class="ellipsis_r"><c:out value="${ r.bTitle }" /></p>
						</div>
				</c:forEach>
			</div>
		</div>
		<!-- 이달의 책 추천 List -->
		<div class="bestreview">
			<h2>이달의BEST리뷰</h2>
			<button class="best_re" id="button_brown" onclick="clickbutton4()">일간</button>
			<button class="best_re" id="button_pink" onclick="clickbutton5()">주간</button>
			<button class="best_re" id="button_pink" onclick="clickbutton6()">월간</button>
			<div class = "review_t" style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="r" items="${ review }" begin="0" end="13" varStatus="status">
						<div id="reviews<c:out value='${status.count}'/>"style = "text-align : left">
						<p class="ellipsis_v">
							<c:out value="${ r.bTitle }" />
						</p>
						</div>
				</c:forEach>
			</div>
		</div>
		<div class="rt_debate">
			<h2>실시간 토론 현황</h2>
			<button class="debate" id="button_brown" onclick="clickbutton7()">일간</button>
			<button class="debate" id="button_pink" onclick="clickbutton8()">주간</button>
			<button class="debate" id="button_pink" onclick="clickbutton9()">월간</button>
			<div class = "discuss_t" style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="d" items="${ discuss }" begin="0" end="13" varStatus="status">
						<div id="discuss<c:out value='${status.count}'/>"style = "text-align : left">
						<p class="ellipsis_d">
						<c:out value="${ d.dTitle }" />
						</p>
						</div>
				</c:forEach>
			</div>
		</div>
		<div class="tiw_t">
			<h2>오나작 인기글</h2>
			<button class="TIW" id="button_brown" onclick="clickbutton10()">일간</button>
			<button class="TIW" id="button_pink" onclick="clickbutton11()">주간</button>
			<button class="TIW" id="button_pink" onclick="clickbutton12()">월간</button>
			<div class = "tiw_f" style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="t" items="${ tiw }" begin="0" end="13">
						<div id="todaywriter<c:out value='${status.count}'/>"style = "text-align : left">
						<p class="ellipsis_t">
							<c:out value="${ b.bTitle }" />
						</p>
						</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<script>
		function clickbutton1() {
			var div2 = document.getElementsByClassName('b_reco');
			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}

			$.ajax({
				url : "recod.do",
				success : function(data) {
					Reset_r();
					insert_r(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton2() {
			var div2 = document.getElementsByClassName('b_reco');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "recow.do",
				success : function(data) {
					console.log(data);
					Reset_r();
					insert_r(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton3() {
			var div2 = document.getElementsByClassName('b_reco');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "recom.do",
				success : function(data) {
					console.log(data);
					Reset_r();
					insert_r(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton4() {
			var div2 = document.getElementsByClassName('best_re');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "reviewd.do",
				success : function(data) {
					console.log(data);
					Reset_v();
					insert_v(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton5() {
			var div2 = document.getElementsByClassName('best_re');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "revieww.do",
				success : function(data) {
					console.log(data);
					Reset_v();
					insert_v(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton6() {
			var div2 = document.getElementsByClassName('best_re');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "reviewm.do",
				success : function(data) {
					console.log(data);
					Reset_v();
					insert_v(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton7() {
			var div2 = document.getElementsByClassName('debate');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "discussd.do",
				success : function(data) {
					console.log(data);
					Reset_d();
					insert_d(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton8() {
			var div2 = document.getElementsByClassName('debate');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "discussw.do",
				success : function(data) {
					console.log(data);
					Reset_d();
					insert_d(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton9() {
			var div2 = document.getElementsByClassName('debate');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "discussm.do",
				success : function(data) {
					console.log(data);
					Reset_d();
					insert_d(data);
				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton10() {
			var div2 = document.getElementsByClassName('TIW');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "tiwd.do",
				success : function(data) {
					console.log(data);
					Reset_t();
					insert_t(data);

				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton11() {
			var div2 = document.getElementsByClassName('TIW');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "tiww.do",
				success : function(data) {
					console.log(data);
					Reset_t();
					insert_t(data);

				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function clickbutton12() {
			var div2 = document.getElementsByClassName('TIW');

			for (var i = 0; i < div2.length; i++) {
				div2[i].addEventListener('click', function() {
					for (var j = 0; j < div2.length; j++) {
						div2[j].style.background = "#F5715C";
					}
					this.style.background = "#A84E19";
				})
			}
			$.ajax({
				url : "tiwm.do",
				success : function(data) {
					console.log(data);
					Reset_t();
					insert_t(data);

				},
				error : function() {
					alert("정보소환에 실패하였습니다");
				}
			});
		}
		function Reset_r() { // 책추천
			$('.ellipsis_r').remove();
		}
		function Reset_v() { // 책 리뷰
			$('.ellipsis_v').remove();
		}
		function Reset_d() { // 토론
			$('.ellipsis_d').remove();
		}
		function Reset_t() { // 오나작
			$('.ellipsis_t').remove();
		}
		function insert_r(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".recommend_t").append("<p class= 'ellipsis_r' style = 'text-align : left'>"+data[i].bTitle+"</p>");
				
			}
		}
		function insert_v(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".review_t").append("<p class= 'ellipsis_v' style = 'text-align : left'>"+data[i].bTitle+"</p>");
			}
		}
		function insert_d(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".discuss_t").append("<p class= 'ellipsis_d' style = 'text-align : left'>"+data[i].dTitle+"</p>");
			}
		}
		function insert_t(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".tiw_f").append("<p class= 'ellipsis_t' style='text-align : left'>"+data[i].bTitle+"</p>");
			}
		}
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>

