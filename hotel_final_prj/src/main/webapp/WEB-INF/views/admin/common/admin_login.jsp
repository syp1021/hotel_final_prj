<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="관리자 로그인"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 관리자 로그인</title>
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
	margin:0px auto;
}

#admin {
	position: absolute;
	top: 20px;
	right: 30px;
	font-size: 20px;
}

.login{
	width:250px;
	padding-top:180px;
	margin:0px auto;
}
.login_id, .login_pass{
	width:200px;
	padding:10px;
	margin:0px auto;
	font-size:18px;
}

#btn {
	width: 200px;
	height:50px;
	margin-left:35px;
	padding:10px;
	font-size:22px;
	font-weight:bold;
	background-color: #343A40;
	color: #ffffff;
}

#btn:hover {
	color: #ffffff;
}

.form-control{
	color:#000000;
	width:200px;
	height:40px;
	margin-top:5px;
	font-size:18px
}
#title{
	font-size:22px;
	font-weight: bold;
}

</style>

<script type="text/javascript">
//로그인 수행 실패 시
<c:if test="${loginResult eq false}">
	alert("아이디와 비밀번호를 확인해주세요.");
</c:if>

	$(function() {
		$("#btn").click(function() {
		// 로그인 유효성 검증
			if ($("#id").val() == "") {
				alert("아이디를 입력하세요");
				$("#id").focus();
				return;
			}
			if ($("#pass").val() == "") {
				alert("비밀번호를 입력하세요");
				$("#pass").focus();
				return;
			}
				$("#frm").submit();
		});//click
	})//ready
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
			<form action="admin_login.do" name="login_form" method="post" id="frm">
				<div class="login">
					<div class="login_id">
						<label id="title">ID</label>
						<input type="text" name="id" placeholder="ID" id="id" class="form-control" maxlength="15"/>
					</div>
					<div class="login_pass">
						<label id="title">Password</label>
						<input type="password" name="password" placeholder="Password" class="form-control"	id="pass" maxlength="15"/>
					</div>
					<br />
						<input type="button" value="Login" class="log_btn btn btn-lg" id="btn" />
				</div>
			</form>
		</div>
		
		<!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
	</div>
</body>
</html>