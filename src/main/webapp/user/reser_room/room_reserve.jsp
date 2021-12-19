<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="kr.co.sist.uesr.room.RoomVO"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
	
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

.hr1 {border-bottom: 1px solid #d3d3d3; }

.button:hover {
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

.button{
	background-color: #FCF4C0 ;
	border: 1px solid #E9E9E9;
	font-weight: bold;
	font-size: 15px;
	color: #333;
	width: 130px;
	height: 40px;
	text-align: center;
	border-radius: 7px;
	cursor: pointer;
}

.roomView {
	width: 720px;
	height: 405px;
}

#roomName {font-size: 18px; font-weight: bold; margin-bottom: 20px; margin-left: 20px}


#roomIntroBtn:hover {
	background-color: #FCF4C0  ;
	color: #333;
	cursor: pointer;
}

#roomIntroBtn {
	border: 1px solid #E9E9E9;
	font-size : 15px;
	font-weight: bold;
	background-color: #FAFAFA;
	color: #333;
	width: 150px;
	height: 50px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}


#roomReserBtn {
	border: 1px solid #E9E9E9;
	font-size : 15px;
	font-weight: bold;
	background-color: #FCF4C0;
	color: #333;
	width: 150px;
	height: 50px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}


#roomReserBtn:hover {
	background-color: #FCF4C0;
	color: #333;
	cursor: pointer;
}


#goHome {
	border: 1px solid #E9E9E9;
	font-size : 17px;
	font-weight: bold;
	background-color: #000;
	color: #F5DF3C;
	width: 130px;
	height: 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

