<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="관리자 로그인"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 관리자 로그아웃</title>
<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/common/css/main_v20211012.css">
	
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
	href="http://team3.aws.sist.co.kr/admin/css/admin_main.css">

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
	font-size: 18px;
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

</script>
</head>
<body>

	<div id="wrap">
		<!-- header  -->
		<div id="header">
			<span class="cursor" onclick="location.href='http://team3.aws.sist.co.kr/admin/common/admin_login.jsp'">Hotel Ritz Seoul</span>
			<span class="glyphicon glyphicon-user" aria-hidden="true" id="adminImg" ></span>
			<span id="admin"> admin</span>
		</div>

		<!-- container  -->
		<div id="container">
			<span id="info">정상적으로 로그아웃 되었습니다.</span> <br/>
			<span class="cursor" id="move" onclick="location.href='http://team3.aws.sist.co.kr/admin/common/admin_login.jsp'">로그인 화면으로 이동</span>
		</div>
		
		<!-- footer import -->
		<c:import url="admin_footer.jsp"/>
	</div>
</body>
</html>