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
.main{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		margin-bottom: 0%; min-width: 1000px;
		padding-top: 15px;
		background-color:  #F6F6F6; 
		font-family: 카페24 아네모네에어;
		min-height: 750px;
}
#find_pwd{font-size: 20px;}
input[id*="slide"] {
	display: none;
}
input[class*="tiw_radio"]{
	display:none;
}
.slide-wrap {
	float: left;
	height: 300px;
	width: 48%;
	margin-left: 18%;
	
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
	background: white;
}

 .slidelist>li>a {
	display: block;
	position: relative;
} 
 .slidelist>li>a img {
	width: 100%;
	height: 298px;
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

input[id="slide01"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(0%);
}

input[id="slide02"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(-100%);
}

input[id="slide03"]:checked ~ .slide-wrap .slidelist>li {
	transform: translateX(-200%);
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
	position : relative;
	float: right;
	text-align : center;
	height: 100%;
	width: 13%;
	margin-left: 2%;
	margin-right: 18%;
	background: #FFFFFF;
	
	box-sizing: border-box;
	border-radius: 50px;
}

.news_login {
	width: 100%;
	height: 300px;
	margin-top: 50px;
}

.r_timebook {
	margin-top: 3%;
	width: 100%;
	height: 20%;
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
	margin-top: 24%;
	width: 60%;
	height: 16%;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 29px;
	color: #FFFFFF;
	background: #C95F12;
	font-family: 카페24 아네모네에어;
}

.enrollbtn {
	margin-top: 3%;
	width: 60%;
	height: 16%;
	font-family: Roboto;
	font-style: normal;
	font-weight: normal;
	font-size: 20px;
	line-height: 29px;
	color: #000000;
	background: #FFC398;
	font-family: 카페24 아네모네에어;
}

#UserImage {
 	display: inline-block;
	width: 100px;
	height: 100px;
	margin-top: 15%;margin-bottom: 15%;
	border: 1px solid #000000;
}

