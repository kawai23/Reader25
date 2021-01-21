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


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/list.css">
<style>
#maindiv1{
	margin:auto;
	width:700px;
	
}

.listtop{
	width:800px;
}

.listtable{
	margin:auto;
	width:1200px;
	border-collapse: collapse;
	border-spacing:0px;
}

.writerlong{
	padding:3px;
	margin:3px;
	width:200px;
	display:inline-block;
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	
}

.writetitle1 {
	margin:auto;
	padding:30px;	
	font-size:25px;
	text-align: center
}

.titlelong{
	margin:3px;
	padding:3px;
	width:280px;
	display:inline-block;
	height:100px;
	display: -webkit-box;
	overflow:hidden;
	word-break:break-all;
	-webkit-box-orient:vertical;
	-webkit-line-clamp:3;
	text-overflow:ellipsis;
}

.contenttable1{
	width:1000px;
	margin:auto;
}

.search{
	margin:auto;
	width:200px;	
}

.commentbase{
	background-color:#fdddc4;
	padding:15px;
	
}

.searchtable{
	border-collapse:collapse;
	border-spacing:0px;
	width:280px;
	margin:auto;
	}
	
.searchtd{margin-right:0px;}
.searchbttd{margin-left:0px;}

.searchbar{
		width:400px;
		height:50px;
		display: inline-block;
		border-color:#ffbb00;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 5px 5px 5px 5px;
	}

.searchbotton{
	width:70px;
	height:50px;
	border-width: thin; 
	border-color:#ffbb00;
	background-color:white;
	font-size:18px;
	
	border-style:solid;
	border-radius: 0px 5px 5px 0px;
}


.bt{
		background-color:white; 
		font-size:17px;
		border-color:#ffbb00;
		height:50px;
		margin: 5px;
		border-width:0.5px;
		border-style:solid;
		cursor: pointer;
		width: 70px;
		border-radius:5px; 
}

a:link {
    color: black;
    text-decoration: none;
}
a:visited {
    color: black;
    text-decoration: none;
}
a:hover {
    color: black;
    text-decoration: none;
}
a:active {
    color: black;
    text-decoration: none;
}

.mouse:hover{
	background-color:#fef5da;
}

.line{
 	border-bottom:1px solid #ffbb00;
 	}
.pline{
	text-overflow:ellipsis;
 	white-space: nowrap;
 	word-wrap:normal;
 	overflow:hidden;
 	width:300px;
}
.nogul{margin:auto;}

.listcolor{
	border-top:3px solid #ffbb00;
	border-bottom:1.5px solid #ffbb00;
	background-color:#ffd668;
}

.listspace{
	align:center;
	width:2000px;
	height:900px;
	background-color:#F2F2F2;
}
	body,ul {

margin: 0;

padding: 0;

}

@CHARSET "UTF-8";

		#body{
		font-family: 'Nanum Gothic', sans-serif;
		color:black;
	}
	
	#maindiv{	
		font-family:"Bauhaus ITC";
		font-size:22px;
		color:black;
		/* border-top:5px solid #ffbb00; */
		margin-top: 50px;
		margin-bottom: 100px;
		
		}	
	#maindiv2{	font-family:"Bauhaus ITC";
		font-size:22px;
		color:black;
			
			.precontent{
			     word-break: keep-all;
        word-wrap: normal;
			}
			
		}	
	.writetitle {
		padding-left:195px; 
		padding-top:30px;
		font-size:25px;
		
		}
	#writetable{
		margin:auto;
		padding:40px;
		
		}
	#space{
		align:center;
		width:100%;
		height:900px;
		background-color:#F2F2F2;
	}
	#writespace{
		padding:20px;
	}
	.signupinput{
		width:758px;
		padding: 15px;
		display: inline-block;
		border-color:#f8db83;;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 3px;
	}
	
	.signupinput2{
		margin:auto;
		width:968px;
		padding: 15px;
		display: inline-block;
		border-color:black;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 3px;
	}
	
	#button123{
		font-family:"Bauhaus ITC";
		font-size:22px;
		width:200px;
		padding: 15px;
		display: inline-block;
		border-color:black;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 3px;
		margin:10px 10px 10px 0px;
		
	}
	
	.contenttable{
		margin:auto;
		width:1200px;
		 border-collapse:collapse;
		 border-width:0px;
		 margin-top:40px;
		}
		
