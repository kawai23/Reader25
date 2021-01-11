<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.font_white{

}
.font_black{
font-family: Roboto;
font-style: normal;
font-weight: normal;
font-size: 20px;
line-height: 23px;
text-align: center;

color: #000000;
}
.news{
float : left;
height : 100%;
width : 45%;
margin-left : 18%;
background: linear-gradient(180deg, #FFFFFF 0%, rgba(255, 255, 255, 0) 100%), #FFFFFF;
border: 1px solid #000000;
box-sizing: border-box;
border-radius: 50px;
}
.login_place{
float : right;
height : 100%;
width : 13%;
margin-left : 2%;
margin-right : 18%;
background: #FFFFFF;
border: 1px solid #000000;
box-sizing: border-box;
border-radius: 50px;
}
.news_login{
 width : 100%;
 height : 250px;
 margin-top : 50px;
}
.r_timebook{
	margin-top : 3%;
	width : 100%;
	height : 400px;
}
#button_brown{
float : left;
width: 33%;
height: 30px;
margin-left : auto;

background: #A84E19;
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
#button_pink{
float : left;
width: 33%;
height: 8%;
margin-left : auto;

background: #F5715C;
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
 .bookreco{
 float : left;
 width :12.5%;
 height : 100%;
 margin-left : 19%;
 text-align: center;
 }
 .bestreview{
 float : left;
 width :12.5%;
 height : 100%;
 margin-left : 4%;
 text-align: center;
 }
 .bestreview{
 float : left;
 width :12.5%;
 height : 100%;
 margin-left : 4%;
 text-align: center;
 }
 .rt_debate{
 float : left;
 width :12.5%;
 height : 100%;
 margin-left : 4%;
 text-align: center;
 }
 .tiw{
 float : left;
 width :12.5%;
 height : 100%;
  margin-left : 4%;
  text-align: center;
 }
 .loginbtn{
 text-align : center;
 margin-top : 24%;
 margin-left : 25%;
 width : 50%;
 height : 16%;
 font-family: Roboto;
 font-style: normal;
 font-weight: normal;
 font-size: 20px;
 line-height: 29px;

color: #FFFFFF;
background: #C95F12;
 }
 .enrollbtn{
 text-align : center;
 margin-top : 3%;
 margin-left : 25%;
 width : 50%;
 height : 16%;
 font-family: Roboto;
 font-style: normal;
 font-weight: normal;
 font-size: 20px;
 line-height: 29px;
 color: #000000;
 background: #FFC398;
 }
 #UserImage{
 float : left;
  width : 35%;
  height : 40%;
  margin-top : 15%;
  margin-left : 11%;
  border: 1px solid #000000;
 }
 
 #UserInfomation{
 text-align : center;
 float : left;
 margin-top : 15%;
 margin-left : 9%;
 width : 40%;
 height : 25%;
 }
 #Userpagelogout{
 text-align : center;
 margin-top : 80%;
 width : 100%;
 cursor:pointer
 }
