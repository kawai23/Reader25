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








<link rel="stylesheet" href="${contextPath}/resources/css/signup.css" type="text/css">


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
 	  
 	  
 	   <%@ include file="../common/mySideMenubar.jsp"%> 
<!-- 	  <div class="col-sm-2" style="background:rgba(0, 0, 0, 0.5);border: 1px solid black" > -->
	  
<!-- <!-- 	  <img alt=" " src=""> --> -->
	  
<%-- 	  <a  style="margin-left: 70px; color: white;">${loginUser.name }</a> <br><br> --%>
	  
<%-- 	  <a style="margin-left: 70px; color: white;">포인트 : ${loginUser.point }</a> <hr> --%>
	  
	  
	 
			



				
<!-- 						<a href="myUpdateForm.me" class="list-group-item " >내 정보 수정</a>  -->
<!-- 						<a href="myDeleteForm.me" class="list-group-item active">회원 탈퇴 </a>  -->
<!-- 						<hr> -->
						
<!-- 						<a href="myList.me?code=2" class="list-group-item">내가 쓴 리뷰</a> -->
<!-- 						<a href="myList.me?code=4" class="list-group-item">책방 리스트</a> -->
<!-- 						<a href="#" class="list-group-item"  >주문 리스트</a> -->
<!-- 						<a href="myList.me?code=5" class="list-group-item">내가 쓴 책</a> -->
<!-- 						<a href="#" class="list-group-item">좋아요/북마크</a> -->
						
<!-- 						<a href="myList.me?code=1" class="list-group-item">문의사항</a> -->

				
<!-- 				<br> -->
<!-- 				<br> -->
<!-- 				<br> -->
			
	  
<!-- 	  </div> -->
	  
	  
	  
	  
	  
	  
	   <div class="col-sm-6" style="border: 1px solid black;" >
	   
		<br>
		<h2 class="txt_signup">회원 탈퇴</h2>
		
		<hr><br>
		
		
		<h3 style="color: red;"> <b>정말로 탈퇴를 진행하시겠습니까 ?  </b></h3><br><br>
		
		<small>탈퇴를 진행할 시 포인트와 그 밖의 정보들은 모두 폐기 처리됩니다.<br>
				이것에 동의하시면 탈퇴를 진행해주시길 바랍니다.</small><br><br><br><br>
				
				
				
				
				<div style="text-align: center;">
				
					<c:url var="mdelete" value="mdelete.me">
						<c:param name="id" value="${ loginUser.id }"/>
					</c:url>
				
					<button style="margin: 5px" class=" btn btn-danger"  onclick="location.href='${mdelete}'">탈퇴</button>
				
					<button style="margin: 5px"class="btn btn-default " onclick="location.href='home.do'">취소</button>

				</div>	
			


	   <br><br><br>
	   </div>
	   


	   
	   
	  
	  
	</div>

 </div>


	

</body>
</html>