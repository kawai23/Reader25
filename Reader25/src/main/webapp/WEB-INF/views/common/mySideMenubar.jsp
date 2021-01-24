<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


 <div class="col-sm-2" style="background:rgba(0, 0, 0, 0.5);border: 1px solid black; width: 15%"  >
	  
<!-- 	  <img src=""> -->


		
		  
		  <a  style="margin-left: 70px; color: white;">${loginUser.name }</a> <br><br>
		  
		  <p style="margin-left: 70px; color: white;"  href="myPointList.me">포인트 : 
		   <a style=" color: white;"  href="myPointList.me"> ${loginUser.point }</a> <hr>
	  
	  
	 
			



				
						<a href="myUpdateForm.me" class="list-group-item" id="info">내 정보 수정</a> 
						<a href="myPointList.me" class="list-group-item" id="point">포인트 리스트</a> 
						<a href="myDeleteForm.me" class="list-group-item" id="mdel">회원 탈퇴 </a> 
						<hr>
						
						<a href="myList.me?code=2" class="list-group-item"	 id="c2">내가 쓴 리뷰</a>
						<a href="myList.me?code=3" class="list-group-item"  id="c3">책방 리스트</a>
						<a href="myPayList.me" class="list-group-item"  id="pay">주문 리스트</a>
						<a href="myList.me?code=5" class="list-group-item" id="c5">내가 쓴 책</a>
						<a href="myLikeList.me" class="list-group-item" id="like">좋아요/북마크</a>
						
						<a href="myList.me?code=1" class="list-group-item" id="c1">문의사항</a>

				
				<br>
				<br>
				<br>
				
			
			
	  
	  </div>





</body>
</html>