</style>
</head>
<body>
	<div class = "news_login"> <!-- 로그인 공지사항 알리미 div -->
		<div class = "news"></div>
		<div class = "login_place">
		<c:if test="${ empty sessionScope.loginUser }">
		<button class = "loginbtn" onclick="location.href='loginView.me'">로그인하기</button>
		<button class = "enrollbtn"onclick="location.href='enrollView.me'">회원가입</button>
		<div style = "margin-top : 12%; text-align : center; width : 100%;">
		<span id = "find_id"><a>아이디 찾기</a> </span>|
		<span id = "find_pwd" ><a>비밀번호 찾기</a></span>
		</div>
	</c:if>
	<c:if test="${ !empty sessionScope.loginUser }">
		<div id = "UserImage">사진</div>
		<div id = "UserInfomation">
		<h2><c:out value="${loginUser.name}"/></h2>
			<h4>${loginUser.rank }</h4>
		</div>

		<div id = "Userpagelogout">
		<c:url var="mypage" value="myList.me?code=2"/>
		<c:url var="logout" value="logout.me"/>
		<span id = "mypage" onclick="location.href='${mypage}'"><a>마이페이지</a> </span>|
		<span id = "logout" onclick="location.href='${logout}'"><a>로그아웃</a></span>
		</div>
	</c:if>
		</div>
	</div>
	<div class = "r_timebook"> <!--  실시간 현황 div 알리미 -->
	
	<div class = "bookreco">
		<h2>이달의 책 추천 List</h2>
		<button class = "b_reco" id = "button_brown" onclick = "clickbutton1()">일간</button>
		<button class = "b_reco" id = "button_pink" onclick = "clickbutton1()">주간</button>
		<button class = "b_reco" id = "button_pink" onclick = "clickbutton1()">월간</button>
		<div style = "width : 98%; height : 70%;border: 1px solid #000000;"></div>
	</div> <!-- 이달의 책 추천 List -->
	<div class = "bestreview">
		<h2>이달의BEST리뷰</h2>
		<button class = "best_re" id = "button_brown" onclick = "clickbutton2()">일간</button>
		<button class = "best_re" id = "button_pink" onclick = "clickbutton2()">주간</button>
		<button class = "best_re" id = "button_pink" onclick = "clickbutton2()">월간</button>
		<div style = "width : 98%; height : 70%;border: 1px solid #000000;"></div>
	</div>
	<div class = "rt_debate">
		<h2>실시간 토론 현황</h2> 
		<button class = "debate" id = "button_brown" onclick = "clickbutton3()">일간</button>
		<button class = "debate" id = "button_pink" onclick = "clickbutton3()">주간</button>
		<button class = "debate" id = "button_pink" onclick = "clickbutton3()">월간</button>
		<div style = "width : 98%; height : 70%;border: 1px solid #000000;"></div>
	</div>
	<div class = "tiw">
		<h2>오나작 인기글</h2>
		<button class = "TIW" id = "button_brown" onclick = "clickbutton4()">일간</button>
		<button class = "TIW" id = "button_pink" onclick = "clickbutton4()">주간</button>
		<button class = "TIW" id = "button_pink" onclick = "clickbutton4()">월간</button>
		<div style = "width : 98%; height : 70%;border: 1px solid #000000;"></div>
	</div>
	</div>
	<script>
		function clickbutton1(){
			var div2 = document.getElementsByClassName('b_reco');

		    for (var i = 0; i < div2.length; i++) {
		      div2[i].addEventListener('click', function(){
		        for (var j = 0; j < div2.length; j++) {
		          div2[j].style.background = "#F5715C";
		        }
		        this.style.background = "#A84E19";
		      })
		    }
		}
		function clickbutton2(){
			var div2 = document.getElementsByClassName('best_re');

		    for (var i = 0; i < div2.length; i++) {
		      div2[i].addEventListener('click', function(){
		        for (var j = 0; j < div2.length; j++) {
		          div2[j].style.background = "#F5715C";
		        }
		        this.style.background = "#A84E19";
		      })
		    }
		}
		function clickbutton3(){
			var div2 = document.getElementsByClassName('debate');

		    for (var i = 0; i < div2.length; i++) {
		      div2[i].addEventListener('click', function(){
		        for (var j = 0; j < div2.length; j++) {
		          div2[j].style.background = "#F5715C";
		        }
		        this.style.background = "#A84E19";
		      })
		    }
		}
		function clickbutton4(){
			var div2 = document.getElementsByClassName('TIW');

		    for (var i = 0; i < div2.length; i++) {
		      div2[i].addEventListener('click', function(){
		        for (var j = 0; j < div2.length; j++) {
		          div2[j].style.background = "#F5715C";
		        }
		        this.style.background = "#A84E19";
		      })
		    }
		}
	</script>
	<div style="text-align:center">${result}</div>
</body>
</html>
