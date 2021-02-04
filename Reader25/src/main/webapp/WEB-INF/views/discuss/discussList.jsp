<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/*세션*/
	section{
		font-family: 카페24 아네모네에어;
		font-size:18px;
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  		overflow:auto; 
  		background: #F6F6F6;
  	}
	/* 회원, 메뉴바 관련*/
	#infomenu{
		float:left; 
		margin-left:10%; 
		margin-right:50px; 
		width: 23%;
	}
  	/* 회원 정보 메뉴*/
  	#subBlue{
	    width: 300px; 
	    height: 110px;
	    padding:5px; 
		border: 1px solid black;
		border-radius:50px;
		text-align: center;
		background:white;
	}
	.sub{display:inline-block;}
	#info{margin-top: 20px;}
	#user-icon{width: 100px;height: 100px; border-radius:10%;}
	/*아이디 찾기*/
	#find_id{ margin-top : 397px; }
	#find_id:hover{cursor: pointer;}
	#find_pwd{ margin-top : 397px; }
	#find_pwd:hover{cursor: pointer;}
	.login_font{
		font-family: 카페24 아네모네에어;
		font-style: normal;
		font-weight: normal;
		font-size: 20px;
		line-height: 29px;
		color: #FFFFFF;
		background:#C95F12;
	}
	.Sign_Up_font{
		font-family: 카페24 아네모네에어;
		font-style: normal;
		font-weight: normal;
		font-size: 20px;
		line-height: 29px;
		color: #000000;
		background:#FFC398;
	}
	/*메뉴바 관련*/
	.subul {
		list-style-image: url( "<%=request.getContextPath() %>/resources/images/icon/li_file.png" );
	}
	.subli{
		margin-top: 10px;
	}
	.subli > span{
		display:inline-block; 
		width:300px; 
		overflow:hidden; 
		text-overflow:ellipsis; 
		white-space:nowrap;
	}
	/*토론방 리스트 관련*/
  	.outer{
    	float:left;
		width: 60%;
		min-height: 320px;
	}
	.outerBg {
 		display: inline;
 		margin-left: 400px;
 		border-bottom: 1px solid black;
	}
	.outerText {
		font-family: 카페24 아네모네;
		font-size: 60px;
		display: inline;
	}
	#head{float:none;}
	#body{float:none;}
	#search-icon{width: 20px;}
	#search-icon:hover {cursor: pointer;}
	.img-span{width: 30px; height: 30px;}
	.img-span:hover{cursor: pointer;}
	#btn{float:right; background:#C95F12; font-family: 카페24 아네모네; font-size:20px; color:white;}
	#btn:hover{cursor: pointer;}
	
	/*검색관련*/
	#search-input{width: 110px;border: none;background: none;}
	#search-type{border: none; background: none;}
	#bimg{width: 200px;height: 150;}
	#imgdiv{background: white; width: 200px;height: 200;}
	#orderTable{
 	border-spacing: 15px 45px;
	}
	#dC{
		overflow:hidden;
		text-overflow: ellipsis;
		max-width: 800px;
		display: -webkit-box;
		-webkit-line-clamp: 3;
		-webkit-box-orient: vertical;
    	word-wrap:break-word;
     	font-size: 19px; 
	}
	#dc-span{/*글제목*/
		font-size: 25px;
		font-weight:bold;
	}
	.modal {
		margin: 40% auto; 
		padding: 20px;
		text-align: center;
		font-family: 카페24 아네모네에어;
		font-size:17px;
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
		display:inline-block; 
		font-family: 카페24 아네모네에어; font-size:17px;
	}
	.modal-content{text-align: center;}
	.modal p{
			display:inline-block;
	}
	.modal img{
			position:relative;
			top: 10px;
	}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<div class="modal-back" id="cancel-modal">
		<div class="modal">
			<div class="modal-content">
				<img src="${contextPath }/resources/images/mark/errormark2.png" width="40px;"/>
				<p> 포인트가 부족합니다. </p>
				<br>
				<button class="modal-close-r" id="cancel" value="Close">확인</button>
			</div>
		</div>
	</div>
	<section>
	<br><br>
		<div id="infomenu">
			<div id="subBlue">
				<c:if test="${ !empty loginUser }">
					<div class="sub">
						<img src="<%=request.getContextPath() %>/resources/images/rank/rank${loginUser.grantId }.png" id="user-icon">
					</div>
					<div class="sub" id="info">
							${ loginUser.getName() }님<br>
							반갑습니다.<br>
							보유포인트 = ${ loginUser.getPoint() }PT<br>
					</div>
				</c:if>
				<c:if test="${ empty loginUser }">
					<button class = "login_font" onclick="location.href='loginView.me'">로그인하기</button>
					<button class = "Sign_Up_font" onclick="location.href='signUpForm.me'">회원가입</button>
					<br>
					<br>
					<span id = "find_id" onclick="location.href='searchUserForm.me'"><a>아이디 찾기</a> </span> | 
					<span id = "find_pwd" onclick="location.href='searchUserForm.me'"><a>비밀번호 찾기</a></span>
				</c:if>
			</div>
			<br><br>
			<div>
				<c:set var="count" value="0"/>
				<h3>현재 열린 토론방</h3>
				<ul class="subul">
					<c:forEach var="d" items="${ dAllList }">
					<c:if test="${count < 5 }">
						<c:if test="${d.dStatus == 'Y'}">
							<c:set var="count" value="${count + 1}"/>
							<li class="subli"><input type="hidden" value="${ d.dNo }"><span>${d.dTitle}</span></li>
						</c:if>
					</c:if>
					</c:forEach>
					<c:if test="${count <= 5 }"><c:set var="count" value="0"/></c:if>
				</ul>
			</div>
			<br><hr><br>
			<div>
				<h3>현재 닫힌 토론방</h3>
				<ul class="subul">
					<c:forEach var="d" items="${ dAllList }">
					<c:if test="${count < 5 }">
						<c:if test="${d.dStatus == 'N'}">
						<c:set var="count" value="${count + 1}"/>
							<li class="subli"><input type="hidden" value="${ d.dNo }"><span>${d.dTitle}</span></li>
						</c:if>
					</c:if>
					</c:forEach>
					<c:if test="${count <= 5 }"><c:set var="count" value="0"/></c:if>
				</ul>
			</div>
			<c:if test="${ !empty loginUser }">
			<br><hr><br>
				<div>
					<h3>내가 연 토론방</h3>
					<ul class="subul">
						<c:forEach var="d" items="${ dAllList }">
						<c:if test="${count < 5 }">
							<c:if test="${(d.dWriter == loginUser.id) && d.dStatus == 'Y'}">
								<c:set var="count" value="${count + 1}"/>
								<li class="subli"><input type="hidden" value="${ d.dNo }"><span>${d.dTitle}</span></li>
							</c:if>
						</c:if>
						</c:forEach>
						<c:if test="${count == 0 }"> 토론방을 연적이 없습니다.</c:if>
					</ul>
				</div>
			</c:if>
		</div>
		<div class="outer">
			<div id="head"><br>
				<div class="outerText">토론방</div>
				<div class="outerBg">
					
					<select id="search-type">
						<option value="1">제목</option>
						<option value="2">내용</option>
						<option value="3">작성자</option>
					</select>
					<input type="text" id="search-input">
					<span class="img-span"><img src="<%=request.getContextPath() %>/resources/images/bookreview/search.png" id="search-icon"/></span>
				</div>
			</div><br>
			<div id="body">
				<table id="orderTable">
				<c:if test="${empty dList }">
					<tr>
						<td>등록된 토론방이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="d" items="${ dList }">
					<tr class="dtr2">
						<c:forEach var="at" items="${ atList }">
							<c:if test="${ d.atcNo == at.atcNo}">
								<td rowspan="2"><input type="hidden" value="${ d.dNo }"><img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at.atcName }" id="bimg"/></td>
							</c:if>
						</c:forEach>
						<c:if test="${ d.atcNo == 0 }">
							<td rowspan="2" id="imgdiv"><input type="hidden" value="${ d.dNo }"><img src="<%=request.getContextPath() %>/resources/images/img/discuss.jpg" id="bimg"/></td>
						</c:if>
						<td ><span id="dc-span">${d.dTitle}</span><br><span id="dC">${ d.dContent }</span></td>
					</tr>
					<tr class="dtr">
						<td><input type="hidden" value="${ d.dNo }">찬반여론 
						<c:if test="${ d.dCount > 0}">
						<c:set var="P" value="${d.dPros/(d.dPros+d.dNeutrality + d.dCons)}"/>
						<c:set var="N" value="${d.dNeutrality/(d.dPros+d.dNeutrality + d.dCons)}"/>
						<c:set var="C" value="${d.dCons/(d.dPros+d.dNeutrality + d.dCons)}"/>
						<c:if test="${(P*100)+(N*100)+(C*100) != 100 }">
								<c:if test="${d.dCons > 0 }">
									<c:set var="C" value="${C + 0.01}"/>
								</c:if>
						</c:if>
						찬성 : <fmt:formatNumber value="${P}" type="percent"/> 
						중립 : <fmt:formatNumber value="${N}" type="percent"/>
						반대 : <fmt:formatNumber value="${C}" type="percent"/>
						</c:if>
						<c:if test="${d.dCount == 0 }">
							찬성 : 0%  중립 : 0%  반대 : 0% 
						</c:if>
						댓글참여 : ${ d.dCount }개</td>
					</tr>					
				</c:forEach>
				</table>
				<!-- 페이징 처리 -->
				<div align="center" id="buttonTab"><br>
						<!-- [이전] -->
						<c:if test="${ pi.currentPage <= 1 }">
							[<] &nbsp;
						</c:if>
						<c:if test="${ pi.currentPage > 1 }">
							<c:url var="before" value="discuss.di">
							<c:param name="page" value="${ pi.currentPage - 1 }"/>
								</c:url>
							<a href="${ before }">[<]</a> &nbsp;
						</c:if>
						
						<!-- 페이지 -->
						<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
							<c:if test="${ p eq pi.currentPage }">
								<font color="red" size="4"><b>[${ p }]</b></font>
							</c:if>
							
							<c:if test="${ p ne pi.currentPage }">
								<c:url var="pagination" value="discuss.di">
									<c:param name="page" value="${ p }"/>
								</c:url>
								<a href="${ pagination }">${ p }</a> &nbsp;
							</c:if>
						</c:forEach>
						
						<!-- [다음] -->
						<c:if test="${ pi.currentPage >= pi.maxPage }">
							[>]
						</c:if>
						<c:if test="${ pi.currentPage < pi.maxPage }">
							<c:url var="after" value="discuss.di">
								<c:param name="page" value="${ pi.currentPage + 1 }"/>
							</c:url> 
							<a href="${ after }">[>]</a>
						</c:if>
				</div><br>
				<script>
					//상세페이지이동
					$(function(){
						$('.dtr').mouseenter(function(){
							$(this).css({'cursor':'pointer'});
						}).click(function(){
							var dNo = $(this).children().children().val();
							location.href='dDetail.di?dNo=' + dNo + '&page=' + ${pi.currentPage};
						});

						$('.dtr2').mouseenter(function(){
							$(this).css({'cursor':'pointer'});
						}).click(function(){
							var dNo = $(this).children().children().val();
							location.href='dDetail.di?dNo=' + dNo + '&page=' + ${pi.currentPage};
						});

						$('.subli').mouseenter(function(){
							$(this).css({'cursor':'pointer', 'border-bottom':'1px solid black'});
						}).mouseout(function(){
							$(this).css({'border-bottom':'none'});
						}).click(function(){
							var dNo = $(this).children().val();
							location.href='dDetail.di?dNo=' + dNo + '&page=' + ${pi.currentPage};
						});
					});
					// 검색 기능
					$('#search-icon').click(function(){
						search();
					});
					$('#search-input').keydown(function(key){
						if(key.keyCode == 13){
							search();
						}
					});
					function search(){
						var text = $('#search-input').val();
						var type = $('#search-type').val();
					
						location.href="discuss.di?text="+text+"&type="+type;
					}
					// 자동완성
					$(function(){
						var sc = '';
						$('#search-type').change(function(){
							sc = $(this).val();
						});
						var category = ['제목','내용','작성자'];
						$('#search-input').keyup(function(){
							if(sc == 'category'){
								$('#search-input').autocomplete({
									source : category
								});
							}
						});
						
					});
				</script>
			</div>
		<c:if test="${ !empty loginUser }">
			<button id="btn" >토론방 열기</button>
			<br><br>
			<script>
				$('#btn').click(function(){
					var point = ${loginUser.getPoint()};
					if(point < 150){
						$('#cancel-modal').show();
						$('#cancel-modal .modal').show();
					} else{
						location.href='discussWrite.di';
					}
				});
				$('#cancel').click(function(){
					$('.modal').hide();
					$('.modal-back').hide();
				});
			</script>
		</c:if>
		</div>
	</section>
	<div style="clear:both;"><!-- float 명령 초기화시키기 -->
		<%@include file="../common/footer.jsp" %>
	</div>
</body>
</html>