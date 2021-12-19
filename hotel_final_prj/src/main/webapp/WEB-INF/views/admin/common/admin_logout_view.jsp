<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="관리자 로그인"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="5;http://localhost/hotel_final_prj/admin_login_form.do">

<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 관리자 로그아웃</title>
<link rel="stylesheet" type="text/css"
	href="http://localhost/hotel_final_prj/common/css/main_v20211012.css">
	
<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 관리자 메인 CSS -->
<link rel="stylesheet" type="text/css"
	href="http://localhost/hotel_final_prj/admin/css/admin_main.css">

<style type="text/css">
#container {
	clear:both;
	left:0px;
	width: 100%;
	text-align: center;
	padding-top: 300px;
}

#info{
	clear:both;
	font-size: 22px;
	font-weight:bold
}

#move{
	color:#0000FF;
	font-size: 17px;
	font-weight:bold
}

#admin {
	position: absolute;
	top: 20px;
	right: 30px;
	font-size: 20px;
}


</style>

<script type="text/javascript">
//카운트다운
let i = 5;
function printSecond() {
    var second = document.getElementById("second");
    second.innerHTML = i;
    i--;
    setTimeout("printSecond()",1000); //1초후에 printSecond()을 호출
}//printSecond

window.onload = function() { //HTML이 로딩되면 printSecond()함수를 호출
	printSecond(); 
}
</script>
</head>
<body>

	<div id="wrap">
		<!-- header  -->
		<div id="header">
			<span class="cursor" onclick="location.href='admin_login_form.do'">Hotel Ritz Seoul</span>
			<span class="glyphicon glyphicon-user" aria-hidden="true" id="adminImg" ></span>
			<span id="admin"> admin</span>
		</div>

		<!-- container  -->
		<div id="container">
			<span id="info">정상적으로 로그아웃 되었습니다.</span> <br/>
			 <span style="font-size:17px;font-weight:bold">
			 	<span id="second" style="color:#FF0000"></span>초 후 로그인 화면으로 이동됩니다.</span><br/><br/>
			<span class="cursor" id="move" onclick="location.href='admin_login_form.do'">지금 로그인하러 가기</span>
		</div>
		
		<!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
	</div>
</body>
</html>