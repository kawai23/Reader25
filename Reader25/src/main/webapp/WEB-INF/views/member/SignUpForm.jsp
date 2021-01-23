<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reader들을 위한 Reader 25</title>

<style>
/*화면*/
.outer{
		width: 80%; min-height: 400px; margin-left: 10%; margin-right: 10%; 
		 min-width: 1000px;
		padding-top: 15px; display: inline-block;
		font-family: 카페24 아네모네에어; font-size:18px;
		}
		
span.guide{display: none; top: 12px; right: 10px;}
span.ok{color: green;}
span.error{color: red;}

span.email{display: none; top: 12px; right: 10px;}
span.check{color: green;}
span.no{color: red;}

td{
	height: 45px;
}
/*글자*/
#blabla{color: #DB0000;}
.massage {
		font-size:15px; border:0.5px solid #aaa;
		font-family: 카페24 아네모네에어;
		}
input{font-size:18px;
		font-family: 카페24 아네모네에어;
		}
span.guide{font-size:18px;
		font-family: 카페24 아네모네에어;
		}
span.email{font-size:18px;
		font-family: 카페24 아네모네에어;
		}
.txt_signup{
	display: inline-block;
	font-size:55px;
	font-family: 카페24 아네모네;
	margin-left: 20%;
}

.txt_signup_tb{
	height: 35px;
	display: inline-block;
	font-size:25px;
	font-family: 카페24 아네모네에어;
	text-align: center;
	width: 200px;
}
.txt_signup_input{
	height: 35px;
	display: inline-block;
	font-size:15px;
	font-family: 카페24 아네모네에어;
	text-align: center;
}
/*버튼*/
.btn_sign_input{
	width:150px;
    height: 35px;
	font-size: 17px; color:#555353;
	border: 1px solid  #FFFFFF;
    background-color:  #FFC398;
    font-family: 카페24 아네모네에어;
}
.btn1 {
	width:200px;
    height: 60px;
	font-size: 20px; color:#FFFFFF;
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

#dirrhks{background: white;
	margin: auto;
	margin-top: 20px;
	border-radius: 2px;
	box-shadow: 0px 2px 2px 3px lightgray;
	padding: 20px;
	width: 70%}
	