.dropdownbt{
		border:solid;
		border-color:#f8db83;
		border-radius:3px;
		padding:15px;
		border-width: thin; 
}


		
	.contentline{
		padding:30px;
 		border-top:5px solid #ffbb00;
 		border-bottom:2px solid #ffbb00;
 	
 	} 
 	.contentline2{
		padding:30px;
 		border-top:2px solid #ffbb00;
	}
	
	#extraline{
		font-size:21px;
		color:#A4A4A4;
		border-bottom:2px solid #ffbb00;
		border-collapse:collapse;
		border-spacing:0px;
	}
	
	.content1{
		width:920px;
		
	}
	.bt2{
		background-color:white; 
		font-size:18px;
		border-color:#ffbb00;
		height:40px;
		margin: 5px;
		border-width:0.5px;
		border-style:solid;
		cursor: pointer;
		width: 80px;
		border-radius:3px; 
	}

	.commment{
		margin:auto;
		border-collapse:collapse;
		width:1000px;
		border-width:4px;
}

#myDIV{
  width:1200px;
  height:100px;
  padding: 50px ;
  text-align: center;
  margin-top: 20px;
  border-top:double;
  border-bottom:double;
  border-color:orange;
  border-width:7px;
}
#myDIV2{
  width:1200px;
  height:100px;
  padding: 50px ;
  text-align: center;
  margin-top: 20px;
  border-top:double;
  border-bottom:double;
  border-color:orange;
  border-width:7px;
}


	.commment td{
	border-color:orange;
	
	}
	
	* {box-sizing: border-box;}

.img-comp-container {
  position: relative;
  height: 250px; 
  width:1100px;
  margin:auto;
}

.img-comp-img {
  position: absolute;
  width: auto;
  height: auto;
  overflow:hidden;
}

.img-comp-img img {
  display:block;
  vertical-align:middle;
}

.img-comp-slider {
  position: absolute;
  z-index:9;
  cursor: ew-resize;
  /*set the appearance of the slider:*/
  width: 65px;
  height: 55px;
  
  opacity: 0.7;
  border-radius: 3px;
  padding:6px;
   background: linear-gradient(90deg, #fddedd 50%, #e6f2ff 50%);
}

/* 재료,도구 슬라이드 */
.divdiv1{
	background-color: #fddedd;
	width:1100px;
	height:200px;
	text-align:left;
	margin:auto;	
	border-top:double;
    border-bottom:double;
    border-color:#593a0d;
    border-width:7px;
    padding:20px 0px 0px 20px;
}

.divdiv2{
	background-color:#e6f2ff;
	width:1100px;
	height:200px;
	text-align:left;
	margin:auto;	
	border-top:double;
    border-bottom:double;
    border-color:#593a0d;
    border-width:7px;
    padding:20px 0px 0px 20px;
}
/* 재료,도구 슬라이드 끝 */

/* 테이블 td에 줄 */
.orangeline11{border-bottom:3px solid orange;
						border-top:3px solid orange;}
.orangeline1{border-bottom:3px solid orange;}
.orangeline111{border-top:3px solid orange;}
.orangeline{border-bottom:2px solid orange;}
/* 테이블 td에 줄 끝 */


.dropbtblack{
	ime-mode:inactive; 
	padding: .8em .5em; 
	border-radius: 3px; 
	border-color:black; 
	font-size:12pt;
	font-family:Bauhaus ITC;"

} /* 드롭다운버튼으로 만들었으나 안먹음 */

.signupinputblack{
		width:758px;
		padding: 15px;
		display: inline-block;
		border-color:black;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 3px;
	}

.signupinputblack2{
		width:1000px;
		padding: 15px;
		display: inline-block;
		border-color:black;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 3px;
	}	
.smallbt{
		background-color:white; 
		font-size:15px;
		border-color:#ffbb00;
		height:30px;
		margin: 5px;
		border-width:0.5px;
		border-style:solid;
		cursor: pointer;
		width: 70px;
		border-radius:5px; 
}

/* 상점 */
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  max-width: 300px;
  text-align: center;
  font-family: arial;
  margin-top:15px;
  
}

