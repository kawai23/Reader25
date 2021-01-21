<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
<title>Reader25란</title>

<style> 

	section{
		width:80%; min-width: 1000px; min-height: 500px; margin:auto; margin-top: 50px;
		position: relative; display: flex; 
		overflow: hidden;
	}
	
	.logo{
        padding: 10px; left: 20%; position: relative; z-index: 3;
    }
	#myImg{
		width: 700px; height: 460px;  opacity: 0.47; 
		position: absolute; z-index: "3";position:absolute;
	}
	.out{
		z-index: "4";position:absolute; width: 700px; height: 460px;
		text-align: center; border:0.5px solid #aaa; position: relative;
	}
	#title{
		font-size:70px;
		font-family: 카페24 아네모네;
		text-align: center;
	}
	#sub-title{
		font-size:30px;
		font-family: 카페24 아네모네;
		text-align: center;
	}
	#contents{
		font-size:15px;
		font-family: 카페24 아네모네에어;
		text-align: center;
		left: 20%; right: 20%; position:absolute;
	}
	 .circle {
        position: absolute;
        top:35%; 
        left: 5%; 
        width: 200px;
        height: 200px;
        border-radius: 50%;
        background: transparent linear-gradient(180deg, #FF6C6C 0%, #FFC6C6 100%) 0% 0% no-repeat padding-box;
        opacity: 0.57;
        
        animation-duration:30s; animation-iteration-count:6; animation-name:aa_ani;
    }
    
    @keyframes aa_ani{
            5%{
                margin-left:0%; 
            }25%{
                margin-left:40%; margin-top:5%
            }50%{
                margin-left:80%; margin-top:10%
            }75%{
                margin-left:20%; margin-top:-20%
            }100%{
                
            }
        }

    .circle2 {
        position: absolute;
        top:50%; 
        right: -10%; 
        width: 683px;
        height: 682px;
        background: transparent linear-gradient(46deg, #F5715C 0%, #F5325C 80%) 0% 0% no-repeat padding-box;
        opacity: 0.37;
        border-radius: 50%;
        
        animation-duration:30s; animation-iteration-count:6; animation-name:bb_ani;
    }
    
    @keyframes bb_ani{
            0%{
                
            }25%{
                margin-right:20%; margin-top:15%
            }50%{
                margin-right:80%; margin-top:-10%
            }70%{
                margin-right:40%; margin-top:-50%
            }100%{
                
            }
        }

    .circle3 {
        position: absolute;
        bottom:0; 
        top:80%;
        left:-10%; 
        width: 300px;
        height: 300px;
        transform: matrix(-0.97, 0.26, -0.26, -0.97, 0, 0);
        background: transparent linear-gradient(46deg, #FFCCAE 0%, #A84E19 100%) 0% 0% no-repeat padding-box;
        opacity: 0.37;
        border-radius: 50%;
        
        animation-duration:30s; animation-iteration-count:6; animation-name:cc_ani;
    }
    
    @keyframes cc_ani{
            10%{
                margin-left:-10%; 
            }25%{
                margin-left:20%; margin-top:-30%
            }50%{
                margin-left:80%; margin-top:-5%
            }75%{
                margin-left:100%; margin-top:-40%
            }100%{
                
            }
        }

    .circle4 {
        position: absolute;
        bottom:0; 
        right:-20%; 
        top:5%;
        width: 400px;
        height: 400px;
        background: transparent linear-gradient(180deg, #F7B45E 0%, #FFFFB4 60%) 0% 0% no-repeat padding-box;
        opacity: 0.47;
        border-radius: 50%;
        
        animation-duration:30s; animation-iteration-count:6; animation-name:dd_ani;
    }
    
    @keyframes dd_ani{
            0%{
               
            }25%{
                margin-right:40%; margin-top:-15%
            }50%{
                margin-right:60%; margin-top:10%
            }70%{
                margin-right:20%; margin-top:30%
            }100%{
                
            }
        }
    
    

</style>
</head>
<body>
	<%@ include file="menubar.jsp" %>
	<section>

		<div class="logo">
			<img id="myImg" align="center" src="resources/images/about/background2.jpg">
			<div class="out">
				<p id="title"> Reader25</p>
				<p id="sub-title">' <span style="background-color:#FFFF90">독서인</span> 을 위한 사이트 '</p> 
				<p id="contents">
					코로나19의 여파로  <br>밖에서 독서 모임, 독서 토론을 즐기지 못하는 사람들을 위해 <br>
					웹적으로나마 독서의 즐거움, 토론의 즐거움을 느낄 수 있는 <br> Reader25 <br>
					‘새로워진 독서’ 독서를  혼자 즐기는 것이 아니라  <br>다양한 방법으로  많은 사람들과 나눌 수 있는 
					 신개념 독서 커뮤니티
				</p>

			</div>
	    </div>
	    <div class="circle"></div> 
	    <div class="circle2"></div>
	    <div class="circle3"> </div>
	    <div class="circle4"></div> 
	</section>
	
	 <%@ include file="footer.jsp" %>
</body>
</html>