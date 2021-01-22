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

    .Btn {
      font-size: 14px;
      color: #fff;
      border: 1px solid #F5715C;
      background-color: #F5715C;
      width: 150px;
      height: 30px;
    }
  
  </style>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<style>

</style>
</head>
<body>
<%@include file="../common/menubar.jsp" %>
<div class="outer">
    <form action="<%= request.getContextPath() %>/importBuy" method="post" id="buyForm" name="buyForm">
      <div id="listArea" class="list-A">
        <h2>주문서작성</h2>
        <table class="table1">
          <tr>
            <td>책이미지</td>
            <td>책정보</td>
            <td>가격</td>
            <td>수량</td>
            <td>배송구분</td>
            <td>배송비</td>
            <td>합계</td>
          </tr>
          <tr>
            <td><input type="hidden" name="chk"></td>
            <td><input type="image" name="b_image"></td>
            <td><input type="text" name="b_id"></td>
            <td><input type="text" name="b_name"></td>
            <td><input type="text" name="cart_price"></td>
            <td><input type="text" name="amount"></td>
          </tr>

        </table>
        <br><br><br><br>
        총 금액 : <input type="text" name="total">
        <br><br><br><br>

      </div>
      <div class="sun"></div>
      <div id="loginUserTable" class="lu-table" >
        <h2>배송정보</h2>
        <p>(저장되어있는 배송지를 가져옵니다. 수정하실 부분을 적어주세요.)</p>
        <br>
        <table id="table2" style="left: 1000px;">
          <tr>
            <td width="200px">받으시는분</td>
            <td width="200px"><input type="text" name="orderName"></td>
          </tr>
          <tr>
            <td>휴대전화</td>
            <td><input type="text" maxlength="11" name="orderPhone" placeholder="(-없이)01012345678"></td>
          </tr>
          <tr>
            <td>우편번호</td>
            <td><input type="text" id="userPostal" name="joinPostal"></td>
            <td>
              <div><input type="button" class="btn" id="findPostal" onclick="ifindPostal();" value="검색"></div>
            </td>
          </tr>
          <tr>
            <td>* 주소</td>
            <td><input type="text" id="joinAddress1" name="joinAddress1"></td>
            <td><span id="guide" style="color:#999;display:none"></span></td>
          </tr>
          <tr>
            <td>* 상세주소</td>
            <td height="60px"><input type="text" id="joinAddress2" name="joinAddress2"></td>
          </tr>
          <tr>
            <td>이메일</td>
            <td><input type="text" name="email"></td>
          </tr>
          <td>배송메모</td>
          <td><input type="text" id="orderRequire" name="orderRequire" placeholder="요청사항을 입력해주세요."></td>
          </tr>
        </table>
        <br>
      </div>
      <div class="sun"></div>
      
      <br>
      <div align="center">
        <input type="submit" onclick="buy(); " value="주문하기" class="Btn">
        <input type="button" onclick="location.href='javascript:history.back();'" value="장바구니 수정하기" class="Btn">
      </div>
      <br><br><br><br>
    </form>
  </div>
     


	

<%@include file="../common/footer.jsp" %>
</body>
</html>