<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<style>
/*화면*/
.outer { 
		background: rgba(246, 246, 246, 1);
		min-height: 600px;
		width: 80%;
		min-width:1000px;
		margin:auto;
		padding-top: 20px;
		font-family: 카페24 아네모네에어; font-size:25px;
}
/*글자*/
.outer>.search-div>h3 {
			font-size:50px;
			font-family: 카페24 아네모네;
			text-align: center;}
.text h3 { font-size:20px; font-family: 카페24 아네모네에어;}
.text p { font-size:14px; font-family: 카페24 아네모네에어;}
.text { display:inline-block; 
          padding:20px; }
/*버튼*/
.button { font-size:24px; cursor:pointer;}
#searchBtn2, #searchBtn {
	width:200px;
    height: 60px;
	font-size: 20px; color:#fff;
	border: 1px solid  #C95F12;
    background-color:  #C95F12;
    font-family: 카페24 아네모네에어;
}
#btn3{
	width:200px;
    height: 60px;
	font-size: 20px; color:#000000;
	border: 1px solid  #C4C4C4;
    background-color:  #C4C4C4;
    font-family: 카페24 아네모네에어;
}
/*입력단*/
.form-control{
	width: 230px; height: 30px;
	background: #EAEAEA;
	text-align: center; border: none;
	font-size:20px; color:#400040;
	font-family: 카페24 아네모네에어;
}
/*모달*/
.jquery-modal blocker current {
	visibility: none;
}
.modal {
	margin: 40% auto; padding: 20px;
	text-align: center;
	font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-back {
	display: none; position: fixed; 
	z-index: 1; left: 0;
	top: 0; width: 100%; 
	height: 100%;
	overflow: auto; background: rgba(0, 0, 0, 0.4); 
	font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-close{
	background-color: #C4C4C4;
	color:white; width: 80px;
	height: 30px; border:none;
	display:inline-block; left: 40%;
	font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-accept{
	background-color: rgba(255,127,14,1);
	color:white; width: 80px;
	height: 30px; border:none;
	display:inline-block; left: 40%;
	font-family: 카페24 아네모네에어; font-size:15px;
}
#modal-ok{
	background:rgba(85, 83, 83, 1);
	font-family: 카페24 아네모네에어; font-size:15px;
}
.modal-accept{
	background-color: #C95F12;
	font-family: 카페24 아네모네에어; font-size:15px;
}
.modal p{
	display:inline-block;
}
.modal img{
	position:relative;
	top: 10px;
}
.search-div{
		min-height: 100px; 
		background: white;
		border-radius: 10px;
		margin-left: auto; margin-right: auto;
		margin-top: 3%; margin-bottom: 10%;
		box-shadow: 0px 5px 5px 7px lightgray;
		padding: 20px;
		width: 600px;
		
		animation-duration:2s; animation-iteration-count:1; animation-name:aa_ani;
}

@keyframes aa_ani{
            0%{
                opacity: 0;
            } 10%{
            	opacity: 0;
            }100%{
            	opacity: 1;
            }
        }
</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>

	<!-- 모달창 -->
	<!-- 아이디 찾기 모달창 -->
	<div class="modal-back" id="login-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p>찾으시는 아이디는</p>
				<p id="id_value"></p>
				<p>입니다 ^-^</p>
				<br>
				<button class="modal-accept" value="accept">로그인하기</button>
				<button class="modal-close" value="Close">취소</button>
			</div>
		</div>
	</div>
	<!-- 비밀번호 찾기 모달창 -->
	<div class="modal-back" id="check-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/check.png" width="40px;"/>
				<p>임시 비밀번호는</p>
				<p id="pw_value"></p>입니다.
				<p>가입 시 기입한 메일로도 비밀번호를 보냈으니 확인해주세요.</p>
				<p>로그인 후 비밀번호 변경을 해주세요</p>
				<br>
				<button class="modal-accept" value="accept">로그인하기</button>
				<button class="modal-close" value="Close" id="modal-ok">확인</button>
			</div>
		</div>
	</div>
	
  <div class="outer">
  	<div class="search-div">
	  	<h3>아이디/비밀번호 찾기</h3>
	  		<table align="center">
	  			<tr>
	  				<td>
	  					<div style="margin-bottom: 10px;" class="radio_div">
						<input type="radio" id="search_1" name="search_total" onclick="search_check(1)" checked="checked">
						<label for="search_1">아이디 찾기</label>
						</div>
	  				</td>
	  				<td>
	  					<div class="radio_div">
						<input type="radio" id="search_2" name="search_total" onclick="search_check(2)"> 
						<label for="search_2">비밀번호 찾기</label>
						</div>
	  				</td>
	  			</tr>
	  		</table>
					<br>
					<!-- 아이디 찾기 단  -->
					<div id="searchI" align="center">
						<div class="form-group">
							<label class="font-weight-bold text-white" for="inputName_1">이름</label>
							<div>
								<input type="text" class="form-control" id="inputName_1" name="inputName_1" placeholder="ex) 김건강">
							</div>
						</div>
						<br>
						<div class="form-group">
							<label class="font-weight-bold text-white" for="inputPhone_1">휴대폰번호</label>
							<div>
								<input type="text" class="form-control" id="inputPhone_1" name="inputPhone_1" placeholder="ex) 010-7777-9999">
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<button id="searchBtn" type="button" onclick="idSearch_click()" class="btn btn-primary btn-block"><label for="modal">확인</label></button>
							<button  style="cursor:pointer" id="btn3" class="btn3" onclick="location.href='loginView.me'"><span class="txt_type">취소</span></button>
						</div>
					</div>
					<!-- 비밀번호 찾기 단  -->
					<div id="searchP" style="display: none;" align="center">
						<div class="form-group">
							<label class="font-weight-bold text-white" for="inputId">아이디</label>
							<div>
								<input type="text" class="form-control" id="inputId_2" name="inputId_2" placeholder="ex) asdfg">
							</div>
						</div>
						<br>
						<div class="form-group">
							<label class="font-weight-bold text-white" for="inputEmail_2">이메일</label>
							<div>
								<input type="email" class="form-control" id="inputEmail_2"	name="inputEmail_2" placeholder="ex) E-mail@gmail.com">
							</div>
						</div>
						<br><br>
						<div class="form-group">
							<button id="searchBtn2" type="button" onclick="pwSearch_click()" class="btn1"><label for="modal2">확인</label></button>
							<button style="cursor:pointer" id="btn3" class="btn3" onclick="location.href='loginView.me'"><span class="txt_type">취소</span></button>
	  					</div>
	  				</div>
	  				<br>
	  			</div>
	  	</div>
 
  <%@ include file="../common/footer.jsp" %>
</body>
<script>
	//모달 기능
	$(function(){
		$('.modal-close').click(function(){
			$('.modal').hide();
			$('.modal-back').hide();
		});
		$('#login-modal .modal-accept').click(function(){
			location.href="loginView.me";
		});
		$('#check-modal .modal-accept').click(function(){
			location.href="loginView.me";
		});
	});

	//체크 버튼에 따라 아이디/비밀번호 기능이 달라진다
	function search_check(num) {
		if (num == '1') {
			document.getElementById("searchP").style.display = "none";
			document.getElementById("searchI").style.display = "";	
		} else {
			document.getElementById("searchI").style.display = "none";
			document.getElementById("searchP").style.display = "";
		}
	}
	
	// 아이디 값 저장하기 위한 변수
	var idV = "";
	// 아이디 값 받고 출력하는 ajax
	var idSearch_click = function(){
		
		var inputName_1 = $('#inputName_1').val();
		var inputPhone_1 = $('#inputPhone_1').val();
		
		$('#login-modal').show();
		$('#login-modal .modal').show();
		
		$.ajax({
			type:"POST",
			url: 'userSearch.me',
			data: {inputName_1:inputName_1, inputPhone_1:inputPhone_1},
			success:function(data){
				if(data == null){
					$('#id_value').text("회원 정보를 확인해주세요!");	
				} else {
					$('#id_value').text(data);
					// 아이디값 별도로 저장
					idV = data;
				}
			}
		});
	}
	
	// 비밀번호 값 받고 출력하는 ajax
	var pwSearch_click = function(){
		
		var inputId_2 = $('#inputId_2').val();
		var inputEmail_2 = $('#inputEmail_2').val();
		
		$('#check-modal').show();
		$('#check-modal .modal').show();
		
		$.ajax({
			type:"POST",
			url: 'pwSearch.me',
			data: {inputId_2:inputId_2, inputEmail_2:inputEmail_2},
			success:function(data){
				if(data == null){
					$('#pw_value').text("다시 시도해주세요.");	
				} else {
					$('#pw_value').text(data);
				}
			}
		});
	}

</script>

</html>