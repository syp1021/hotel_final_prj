<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>Hotel_Ritz_Seoul</title>

<!-- 메인 CSS -->
<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">

<style type="text/css">
#diningTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}

#diningText {
	color: #5A5A5A;
	font-size: 15px
}

.diningTab {
	width: 1100px;
	height: 1000px;
	text-align: center;
	margin: 0px auto;
}

.diningBox {
	color: #5A5A5A;
	width: 450px;
	height: 200px;
	margin-top: 10px;
	text-align: left;
	margin: 0px auto;
}

.rstr {
	float: left;
	font-size: 12px;
	font-weight: bold;
	color: #5A5A5A
}

.rstrInfo {
	float: left;
	margin-top: 5px;
	font-size: 13px;
	color: #5A5A5A
}

.rstrLink {
	float: right;
	margin-top: 5px;
	font-size: 13px;
}

.rstrName {
	float: left;
	margin-top: 5px;
	font-size: 19px;
	font-weight: bold;
	color: #333
}

.rstrName:hover {
	float: left;
	margin-top: 5px;
	font-size: 20px;
	font-weight: bold;
	color: #000000
}

.diningImg {
	width: 480px;
	overflow: hidden;
	margin: 0px auto;
	overflow: hidden
}

.diningImg img {
	transition: all 0.2s linear;
}

.diningImg:hover img {
	transform: scale(1.1);
}
/*
div { border: 1px solid #0000FF}
td { border: 1px solid #FF0000}
tr { border: 1px solid #FF0000}
span { border: 1px solid #FF00FF}
p { border: 1px solid #FF00FF}
*/
</style>

<!-- Bootstrap core CSS -->
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

<link href="http://team3.aws.sist.co.kr/common/bootstrap/carousel.css"
	rel="stylesheet">
</head>

<!-- NAVBAR
================================================== -->
<body>
	<div class="wrapper">
		<!-- header/navibar import -->
		<jsp:include page="main_header_nav.jsp"/>



		<!-- ================================================== -->

		<div class="container marketing" style="width: 1130px;">
			<br /> <br /> <br /> <br />

			<div style="text-align: center">
				<p id="diningTitle">다이닝</p>
				<br />
				<p id="diningText">탁트인 도심의 전경을 바라보며 세계 최고 수준의 셰프들이 직접 선보이는 다양한
					요리를 즐기실 수 있습니다.</p>

				<hr class="featurette-divider">


				<table class="diningTab">
					<tr>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining01.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr">레스토랑</span><br /> <a href="#void"><span
									class="rstrName">스테이, 모던 레스토랑</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>프렌치</strong> &nbsp;|&nbsp;
									위치 <strong>81층</strong></span> <a class="rstrLink" href="#void">자세히
									보기 > </a>
							</div>
						</td>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining02.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr">레스토랑</span><br /> <a href="#void"><span
									class="rstrName">비채나</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>한식</strong> &nbsp;|&nbsp;
									위치<strong>81층</strong></span> <a class="rstrLink" href="#void">자세히
									보기 > </a>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining03.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr"> 멤버스 레스토랑</span><br /> <a href="#void"><span
									class="rstrName">RITZ CLUB</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>멤버스 레스토랑</strong>
									&nbsp;|&nbsp; 위치 <strong>107층</strong></span> <a class="rstrLink"
									href="#void">자세히 보기 > </a>
							</div>
						</td>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining04.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr">바 & 라운지</span><br /> <a href="#void"><span
									class="rstrName">더 라운지</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>라운지</strong> &nbsp;|&nbsp;
									위치 <strong>79층</strong></span> <a class="rstrLink" href="#void">자세히
									보기 > </a>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining05.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr">바 & 라운지</span><br /> <a href="#void"><span
									class="rstrName">바81</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>바</strong> &nbsp;|&nbsp; 위치
									<strong>81층</strong></span> <a class="rstrLink" href="#void">자세히
									보기 > </a>
							</div>
						</td>
						<td>
							<div class="diningImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/dining06.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="diningBox">
								<span class="rstr">베이커리</span><br /> <a href="#void"><span
									class="rstrName">Pastry Salon</span></a><br /> <br /> <span
									class="rstrInfo"> 타입 <strong>베이커리</strong> &nbsp;|&nbsp;
									위치 <strong>79층</strong></span> <a class="rstrLink" href="#void">자세히
									보기 > </a>
							</div>
						</td>
					</tr>
				</table>
			</div>

		</div>
		<!-- footer import -->
	</div>
		<c:import url="http://team3.aws.sist.co.kr/main/main_footer.jsp"></c:import>




		<!--  ================================================== -->
		<script
			src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
