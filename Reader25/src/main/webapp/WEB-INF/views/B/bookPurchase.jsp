<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, com.kh.Reader25.board.model.vo.*"%>
<%@ page import="java.sql.*"%><%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style media="screen">
	
	.list-A{
	margin-left: 15%;
    margin-right: 50%;
    width: 1300px;
	}
	.sun{
	 margin: auto;
	 border-bottom: 3px solid rgb(200, 200, 200);
     max-width: 80%;
	}
	.lu-table{
	margin-left: 15%;
    margin-right: 50%;
	}
    .outer {
      min-width: 500px;
      min-height: 500px;
      font-size: 14px;
      margin-left: auto;
      margin-right: auto;
      margin-top: 5%;
      margin-bottom: 50px;
    }

    table {
      text-align: center;
    }

    td {
      height: 40px;
    }

    input[type="text"] {
      height: 20px;
      border: 0px;
      text-align: center;
    }

    hr {
      width: 50%;
      color: #bcbcbc;
    }

    .btn {
      font-size: 14px;
      color: #fff;
      border: 1px solid #F5715C;
      background-color: #F5715C;
      width: 80px;
      height: 30px;
    }

  </style>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<style>
.outer{
	width: 80%; min-height: 400px;  margin-left: 10%; margin-right: 10%; 
	display: inline-block;
	font-family: 카페24 아네모네에어; font-size:18px;
}
.txt_pack{
	display: inline-block;
	font-size:55px;
	font-family: 카페24 아네모네;
	margin-left: 20%;
}
.table1{
	min-width: 70%;
	min-height: 10%;
	border-top:2px solid #F7B45E;
	border-collapse: collapse;
	text-align: center;
	font-family: 카페24 아네모네에어; font-size:22px;
}
.table1 th{
	height: 30px;
	border-bottom: 1px solid #F7B45E;
}
#total_price{
	display: inline-block;
	font-size: 35px;
	font-family: 카페24 아네모네;
 	float:right;
}

.list-A{
	min-height: 100px; 
	background: white;
	margin: auto; padding-top:5%; padding-left:2%; padding-right:2%; padding-bottom:3%;
	border-radius: 2px;
	box-shadow: 0px 2px 2px 3px lightgray;
	width: 80%;
}
.sum{
	min-height: 100px; 
	background: rgba(225,242,120,0.1);
	margin: auto; padding-top:5%; padding-left:2%; padding-right:2%; padding-bottom:3%;
	border-radius: 2px;
	box-shadow: 0px 3px 3px 5px lightgray;
	width: 80%;
}
.bea-title{
	display: inline-block;
	font-size:45px;
	font-family: 카페24 아네모네;
	margin-left: 10%;
}
.bea-sub{
	display: inline-block;
	font-size:15px; color: #A50000;
	margin-left: 10%;
}
.sum input{
	height: 35px;
	display: inline-block;
	font-size:15px;
	font-family: 카페24 아네모네에어;
	text-align: center;
}
.txt_sum_tb{
	font-size:20px;
	font-family: 카페24 아네모네에어;
	text-align: center;
	width: 50%
}
.btn_sign_input{
	width:100px;
    height: 35px;
	font-size: 17px; color:#555353;
	border: 1px solid  #FFFFFF;
    background-color:  #FFC398;
    font-family: 카페24 아네모네에어;
}
#btn1 {
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
#findPostal{color:white;}
#poingdiv{text-align: center;}
#pointbtn{color:white; background: #C4C4C4; border:none; height:35px;}
#pointinput{width:200px; height:30px;}
#sumTable{
	min-width: 400px; margin-left: 10%
}
.tdbottom{
	border-bottom: 4px solid #F7B45E;
}
.tdbottom2{
	border-bottom: 2px solid #F7B45E;
}
.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
		font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-back {
		display: none; 
		position: fixed; 
		z-index: 1;
		left: 0;
		top: 0;
		width: 100%; 
		height: 100%;
		overflow: auto; 
		background: rgba(0, 0, 0, 0.3); 
		font-family: 카페24 아네모네에어; font-size:17px;
}
.modal-close, .modal-close-r{
	background-color: #C4C4C4;
	color:white; width: 80px;
	height: 30px; border:none;
	display:inline-block; left: 40%;
	font-family: 카페24 아네모네에어; font-size:17px;
}
.modal p{
		display:inline-block;
}
.modal img{
		position:relative;
		top: 10px;
}
</style>
</head>
<body>
<%@include file="../common/menubar.jsp" %>

<div class="modal-back" id="cancel-modal">
	<div class="modal">
		<div class="modal-content">
			<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
			<p>결제를 취소 하셨습니다.</p>
			<br>
			<button class="modal-close-r" id="cancel" value="Close">확인</button>
		</div>
	</div>
