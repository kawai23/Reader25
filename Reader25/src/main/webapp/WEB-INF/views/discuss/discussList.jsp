<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
  		border: 1px solid rgba(246, 246, 246, 1);
  		width: 80%;
  		margin:auto;
  		min-width: 1000px;
  	}
  	#subBlue{
	    width: 300px; 
	    height: 110px;
	    padding:5px; 
		border: 1px solid black;
	}
	#infomenu{float:left; margin-left:50px;margin-right:100px;}
	.sub{display:inline-block;}
	#info{margin-top: 20px;}
	#user-icon{width: 100px;height: 100px;}
	
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
	#search-icon{width: 20px; height: 20px;}
	.img-span{width: 30px; height: 30px;}
	#btn{width: 140px;height: 30px; background:#C95F12;}
	#search-input{width: 110px;height: 30px;}
	#bimg{width: 100px;height: 100px;}
	p{font-size: 26px;}
</style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	<br><br>
	<section>
		<div id="infomenu">
			<div id="subBlue">
				<div class="sub">
					<img src="" id="user-icon">
				</div>
				<div class="sub" id="info">
						아무개님<br>
						반갑습니다.<br>
						보유포인트 = 3000PT<br>
				</div>
			</div>
			<br><br>
			<div id="subMenuDiv">
				<h2>메뉴바</h2>
				<ul>
					<li class="subMenuLi">
						<a class="submenuLink" href="">도서리뷰</a>
					</li>
					<li class="subMenuLi">
						<a class="submenuLink" href="">책방</a>
					</li>
					<li class="subMenuLi">
						<a class="submenuLink" href="">토론방</a>
					</li>
				 </ul>
			</div>
		</div>
		<div class="outer">
			<div id="head">
				<div class="outerText">토론방</div>
				<div class="outerBg">
					<button id="btn">토론방 열기</button>
					<input type="text" id="search-input"><!-- ajax로 검색하자 -->
					<button class="img-span">
						<img src="<%=request.getContextPath() %>/resources/images/bookreview/search.png" id="search-icon"/>
					</button>
				</div>
			</div>
			<div id="body">
				<table id="orderTable">
					<tr>
						<td><img src="" id="bimg"/></td>
						<td><p>코로나로 인한 트랜드 변화 이대로 괜찮은가?
						친절한 트렌드 뒷담화 2021 책에서 나온 트렌드의 변화에 
						대한 이야기에 대해 이야기해볼 필요가있다...</p></td>
					</tr>
					<tr>
						<td>찬반여론</td>
						<td>찬성 : 50% 반대: 50% 댓글참여 : 5개</td>
					</tr>
					
					<tr>
						<td><img src="" id="bimg"/></td>
						<td><p>코로나로 인한 트랜드 변화 이대로 괜찮은가?
						친절한 트렌드 뒷담화 2021 책에서 나온 트렌드의 변화에 
						대한 이야기에 대해 이야기해볼 필요가있다...</p></td>
					</tr>
					<tr>
						<td>찬반여론</td>
						<td>찬성 : 50% 반대: 50% 댓글참여 : 5개</td>
					</tr>
					
					<tr>
						<td><img src="" id="bimg"/></td>
						<td><p>코로나로 인한 트랜드 변화 이대로 괜찮은가?
						친절한 트렌드 뒷담화 2021 책에서 나온 트렌드의 변화에 
						대한 이야기에 대해 이야기해볼 필요가있다...</p></td>
					</tr>
					<tr>
						<td>찬반여론</td>
						<td>찬성 : 50% 반대: 50% 댓글참여 : 5개</td>
					</tr>
					
					<tr>
						<td><img src="" id="bimg"/></td>
						<td><p>코로나로 인한 트랜드 변화 이대로 괜찮은가?
						친절한 트렌드 뒷담화 2021 책에서 나온 트렌드의 변화에 
						대한 이야기에 대해 이야기해볼 필요가있다...</p></td>
					</tr>
					<tr>
						<td>찬반여론</td>
						<td>찬성 : 50% 반대: 50% 댓글참여 : 5개</td>
					</tr>
					
					<tr>
						<td><img src="" id="bimg"/></td>
						<td><p>코로나로 인한 트랜드 변화 이대로 괜찮은가?
						친절한 트렌드 뒷담화 2021 책에서 나온 트렌드의 변화에 
						대한 이야기에 대해 이야기해볼 필요가있다...</p></td>
					</tr>
					<tr>
						<td>찬반여론</td>
						<td>찬성 : 50% 반대: 50% 댓글참여 : 5개</td>
					</tr>
					<!-- 페이징 처리 -->
					<tr align="center" height="20" id="buttonTab">
						<td colspan="6">
							<!-- [이전] -->
							<c:if test="${ pi.currentPage <= 1 }">
								[이전] &nbsp;
							</c:if>
							<c:if test="${ pi.currentPage > 1 }">
								<c:url var="before" value="blist.bo">
									<c:param name="page" value="${ pi.currentPage - 1 }"/>
								</c:url>
								<a href="${ before }">[이전]</a> &nbsp;
							</c:if>
							
							<!-- 페이지 -->
							<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
								<c:if test="${ p eq pi.currentPage }">
									<font color="red" size="4"><b>[${ p }]</b></font>
								</c:if>
								
								<c:if test="${ p ne pi.currentPage }">
									<c:url var="pagination" value="blist.bo">
										<c:param name="page" value="${ p }"/>
									</c:url>
									<a href="${ pagination }">${ p }</a> &nbsp;
								</c:if>
							</c:forEach>
							
							<!-- [다음] -->
							<c:if test="${ pi.currentPage >= pi.maxPage }">
								[다음]
							</c:if>
							<c:if test="${ pi.currentPage < pi.maxPage }">
								<c:url var="after" value="blist.bo">
									<c:param name="page" value="${ pi.currentPage + 1 }"/>
								</c:url> 
								<a href="${ after }">[다음]</a>
							</c:if>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</section>
</body>
</html>