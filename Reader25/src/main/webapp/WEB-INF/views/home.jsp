<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
	<c:import url="common/menubar.jsp"></c:import>
	<c:import url="common/mainPage.jsp"></c:import>
	
	
	<script>
	
		$(function () {
			
			var msg = "${msg}";
			
			if(msg != ""){
				
				alert(msg);
			}
		});
	
	
	
	</script>
</body>
</html>