</div>
<div class="modal-back" id="success-modal">
	<div class="modal">
		<div class="modal-content">
			<img src="${contextPath }/resources/images/mark/check.png" width="40px;"/>
			<p>결제에 성공 하셨습니다.</p>
			<br>
			<button class="modal-close-r" id="success" value="Close">확인</button>
		</div>
	</div>
</div>

<div class="modal-back" id="point-modal">
	<div class="modal">
		<div class="modal-content">
			<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
			<p>보유포인트가 적습니다.</p>
			<br>
			<button class="modal-close-r" id="cancel2" value="Close">확인</button>
		</div>
	</div>
</div>

<div class="outer">
    <h2 class="txt_pack">결제 하기</h2>
      <div id="listArea" class="list-A">
        <table class="table1">
          <tr>
            <th width="300px">책이미지</th>
            <th width="300px">책제목</th>
            <th width="80px">가격</th>
            <th width="50px">수량</th>
            <th width="80px">배송비</th>
            <th width="100px">합계</th>
          </tr>
          <c:set var="sum" value="0"/>
          <c:set var="sh" value="2500"/>
          <c:set var="count" value="0"/>
          <c:forEach var="b" items="${book}" varStatus="vs">
		  		<c:if test="${vs.index > 0 }">
					<c:forEach var="i" begin="0" end="${book.size()-1 }" step="1">
						<c:if test="${book.get(i).b_no == b.b_no}">
							<c:set var="count" value="${count+1}"/>
						</c:if>
					</c:forEach>
					<c:if test="${count != 1 }">
						 <c:set var="sh" value="0"/>
					</c:if>
					<c:if test="${count == 1 }">
					     <c:set var="sh" value="2500"/>
					</c:if>
				</c:if>
			<tr>
				<c:choose>
					<c:when test="${vs.last}">
						<td width="150" class="tdbottom">
						<c:choose>
							<c:when test="${ at[vs.index] eq null }">
								<p>등록된 이미지가 없습니다.<p>
							</c:when>
							<c:otherwise>
								<div class="bak_item">
									<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at[vs.index].atcName }" width="200" height="120">
								</div>
							</c:otherwise>
						</c:choose>
						</td>
							<td width="150" class="tdbottom">${b.b_name}</td>
							<td width="150" class="tdbottom">${b.b_price}원</td>
							<td width="150" class="tdbottom">${b.b_Q1}</td>
							<td width="150" class="tdbottom">${sh}원</td>
							<td width="150" class="tdbottom">${(b.b_price * b.b_Q1) + sh}원<c:set var="sum" value="${sum + (b.b_price * b.b_Q1) + sh }"/></td>
					</c:when>
						<c:otherwise>
							<td width="150" class="tdbottom2">
							<c:choose>
								<c:when test="${ at[vs.index] eq null }">
									<p>등록된 이미지가 없습니다.<p>
								</c:when>
								<c:otherwise>
									<div class="bak_item">
										<img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at[vs.index].atcName }" width="200" height="120">
									</div>
								</c:otherwise>
							</c:choose>
							</td>
							<td width="150" class="tdbottom2">${b.b_name}</td>
							<td width="150" class="tdbottom2">${b.b_price}원</td>
							<td width="150" class="tdbottom2">${b.b_Q1}</td>
							<td width="150" class="tdbottom2">${sh}원</td>
							<td width="150" class="tdbottom2">${(b.b_price * b.b_Q1) + sh}원<c:set var="sum" value="${sum + (b.b_price * b.b_Q1) + sh }"/></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
        </table>
        <br><br>
        <div id="poingdiv">
        	<span>현재 고객님의 보유 포인트는 ${loginUser.getPoint() }포인트 최대사용 가능 포인트는 <c:if test="${loginUser.getPoint() >sum}">${sum }포인트</c:if><c:if test="${loginUser.getPoint() <=sum}">${loginUser.getPoint() }포인트</c:if>입니다.</span><br><br>
        	포인트 사용 : <input type="number" id="pointinput" placeholder="사용 포인트를 적어주세요">
        	<input type="button" id="pointbtn" value="모든 포인트 사용">
        </div>
        <div id="total_price">
       		총 금액 : <span id="sp">${sum}</span> 원
        </div><br>
      </div>
      <br><br>
      <div class="sum">
      	<h2 class="bea-title">배송받을 정보</h2><p class="bea-sub">(기본으로 회원가입 시 입력한 정보를 가져옵니다)</p>
	      <div id="loginUserTable" class="lu-table">
	        <br>
	        <table id="sumTable">
	          <tr>
					<td class="txt_sum_tb" width="100px">이름</td> 
					<td width="200px"><input type="text" name="name" required value="${loginUser.name }"></td>
					<td width="100px"></td>
			  </tr>
	          <tr>
					<td class="txt_sum_tb">연락처</td>
					<td><input type="tel" maxlength="11" name="phone" id="phnoe" placeholder="(-없이)01012345678" required value="${loginUser.phone }"></td>
					<td></td>
			  </tr>
	          <tr>
					<td class="txt_sum_tb">우편번호</td>
					<td><input type="text" id="joinPostal" name="joinPostal" readonly value="${loginUser.address.split("/")[0]}"></td>
					<td><input type="button" class="btn_sign_input" id="findPostal" onclick="ifindPostal();" value="검색"></td>
				</tr>
				<tr>
					<td class="txt_sum_tb">주소</td>
					<td><input type="text" id="joinAddress1" name="joinAddress1" readonly value="${loginUser.address.split("/")[1]}"></td>
					<td><span id="guide" style="color:#999;display:none"></span></td>
				</tr>
				<tr>
					<td class="txt_sum_tb">상세주소</td>
					<td><input type="text" id="joinAddress2" name="joinAddress2" required value="${loginUser.address.split("/")[2]}"></td>
					<td></td>
			  </tr>
	          <tr>
					<td class="txt_sum_tb">이메일</td>
					<td><input type="email" id="joinEmail" name="email" required value="${loginUser.email }"></td>
					<td></td>
			  </tr>
			  <tr>
	         	 <td class="txt_sum_tb">배송메모</td>
	          	<td><input type="text" id="orderRequire" name="orderRequire" placeholder="요청사항을 입력해주세요." maxlength="30"></td>
	          	<td></td>
	          </tr>
	        </table>
	        <br>
	      </div>
      </div>
      <br><br>
      <div align="center">
        <input type="button" value="주문하기" id="btn1">
      </div>
      <br>
  </div>
  <script>
	$('#cancel').click(function(){
		$('.modal').hide();
		$('.modal-back').hide();
	});
	$('#success').click(function(){
		$('.modal').hide();
		$('.modal-back').hide();
		location.href="<%=request.getContextPath()%>/gobookr.bo"
	});
	$('#pointinput').keyup(function(){
		if($(this).val() > ${loginUser.getPoint()}){
			$('#point-modal').show();
			$('#point-modal .modal').show();
			$(this).val(${loginUser.getPoint()});
		}
	});
	$('#pointinput').on("propertychange change keyup paste input",function(){
		console.log($(this).val());
		$('#sp').text(${sum}-Number($(this).val()));
	});
	
	$('#pointbtn').click(function(){
		$('#pointinput').val(${loginUser.getPoint()});
		$('#sp').text(${sum}-${loginUser.getPoint()});
	});
	$('#cancel2').click(function(){
		$('.modal').hide();
		$('.modal-back').hide();
	});
		// 결제 api
		$('#btn1').click(function(){
			if(${book.size()>1}){
				var name = '${book.get(0).b_name } 외 ${book.size() - 1}';
			} else{
				var name = '${book.get(0).b_name }';
			}
			var price = Number($('#sp').text());// 택배비 어떻게 할것인지 물어보자
// 			var price = 200;// 택배비 어떻게 할것인지 물어보자
			var orderemail = $('#joinEmail').val();
			var orderName =$('#name').val();
			var orderphone = $('#phone').val();
			var orderaddress = $('#joinAddress1').val() + $('#joinAddress12').val();
			var orderPost = $('#joinPostal').val();

			console.log(price);
			IMP.init('imp09501430');
			IMP.request_pay({
			pg : 'html5_inicis',
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : name,
			amount : price,
			buyer_email : orderemail,
			buyer_name : orderName,
			buyer_tel : orderphone,
			buyer_addr : orderaddress,
			buyer_postcode : orderPost
			}, function(rsp) {
				if ( rsp.success ) {
					var pay = [];
					var b_no = [];
					var b_v = [];
					var board_no = [];
					var point = $('#pointinput').val();
					<c:forEach var="p" items="${pay}">
						pay.push(${p});
					</c:forEach>
					<c:forEach var="b" items="${book}">
						b_no.push(${b.b_no});
						b_v.push(${b.b_Q1});
						board_no.push(${b.boardNo});
					</c:forEach>
					$.ajax({
						url: "paylast.tr",
						traditional : true,
						data:{b_no:b_no, b_v:b_v, board_no:board_no, pay:pay, point:point},
						success: function(data){
							if(data == 'success'){
								$('#success-modal').show();
								$('#success-modal .modal').show();
							}
						}
					});
			     } else {
			    	 $('#cancel-modal').show();
					$('#cancel-modal .modal').show();
			     }
			 });
		});
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
  </script>

<%@include file="../common/footer.jsp" %>
</body>
</html>