.product_price_html {
  color: grey;
  font-size: 22px;
  height:58px;
}

.card button {
  border: none;
  outline: 0;
  padding: 12px;
  color: white;
  background-color: #000;
  text-align: center;
  cursor: pointer;
  width: 100%;
  font-size: 18px;
  margin-right:10px;
}

.card button:hover {
  opacity: 0.7;
}
/* 상점 끝*/



/* 자주하는 질문 */
.accordion {
  background-color: #ffbc0d;
  color: #ffffff;
  cursor: pointer;
  padding: 18px;
  width: 1300px; 
  border: none;
  text-align: left;
  outline: none;
  font-size: 17px;
  transition: 0.4s;
  margin-bottom:1px;
}

.active1, .accordion:hover {
  background-color: #efa927;
}

.accordion:after {
  content: '\002B';
  color:white;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.active1:after {
  content: "\2212";
  color:white;
}
.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  word-break:keep-all;
  width:1300px;
}
.active1{
	background-color: #d88912;
} 

.active1:visited {
	background-color: #d88912;
} 

/* 자주하는 질문 끝 */

/* custom */
.customtb{
	border-collapse:collapse;
	border-spacing:0px;
	width:1000px;
	height:500px;
	margin:auto;
}

.customfirst{
	text-align:center;
	height:70px;
	border-top:3px solid #ffbb00;
	border-left:3px solid #ffbb00;
	border-right:3px solid #ffbb00;
	border-bottom:3px solid #ffbb00;
	background-color:#ffd668;
}

.customsecond{
	text-align:top;
	padding-left:12px;
	border-left:3px solid #ffbb00;
	border-right:3px solid #ffbb00;
	border-bottom:2.5px solid #ffbb00;
	
}

.cusearchbar{
		width:400px;
		height:50px;
		display: inline-block;
		border-color:#ffbb00;
		background: white;
		border-style:solid;
		border-width: thin; 
		border-radius: 5px 5px 5px 5px;
		padding-left:10px;
		font-size:13pt;
	}

.addBtn{
	width:80px;
	font-size:14pt;
	text-align:center;
	border-radius: 5px 5px 5px 5px;
	border-top:1px solid #ffbb00;
	border-left:1px solid #ffbb00;
	border-right:1px solid #ffbb00;
	border-bottom:1px solid #ffbb00;
}

/* 글목록 */
.card1 {
    -webkit-transition: 0.3s;
 	 transition: 0.3s;
 	 max-width: 300px;
 	 margin: 28px;
  	 max-height:610px;
     font-family: arial;
 	 text-align: center;
 	 display: inline-block;
 	 box-shadow:0 2px 2px 0 rgba(0,0,0,0.2)
}

.card1:hover {
  box-shadow: 0 8px 12px 0 rgba(0,0,0,0.2)
}

/* 글목록 끝 */
#thumbnail{
	background-image:url('../img/thumbn.png');
	background-size:cover;
	background-position:center center;
	height:200px; 
	width:300px;
}


/*상품목록*/
/* Clear floats after rows */
/* .row:after {
  content: "";
  display: table;
  clear: both;
} */

 .mypagetable{
 	
 		font-size:20px; 
 	
 	}
 	
.welcome2{
	
		padding:50px;
		font-family:"Bauhaus ITC";
		font-size:20pt;
		border-width:10px;
	 
	}
 	
 	
.sidebar {
  height: 500px;
  width: 200px;
  position: absolute;
  z-index: 1;
  left: 0;
  background-color: white;
  overflow-x: hidden;
  padding-top: 80px;
  padding-left:0px;
  
}