#goHome:hover {
	background-color: #F5dF4D;
	color: #000000;
	cursor: pointer;
}
/*
div { border: 1px solid #FF0000}
td { border: 1px solid #FF0000}
tr { border: 1px solid #FF0000}
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

<script src="http://team3.aws.sist.co.kr/jsp_prj/common/bootstrap/holder.js"></script>

<script
	src="http://team3.aws.sist.co.kr/common/bootstrap/ie-emulation-modes-warning.js"></script>

<link href="http://team3.aws.sist.co.kr/common/bootstrap/carousel.css"
	rel="stylesheet">


 
	 
<script type="text/javascript">


function divPlaying(  viewId, btnId  ){
	if($( "#"+viewId ).css("display") == "block" ){ //view제어
		$( "#"+viewId).hide();
		$("#"+btnId).text("detail"); //버튼의 텍스트 변경
	}else{
		$("#"+viewId ).show();
		$("#"+btnId).text("close");
	}//end else
}//divPlaying 



function roomDetail( Hroom,paramSd,paramEd,paramAdult ,paramChild){
	//파라메터를 hiddenFr에 설정한다.
	$("#Room_no").val(Hroom);
	$("#Sd").val(paramSd);
	$("#Ed").val(paramEd);
	$("#Adult").val(paramAdult);
	$("#Child").val(paramChild); 
	
	//alert( $("#room_no").val() );
	 //alert( Hroom+" / " +paramSd+" / "+paramEd+" / "+paramAdult +" / "+paramChild)
	 
	//hiddenFrm을 submit 한다. 
	$("#hiddenFrm").submit();
}//roomDetail

$(function(){
	$("#goHome").click(function(){

		location.href="http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp";
	})//click
	
	$("#roomIntroBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_intro.jsp";
	})//table click
	
	$("#roomReserBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_date.jsp";
	})//table click
	
	
}); //ready

</script>

</head>

<!-- NAVBAR
================================================== -->

<body>

<%
	request.setCharacterEncoding("UTF-8");
	String paramSd = request.getParameter("start_date");
	String paramEd = request.getParameter("end_date");
	String paramAdult = request.getParameter("adult");
	String paramChild = request.getParameter("child");
	String[] paramRoomNo = request.getParameterValues("rev_room_num");

	// 박 수 구하기
	Date sdFormat = new SimpleDateFormat("yyyy.MM.dd").parse(paramSd);
	Date edFormat = new SimpleDateFormat("yyyy.MM.dd").parse(paramEd);
	long diffDays = (edFormat.getTime() - sdFormat.getTime() )/1000/(24*60*60);
		
%>

<div class="wrapper">
<jsp:include page="../../main/main_header_nav.jsp"/>
	<br/><br/><br/><br/><br/><br/>
		
		<div style="width: 1130px; text-align: center; margin: 0px auto">
 		 <input type="button" id = "roomIntroBtn" value="객실소개"  style="width: 100px;">	
  			&nbsp;	&nbsp; 	&nbsp;
 		 <input type="button" id = "roomReserBtn" value="객실예약"  style="width: 100px;" >
 		 <br/><br/>
  		<hr class = "hr1">
  		<table style = "width: 900px; margin: 0px auto">
  		<tr style = "width: 1000px; height: 50px">
  		<td style = "width: 50px;">
  		<img style = "width: 30px" src = "http://team3.aws.sist.co.kr/main/main_images/cal_icon.png"/>
  		</td>
  		<td style = " width: 400px; font-size: 18px; font-weight: bold">
  		&nbsp;&nbsp;<%=paramSd %>&nbsp;-&nbsp;<%= paramEd %>&nbsp;(<%=diffDays %>박)
  		</td>
  		<td style = "font-size: 18px; font-weight: bold">
  		성인&nbsp;&nbsp;<%=paramAdult %>&nbsp;&nbsp;&nbsp;&nbsp;어린이&nbsp;&nbsp;<%= paramChild %> 
  		</td>
  		</tr>
  		</table>
  		<hr class = "hr1">
  		</div>
		<br/><br/><br/>
	<div id = "info">
	

	
	</div>	
		
	<div id = "big" style = "width:1000px; margin: 0px auto">
	<%
	RoomSelect rs=new RoomSelect();
	
	RoomVO tempRoom=null;
	
	for(int i= 0 ; i <paramRoomNo.length ; i++){
		tempRoom = rs.selectRoomInfo(Integer.parseInt( paramRoomNo[i]));
		pageContext.setAttribute("searchRoom", tempRoom);
	
	String Hroom = paramRoomNo[i];
	String btnId = "detail"+Hroom;
	String viewId = "divView"+Hroom;
	String priceId = "price"+Hroom;
	
	%>
	
	<div style="width: 1000px; margin: 0px auto;">
		<table style="width: 1000px;">
			<tr>
				<td style="width: 252px;" rowspan="2">
				<img src="http://team3.aws.sist.co.kr/roomImages/${searchRoom.main_img }"
					style="width: 270px; height: 187px;">
				</td>
				<td style="height: 120px;"><br><br><br>
				<div id = "roomName">${ searchRoom.r_name }</div>
				<input type="button" onclick = "divPlaying( '<%= viewId %>','<%= btnId %>' )" id="<%= btnId %>" value="detail" class="btn" style="margin-left: 20px;"/>
				<hr/>
				</td>
			</tr>
			<tr>
				<td style="height: 87px;">&nbsp;&nbsp; 전망 ${ searchRoom.r_view }| 객실면적 ${searchRoom.r_size }<br/>
				
				<br><br><br><br>
			</tr>
			
		</table>
		<div id="<%=viewId %>"  style = "display: none">${ searchRoom.description }</div><br/>
		<input type="button" class="button" id="<%= priceId%>" style="float: right;" 
			value="<fmt:formatNumber pattern = "#,###,###" value = "${ searchRoom.price }" /> KRW"
 			onclick="roomDetail('<%= Hroom %>','<%=paramSd %>','<%=paramEd %>','<%=paramAdult %>','<%=paramChild %>')">
	</div>
	
	
	
	
	<% 
	 Hroom = "";
	btnId = "";
	viewId = "";
	}//end for %>

	<br><br><br><br>
	<hr class = "hr1">
	
	<form name="frm" id="hiddenFrm" action="http://team3.aws.sist.co.kr/user/reser_room/reservation2.jsp" method = "post">
	 <input type="hidden" id="Room_no" name = "room_no"/>
	 <input type="hidden" id="Sd" name="sd"/>
	 <input type="hidden" id="Ed"  name="ed"/>
	 <input type="hidden" id="Adult" name="adult" />
	 <input type="hidden" id="Child" name="child"/>
	</form>
	
	</div>


	<br /><br /><br /><br /><br />
	<div style="width: 1000px; margin: 0px auto; text-align: center;">
		<input type="button" id = "goHome" style="width: 100px;" value="홈으로">
	</div>
	<br /><br /><br /><br /><br /><br /><br />
	<!-- FOOTER -->
	<jsp:include page="../../main/main_footer.jsp"/>
</div>
	<!--================================================== -->

	<script
		src="http://team3.aws.sist.co.kr/jsp_prj/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
