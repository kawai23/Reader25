<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
     <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
	body{background:rgba(246, 246, 246, 1);}
	section{
		min-height: 700px;
		position: absolute;
		left:160px;
		margin-left: 10px;
 		width: 80%;
 		min-width: 800px; 
	}
	#logo-img:hover{cursor:pointer;}
	.count{width: 800px; height: 50px; padding:5px;  margin:auto;margin-top: 20px;}
	.graph-box, .title{
		max-width: 800px;
		margin: auto;
	}
	.graphs-title{padding-bottom:7px; display:inline-block; width:800px; border-bottom: 1px solid rgb(200, 200, 200);}
	.graph{display:inline-block;}
	.graph input{margin-bottom: 5px;}
	.count span{color:rgba(245, 113, 92, 1);font-weight: bolder;}
	.list-box{
		width: 800px;
		margin-top:10px;
		max-width: 1000px;
		background: white;
		margin:auto;
	}
	.list{
		margin: 10px;
	}
	.list-header{
		height: 35px;
		line-height: 35px;
		border-bottom: 1px solid rgb(200, 200, 200);
	}
	.list-header p{
		display:inline;
	}
	.list-table{
		width: 100%;
		border-collapse: collapse;
		margin:auto;
	}
	.list-table tr{border-bottom: 1px solid rgb(240, 240, 240);}
	.list-table tr:hover{
		background: rgb(240, 240, 240);
	}
	.list-table td{
		text-align: center;
		color:gray;
		font-size: 13px;
	}
	.list-table .agent{font-size: 10px;}
	.list-table td[class=td-left]{text-align: left;}
	.list-table td[class=td-right]{text-align: right; color:rgb(180, 180, 180);}
	.paging{width: 150px; margin:auto;text-align: center;}
	.paging-div {
		display:inline-block;
		max-width: 250px;
	}
	.paging-div>a, .paging-div>p {
		padding: 0;
		margin: 0;
		display: inline-block;
		width: 18px;
		height: 18px;
		color: rgba(85, 83, 83, 1);
		font-size: 13px;
		background: rgba(229, 229, 229, 1);
		border: none;
		text-decoration: none;
		text-align: center;
		vertical-align: middle;
	}
	.paging-div>a:hover {
		font-weight: bold;
		background: rgba(220, 220, 220, 1);
	}
	
	.paging-div>p {
		background: rgba(39, 50, 56, 1);
		color: white;
	}
	#st-ad{
		font-weight: bolder;
		background: black;
	}