.sidebar a {
  height:80px;
  padding: 15px 16px 15px 16px;
  text-decoration: none;
  font-size: 18pt;
  color: black;
  display: block;
  border: 2px solid orange;
  
}

.sidebar a:hover {
  color: orange;
}



@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}


.sideleft {
  width:80px;
  height:55px; 
  position: absolute;
  z-index: 1;
  left: 0;
  /* background-color: #ffbb00; */
  padding-left:10px;
}

.longbt1{
		background-color:#ffbb00; 
		font-size:17px;
		color:white;
		border-color:#ffbb00;
		height:50px;
		margin: 5px;
		border-width:0.5px;
		border-style:solid;
		cursor: pointer;
		width: 150px;
		border-radius:5px; 
}

.longbt2{
		background-color:white; 
		font-size:17px;
		border-color:#ffbb00;
		height:50px;
		margin: 5px;
		border-width:0.5px;
		border-style:solid;
		cursor: pointer;
		width: 150px;
		border-radius:5px; 
}

.list-table {
	width:1300px;
	margin-top: 80px;
	margin-left:280px;
	position: relative;
	overflow : hidden;
	white-space : nowrap; 
	margin: auto;
	
}
.list-tableth{
	height:50px;
	border-collapse:0px;
	font-size: 17pt;
	text-align:center;
}
.list-tabletd{
	text-align:center;
	padding:10px 0;
	border-bottom:1px solid	 #CCC; height:20px;
	font-size: 18pt; 
}
.bak_item {
	
	height: 130px;
	margin-top: 20px;
}

.proquantity{
		width: 80px;
		height:30px;
		padding: 15px;
		display: inline-block;
		border-color:#A4A4A4;
		background:white;
		border-style:solid;
		border-width:thin;
		border-radius:3px;
		font-size:13pt;
	
}

.img-button{
		background: url( "../img/close.png") no-repeat;
		background-size:20px;
		border: none;
	    width: 20px;
	    height: 20px;
	    cursor: pointer;

}

.img-button2{
		background: url( "../img/plus.png") no-repeat;
		background-size:20px;
		border: none;
	    width: 20px;
	    height: 20px;
	    cursor: pointer;

}

.img-button3{
		background: url( "../img/minus.png") no-repeat;
		background-size:20px;
		border: none;
	    width: 20px;
	    height: 20px;
	    cursor: pointer;

}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-50,
.col-75 {
  padding: 0 16px;
}

/*샵 메뉴*/
#apsb, #wofy, #ehrn{
background-color:#ffa042;
color: #ffffff;
padding:15px;
}

#apsb2, #wofy2, #ehrn2{
background-color:#f7f7f7;
color: #bdbdbd;
padding:5px;
}

/* 샵 메뉴 끝 */

/* 결제페이지 시작 */
.container {
  width:570px;
  height:550px;
  float:right;
  background-color: #FAE4AD;
  padding: 5px 20px 15px 20px;
  border: 2px solid #ffbb00;
  border-radius: 3px;
  font-size:16pt;
  
}

.container2 {
  width:570px;
  height:550px;
  float:center;
  background-color: #FAE4AD;
  padding: 5px 20px 15px 20px;
  border: 2px solid #ffbb00;
  border-radius: 3px;
  font-size:16pt;
}

.container3 {
	width:100%;
	height:650px;
	float:left;
	background-color: #FAE4AD;
	padding: 5px 20px 15px 20px;
	border: 2px solid #ffbb00;
	border-radius: 3px;
	font-size:16pt;
}

  .row {
  	width:1300px;
  	margin:auto;
    padding-top:55px;
  }
 
.inputtext{
  width: 100%;
  font-size:12pt;
  padding: 15px;
  background-color:white;
  border: 1px solid #ffbb00;"
  border-radius: 3px;
  float:left;
}

.labelpay {
  padding-top:20px;
  margin-bottom: 10px;
  float:left;
  display: block;
}

.paymoney{
	float:left;
	font-size:16pt;
	
	
}

.inputtd2{
	width: 100%;
	font-size:12pt;
	padding: 15px;
	background-color:white;
	border: 1px solid #ffbb00;"
	border-radius: 3px;
	float:left;
}

