<%@page import="kr.co.sist.admin.reservation.ReserveDateVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="kr.co.sist.admin.reservation.ReserveSelect"%>
<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 메인</title>
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

#todayRes{
height:300px;
}
.table{
	margin-top: 80px;
	margin-left: 50px;
	border: 1px solid #333;
	font-size: 15px;
	margin-bottom:0px;
	text-align: center;
	width:1100px;
	}

th{
	height:40px;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	background-color: #dfdfdf;
	}
	
td{
	font-size: 16px;
	text-align: center;
	vertical-align: middel;
	color:#000000;
	background-color: #FFFFFF;
}

tr:hover td {
	background-color: #F1F3F4;
	cursor:pointer;
}

#page{
	margin-top : 20px;
	padding-left:420px;
}
.pagination>li>a {color:#343A40}
</style>

<script type="text/javascript">
$(function(){
/* 예약 변경 */
$("#toDayList tr").click(function(){
	//현재 선택된 tr과 td
	let tr = $(this);
	let td = tr.children();

	//선택된 행에서 예약번호 얻어오기
	let resNum = td.eq(0).text();
	
	if(resNum != "예약번호" && resNum != null){
		$("#moveFrm").submit();
	}//end if
})//table click
})//ready
</script>
</head>
<body>

	<div id="wrap">
		<!-- header/navibar import -->
		<c:import url="../common/admin_header_nav.jsp" /> 
		
		<div id="container">
			<span id="mainMenu" onclick="http://team3.aws.sist.co.kr/admin/common/admin_main.jsp">오늘의 예약</span><br/>
			<div id="todayRes">
			
		<%
		 Calendar cal = Calendar.getInstance();
		 int nowYear = cal.get(Calendar.YEAR);
		 int nowMonth = cal.get(Calendar.MONTH)+1;
		 int nowDay = cal.get(Calendar.DAY_OF_MONTH);
		 // 오늘을 체크인 일자로 투입하여 VO 생성
		 ReserveDateVO date = new ReserveDateVO();
		 date.setYear(String.valueOf(nowYear));
		 date.setMonth(String.valueOf(nowMonth));
		 date.setDay(String.format("%02d",nowDay));
		 
		 ReserveSelect rs = new ReserveSelect();
		 pageContext.setAttribute("toDayData", rs.selectRes(date));
		 %>
		<table  class="table table-bordered" id="toDayList">
			<tr>
			<th>예약번호</th>
			<th>예약자명</th>
			<th>객실</th>
			<th>투숙기간</th>
			<th>인원수</th>
			<th>예약일자</th>
		<tr>
				
		<c:if test="${ empty toDayData }">
		<tr>
			<td onclick="event.cancelBubble=true" colspan="6" style="font-weight: bold">
			예약 정보가 존재하지 않습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach var="data" items="${ toDayData }">
		  <tr>
			<td><c:out value="${ data.resNo }"/></td>
			<td><c:out value="${ data.kName }"/></td>
			<td><c:out value="${ data.rName }"/></td>
			<td><c:out value="${ data.stayDate }"/></td>
			<td><c:out value="${ data.guest }"/></td>
			<td><c:out value="${ data.resDate }"/></td>
		  </tr>
		</c:forEach>
		
		</table>
		</div>
		
		<!-- 테이블의 예약건(행) 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="moveFrm" id="moveFrm" action="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp" method="get">
		 <c:if test="${ not empty toDayData }">
		 	<input type="hidden" name="year" id="year" value="<%=nowYear%>"/>
		 	<input type="hidden" name="month" id="month" value="<%=nowMonth%>"/>
		 	<input type="hidden" name="day" id="day" value="<%=String.format("%02d",nowDay)%>"/>
		 </c:if>
		 </form>

		</div>
	</div>

	<!-- footer import -->
	<c:import url="../common/admin_footer.jsp" />

</body>
</html>
