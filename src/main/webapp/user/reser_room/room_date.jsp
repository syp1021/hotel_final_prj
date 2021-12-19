<%@page import="kr.co.sist.user.images.ImageCount"%>
<%@page import="kr.co.sist.uesr.room.RoomVO"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

#btn {
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

#btn:hover {
	background-color: #F5dF4D;
	color: #000000;
	cursor: pointer;
}


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

/*
div { border: 1px solid #FF0000}
td { border: 1px solid #FFFF00}
tr { border: 1px solid #FFFF00}
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
<!--  zebra_datepicker -->
<script src="http://team3.aws.sist.co.kr/common/zebra_datepicker/zebra_datepicker.min.js"></script>
<link rel="stylesheet" href="http://team3.aws.sist.co.kr/common/zebra_datepicker/css/default/zebra_datepicker.min.css">

<script type="text/javascript">

<%--  function loginChk(){
	var userId = '<%=(String)session.getAttribute("id") %>';
	if(userId == "null"){
		alert("예약은 로그인 후 가능합니다. ")
		location.href = "http://team3.aws.sist.co.kr/user/login/login.jsp";
		return;
	}//endif
}//loginChk --%>

$(function(){
	$('#datepicker-range-start').Zebra_DatePicker({
	    direction: true,
	    showDropdowns : true,
	    default_position: 'below',
 pair: $('#datepicker-range-end'),

	    format: 'Y.m.d'
	});
	 
	$('#datepicker-range-end').Zebra_DatePicker({
	    direction: 1,
	    showDropdowns : true,
	    default_position: 'below',
	    format: 'Y.m.d'
	});
	
	
	$("#btn").click(function(){
		 let sd=$("#datepicker-range-start").val();
		 let ed=$("#datepicker-range-end").val();
		 let adult = $("#adult").val(); 
		 let child = $("#child").val();
		 
		 var userId = '<%=(String)session.getAttribute("id") %>';
			if(userId == "null"){
				alert("예약은 로그인 후 가능합니다. ")
				location.href = "http://team3.aws.sist.co.kr/user/login/login.jsp";
				return;
			}//endif

		 
		  if( (Number(adult) + Number(child)) > 4 ){
			 alert("어린이를 동반한 수용 가능한 최대 인원수는 4명입니다. ");
			 return;
		 }//end if 
		 
		   if ( !sd || !ed ){
			 alert("원하시는 예약 날짜를 선택해주세요.");
			 return;
		 }//end if   
		 
		 if ( sd == ed ){
			 alert("체크인 날짜와 체크아웃 날짜는 달라야 합니다.");
			 return;
		 }//end if
		 
		//alert(sd +"  / " +ed + " / " + " / " + Number(adult) + " / " + Number(child) + " / " + (Number(adult) + Number(child)));
	 
		 let queryString = "start_date="+sd+"&end_date="+ed+"&adult="+adult+"&child="+child;
		
		 $.ajax({
			 url:"http://team3.aws.sist.co.kr/user/reser_room/ajax_room_date.jsp",
			 type:"post",
			 data:queryString,
			 dataType:"json",
			 error:function(xhr){
				 console.log("에러코드:" + xhr.status + "/ 에러메시지" + xhr.statusText);
				},
			 success: function(jsonObj){
				//단일데이터
				if(!jsonObj.dataResult){
				//복합데이터
				alert("선택하신 날짜 : " + jsonObj.searchStartDate+ " ~ " + jsonObj.searchEndDate+
						"\n선택하신 인원수 ( 성인 : " + jsonObj.adultCnt + " 어린이 : " + jsonObj.childCnt +" ) \n예약가능한 방이 없습니다."
					);
							
				return;
				}//end if
				
				
				//조회 데이터 (JSONArray) 보여주기
				let param="start_date="+sd+"&end_date="+ed+"&adult="+adult+"&child="+child+"&";
				
				$.each(jsonObj.data,function(idx,temp){
					param += "rev_room_num="+temp.room_no+"&";
				//요기서 디자인하기
				});//each
				
				location.href="http://team3.aws.sist.co.kr/user/reser_room/room_reserve.jsp?"+param;
		
			 }//success
			 
		 });//end ajax
		
		 
	});//click
	
	$("#roomIntroBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_intro.jsp";
	})//table click
	
	$("#roomReserBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_date.jsp";
	})//table click
	
	
});//ready

</script>

</head>

<!-- NAVBAR
================================================== -->
<body>
<%
 String userId = (String)session.getAttribute("id");
pageContext.setAttribute("userId", userId);
%>

	<jsp:include page="../../main/main_header_nav.jsp"/>
	<div class="wrapper" style = "text-align: center">
		<!-- header/navibar import -->
		<br/><br/><br/><br/><br/><br/>
		
		<div style="width: 1130px; text-align: center; margin: 0px auto">
 		 <input type="button" id = "roomIntroBtn" value="객실소개"  style="width: 100px;">	
  			&nbsp;	&nbsp; 	&nbsp;
 		 <input type="button" id = "roomReserBtn" value="객실예약"  style="width: 100px;" >
 		 <br/><br/>
  		<hr class = "hr1">
  		</div><br/>
  		
		<br/>
		
		<form name = "dateFrm" id = "dateFrm" method = "get" action = "room_reserve.jsp">
		<div style = "width: 800px; margin: 0px auto">
		<div style = "width: 500px;  margin: 0px auto">
		
		<c:if test = "${ not empty userId }">
		<span style = "font-size: 18px"><strong> <c:out value = "${userId}" /></strong></span>님 반갑습니다.<br/>
		원하시는 날짜와 인원을 선택해주세요. <br/>
		</c:if>
		
		<c:if test = "${ empty userId }">
		
		원하시는 날짜와 인원을 선택해주세요. <br/>
		</c:if>
		
		</div><br/><br/>
		
		<table style = " margin: 0px auto">
		<tr >
			<td  style = "width: 120px; height: 30px; font-size: 18px; font-weight: bold">
			성인
			</td>
			<td  style = "width: 120px;  font-size: 17px; font-weight: bold">
			<input type = "number" id = "adult" name = "adult" min = "1" max = "4"/>
			</td>
			<td style = "width: 100px; ">
			</td>
			<td  style = "width: 120px;  font-size: 18px; font-weight: bold">
			어린이
			</td>
			<td  style = "width: 140px;  font-size: 17px; font-weight: bold">
			<input type = "number" id = "child" name = "child" min = "0" max = "3"/>
			</td>
		</tr>
		
		</table><br/>
		
		<br/>
		<hr class = "hr1">
		<br/>
		</div>
		
		
		<table style=" margin: 0px auto" >
		<tr >
			<td style = "width: 300px; height: 60px;  font-size: 16px; font-weight: bold">
			체크인<br/> 
			<span class="Zebra_DatePicker_Icon_Wrapper"
				style=" width: 300px;"> <input
				id="datepicker-range-start" type="text" class="form-control"
				data-zdp_readonly_element="false"
				style="position: relative; float: none; inset: auto; margin: 0px; margin-top: 10px"></span>
			</td>
			
			<td style = "width: 80px"></td>
			
			<td  style = "width: 300px; height: 60px;  font-size: 16px; font-weight: bold">
			체크아웃<br/>
			<span class="Zebra_DatePicker_Icon_Wrapper"
				style=" width: 300px;"> <input
				id="datepicker-range-end" type="text" class="form-control"
				data-zdp_readonly_element="false"
				style="position: relative; float: none; inset: auto; margin: 0px;  margin-top: 10px "></span>
			</td>

			</tr>
			</table>
			<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
			<input type="button"  value="조회" id="btn" />
			</form>
<!--  -->






	

	</div><!-- wrapper -->
	<br />
	<br />

	<!-- footer import -->
	<jsp:include page="../../main/main_footer.jsp"/>





	<!-- ================================================== -->

	<script
		src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