.inputtd3{
	width:120px;
	height:45px;
	font-size:12pt;
	background-color:white;
	border: 1px solid #ffbb00;"
	border-radius: 3px;
}

.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  width:700px;
  display: none;
  padding: 6px 12px;
  border-top: none;
}

.tdpayment{
	width:500px;
	padding:15 0 0 0px;
	font-size:17pt;
	font-align:left;
	font-weight:none;
	
}

.tdpayinput{
	  font-size:13pt;
	  background-color:white;
	  border: 1px solid #ffbb00;"
	  border-radius: 3px;
	  float:left;
}

.tdpayinput2{
	  text-align:left;
	  width:100px;
	  height:30px;
	  margin-right:18px;
	  font-size:13pt;
	  background-color:white;
	  border: 1px solid #ffbb00;"
	  border-radius: 3px;
	  float:left;
}


.tabcontent2 {
  width:400px;
  padding: 6px 12px;
  border-top: none;

}

.tablinks{
	float:left;
	font-size:16pt;
	
}

.cont3table{
	width:1000px;
	float:left;
	
}

.headh3{
	width:500px;
	font-size:18pt;
	 padding: 15 0 0 10px;
}

.headh4{
	width:500px;
	font-size:18pt;
	 padding: 15 0 0 10px;
}

.tabcontent3 {
  width:1000px;
  padding: 6px 400px;
  border-top: none;
  float:left;

}

.spacetb1{
	width:500px; 
	float:left;
	
	
}
.spacetb2{
	width:400px;
	height:400px;
	float:right;
	margin-left:550px;
	
}

.btpay1{
	width: 120px;
	height:50px;
	font-size:18px;
	font-weight:400;
	color:white;
	background-color:#ffbb00;
	border-color:#ffbb00;
	border-width:0.5px;
	border-style:solid;
	border-radius:5px;
	margin-top:-40px;
	margin-left:390px; 
	cursor: pointer;
	position:relative;
}

.btpay2{
	width: 120px;
	height:50px;
	font-size:18px;
	font-weight:400;
	color:white;
	background-color:#ffbb00;
	border-color:#ffbb00;
	border-width:0.5px;
	border-style:solid;
	border-radius:5px;
	margin-top:205px;
	margin-left:400px; 
	cursor: pointer;
	position:relative;
}

.tkdyd{
	background-color:white; 
	font-size:12pt;
	border-color:#ffbb00;
	height:47px;
	border-width:0.5px;
	border-style:solid;
	cursor: pointer;
	width: 60px;
	margin-left: 2.2px;
}

.tkdyd2{
	background-color:#ffbb00;
	font-size:12pt;
	border-color:#ffbb00;
	height:45px;
	border-width:0.5px;
	border-style:solid;
	cursor: pointer;
	width: 60px;
	margin-left: 2.2px;
}

.tkdyd3{
	display: inline-block;
    z-index: 0;
    width: 52px;
    height: 45px;
    margin-left: 0px;
    padding-top: 12px;
    border: 1px solid rgba(0,0,0,.1);
    border-radius: 0 2px 2px 0;
    background: #ffbb00;
    font-size: 14pt;
    color: #fff;
    text-align: center;
    vertical-align: bottom;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    text-decoration: none;
	
}
.won{
	    display: inline-block;
	    margin: 1px 0 0 -27px;
	    font-size: 14pt;
	    color: #888;
	    vertical-align: middle
}
   

/* 결제페이지 끝 */

/* 난이도별 레시피 */
.3div{
	width:1200px;
	margin:auto;
}

.rlch, .chqh, .tlaghk{
	width:350px;
	height:350px;
	float:left;
	margin-left:200px;
	margin-top:150px;
	font-size:40px;
	text-align:center;
}

.ppp{
	text-size:35px;
}


.rlch{
	background-color:#f3d97e;
}

.chqh{
	background-color:#f5ad7c;
}

.tlaghk{
	background-color:#ff7373;
}

.banktext{
	width:80px;
	height:20px;
	
}

