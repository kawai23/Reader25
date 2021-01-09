<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>





<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>



<%-- <link rel="stylesheet" href="${contextPath}/resources/css/member/signup.css" type="text/css"> --%>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<style>
.outer{
		width: 900px; height: 900px; font-size: 13px;
		margin-left: auto; margin-right: auto; margin-top: 5%; 
		margin-bottom: 50px;
		}
		
span.guide{display: none; font-size: 12px; top: 12px; right: 10px;}
span.ok{color: green;}
span.error{color: red;}

span.email{display: none; font-size: 12px; top: 12px; right: 10px;}
span.check{color: green;}
span.no{color: red;}


td{ margin: 5px; padding: 5px }


</style>


</head>
<body>


<%@ include file="../common/menubar.jsp"%> <br><br><br>

<div class="container-fluid" style="justify-content: center;"> 

 	<div class="row">
 
 
 
 
 	  <div class="col-sm-2"></div>
	  <div class="col-sm-2" style="background:rgba(0, 0, 0, 0.5);border: 1px solid black" >
	  
	  <img alt=" " src="">
	  
	  <a  style="margin-left: 50px; color: white;">${loginUser.name }</a> <br><br>
	  
	  <a style="margin-left: 70px; color: white;">포인트 : ${loginUser.point }</a> <hr>
	  
	  
	 
			



				
						<a href="myUpdateForm.me" class="list-group-item active" >내 정보 수정</a> 
						<a href="#" class="list-group-item">회원 탈퇴 </a> 
						<hr>
						
						<a href="myList.me?code=2" class="list-group-item">내가 쓴 리뷰</a>
						<a href="myList.me?code=4" class="list-group-item">책방 리스트</a>
						<a href="#" class="list-group-item"  >주문 리스트</a>
						<a href="myList.me?code=5" class="list-group-item">내가 쓴 책</a>
						<a href="#" class="list-group-item">좋아요/북마크</a>
						
						<a href="myList.me?code=1" class="list-group-item">문의사항</a>

				
				<br>
				<br>
				<br>
			
	  
	  </div>
	  
	  
	  
	  
	  
	  
	   <div class="col-sm-6" style="border: 1px solid black;" >
	   
				

		
		
		<form action="myUpdate.me" method="post" id="joinForm" name="joinForm" onsubmit="return send(this);">
			<br>
			<h2 class="txt_signup">내 정보 수정</h2>
			<hr><br>
			<table style="text-align: center; width: 500px " >
			
				<tr>
					<td class="txt_signup_tb">이름</td>
					<td><input type="text" name="name" readonly="readonly" value="${loginUser.name }"></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">비밀번호</td>
					<td><input type="password" class="joinPassword" id="joinPassword1" name="pwd" required></td>
					<td rowspan="2"><label id="pwResult"></label></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">비밀번호 확인</td>
					<td><input type="password" class="joinPassword" id="joinPassword2" name="pwd2" required></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">연락처</td>
					<td><input type="tel" maxlength="11" name="phone" placeholder="(-없이)01012345678" value="${loginUser.phone }"></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">우편번호</td>
					<td><input type="text" id="joinPostal" name="joinPostal" readonly></td>
					<td style="text-align: left;"><input type="button"  class="btn_sign_input" id="findPostal" onclick="ifindPostal();" value="검색"></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">주소</td>
					<td><input type="text" id="joinAddress1" name="joinAddress1" readonly></td>
					<td><span id="guide" style="color:#999;display:none"></span></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">상세주소</td>
					<td><input type="text" id="joinAddress2" name="joinAddress2"></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">이메일</td>
					<td><input type="email" id="joinEmail" name="email" value="${loginUser.email }"></td>
					<td width="150px"><span class="email check">이 이메일은 사용 가능합니다.</span>
						<span class="email no">이 이메일은 사용 불가능합니다.</span>
						<input type="hidden" name="emailDuplicateCheck" id="emailDuplicateCheck" value="0">
					</td>
				</tr>
				<tr>
					<td class="txt_signup_tb">성별</td>
				
					
					<c:if test="${ loginUser.gender eq 'M'}">
						<td>
							<input type="radio" name="gender" value="M" checked>남
							<input type="radio" name="gender" value="F">여
						</td>
					</c:if>
					<c:if test="${ loginUser.gender eq 'F'}">
						<td>
							<input type="radio" name="gender" value="M">남
							<input type="radio" name="gender" value="F" checked>여
						</td>
					</c:if>
					
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">생년월일</td>
					<td><input type="date" name="birthDay" value="${loginUser.birthDay }"></td>
					<td></td>
				</tr>
				<tr>
					<td class="txt_signup_tb">MBTI</td>
					<td><input type="text" name="mbti"></td>
					<td></td>
				</tr>
			</table>
			
			<br>
			
			<div class="btns" id="signUpBtns" align="center">
				<table>
					<tr>
						
						
						<td colspan="2" align="center">
			    	
				    	<button type="submit" style="margin: 5px" class=" btn btn-primary" >확인</button>
				    	
				    	<button type="reset"  style="margin: 5px"class="btn btn-default " onclick="location.href='home.do'">취소</button></td>
					</tr>
				</table>
				
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
		
		

</script>
	   
	   
	  
	  
	</div>

 </div>


</body>
</html>