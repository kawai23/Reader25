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
	*{border: 1px solid pink;}
	body{
		background:rgba(246, 246, 246, 1);
	}
	section{
		min-height: 700px;
		position: absolute;
		left:160px;
		margin-left: 10px;
 		width: 80%;
 		min-width: 700px; 
	}
	#logo-img:hover{cursor:pointer;}
</style>
</head>
<body>
	<header>
		<img src="#logo"/>
		<h3 id="header-h2">통계 자료</h3>
	</header>
	<%@ include file="header.jsp" %>
	<section>
		<div class="count">
			전체 방문자 수 : ${sessionScope.totalCount }<br>
			오늘 방문자 수 : ${sessionScope.todayCount }
		</div>
		<h4>사이트 방문자 현황 그래프</h4>
		<div class="day-graph" id="chart_div">
		</div>
		<div id="chart_month">
		</div>
		<script>
			
		 	google.charts.load('current', {'packages':['corechart']});
	     	google.charts.setOnLoadCallback(drawChart);
	     	
	     	function drawChart() {
	     	        var data = new google.visualization.arrayToDataTable([
	     	        	['Day','Count']
	     	        	${dayStr}
	     	        ]);
	     	        var data2 = new google.visualization.arrayToDataTable([
	     	        	['Month','Count']
	     	        	${monthStr}
	     	        ]);

	     	        var options = {
	     	          title: '일별 방문자 차트',
	     	          hAxis: {title: 'Day',  titleTextStyle: {color: '#333'}},
	     	          vAxis: {minValue: 0}
	     	        };
	     	        
	     	       var options2 = {
	 	     	          title: '월별 방문자 차트',
	 	     	          hAxis: {title: 'Month',  titleTextStyle: {color: '#333'}},
	 	     	          vAxis: {minValue: 0}
	 	     	        };

	     	        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
	     	        chart.draw(data, options);
	     	        
	     	       var chart = new google.visualization.AreaChart(document.getElementById('chart_month'));
	     	        chart.draw(data2, options2);
	     	}
 		 </script>
		<div class="month-graph">
		</div>
		<div class="visitor">
			
		</div>
	</section>
	
</body>
</html>