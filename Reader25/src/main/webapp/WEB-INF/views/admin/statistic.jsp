<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<script>
			var day = new Array();
			var dayCount = new Array();
			$(function(){
				console.log('${dayList}');
				console.log('${monthList}');
				console.log('${monthCount}');
// 				console.log(${dayList.size()});
				var size = '${dayList.size()}';
				for(var i = 0; i < ${dayList.size()}; i++){
					day[i] = "${dayList.get(i)}";
					dayCount[i] = "${dayList.get(i)}";
				}
			});
			
		 	google.charts.load('current', {'packages':['corechart']});
	     	google.charts.setOnLoadCallback(drawChart);
	     	function drawChart() {
	     	        var data = google.visualization.arrayToDataTable([
	     	          ['Year', 'Sales', 'Expenses'],
	     	          ['2013',  1000,      400],
	     	          ['2014',  1170,      460],
	     	          ['2015',  660,       1120],
	     	          ['2016',  1030,      540]
	     	        ]);

	     	        var options = {
	     	          title: 'Company Performance',
	     	          hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
	     	          vAxis: {minValue: 0}
	     	        };

	     	        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
	     	        chart.draw(data, options);
	     	      }
 		 </script>
		<div class="month-graph">
		</div>
		<div class="visitor">
			
		</div>
	</section>
	
</body>
</html>