</style>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	<div class="outer">
				
		<form action="minsert.me" method="post" id="joinForm" name="joinForm" onsubmit="return send(this);">
			<br>
			<h2 class="txt_signup">회원가입 . . .</h2>
			<hr><br>
			<table align="center">
				<tr>
					<td class="txt_signup_tb">아이디</td>
					<td width="200px"><input type="text" id= "joinMemberid" name="id" placeholder="6자 이상의 영문+숫자" required></td>
					<td width="300px"><span class="guide ok">이 아이디는 사용 가능합니다.</span>
						<span class="guide error">이 아이디는 사용 불가능합니다.</span>
						<input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value="0">
					</td>
				</tr>
				<tr>
					<td class="txt_signup_tb">이름</td>
					<td><input type="text" name="name" required></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">비밀번호</td>
					<td><input type="text" class="joinPassword" id="joinPassword1" name="pwd" required></td>
					<td rowspan="2"><label id="pwResult"></label></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">비밀번호 확인</td>
					<td><input type="text" class="joinPassword" id="joinPassword2" name="pwd2" required></td>
				</tr>
			</table>
			
			<br><br><br>
			
			<table align="center">
				<tr>
					<td class="txt_signup_tb">연락처</td>
					<td width="200px"><input type="tel" maxlength="11" name="phone" placeholder="(-없이)01012345678" required></td>
					<td width="300px"></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">우편번호</td>
					<td><input type="text" id="joinPostal" name="joinPostal" readonly></td>
					<td><input type="button" class="btn_sign_input" id="findPostal" onclick="ifindPostal();" value="검색"></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">주소</td>
					<td><input type="text" id="joinAddress1" name="joinAddress1" readonly></td>
					<td><span id="guide" style="color:#999;display:none"></span></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">상세주소</td>
					<td><input type="text" id="joinAddress2" name="joinAddress2" required></td>
					<td></td>
				</tr>
			</table>
			
			<br><br><br>
			
			<table align="center">
				<tr>
					<td class="txt_signup_tb">이메일</td>
					<td width="200px"><input type="email" id="joinEmail" name="email" required></td>
					<td width="150px"><span class="email check">이 이메일은 사용 가능합니다.</span>
						<span class="email no">이 이메일은 사용 불가능합니다.</span>
						<input type="hidden" name="emailDuplicateCheck" id="emailDuplicateCheck" value="0" required>
					</td>
				</tr>
				<tr>
					<td class="txt_signup_tb">성별</td>
					<td><input type="radio" id="male" name="gender" value="M">남자<input type="radio" id="female" name="gender" value="F">여자</td>
					<td width="300px"></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">생년월일</td>
					<td><input type="date" name="birthDay" required></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">MBTI</td>
					<td><input type="text" name="mbti"></td>
					<td></td>
				</tr>
			</table>
			
			<br><hr><br>
			
			<br><br>
			
			<table align="center">
				<tr>
					<td align="center" colspan="3">
						<input type="checkbox" class="terms" id="terms" name="terms" value="약관동의" onclick="allCheck();">필수 약관 동의 (필수)
					</td>
				</tr>
				<tr height="30px">
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						<input type="checkbox" class=" terms" id="all" name="receiveInform" value="전체선택" onclick="allReciveCheck();">할인 쿠폰, 혜택 정보 수신 동의 (선택)
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						<input type="checkbox" class=" terms" id="sms" name="receiveInform" value="sms" onclick="check();">SMS
						<input type="checkbox" class=" terms" id="email" name="receiveInform" value="email" onclick="check();">E-MAIL
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2">
						<input type="checkbox" id="adult" name="adult" value="adult">본인은 만 14세 이상 입니다.(필수)	
					</td>
				</tr>
			</table>
			
			<div id="dirrhks">
				<table>
					<tr>
						<td class="txt_signup_tb">이용약관 동의</td>
						<td width="500px" colspan="2">
							<div class="message">
							Reader25는 Reader들의 활동을 응원합니다.<br>
							Reader25의 서비스 및 제품(이하 '서비스')을 이용하실 수 있으시며<br> 서비스의 발전의 위한 제안도 가능합니다.<br>
							본 약관은 다양한 Reader25 서비스의 이용과 관련하여<br> Reader25 서비스를 제공하는 Reader25와 <br>
							이를 이용하는 Reader25 서비스 회원(이하 '회원') 또는 <br>비회원과의 관계를 설명하며, <br>
							아울러 여러분의 Reader25 서비스 이용에<br> 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
							</div>
						</td>
					</tr>
				</table>
			</div>
			<br>
			<table align="center">
				<tr>
					<td align="center">
						<a id="blabla">선택 항목에 동의하지 않은 경우는 <br>
						회원가입 및 일반적인 서비스를 이용할 수 없습니다.</a>
					</td>
				</tr>
			</table>
			
			<br><br><br><br>	
			
			
			<br clear="all">
			
			<div class="btns" id="signUpBtns" align="center">
				<table>
					<tr>
						<td width="300" align="center">
							<button style="cursor:pointer" id="btn1" type="submit" class="btn1" onclick="return validate();"><span>가입하기</span></button>
						</td>
						<td width="300" align="center">
							<button style="cursor:pointer" id="btn3" class="btn3" onclick="location.href='home.do'"><span class="txt_type">메인으로</span></button>
						</td>
					</tr>
				</table>
				<br><br>
			</div>
			
		</form>
		
	</div>
	
	
<script>
	
	//우편번호 검색
	function ifindPostal() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('joinPostal').value = data.zonecode;
                document.getElementById("joinAddress1").value = roadAddr;
