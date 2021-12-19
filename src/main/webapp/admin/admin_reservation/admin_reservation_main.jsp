<%@page import="kr.co.sist.admin.reservation.ReserveSelect"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="예약관리 메인"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 예약관리</title>
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
#date{
	font-size: 15px;
	margin: 20px;
	padding-bottom :30px;
	border-bottom: 1px solid #454D55;
	width:100%;
	hegiht:300px;
}

#resList{
	font-size: 15px;
	margin-left: 10px;
	margin-bottom:0px;
}

#year,#month,#day{
	width:120px;
	margin-right: 5px;
	font-size: 15px;
	color:#000000}

.table{
	width:1200px;
	margin-top: 40px;
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
.btn{
	font-weight: bold;
}
#page{
	margin-top : 20px;
	padding-left:420px;
}
.pagination>li>a {color:#343A40}

tr:hover td {
	background-color: #F1F3F4;
	cursor:pointer;
}

</style>

<script type="text/javascript">
$(function(){
	/* 날짜 검색 */
	$("#searchBtn").click(function(){
		let year = $("#year").val();
		let month = $("#month").val();
		let day = $("#day").val();
		
		if(year == "" || month == "" || day == ""){
			alert("날짜를 입력해주세요.");
			$("#year").focus();
			return;
		}//end if
		
		//날짜 유효성 체크
		let inputDate = year;
		inputDate +='-'+month;
		inputDate +='-'+day;
		
		let isValidDate = Date.parse(inputDate);
		
		if(isNaN(isValidDate)){
			alert("정상적인 날짜를 입력해주세요.");
			$("#year").val("");
			$("#month").val("");
			$("#day").val("");
			$("#year").focus();
			return;
		}//end if
		
		$("#dateFrm").submit();
	})//날짜검색 click
	
	
	/* 예약 변경 */
	$("#resList tr").click(function(){
		//현재 선택된 tr과 td
		let tr = $(this);
		let td = tr.children();

		//선택된 행에서 예약번호 얻어오기
		let resNum = td.eq(0).text();
		
		if(resNum != "예약번호" && resNum != null){
		//해당 예약번호를 예약변경 페이지로 전송!
			$("#resNum").val(resNum);
			$("#chgFrm").submit();
		}//end if
	})//table click
	
	
	/* 예약 삭제*/
	$(".delBtn").click(function(){
		//선택된 버튼 할당
		var delBtn = $(this);
		//선택된 버튼에 해당하는 행과 각 td
		let tr = delBtn.parent().parent(); 
		let td = tr.children();
		//예약번호 얻기
		let resNum = td.eq(0).text();
		
		if(confirm("["+resNum+"] 예약을 삭제하시겠습니까?")){
			$("#delResNum").val(resNum);
			$("#delFrm").submit();
		}else{
			alert("예약 삭제 진행을 취소합니다.");
		}//end else
			
	})//table click
	
})//ready

</script>
</head>
<body>
	<div id="wrap">
		<!-- header/navibar import -->
		<c:import url="../common/admin_header_nav.jsp" /> 

		<div id="container" style="padding:50px">
		<form name="dateFrm" id="dateFrm" action="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp" method="get" class="form-inline">
		 <span id="mainMenu" onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp'">체크인 날짜 검색</span><br/><br/>
	
		 <div id="date">
		 <!-- 날짜 입력/선택여부에 따라 value 설정-->
		 	<c:choose>
		  	 <c:when test="${not empty param.year}">
		  	  <input type="text" id="year" name="year" class="form-control" value="${param.year}" maxlength="4"/>년 &nbsp;
		  	  <input type="text" id="month" name="month" class="form-control" value="${param.month}" maxlength="2"/>월 &nbsp;
		  	  <input type="text" id="day" name="day" class="form-control" value="${param.day}" maxlength="2"/>일 &nbsp;
		  	 </c:when>
		  	 <c:otherwise>
		  	  <input type="text" id="year" name="year" class="form-control" placeholder="YYYY" maxlength="4"/>년 &nbsp;
		  	  <input type="text" id="month" name="month" class="form-control" placeholder="MM" maxlength="2"/>월 &nbsp;
		  	  <input type="text" id="day" name="day" class="form-control" placeholder="DD" maxlength="2"/>일 &nbsp;
		  	 </c:otherwise>
		  	</c:choose>
		  	<input type="button" id="searchBtn" name="searchBtn" class="btn btn-default" value="검색"/>
		 </div>
		 </form>
		 
		 <!-- 날짜 선택 or 오늘의 예약으로 넘어왔을 때 웹파라미터 처리 -->
		 <jsp:useBean id="date" class="kr.co.sist.admin.reservation.ReserveDateVO" scope="page"/>
		 <jsp:setProperty property="*" name="date"/>
		 
		 <%
		 ReserveSelect rs = new ReserveSelect();
		 pageContext.setAttribute("resData", rs.selectRes(date));
		 %>
		 
		 <div id="resList">
		 <table class="table table-bordered" id="resList">
		 <tr>
		 	<th>예약번호</th>
		 	<th>예약자명</th>
		 	<th>객실</th>
		 	<th>투숙기간</th>
		 	<th>인원수</th>
		 	<th>예약일자</th>
		 	<th>예약관리</th>
		 </tr>
		 
		<c:if test="${ empty resData }">
		<tr>
			<td onclick="event.cancelBubble=true" colspan="7" style="font-weight: bold">
			예약 정보가 존재하지 않습니다.</td>
		</tr>
		</c:if>
	
		<c:forEach var="res" items="${ resData }">
		  <tr>
			<td><c:out value="${ res.resNo }"/></td>
			<td><c:out value="${ res.kName }"/></td>
			<td><c:out value="${ res.rName }"/></td>
			<td><c:out value="${ res.stayDate }"/></td>
			<td><c:out value="${ res.guest }"/></td>
			<td><c:out value="${ res.resDate }"/></td>
	 		<td onclick="event.cancelBubble=true">
	 	 	<input type="button" id="delBtn" name="delBtn" class="delBtn btn btn-danger" value="예약삭제"></td>
		  </tr>
		</c:forEach>
		</table>
		</div>
		 
		  <!-- 테이블의 예약건(행) 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="chgFrm" id="chgFrm" action="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_change.jsp" method="post">
		 	<input type="hidden" name="resNum" id="resNum"/>
		 </form>
		 
		 <!-- 삭제버튼 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="delFrm" id="delFrm" action="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_del_process.jsp" method="post">
		 	<input type="hidden" name="delResNum" id="delResNum"/>
		 </form>
		 
		</div> <!-- 컨테이너 div -->
		 
	    <!-- footer import -->
		<c:import url="../common/admin_footer.jsp" />
	
	</div>
</body>
</html>