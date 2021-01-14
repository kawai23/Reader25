<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.outer{width:1000px; height:700px; background: rgba(255, 255, 255, 0.4); border: 5px solid white;
		margin-left:auto; margin-right:auto; margin-top:50px;
	}
	.thumbnailArea {width:760px; height:550px; margin-left:auto; margin-right:auto;}
	.buttonArea {width:80px; margin-left:auto; margin-right:auto;}
	.thumb-list {width:220px; border:1px solid white; display:inline-block; margin:10px; align:center;}
	.thumb-list:hover {opacity:0.8; cursor:pointer;}
	#insertBtn{background: #B2CCFF;}
</style>
</head>
<body>

	<form name="main" action="purchaseCart.jsp" method="post">
		<table>
			<tr>
				<td colspan="1" align="center">
					<input type="submit" value="결제상세페이지">
					
				</td>
			</tr>
		</table>
	</form>
	<form name="main" action="bookroom.jsp" method="post">
		<table>
			<tr>
				<td colspan="1" align="center">
					<input type="submit" value="북 리스트">
					
				</td>
			</tr>
		</table>
	</form>
	


</body>
</html>