//                 document.getElementById("joinAddress2").value = data.jibunAddress;
				document.getElementById("joinAddress2").value = "";

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if (roadAddr !== '') {
                    document.getElementById("joinAddress1").value += extraRoadAddr;
                } else {
                    document.getElementById("joinAddress1").value += '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
	// 아이디 유효성 검사
	$(function(){
		$('#joinMemberid').on('keyup', function(){
			var userId = $(this).val().trim();
				
			if(userId.length < 4){
				$('.guide').hide();
				$('#idDuplicateCheck').val(0);
					
				return;
			}
				
			$.ajax({
				url: 'dupid.me',
				data: {id:userId},
				success: function(data){
					if(data == 'true'){
						$('.guide.error').hide();
						$('.guide.ok').show();
						$('#idDuplicateCheck').val(1);
					} else{
						$('.guide.error').show();
						$('.guide.ok').hide();
						$('#idDuplicateCheck').val(0);
					}
				}
			});
		});
	});
		
	function validate(){
		if($('#idDuplicateCheck').val() == 0){
			alert('사용가능한 아이디를 입력해주세요.');
			$('#joinMemberid').focus();
			return false;
		} else{
			$('#joinForm').submit();
		}
	}
	
	// 이메일 유효성 검사
	$(function(){
		$('#joinEmail').on('keyup', function(){
			var userEmail = $(this).val().trim();
				
			if(userEmail.length < 4){
				$('.email').hide();
				$('#emailDuplicateCheck').val(0);
					
				return;
			}
				
			$.ajax({
				url: 'dupemail.me',
				data: {email:userEmail},
				success: function(data){
					if(data == 'true'){
						$('.email.no').hide();
						$('.email.check').show();
						$('#emailDuplicateCheck').val(1);
					} else{
						$('.email.no').show();
						$('.email.check').hide();
						$('#emailDuplicateCheck').val(0);
					}
				}
			});
		});
	});
		
	function validate(){
		if($('#emailDuplicateCheck').val() == 0){
			alert('사용가능한 아이디를 입력해주세요.');
			$('#joinEmail').focus();
			return false;
		} else{
			$('#joinForm').submit();
		}
	}
	
	//비밀번호 제한
	$('#joinPassword1').keyup(function(){
		var joinPassword1 = $("#joinPassword1").val();
		var joinPassword2 = $("#joinPassword2").val();
			
		var reg = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
		if(joinPassword2.length == 0 || !isPwChecked){
			if(false === reg.test(joinPassword1)) {
				$('#pwResult').text('소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(joinPassword1)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(joinPassword1.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(hangulcheck.test(joinPassword1)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else {
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
			 }
		}else{
			if(false === reg.test(joinPassword2)) {
				$('#pwResult').text('소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(joinPassword2)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(joinPassword2.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(hangulcheck.test(joinPassword2)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(joinPassword1 != joinPassword2){
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = false;
			}else{
				$('#pwResult').text('비밀번호가 사용가능합니다.');
				$('#pwResult').css({'color':'green', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = true;
			}
		}
	});
	
	//비밀번호 일치
	$('#joinPassword2').keyup(function(){
		var joinPassword1 = $("#joinPassword1").val();
		var joinPassword2 = $("#joinPassword2").val();
			
		var reg = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(joinPassword1.length == 0 || !isPwChecked){
			if(false === reg.test(joinPassword2)) {
				$('#pwResult').text('소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(joinPassword2)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(joinPassword2.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(hangulcheck.test(joinPassword2)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else {
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
			 }
		}else{
			if(false === reg.test(joinPassword1)) {
				$('#pwResult').text('소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(joinPassword1)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(joinPassword1.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(hangulcheck.test(joinPassword1)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(joinPassword1 != joinPassword2){
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'red', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = false;
			}else{
				$('#pwResult').text('비밀번호가 사용가능합니다.');
				$('#pwResult').css({'color':'green', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = true;
			}
		}
	});
		
	//전체 체크
	function allCheck(){
		var terms = $(".terms");
		var checkItem="";
		for(var i=0; i<terms.length; i++){
			if(terms[0].checked == true){
				terms[i].checked = true;
			} else {
				terms[i].checked = false;
			}
		}
	}
	//전체 체크
	function allReciveCheck(){
		var receiveInform = document.getElementsByName("receiveInform");
		var checkItem="";
		for(var i=0; i<receiveInform.length; i++){
			if(receiveInform[0].checked == true){
				receiveInform[i].checked = true;
			} else {
				receiveInform[i].checked = false;
			}
		}
	}
	//홍보 수단 체크 기능
	function check(){
		var receiveInform = document.getElementsByName("receiveInform");
		var checkItem=""
		for(var i = 0; i<receiveInform.length; i++){
			if(receiveInform[i].checked == false){
				checkItem = false;
			}
		}
		receiveInform[0].checked = checkItem;
	}	
	
	

</script>
	
	
	<%@ include file="../common/footer.jsp" %>


</body>
</html>