</style>
</head>
<body>
	<header>
		<img src="resources/images/logo/logo.png" id="logo-img" style="height:45px" onclick="goHome();"/>
		<h3 id="header-h2">방문자 관리</h3>
	</header>
	<%@ include file="header.jsp" %>
	<script>
		function goHome(){
			location.href="home.do";
		}
	</script>
	<section>
		<div class="count">
			전체 방문자 수 : <span>${sessionScope.totalCount }</span><br>
			오늘 방문자 수 : <span>${sessionScope.todayCount }</span>
		</div>
		<div class="graph-box">
			<h4 class="graphs-title">사이트 방문자 현황 그래프</h4>
			<div class="graphs">
				<div class="graph">
					<input type="date" name="dayStart" id="dayStart" min="2021-01-19">
					<div class="day-graph" id="chart_div">
					</div>
				</div>
				<div class="graph">
					<input type="month" name="monthStart" id="monthStart" min="2021-01">
					<div id="chart_month">
					</div>
				</div>
			</div>
		</div>
		<script>
     		var month = [];
     		var day = [];
     		
     		day =   [${dayStr}];
     		month = [${monthStr}];
     		
			$(function(){
				console.log(day);
				var today = new Date();
	     		var dd = today.getDate();
	     		var mm = today.getMonth() + 1;
	     		var yyyy = today.getFullYear();
	     		if(dd < 10){
	     			dd = '0' + dd;
	     		}
	     		if(mm < 10){
	     			mm = '0' + mm;
	     		}
	     		today = yyyy +'-' + mm + '-' +dd;
	     		today2 = yyyy +'-' + mm;
	     		
	     		$('#dayStart').attr('max', today);
	     		$('#monthStart').attr('max', today2);
				
				
				$('#dayStart').change(function(){
					var value = $(this).val();
					day = [];
					$.ajax({
						url:"dayCount.ad",
						data:{dayStart:value},
						success:function(data){
							day[0] = ['Day','방문자수','회원가입수'];
							
							for(var i = 0; i < data.dayList.length; i++){
								var count = 0;
								for(var j = 0; j <data.enrollList.length; j++){
									if(data.dayList[i].day == data.enrollList[j].day){
										day[i+1] = [data.dayList[i].day, Number(data.dayList[i].count),Number(data.enrollList[j].count)];
									}else{
										count++;
									}
								}
								if(count == data.enrollList.length){
									day[i+1] = [data.dayList[i].day, Number(data.dayList[i].count),0];
								}
							}
							drawChart();
						}
					});
				});
			});
			$(function(){
				$('#monthStart').change(function(){
					var value = $(this).val();
					month = [];
					$.ajax({
						url:"monthCount.ad",
						data:{monthStart:value},
						success:function(data){
							month[0] = ['Month','Count'];
							for(var i = 0; i < data.length; i++){
								month[i+1] = [data[i].month, Number(data[i].count)];
							}
							drawChart();
						}
					});
				});
			});
		 	google.charts.load('current', {'packages':['corechart']});
	     	google.charts.setOnLoadCallback(drawChart);
	     	
	     	function drawChart() {
	     	        var data = new google.visualization.arrayToDataTable(day);
	     	        var data2 = new google.visualization.arrayToDataTable(month);

	     	        var options = {
	     	          legend:'top',
	     	          title: '일별 방문자 차트',
	     	          hAxis: {title: 'Day',  titleTextStyle: {color: '#333'}},
	     	          vAxis: {minValue: 0},
	     	          width: 380, 
	     	          height: 300, 
	     	          is3D:true
	     	        };
	     	        
	     	       var options2 = {
	     	    		  legend:'none',
	 	     	          title: '월별 방문자 차트',
	 	     	          hAxis: {title: 'Month',  titleTextStyle: {color: '#333'}},
	 	     	          vAxis: {minValue: 0},
	 	     	          width: 380, height: 300, is3D:true
	 	     	        };

	     	        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
	     	        chart.draw(data, options);
	     	        
	     	       var chart = new google.visualization.AreaChart(document.getElementById('chart_month'));
	     	        chart.draw(data2, options2);
	     	}
 		 </script>
		<div class="title">
			<h4 class="graphs-title">접속자 정보</h4>
		</div>
		<div class="list-box">
			<div class="list">
				<div class="list-contents">
					<table class="list-table" id="wiseTable">
						<tr>
							<th>IP</th>
							<th>TIME</th>
							<th>REFER</th>
							<th>AGENT</th>
						</tr>
						<c:forEach items="${visitList}" var="v">
							<tr>
								<td>${v.visit_ip }</td>
								<td>${v.visit_time }</td>
								<td>${v.visit_refer }</td>
								<td class="agent">${v.visit_agent }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div class="paging">
		<div class="paging-div">
			<!------ 이전 --------->
			<c:if test="${ pi.currentPage <= 1 }">
				<p>&lt;</p>
			</c:if>
			<c:if test="${ pi.currentPage > 1 }">
				<c:url var="before" value="${loc }">
					<c:param name="page" value="${ pi.currentPage -1 }"/>
				</c:url>
				<a href="${ before }">&lt;</a>
			</c:if>
			<!------ 버튼 --------->
			<c:forEach  var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:if test="${pi.currentPage ne p }">
					<c:url var="pNo" value="${loc }">
						<c:param name="page" value="${ p }"/>
					</c:url>
					<a href="${ pNo }">${ p }</a>
				</c:if>
				<c:if test="${ pi.currentPage eq p }">
					<p>${ p }</p>
				</c:if>
			</c:forEach>
			
			<!------ 다음 --------->
			<c:if test="${ pi.currentPage >= pi.maxPage }">
				<p>&gt;</p>
			</c:if>
			<c:if test="${ pi.currentPage < pi.maxPage }">
				<c:url var="Next" value="${ loc }">
					<c:param name="page" value="${ pi.currentPage + 1 }"/>
				</c:url>
				<a href="${ Next }">&gt;</a>
			</c:if>
		</div>
		</div>
		
	</section>
	
</body>
</html>