#Userpagelogout {
	position : absolute;
	display: inline-block;
	bottom : 40px;
	left : 0px;
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
.recommend_t, .review_t, .discuss_t, .tiw_f{font-size: 20px;padding-top: 10%;}
</style>
</head>
<body>
	<div class = "main">
	<div class="news_login">
		<!-- 로그인 공지사항 알리미 div -->
		<input type="radio" name="slide" id="slide01" checked>
		<input type="radio" name="slide" id="slide02"> 
		<input type="radio"name="slide" id="slide03">
		<div class="slide-wrap">
			<ul class="slidelist">
				<li><a> <label for="slide03" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/배너0.jpg">
						<label for="slide02" class="right"></label>
				</a></li>
				<li><a> <label for="slide01" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/배너1.png">
						<label for="slide03" class="right"></label>
				</a></li>
				<li><a> <label for="slide02" class="left"></label> <img
						src="<%=request.getContextPath()%>/resources/images/img/배너2.jpg">
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
							찾기 <br> 비밀번호 찾기</a></span>
				</div>
			</c:if>
			<c:if test="${ !empty sessionScope.loginUser  }">
				<div id="UserImage">
				<img src="<%=request.getContextPath() %>/resources/images/icon/usericon.png" style="width: 100px;height: 100px; ">
				</div>
					<h2>
						<c:out value="${loginUser.name}" />님
					</h2>
					<c:if test="${ loginUser.grantId eq 0}" >
					<h3>관리자</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 6}" >
					<h3>다이아몬드등급</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 5}" >
					<h3>플래티넘등급</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 4}" >
					<h3>골드등급</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 3}" >
					<h3>실버등급</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 2}" >
					<h3>브론즈등급</h3>
					</c:if>
					<c:if test="${loginUser.grantId eq 1}" >
					<h3>아이언등급</h3>
					</c:if>
					<h4 style = "margin-top : 5%;">보유포인트 : ${loginUser.point }</h4>
				<div id="Userpagelogout">
					<c:url var="mypage" value="myList.me?code=2" />
					<c:url var="logout" value="logout.me" />
					<span id="mypage" onclick="location.href='${mypage}'"><a>마이페이지</a></span><br>
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
				<c:forEach var="r" items="${ views }" begin="0" end="4">
						<c:url var="redetail" value="redetail.re">
							<c:param name="boardNo" value="${ r.boardNo }"/>
							<c:param name="page" value = "${ pi.currentPage }"/>
						</c:url>
						<p class="ellipsis_r">
							<a style="color : black" href="${ redetail}">
								<c:out value="${ r.bTitle }" />
							</a>
						</p>
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
				<c:forEach var="r" items="${ review }" begin="0" end="4">
						<c:url var="redetail" value="redetail.re">
							<c:param name="boardNo" value="${ r.boardNo }"/>
							<c:param name="page" value = "${ pi.currentPage }"/>
						</c:url>
						<p class="ellipsis_v">
							<a style="color : black" href="${ redetail}">
								<c:out value="${ r.bTitle }" />
							</a>
						</p>
				</c:forEach>
			</div>
		</div>
		<div class="rt_debate">
			<h2>실시간 토론 현황</h2>
			<button class="debate" id="button_brown" onclick="clickbutton7()">일간</button>
			<button class="debate" id="button_pink" onclick="clickbutton8()">주간</button>
			<button class="debate" id="button_pink" onclick="clickbutton9()">월간</button>
			<div class = "discuss_t" style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="d" items="${ discuss }" begin="0" end="4">
						<c:url var="dDetail" value="dDetail.di">
							<c:param name="boardNo" value="${ d.dNo }"/>
							<c:param name="page" value = "${ pi.currentPage }"/>
						</c:url>
						<p class="ellipsis_d">
							<a style = "color : black;" href="${ dDetail } }">
								<c:out value="${ d.dTitle }" />
							</a>
						</p>
				</c:forEach>
			</div>
		</div>
		<div class="tiw_t">
			<h2>오나작 인기글</h2>
			<button class="TIW" id="button_brown" onclick="clickbutton10()">일간</button>
			<button class="TIW" id="button_pink" onclick="clickbutton11()">주간</button>
			<button class="TIW" id="button_pink" onclick="clickbutton12()">월간</button>
			<div class = "tiw_f" style="width: 98%; height: 85%; border: 1px solid #000000; display : flex; flex-direction : column">
				<c:forEach var="t" items="${ tiw }" begin="0" end="4" varStatus="status">
						<c:url var='TIWdetail' value="TIWdetail.to">
							<c:param name="boardNo" value="${ t.boardNo }"/>
							<c:param name="page" value = "${ pi.currentPage }"/>
							<c:param name="User" value="${ loginUser.id }"/>
							<c:param name="code" value='${ t.code }'/>
						</c:url>
						<p class="ellipsis_t"><a style = 'color : black;' href='${ TIWdetail }'>${ t.bTitle }</a></p>
				</c:forEach>
			</div>
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
			$('.recommend_t').empty();
		}
		function Reset_v() { // 책 리뷰
			$('.review_t').empty();
		}
		function Reset_d() { // 토론
			$('.discuss_t').empty();
		}
		function Reset_t() { // 오나작
			$('.tiw_f').empty();
		}
		function insert_r(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".recommend_t").append("<p class='ellipsis_r'><a style = 'color : black;' href='redetail.re?boardNo=" + data[i].boardNo +"&page=1'>"+ data[i].bTitle+"</a></p>");
			}
		}
		function insert_v(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".review_t").append("<p class='ellipsis_v'><a style = 'color : black;' href='redetail.re?boardNo=" + data[i].boardNo +"&page=1'>"+ data[i].bTitle+"</a></p>");
			}
		}
		function insert_d(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".discuss_t").append("<p class='ellipsis_d'><a style = 'color : black;' href='dDetail.di?dNo=" + data[i].dNo +"&page=1'>"+ data[i].dTitle+"</a></p>");
			}
		}
		function insert_t(data){
			for(var i = 0; i < data.length; i ++)
			{
				$(".tiw_f").append("<p class='ellipsis_t'><a style = 'color : black;' href='TIWdetail.to?boardNo=" + data[i].boardNo +"&page=1&code=5'>"+ data[i].bTitle+"</a></p>");
			}
		}
		function click_t(){
			
		}
	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>