.tdpayinput2::placeholder { text-align:center; }
/* 결제페이지 끝 */



/* 포인트관리 페이지 시작 */

.row2 {
  	width:1300px;
  	margin:auto;
  }

.row3 {
  	width:1500px;
  	margin:auto;
  }

.forkpoint{
		width: 800px;
		height:300px;
		float:center;
		background-color:#ffbb00;
		vertical-align:middle;
		display:table-cell;
		margin-top:1000px;
	
}

.forkpoint2{
		width: 220px;
		height:50px;
		font-size:20pt;
		float:center;
		font-weight: normal;
		letter-spacing:3px;

}

.forkpoint3{
		font-size:25pt;
		width: 300px;
		height:100px;
		float:center;
		background-color:white;
		vertical-align:middle;
		display:table-cell;
	
}

#forkimage{
		width:100px;
		height:70px;
		float:left;
		
		
}


.pointsearch{
		background-color:#ffecbb;
		width:800px;
		height:80px;
		font-size:17pt;
		margin-top:50px;
	
}

.pointbutton{
	background-color:white;
	width:70px;
	height:30px;
	font-size:13pt;
	border-width:0.5px;
	border:0.5px solid #A4A4A4; 
}


.calendar{
	width:150px;
	height:30px;
	font-size:12pt;
	border:0.5px solid #A4A4A4; 
}

.pointtable{
		margin-top:20px;
		background-color:#ffecbb;
		width:800px;
		height:400px;
}

.pointtd{
		display:text-cell;
		vertical-align:middle;
		font-size:16pt;
}


/* 포인트관리 페이지 끝 */

/* 회원 탈퇴 페이지 시작 */
.deleteuser{
	top:100px;
	margin:60px auto;
	width:50%;
	border: 3px solid #ffbb00;
	border-radius:10px;
	padding:100px;
	font-size: 28px;
	text-align: center;
}

.check{
	background-color:white; 
		font-size:15px;
		border-color:#ffbb00;
		height:40px;
		border-style:solid;
		cursor: pointer;
		width: 80px;
		border-radius:3px; 
		margin-left:70%;
}
#notice{
	font-size: 27px;
	text-align: center;
	
}
.check:hover{
		background-color:#ffe08c;
	}
#checkpw{
	line-height:24px;
	font-size: 24px;
}
/* 회원 탈퇴 페이지 끝 */

/* 무통장주문시 시작 */
.row2 {
	  	width:800px;
	  	margin:auto;
	    margin-top:65px;
	    margin-left:480px;
	    text-align:left;
  }
  
  .jumungamsa{
  		height:80px;
  		font-size:22pt;
  }
  
  .jugamtable{
  		width:800px;
  		height:80px;
  		font-size:15pt;
  		border-bottom:2px solid #ffbb00;
  }
  
    
.bankinfo{
		width:150px;
  		height:25px;
  		font-size:15pt;
  		text-align:center;
		
}

.bankallprice{
  		width:150px;
  		height:50px;
  		font-size:14pt;
  		text-align:center;
  		border:1px solid #c0c0c0;
  		background-color:#f5f5f5;
  		
  		
  }
  
.banking{
		width:300px;
	  	height:50px;
		font-size:14pt;
		border:1px solid #c0c0c0;
		padding-left:10px;
}

