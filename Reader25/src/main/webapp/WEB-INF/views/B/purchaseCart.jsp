<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP&Servlet</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
	<%-- body{
		background:url('<%= request.getContextPath() %>/images/bg.png') no-repeat center center fixed;
		background-size: cover;
	}  --%>
	img{
		align="center"
	}
	.loginArea{float: right;}
	#loginTable{text-align: right;}
	#loginTable td:nth-child(1){padding-right: 15px;}
	.loginBtns{float: right; margin-left: 5px;}
	#loginBtn, #myPageBtn{background: #D1B2FF;}
	#joinBtn, #logoutBtn{background: #B2CCFF;}
	input[type=button], input[type=submit]{cursor: pointer; border-radius: 15px; color: white;}
	#userInfo label{font-weight: bold;}

	.wrap{background: #F5715C; width: 100%; height: 50px;}
	.menu{
		background: #F5715C; color: white; text-align: center; font-weight: bold; 
		vertical-align: middle; width: 150px; height: 50px; display: table-cell;
	}
	nav{width: 600px; margin-left: auto; margin-right: auto;}
	.menu:hover {background: beige; color:orangered; font-weight:bold; cursor:pointer;}
 
 /*        결제                  */
 
 	.outer{
		min-width: 500px; min-height: 500px; font-size: 14px;
		margin-left: auto; margin-right: auto; margin-top: 5%; margin-bottom: 50px;
	}
	
	table {text-align:center; }
	td{height:40px;}
	
	input[type="text"]{
		height:20px; 
		border : 0px;
		text-align:center;
	}
	hr{width:50%; color:#bcbcbc;}
	
	.btn{
		font-size: 14px; color:#fff; border: 1px solid  #F5715C;
		background-color:  #F5715C; width:80px; height:30px;
	}
	
	.Btn{
		font-size: 14px; color:#fff; border: 1px solid  #F5715C;
		background-color:  #F5715C; width:150px; height:30px;
	}
 
 /*    footer    */
footer{
	width: 100%;
	height: 270px;
	background-color: #F5715C; color: white;
	padding-top: 30px;
}
#bottom_logo{
	display: inline-block;
	width: 346px;
	height: 77px;
}

#notice{
	display: inline-block;
	width: 800px;
	color: white;
	padding:3px 2px 0 10px;
	/*출력할 문자의 위치 ( 위쪽에서 3px , 오른쪽 2px , 아래쪽 0 , 왼쪽 30px만큼 공간을 띄고 출력)  */
	font-family: NanumGothic;
	font-size: 15px;
	font-weight:bold;
	line-height: 18px;
	letter-spacing: 3px;
}


</style>
</head>
<body>
	<!-- <h1 align="center">Reader25</h1> -->
<%@include file="../common/menubar.jsp" %>
	<br>
	  
	  
	<div class="outer">
		<form action="<%= request.getContextPath() %>/importBuy" method="post" id="buyForm" name="buyForm">
			<div id="listArea" align="center">
				<h2 align="center">주문하신 상품</h2>			 
				<table class="table1">
					<tr>
						<td></td>
						<td>상품 코드</td>
						<td>상품 이름</td>
						<td>상품 가격</td>
						<td>개수</td>
					</tr>
					
					<tr>
						<td><input type="hidden" name="chk" ></td>
						<td><input type="text" name="p_id"></td>
						<td><input type="text" id="pName" name="p_name"></td>
						<td><input type="text" name="cart_price" ></td>
						<td><input type="text" name="amount"></td>
					</tr>
					
				</table>		
				<br><br><br><br>
				총 금액 : <input type="text" id="totla" name="total" >	
				<br><br><br><br>
				
			</div>
			<hr>
			<div id="loginUserTable" align="center">
				<h2>배송지</h2>
				<p>(저장되어있는 배송지를 가져옵니다. 수정하실 부분을 적어주세요.)</p>
				<br>
				<table id="table2">
					<tr>
						<td width="200px">수령인</td>
						<td width="200px"><input type="text" id="orderName" name="orderName"></td>
					</tr>				
					<tr>
						<td>아이디</td>
						<td><input type="text" name="memberId" style="background:lightgray;"></td>
					</tr>
					<tr>
						<td>휴대폰 번호</td>
					<td><input type="text" maxlength="11" name="orderPhone" id="orderPhone" placeholder="(-없이)01012345678" ></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="" name="email"></td>
					</tr>
					<tr>
						<td>우편번호</td>
						<td><input type="text" id="userPostal" name="joinPostal"  ></td>
						<td><div><input type="button" class="btn" id="findPostal" onclick="ifindPostal();" value="검색"></div></td>
					</tr>
					<tr>
						<td>* 주소</td>
						<td><input type="text" id="joinAddress1" name="joinAddress1"></td>
						<td><span id="guide" style="color:#999;display:none"></span></td>
					</tr>
					<tr>
						<td>* 상세주소</td>
						<td height="60px"><input type="text" id="joinAddress2" name="joinAddress2" ></td>
					</tr>
					<tr>
						<td>배송메모</td>
						<td><input type="text" id="orderRequire" name ="orderRequire" placeholder="요청사항을 입력해주세요."></td>
					</tr>
				</table>
				<br>
			</div>
			<hr>
			<br><br><br><br>
			<div align="center">
				<input type="submit" onclick="buy(); " value="주문하기" class="Btn">
				<input type="button" onclick="location.href='javascript:history.back();'" value="장바구니 수정하기" class="Btn">
			</div>
			<br><br><br><br>	
		</form>	
	</div><!-- outer마지맘ㄱ -->
	  
	  
	  
	<br><br><br><br><br><br><br><br>

	<script>
		function buy(){//필수 동의 체크 확인
			var pName = $("#pName").val();
			var pPrice = $("#total").val();

			var orderName = $("#orderName").val();
			var orderEmail = $("#orderEmail").val();
			var orderPhone = $("#orderPhone").val();
			
			var orderAddress = $("#joinAddress1").val() + $("#joinAddress2").val(); // 우폄번호 / 주소 로 나뉘어있어 나눠라ㅏ
			var orderPost = $("#userPostal").val();
				if(check){
					IMP.init('imp09501430');//내가맹점고유번호
				    IMP.request_pay({
				          pg : 'html5_inicis', // version 1.1.0부터 지원.
				          pay_method : 'card', // 결제수단
				          merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
				          name : pName, //주문 명
				          amount : pPrice, //판매 가격
				          buyer_email : orderEmail, // 구매재 이메일
				          buyer_name : orderName, // 구매자 이름
					      buyer_tel : orderPhone, // 구매자 핸드폰 번호
					      buyer_addr : orderAddress, // 구매자 주소
				          buyer_postcode : orderPost // 구매자 우편번호
				      }, function(rsp) {
				          if ( rsp.success ) {
							$('#buyForm').submit();
				          } else {
				        	  alert('결재에 실패하였습니다.');
				          }
				      });
				} else {
					alert('주문 동의를 해주세요.');
					return false;
				}
		}
	</script>
</body>
</html>