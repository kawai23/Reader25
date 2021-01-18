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
  		border: 1px solid rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  	}
	/* 회원, 메뉴바 관련*/
	#infomenu{float:left; margin-left:50px;margin-right:100px;}
  	/* 회원 정보 메뉴*/
  	#subBlue{
	    width: 300px; 
	    height: 110px;
	    padding:5px; 
		border: 1px solid black;
	}
	.sub{display:inline-block;}
	#info{margin-top: 20px;}
	#user-icon{width: 100px;height: 100px; border-radius:50%;}
	/*아이디 찾기*/
	#find_id{ margin-top : 397px; }
	#find_id:hover{cursor: pointer;}
	#find_pwd{ margin-top : 397px; }
	#find_pwd:hover{cursor: pointer;}
	.login_font{
		font-family: Roboto;
		font-style: normal;
		font-weight: normal;
		font-size: 20px;
		line-height: 29px;
		color: #FFFFFF;
		background:#C95F12;
	}
	.Sign_Up_font{
		font-family: Roboto;
		font-style: normal;
		font-weight: normal;
		font-size: 20px;
		line-height: 29px;
		color: #000000;
		background:#FFC398;
	}
	/*메뉴바 관련*/
	#subMenuDiv{
		width: 310px; 
	    height: 455px;
		border: 1px solid black;
	}
	.subMenuLi {
		display: block;
		text-align: center;
		width: 100px;
	    margin-top:  10px;
		font-size: 15px;
		font-weight: bold;
	}
	/*토론방 리스트 관련*/
  	.outer{
  		float:left;
		width: 920px;
		min-height: 320px;
	}
	.outerBg {
 		display: inline;
 		margin-left: 400px;
	}
	.outerText {
		font-size: 60px;
		display: inline;
	}
	#head{float:none;}
	#body{float:none;}
	#search-icon{width: 20px; height: 18px;}
	.img-span{width: 30px; height: 30px;}
	.img-span:hover{cursor: pointer;}
	#btn{width: 100px;height: 30px; background:#C95F12;}
	#btn:hover{cursor: pointer;}
	/*검색관련*/
	#search-input{width: 110px;height: 26px;}
	#search-type{height: 30px;}
	#bimg{width: 100px;height: 100px;}
	#orderTable{table-layout:fixed;}
	#dC{ /*글자수 제한(...) 포시*/
		overflow:hidden;
		text-overflow: ellipsis;
		max-width: 800px;
		display: -webkit-box;
		-webkit-line-clamp: 4;
		-webkit-box-orient: vertical;
    	word-wrap:break-word;
     	font-size: 20px; 
	}
	#dc-span{/*글제목*/
		font-size: 26px;
	}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<br><br>
	<section>
		<div id="infomenu">
		<div id="subBlue">
			<c:if test="${ !empty loginUser }">
				<div class="sub">
					<img src="<%=request.getContextPath() %>/resources/images/icon/usericon.png" id="user-icon">
				</div>
				<div class="sub" id="info">
						${loginUser.getName() }님<br>
						반갑습니다.<br>
						보유포인트 = ${loginUser.getPoint() }PT<br>
				</div>
			</c:if>
			<c:if test="${ empty loginUser }">
				<button class = "login_font" onclick="location.href='loginView.me'">로그인하기</button>
				<button class = "Sign_Up_font" onclick="location.href='enrollView.me'">회원가입</button>
				<br>
				<br>
				<span id = "find_id" onclick="location.href='searchUserForm.me'"><a>아이디 찾기</a> </span> | 
				<span id = "find_pwd" onclick="location.href='searchUserForm.me'"><a>비밀번호 찾기</a></span>
			</c:if>
		</div>
			<br><br>
			<div id="subMenuDiv">
				<h2>메뉴바</h2>
				<ul>
					<li class="subMenuLi">
						<a class="submenuLink" href="book.re">도서리뷰</a>
					</li>
					<li class="subMenuLi">
						<a class="submenuLink" href="goTIWList.to">책방</a>
					</li>
					<li class="subMenuLi">
						<a class="submenuLink" href="discuss.di">토론방</a>
					</li>
				 </ul>
			</div>
		</div>
		<div class="outer">
			<div id="head">
				<div class="outerText">토론방</div>
				<div class="outerBg">
					<c:if test="${ !empty loginUser }">
						<button id="btn" onclick="location.href='discussWrite.di'">토론방 열기</button>
					</c:if>
					<select id="search-type">
						<option value="1">제목</option>
						<option value="2">내용</option>
						<option value="3">작성자</option>
					</select>
					<input type="text" id="search-input">
					<button class="img-span" id="search"><img src="<%=request.getContextPath() %>/resources/images/bookreview/search.png" id="search-icon"/></button>
				</div>
			</div>
			<div id="body">
				<table id="orderTable">
				<c:forEach var="d" items="${ dList }">
					<tr class="dtr2">
						<c:forEach var="at" items="${ atList }">
							<c:if test="${ d.atcNo == at.atcNo}">
								<td><input type="hidden" value="${ d.dNo }"><img src="<%=request.getContextPath() %>/resources/buploadFiles/${ at.atcName }" id="bimg"/></td>
							</c:if>
						</c:forEach>
						<c:if test="${ d.atcNo == 0 }">
							<td><input type="hidden" value="${ d.dNo }"><img src="<%=request.getContextPath() %>/resources/images/bookreview/book.jpg" id="bimg"/></td>
						</c:if>
						<td id="dC"><span id="dc-span">${d.dTitle}</span><br>${ d.dContent }</td>
					</tr>
					<tr class="dtr">
						<td><input type="hidden" value="${ d.dNo }"></td>
						<td>찬반여론 
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
					<!-- 페이징 처리 -->
					<tr align="center" height="20" id="buttonTab">
						<td colspan="6">
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
						</td>
					</tr>
				</table>
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
							console.log(dNo);
							location.href='dDetail.di?dNo=' + dNo + '&page=' + ${pi.currentPage};
						});
					});

					$('#search').click(function(){
						var text = $('#search-input').val();
						var type = $('#search-type').val();
					
						location.href="discuss.di?text="+text+"&type="+type;
					});
				</script>
			</div>
		</div>
	</section>
</body>
</html>