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
#offerTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}

#offerText {
	color: #5A5A5A;
	font-size: 15px
}

.offerTab {
	width: 1100px;
	height: 1000px;
	text-align: center;
}

.offerBox {
	color: #5A5A5A;
	width: 450px;
	height: 250px;
	margin-top: 10px;
	text-align: left;
	margin: 0px auto;
}

.offerInfo {
	float: left;
	margin-top: 5px;
	font-size: 13px;
	color: #5A5A5A
}

.offerName {
	float: left;
	margin-top: 5px;
	font-size: 21px;
	font-weight: bold;
	color: #333
}

.offerName:hover {
	float: left;
	margin-top: 5px;
	font-size: 22px;
	font-weight: bold;
	color: #000000
}

.offerImg {
	width: 480px;
	overflow: hidden;
	margin: 0px auto;
	overflow: hidden
}

.offerImg img {
	transition: all 0.2s linear;
}

.offerImg:hover img {
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
			<br />
			<br />
			<br />
			<br />
			<div style="text-align: center">
				<p id="offerTitle">스페셜 오퍼</p>
				<br />
				<p id="offerText">호텔 리츠 서울에서만 만날 수 있는 특별할 호텔 패키지 및 프로모션 상품들을
					확인하세요.</p>
			</div>
			<hr class="featurette-divider">

			<div>
				<table class="offerTab">
					<tr>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO05.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">Delightful
										Celebration</span></a><br /> <br /> <span class="offerInfo"> 특별한
									날은 리츠호텔의 프리미엄 케이크와 함께하세요. </span><br />
								<hr />
								<span class="offerInfo"> 기간 2021년 01월 27일 - 2021년 12월 31일
								</span><br />
							</div>
						</td>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO01.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">Long and
										lasting love</span></a><br /> <br /> <span class="offerInfo"> 더
									라운지 프로포즈 패키지 </span><br />
								<hr />
								<span class="offerInfo"> 기간 2021년 04월 26일 - 2021년 12월 31일
								</span><br />
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO03.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">Arrive in
										Style</span></a><br /> <br /> <span class="offerInfo">롤스로이스와
									프라이빗 버틀러 서비스가 제공되는 객실 패키지</span><br />
								<hr />
								<span class="offerInfo"> 기간 2021년 01월 01일 - 2021년 12월 31일
								</span><br />
							</div>
						</td>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO02.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">Deep
										Relaxation</span></a><br /> <br /> <span class="offerInfo">
									에비앙스파의 대표적인 바디 프로그램을 이용해보세요. </span><br />
								<hr />
								<span class="offerInfo"> 기간 2021년 01월 01일 - 2021년 12월 31일
								</span><br />
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO04.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">Kids at home</span></a><br />
								<br /> <span class="offerInfo"> 사랑하는 아이에게 행복한 하루를 선물하세요.
								</span><br />
								<hr />
								<span class="offerInfo"> 기간 2021년 04월 14일 - 2022년 2월 28일
								</span><br />
							</div>
						</td>
						<td>
							<div class="offerImg">
								<a href="#void"><img
									src="http://team3.aws.sist.co.kr/main/main_images/SO06.jpg"
									width="480" height="300"></a><br />
							</div>
							<div class="offerBox">
								<a href="#void"><span class="offerName">해온(he:on)
										프리미엄 샵</span></a><br /> <br /> <span class="offerInfo"> 리츠호텔 자체
									침구 브랜드 '해온(he:on)' 프리미엄 샵 오픈! </span><br />
								<hr />
								<span class="offerInfo"> 기간 2020년 05월 06일 - 2021년 12월 31일
								</span><br />
							</div>
						</td>
					</tr>
				</table>
			</div>

		</div>
		<!-- footer import -->
	</div>
		<c:import url="http://team3.aws.sist.co.kr/main/main_footer.jsp" />



		<!-- ================================================== -->

		<script
			src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
