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
#weddingTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}

.weddingTab {
	width: 1100px;
	height: 700px;
	text-align: center;
}

.weddingBox {
	color: #5A5A5A;
	width: 520px;
	height: 150px;
	margin-top: 10px;
	text-align: left;
	margin: 0px auto;
}

.weddingInfo {
	float: left;
	margin-top: 5px;
	font-size: 15px;
	color: #5A5A5A
}

.weddingName {
	float: left;
	margin-top: 5px;
	font-size: 20px;
	font-weight: bold;
	color: #333
}

.weddingImg {
	width: 520px;
	height: 400px;
	overflow: hidden;
	margin: 0px auto;
	overflow: hidden
}

.weddingImg img {
	transition: all 0.2s linear;
}

.weddingImg:hover img {
	transform: scale(1.1);
}

.weddingLink {
	margin-top: 5px;
	font-size: 13px;
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
				<p id="weddingTitle">웨딩&컨벤션</p>
				<br />
			</div>
			<div>
				<table class="weddingTab">
					<tr>
						<td>
							<div class="weddingImg">
								<img
									src="http://team3.aws.sist.co.kr/main/main_images/wedding01.jpg"
									width="520" height="400"><br />
							</div>
							<div class="weddingBox">
								<a href="#void"><span class="weddingName">웨딩</span></a><br /> <br />
								<span class="weddingInfo"> 당신이 꿈꾸던 최상의 결혼식을 위한 최고의 장소를
									제공해 드립니다. 단 한 번 뿐인 기억에 남는 아름다운 결혼식을 위해 리츠호텔이 함께합니다. </span><br /> <br />
								<br /> <br /> <a class="weddingLink" href="#void">자세히 보기 >
								</a>
							</div>
						</td>
						<td>
							<div class="weddingImg">
								<img
									src="http://team3.aws.sist.co.kr/main/main_images/wedding02.jpg"
									width="520" height="400"><br />
							</div>
							<div class="weddingBox">
								<a href="#void"><span class="weddingName">컨벤션</span></a><br />
								<br /> <span class="weddingInfo"> 품격 있는 가족모임과 대규모 국제회의 등
									당신의 성공적인 비즈니스 행사를 위한 최상의 서비스를 준비해 드립니다. </span><br /> <br /> <br />
								<br /> <a class="weddingLink" href="#void">자세히 보기 > </a>
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
