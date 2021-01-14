<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){
		var searchWords = ["asdf","acewg"];
		$("#texSerch").autocomplete({source: searchWords});
	});
</script>
</head>
<body>
	<div>
		<input type="test" name="txtSearch" id="txtSearch" value="" />
	</div>

</body>
</html>