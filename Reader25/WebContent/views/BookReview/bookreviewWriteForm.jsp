<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{border: 1px solid pink;}
	.title-div{
		width: 550px;
		margin: auto;
		padding: 0;
	}
	.title{
		display:inline-block;
		background: rgba(235, 235, 235, 1);
		width: 50px;
		text-align: center;
		height: 25px;
		border-radius: 3px 0px 0px 3px;
	}
	.title-div>input{
		height: 25px;
		margin-left: -7px;
		width: 400px;
	}
</style>
</head>
<body>
	<section>
		<form action="#">
			<div class="title-div">
				<div class="title">title</div>
				<input type="text" placeholder="제목을 작성하세요">
				<select>
					<option selected="selected">분류</option>
					<option>총류</option>
					<option>철학</option>
					<option>종교</option>
					<option>사회 과학</option>
					<option>자연 과학</option>
					<option>기술 과학</option>
					<option>예술</option>
					<option>언어</option>
					<option>문학</option>
					<option>역사</option>
				</select>
			</div>
			<div class="content">
				
			</div>
		</form>
	</section>
</body>
</html>