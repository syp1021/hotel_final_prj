<%@page import="kr.co.sist.user.reservation.ReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.user.reservation.ReservationSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Hotel_Ritz_Seoul</title>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 메인 CSS -->
<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">

	<style type = "text/css">

.hr1 {border-bottom: 1px solid #d3d3d3;}

.searchTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}	

	#table {width:100%; border-align: center; margin: 0px auto; }
	#reserTd{vertical-align: middle; height: 50px;}
	
	#reserTr:hover {cursor: pointer; background-color: #FCF4C0;}
	
.button {
	border: 1px solid #E9E9E9;
	font-weight: bold;
	font-size: 15px;
	background-color: #000;
	color: #F5DF3C;
	width: 130px;
	height: 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

.button:hover{
	background-color: #F5dF4D;
	color: #000000;
	cursor: pointer;
	border: 1px solid #E9E9E9;
	font-weight: bold;
	font-size: 15px;
	width: 130px;
	height: 40px;
	text-align: center;
	border-radius: 7px;
}
	
	
	</style>

<script type="text/javascript">
function main(){
	alert("메인 페이지로 이동합니다.");
	location.href="http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp"
}


function searchReservation( res_no ){
	$("#res_no").val( res_no );
	$("#res_noFrm").submit();
} 
</script>
</head>
<!-- NAVBAR
================================================== -->
  <body>
<%
String id = (String)session.getAttribute("id"); 

if(id == null){
		response.sendRedirect("../login/login.jsp"); 
		return;
}//end if
  request.setCharacterEncoding("UTF-8");
%>
  
  <!-- 이전 페이지에서 날아온 웹파라미터 이 페이지에서 받아서 설정하기 -->
  <jsp:useBean id="rVO" class="kr.co.sist.user.reservation.ReservationVO"/>  
  <!-- *써서 setter method 다 실행해서 세팅됨 -->
  <jsp:setProperty property="*" name="rVO"/>
  
<%
	ReservationSelect rsD = new ReservationSelect();
	List<ReservationVO> rv = rsD.reserInq(id);
	pageContext.setAttribute("reserInq", rv);

%>
<form action="reservation_confirm.jsp" id="res_noFrm" name="res_noFrm" method="post">
<input type="hidden" name="res_no" id="res_no" />
</form>

<div class="wrapper">
<jsp:include page="../../main/main_header_nav.jsp"/>	

<br/><br/><br/>
<div class = "container">	
<div style="text-align: center">
		<p class="searchTitle">예약조회</p><br/>
 <hr class="hr1">
	</div>
<br/><br/>
<div  style = "width:1000px; margin:0px auto;">

<c:choose>
<c:when test="${ empty reserInq }">
예약이 존재하지 않습니다.
</c:when> 
<c:when test="${ not empty reserInq }">
	<table id="table" class="table">
	<thead>
	<tr>
		<th>예약번호</th>
		<th>객실이름</th>
		<th>투숙날짜</th>
		<th>예약상태</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="res_inq" items="${ reserInq }">
			<tr id="reserTr" onclick="searchReservation('${ res_inq.res_no }')">
				<td id="reserTd"><c:out value="${ res_inq.res_no }"/></td>
				<td id="reserTd"><c:out value="${ res_inq.r_name }"/></td>
				<td id="reserTd"><c:out value="${ res_inq.chkin_date }"/>~<c:out value="${ res_inq.chkout_date }"/></td>
				<td id="reserTd">
				<c:choose>
				<c:when test="${ res_inq.res_status eq 'Y' }">예약완료</c:when>
				<c:when test="${ res_inq.res_status eq 'N' }"><span style="color: #D29C78; font-weight: bold;">예약취소</span></c:when>
				</c:choose>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</c:when>
</c:choose>
</div>
<br/><br/><br/>
<div style = "width:450px; text-align: center; margin:0px auto;">
<button type="button" class="button" name="reservation_inq" onclick="main()">홈으로</button>
</div>


  <br/><br/><br/><br/><br/><br/>
</div>
 <!-- FOOTER -->

	<jsp:include page="../../main/main_footer.jsp"/>

</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>