.tkdyd4{
    z-index: 0;
    width: 70px;
    height: 40px;
    border: 1px solid rgba(0,0,0,.1);
    border-radius: 4px 4px 4px 4px;
    background: #ffbb00;
    font-size: 12pt;
    color: #fff;
    text-align: center;
    text-decoration: none;
	
}
.botl{border-bottom:1px solid #ffbb00;}
.botl1{border-bottom:3px solid #ffbb00;}
	
/* footer */
body{line-height: 1;}
	footer{background:rgba(245, 113, 92, 1);color:white;margin:0;padding:0;width: 80%;margin:auto; min-width: 1000px; bottom:0;border: 1px solid rgba(245, 113, 92, 1);}
	.footer-div{width: 100%; text-align: center; height: 130px;font-size: 13px;}
	.footer-div p{display:inline-block;}
	.footer-div .company{margin-top:20px; font-size: 15px;}
	.company-info{margin:0; padding:0;margin-top:-10px; height:30px;position:relative;top:-12px;}
	.company-link{margin-top:-5px;}
	.company-link a{color:white;text-decoration: none;}
	.company-right{margin-top:5px; color:#ACB5BD;}
</style>
</head>
<body id="body">
<%@include file="../common/menubar.jsp" %>

     

<div id="maindiv">
<div class="writetitle1">장바구니</div>


	<div class="sidebar">
		<div class="sideleft"></div><a href="../mypages/updatepage.jsp" > 개인정보 관리</a>
		<div class="sideleft"></div><a href="#" >포인트 관리</a>
		<div class="sideleft"></div><a href="#" >게시글 관리</a>
		<div class="sideleft"></div><a href="#" > 주문조회</a>
		<div class="sideleft"></div><a href="../mypages/shopbasket.jsp" > 장바구니</a>
	</div>

	
 	<section>
			<br> 
		
		<table class="list-table" style="border-spacing:0px;">
						<td align="left" style="text-align:left; font-size:18pt; padding:10px;">일반상품(1)</td>
				          <tr class="list-tableth" >
				         	  <td width="10px;" style="border-top:4px solid orange; border-bottom:2px solid orange;">
				         	   <label><input type="checkbox" value="alldelete"></label></td>
				              <td width="200" style="border-top:4px solid orange; border-bottom:2px solid orange;">이미지</td>
				              <td width="300" style="border-top:4px solid orange; border-bottom:2px solid orange;">상품정보</td>	
				              <td width="120" style="border-top:4px solid orange; border-bottom:2px solid orange;">판매가</td>
				              <td width="180" style="border-top:4px solid orange; border-bottom:2px solid orange;">수량</td>
				              <td width="100" style="border-top:4px solid orange; border-bottom:2px solid orange;">포인트</td>
				              <td width="100" style="border-top:4px solid orange; border-bottom:2px solid orange;">배송비</td>
				              <td width="100" style="border-top:4px solid orange; border-bottom:2px solid orange;">합계</td>
				              <td width="100" style="border-top:4px solid orange; border-bottom:2px solid orange;"></td>
				           </tr> 
				        
				      
				        <tbody class="list-tabletd">
				        <tr>
				          <td width="10"  style="border-bottom:4px solid orange;">
				          		<label><input type="checkbox" value="prodelete1"></label></td> 
				          <td width="150" style="border-bottom:4px solid orange;">
					          	<div class="bak_item">
									<div class="pro_img"></div>
									<div class="pro_nt"></div>
					          		<img src="../img/pizza-3007395_420.jpg" width="200" height="150">
				          		</div></td>
				          <td width="150" style="border-bottom:4px solid orange;">책제목</td>
				          <td width="150" style="border-bottom:4px solid orange;">19,900원</td>
				          <td width="150" style="border-bottom:4px solid orange;">	
				          		<div>
				          			<input type="number" value="1" name="ea" size="2" min="0" max="100" class="proquantity"  
				          			>
				          		<!-- <span>
				          			<input type="button" class="img-button2" >
				          			<input type="button" class="img-button3" >
				          		</span> -->
				          		</div>
				          </td>
				          <td width="100" style="border-bottom:4px solid orange;" img src="../img/fork.jpg">20</td>
				          <td width="150" style="border-bottom:4px solid orange;">2500원</td>
				          <td width="150" style="border-bottom:4px solid orange;">22,400원</td>
					          <td width="50" style="border-bottom:4px solid orange;">
					           		<input type="button" class="img-button" >
							  </td>
				        </tr>
				      </tbody>
				    </table>


		
		
		<br><br><br>
		
		<input type="reset" value="전체상품주문" class="longbt1" style="margin-left:250px;">
		<input type="submit" value="선택상품주문" class="longbt2">
		
		
	
	
</div>
	
</section>
<br><br><br>
<%@include file="../common/footer.jsp" %>

</body>
</html>