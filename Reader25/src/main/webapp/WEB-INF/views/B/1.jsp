<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP&Servlet</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
<style>
	<%-- body{
		background:url('<%= request.getContextPath() %>/images/bg.png') no-repeat center center fixed;
		background-size: cover;
	}  --%>
	img{
		align="center"
	}

	input[type=button], input[type=submit]{cursor: pointer; border-radius: 15px; color: white;}
	#userInfo label{font-weight: bold;}


 
 /*        리스트                  */
 thumb-list1{
 position: reative;
 left: 100px;
 top: 50px;
 
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
	<%@ include file="../common/menubar.jsp" %>
	<br><br><br><br><br><br><br><br>
	  
	 <div class="outer">
		<br>
		<h2 align="center">판매중인 책 리스트</h2>
		<div class="thumbnailArea">
			<div class="thumb-list1">
				<div>
					<input type="hidden" value="141"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020102017131464658.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 141 사진게시판 테스트12<br> 조회수 : 8
				</p>
			</div>
			<div class="thumb-list1">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list1">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list2">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list2">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list2">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list3">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list3">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div>
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			<div class="thumb-list3">
				<div>
					<input type="hidden" value="125"> <img
						src="/3_JSPServlet/thumbnail_uploadFiles/2020101921105923988.PNG"
						width="200px" height="150px">
				</div> 
				<p>
					No. 125 e<br> 조회수 : 18
				</p>
			</div>
			
		</div>
		<div class="buttonArea"></div>
	</div>
	<script>
		$(function() {
			$('.thumb-list').click(function() {
				var bId = $(this).children().children().eq(0).val();
				location.href = "/3_JSPServlet/detail.th?bId=" + bId;
			});
		});
	</script> 
	<!-- outer마지맘ㄱ -->
	  
	  
	  
	<br><br><br><br><br><br><br><br>
	<footer>
	<div class="footer">
			<div class="frame botton_area">
				<div id="bottom_logo">
				<img src="${ pageContext.servletContext.contextPath }
				/images/Logo2.png"style="float: left;  margin: 0 auto;"  
				width="210" height="45" ></div>
				<br>
				<div id="notice">
					레시피팩토리에 게시된 모든 컨텐츠들은 저작권법에 의거 보호받고 있습니다. <br> 저작권자 또는
					(주)레시피팩토리의 승인없이 컨텐츠의 일부 또는 전부를 복제,전송,배포 및 기타의 방법으로 저작물을 이용할 경우에는<br>
					저작권법에 의해 법적 조치에 처해질 수 있으므로 주의하시길 바랍니다. <br> <br> 사업자등록번호:
					111-22-33333 통신판매업신고번호 : 제1111-서울역삼-2222호 대표 : 금민석 <br> 주소 :
					서울시 역삼동 어쩌주 저쩌구 고객센터: 1234-1004 <br> <br> <b>ⓒ 2020
						Recipe Factory Corp. Ltd. All rights reserved</b>
				</div>
			</div>
		</div>
	</footer>
	<script>
		function logout(){
			location.href='<%= request.getContextPath() %>/logout.me';
		}
		
		function memberJoin(){
			location.href="<%= request.getContextPath() %>/signUpForm.me";
		}
		
		function goHome(){
			location.href='<%= request.getContextPath() %>';
		}
		
		function goNotice(){
			location.href='<%= request.getContextPath() %>/list.no';
		}
		
		function goBoard(){
			location.href='<%= request.getContextPath() %>/list.bo';
		}
		
		function goThumbnail0(){
			location.href='<%= request.getContextPath() %>/list.th';
		}
		function goThumbnail1(){
			location.href='<%= request.getContextPath() %>/list.th';
		}
		function noticeboard(){
			location.href="<%= request.getContextPath() %>/NoticeListServlet.no";
		}
		
		function qna(){
		      location.href="<%=request.getContextPath() %>/QboardListServlet.qb";
		}
		function fqna(){
			location.href="<%= request.getContextPath()%>/FAQListServlet.fa";
		}
	</script>
</body>
</html>