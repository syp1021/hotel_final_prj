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
	margin:0px auto;
}

#admin {
	position: absolute;
	top: 20px;
	right: 30px;
	font-size: 20px;
}

.login{
	width:200px;
	padding-top:100px;
	margin:0px auto;
}
.login_id, .login_pass{
	width:200px;
	padding:10px;
	margin:0px auto;
	font-size:18px;
}

.log_btn {
	width: 150px;
	margin-left:35px;
	padding:10px;
	font-size:18px;
	font-weight:bold;
	background-color: #343A40;
	color: #ffffff;
}

.log_btn:hover {
	color: #ffffff;
}

.form-control{
	color:#000000;
	width:200px;
	height:35px;
	margin-top:5px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#btn").click(function() {
			login();
		});
		// 로그인 유효성 검증
		function login() {
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
		}//login	
	})
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
			<form action="http://team3.aws.sist.co.kr/admin/common/admin_login_process.jsp" name="login_form" method="post"
				id="frm">
				<div class="login">
					<div class="login_id">
							<strong>ID</strong>
						<input type="text" name="userid" placeholder="ID" id="id" class="form-control" maxlength="15"/>
					</div>
					<div class="login_pass">
							<strong>Password</strong>
						<input type="password" name="password" placeholder="Password" class="form-control"
							id="pass" maxlength="15" />
					</div>
					<br />
					<div class="submit">
						<input type="button" value="Login" class="log_btn btn" id="btn" />
					</div>
				</div>
			</form>
		</div>
		
		<!-- footer import -->
		<c:import url="http://team3.aws.sist.co.kr/admin/common/admin_footer.jsp" />
	</div>
</body>
</html>