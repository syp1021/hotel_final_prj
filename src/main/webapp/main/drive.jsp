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
#driveTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}

#driveText {
	color: #5A5A5A;
	font-size: 15px;
	font-weight: bold;
}

.driveStore {
	width: 1000px;
	margin: 0px auto;
}

.driveTab {
	width: 1000px;
	border: none;
}

.storeInfoTitle {
	width: 300px;
	color: #000000;
	text-align: center;
	font-size: 20px;
	font-weight: bold
}

.storeInfoTitle2 {
	width: 300px;
	color: #000000;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
	height: 150px
}

.storeInfo {
	width: 400px;
	height: 200px;
	color: #5A5A5A;
	font-size: 15px;
}

.storeImg {
	text-align: center;
}

.driveTr {
	border: 1px solid #d3d3d3;
	border-left: none;
	border-right: none
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
				<p id="driveTitle">Drive-Thru</p>
				<br /> <img
					src="http://team3.aws.sist.co.kr/main/main_images/dining_main.jpg"
					width="1000"><br /> <br /> <br />
				<p id="driveText">드라이브 스루 픽업으로 간편하게! 레스토랑을 집에서 만나보세요</p>
			</div>
			<br />
			<br />
			<br />
			<br />

			<div class="driveStore">
				<table class="driveTab">
					<tr class="driveTr">
						<td rowspan="5" class="storeInfoTitle">업장정보</td>
						<td class="storeInfo"><span><strong>업장명</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>모모야마</span><br /> <br /> <span><strong>위치</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>MAIN TOWER 38층</span><br /> <br /> <a class="rstrLink"
							href="#void">자세히 보기 > </a></td>
						<td class="storeImg"><img
							src="http://team3.aws.sist.co.kr/main/main_images/dining_momo.jpg" />
						</td>
					</tr>
					<tr class="driveTr">
						<td class="storeInfo"><span><strong>업장명</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>무궁화</span><br /> <br /> <span><strong>위치</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>MAIN TOWER 38층</span><br /> <br /> <a class="rstrLink"
							href="#void">자세히 보기 > </a></td>
						<td class="storeImg"><img
							src="http://team3.aws.sist.co.kr/main/main_images/dining_mu.jpg" />
						</td>
					</tr>
					<tr class="driveTr">
						<td class="storeInfo"><span><strong>업장명</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>델리카한스</span><br /> <br /> <span><strong>위치</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>MAIN TOWER 1층</span><br /> <br /> <a class="rstrLink"
							href="#void">자세히 보기 > </a></td>
						<td class="storeImg"><img
							src="http://team3.aws.sist.co.kr/main/main_images/dining_delica.jpg" />
						</td>
					</tr>
					<tr class="driveTr">
						<td class="storeInfo"><span><strong>업장명</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>도림</span><br /> <br /> <span><strong>위치</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>MAIN TOWER 32층</span><br /> <br /> <a class="rstrLink"
							href="#void">자세히 보기 > </a></td>
						<td class="storeImg"><img
							src="http://team3.aws.sist.co.kr/main/main_images/dining_do.jpg" />
						</td>
					</tr>
					<tr class="driveTr">
						<td class="storeInfo"><span><strong>업장명</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>라세느</span><br /> <br /> <span><strong>위치</strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>MAIN TOWER 42층</span><br /> <br /> <a class="rstrLink"
							href="#void">자세히 보기 > </a></td>
						<td class="storeImg"><img
							src="http://team3.aws.sist.co.kr/main/main_images/dining_la.jpg" />
						</td>
					</tr>
					<tr class="driveTr">
						<td class="storeInfoTitle2">유의사항</td>
						<td colspan="2" class="storeInfo"><span>ㆍ <strong>판매가격<strong>
										: 메뉴 선택에 따라 변동 &lt;VAT 별도&gt;</span><br /> <span>ㆍ <strong>구매문의<strong>
										: ☎ +82-2-317-7148 </span></td>
						<td></td>
					</tr>
				</table>
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
			</div>
		</div>

	</div>
		<!-- footer import -->
		<c:import url="http://team3.aws.sist.co.kr/main/main_footer.jsp" />


		<!--================================================== -->
		<script
			src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
