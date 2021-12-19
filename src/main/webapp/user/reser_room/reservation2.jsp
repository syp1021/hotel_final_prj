<%@page import="kr.co.sist.admin.member.Admin_Decription"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.sist.user.images.ImageCount"%>
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

.roomName {font-size: 25px; font-weight: bold; color: #5A5A5A; margin: 0px auto; text-align: center;}
.roomBox { width: 1000px; height: 1400px; color: #5A5A5A; margin: 0px auto; text-align: center;}
.roomDesc {width: 1000px; color: #5A5A5A; margin: 0px auto; text-align: center; }

.roomSumm {width: 1000px; height: 150px;color: #5A5A5A;; font-size: 15px; 
			border-bottom: 1px solid #d3d3d3; border-top: 1px solid #d3d3d3;  }
 
#summTitle {width: 200px; color: #5A5A5A; font-size: 18px;  font-weight: bold;}
.summSubTab{width: 800px; color: #5A5A5A; font-size: 15px; table-layout: fixed;}
.summSubTd { padding: 10px; text-align: left;}
.summSubTh { width: 130px; padding: 5px; text-align: left;}

.summSubTab tr { border: none}

.guide {width: 1000px; height: 210px;color: #5A5A5A;; font-size: 15px;}
.guideTitle {width: 1000px; height: 40px;color: #5A5A5A;; font-size: 19px; font-weight: bold;
				text-align: left; padding-left: 20px}
.guideText {width: 1000px; color: #5A5A5A;; font-size: 15px; text-align: left; padding-left: 20px;}				
				
#amntTab {width: 1000px; height: 130px;color: #5A5A5A;; font-size: 15px;  }
.amntTh {padding-left: 20px; width: 80px}
.amntTd {text-align: left;}

.guideC {width: 1000px; height: 150px;color: #5A5A5A;; font-size: 15px;}
.guideP {width: 1000px; height: 170px;color: #5A5A5A;; font-size: 15px;}
.guideR {width: 1000px; height: 400px;color: #5A5A5A;; font-size: 15px; }

#confirmDiv {width: 960px; height: 350px; border: 1px solid #5a5a5a; padding: 30px}
#confirmTab {width: 900px; height: 290px; table-layout: fixed;}

#confirmPaper {width: 400px; height: 290px; background-color: #F0F0F0; float: right;
				padding: 30px}

#addReq {width: 450px; height: 120px;}

#checkRname {color: #333; font-size: 17px; font-weight: bold; text-align: left;}
#checkAdult {color: #5a5a5a; font-size: 17px; text-align: left;}

.chkPaperLeft {color: #333; font-size: 15px; font-weight: bold; text-align: left; float: left}
.chkPaperRight {color: #333; font-size: 15px; font-weight: bold; text-align: left;  float: right}

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

#resBtn {
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

#resBtn:hover {
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

<link href="http://team3.aws.sist.co.kr/common/bootstrap/carousel.css"
	rel="stylesheet">
	
<script type="text/javascript">
$(function(){
	$("#resBtn").click(function(){
		 //해당 방번호를 결제 페이지로
		/* $("#room_no").val();  */
		
		("#frmRes").submit();
		
	})//table click
	
}); //ready



</script>

</head>

<!-- NAVBAR
================================================== -->
<body>


<%
	request.setCharacterEncoding("UTF-8");


	String paramSd = request.getParameter("sd");
	
	String paramEd = request.getParameter("ed");
	String paramAdult = request.getParameter("adult");
	String paramChild = request.getParameter("child");	
	String paramRoomNo = request.getParameter("room_no");
	int room_no = Integer.parseInt( paramRoomNo );
	
	// 박 수 구하기
	Date sdFormat = new SimpleDateFormat("yyyy.MM.dd").parse(paramSd);
	Date edFormat = new SimpleDateFormat("yyyy.MM.dd").parse(paramEd);
	long diffDays = (edFormat.getTime() - sdFormat.getTime() )/1000/(24*60*60);
	
	RoomSelect rs = new RoomSelect();
	RoomVO rv = rs.selectRoomInfo(room_no);
	
	//
	String paramCount = request.getParameter("room_no");
	int count = Integer.parseInt( paramCount );
	
	//룸당 등록된 사진의 갯수 
	ImageCount ic = new ImageCount();
	int cnt = ic.selectCountImg(count);
	pageContext.setAttribute("imgs", ic.selectImages(room_no));
%>
	
	

	<div class="wrapper">
		<!-- header/navibar import -->
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
		
		<br/><br/>
		<div class ="roomName"><%= rv.getR_name()%></div><br/>
		

		<!-- Carousel
    ================================================== -->
		<div id="myCarousel" class="carousel slide" data-ride="carousel"
			style="width: 1000px; margin: 0px auto;">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				
				<c:forEach var = "i" begin = "1" end = "<%=cnt %>" step = "1">
				<li data-target="#myCarousel" data-slide-to= <%= cnt %>"></li>
				
				</c:forEach>
			</ol>
			<div class="carousel-inner" role="listbox">
			
				
				 <div class="item active">
					<img class="first-slide"
						src="http://team3.aws.sist.co.kr/roomImages/<%= rv.getMain_img() %>"
						>
					<div class="container">
						<div class="carousel-caption"></div>
					</div>
				</div>
				 
				<!-- 룸의 images table에 등록된 이미지의 숫자만큼 반복하여 캐러셀 만듦 -->
				<c:forEach var = "img" items = "${ imgs }">
				<div class="item ">
					<img  
						src="http://team3.aws.sist.co.kr/roomImages/<c:out value = "${ img.img_src }"/>"
						>
					<div class="container">
						<div class="carousel-caption"></div>
					</div>
				</div>
				</c:forEach>
			</div>
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		<!-- /.carousel -->
		<br/><br/>

		<!--================================================== -->

		<div class = "roomBox">
			<div class = "roomDesc">
			
			<%= rv.getDescription()%>
			
			</div><br/><br/>
			<table class = "roomSumm">
			<tr>
			<td id =  "summTitle">객실개요</td>
			<td>
				<table class = "summSubTab">
				<tr>
				<th class = "summSubTh">침대타입</th>
				<td class = "summSubTd"><%= rv.getBed_type() %></td>
				<th class = "summSubTh">투숙인원</th>
				<td class = "summSubTd"><%= rv.getMax_guest() %></td>
				<th class = "summSubTh">전망</th>
				<td class = "summSubTd"><%= rv.getR_view() %></td>
				</tr>
				<tr>
				<th class = "summSubTh">객실면적(㎡)</th>
				<td class = "summSubTd"><%= rv.getR_size() %></td>
				<th class = "summSubTh">체크인/체크아웃</th>
				<td class = "summSubTd"><%= rv.getChkin_time() %>/<%= rv.getChkout_time() %></td>
				<th></th>
				<td></td>
				</tr>
				</table>
			</td>
			</tr>
			</table><br/><br/><br/>
			<div class = "guide">
				<div class = "guideTitle"> 어메니티 </div>
				<table id = "amntTab">
				<tr>
				<th class = "amntTh">일반</th>
				<td class = "amntTd"><%= rv.getAmnt_gen() %></td>
				</tr>
				<tr>
				<th class = "amntTh">욕실</th>
				<td class = "amntTd"><%= rv.getAmnt_bath() %></td>
				</tr>
				<tr>
				<th class = "amntTh">기타</th>
				<td class = "amntTd"><%= rv.getAmnt_other() %></td>
				</tr>
				</table>
			</div>
			<hr class = "hr1"><br/>
			
			<div class = "guideC">
				<div class = "guideTitle"> 취소규정 </div>
				<div class = "guideText">
				ㆍ 상기 홈페이지 요금은 정상가로 할인은 불가능합니다. <br/>
				ㆍ 예약 취소 및 변경은 체크인 하루 전 18 : 00(한국시간)까지 가능합니다. <br/>
				ㆍ 예약하신 일자에 체크인 되지 않거나 또는 위의 지정 시간 이후에 예약을 취소했을 경우에는 예약 사항에 대해 노-쇼 (No-Show)처리 되며, <br/>
					&nbsp;&nbsp;&nbsp;&nbsp; 이에 따른 위약금으로 예약 첫날에 해당하는 1박 객실요금이 청구되오니 유의하시기 바랍니다. 
				</div>
			</div><br/>
			<hr class = "hr1"><br/>
			
			<form name = "frmRes" method = "post" id = "frmRes" action = "http://team3.aws.sist.co.kr/user/reser_room/reservation3_card.jsp">
				<input type="hidden" name="room_no" id="room_no" value = "${param.room_no}"/>
				 <input type="hidden" id="Sd" name="sd" value = "<%=paramSd %>"/>
				 <input type="hidden" id="Ed"  name="ed" value = "<%=paramEd %>"/>
				 <input type="hidden" id="Adult" name="adult" value = "<%=paramAdult %>"/>
				 <input type="hidden" id="Child" name="child" value = "<%=paramChild %>"/>
				 <input type="hidden" id="diffDays" name="diffDays" value = "<%=diffDays %>"/>
				 
				
			<div class = "guideR">
			<div class = "guideTitle"> 예약 옵션 </div>
			<div id = "confirmDiv">
			<table id = "confirmTab">
				<tr>
				<td>
				<p id = "checkRname">객실 no_${ param.room_no }&nbsp;&nbsp;<%= rv.getR_name()%></p>
				<p id = "checkAdult">투숙인원 : 성인 <%=paramAdult %>명, 어린이 <%=paramChild %>명</p>
				<br/><br/><br/>
				<p id = "checkRname">추가요청</p>
				 <textarea id="addReq" name="addReq" rows="5" cols="80" placeholder="예시) 추가 배드를 요청합니다." style = "resize: none"></textarea>
				</td>
				<td>
				<div id = "confirmPaper">
				<br/>
				<%
				int price = rv.getPrice();
				pageContext.setAttribute("price", price);
				
				int tax = (int)(rv.getPrice()*0.21);
				pageContext.setAttribute("tax", tax);
				
				int totalP = (int)(rv.getPrice()+tax);
				pageContext.setAttribute("totalP", totalP);
				
				int daysPrice = price*(int)diffDays;
				pageContext.setAttribute("daysP", daysPrice);

				int daysTax = tax*(int)diffDays;
				pageContext.setAttribute("daysTax", daysTax);
				
				int daysTotal = (daysPrice + daysTax);
				pageContext.setAttribute("daysTotal", daysTotal);
				
				%>
				<span class = "chkPaperLeft">객실 요금 (1박 기준)</span>
				<span class = "chkPaperRight"><fmt:formatNumber pattern = "#,###,###" value = "${ price }"/>&nbsp;KRW</span><br/><br/>
				<span class = "chkPaperLeft"><%=paramSd %>&nbsp;( <%=diffDays %>박)</span>
				<span class = "chkPaperRight"><fmt:formatNumber pattern = "#,###,###" value = "${ daysP }"/>&nbsp;KRW  </span><br/><br/><br/>
				
				<span class = "chkPaperLeft">세금 및 봉사료</span>
				<span class = "chkPaperRight"><fmt:formatNumber pattern = "#,###,###" value = "${ daysTax }"/>&nbsp;KRW </span><br/>
				<hr class = "hr1">
				
				<span class = "chkPaperLeft">총 요금</span>
				<span class = "chkPaperRight"><fmt:formatNumber pattern = "#,###,###" value = "${ daysTotal }"/> &nbsp;KRW </span><br/>
				</div>
				</td>
				</tr>
			</table>
			</div>
			</div><br/>
			<hr class = "hr1"><br/>
			 <button type="submit" id = "resBtn">예약하기</button>
			</form>
			 			
			</div><!-- roomBox -->
			
			<br/><br/>

			<!-- footer import -->
		<jsp:include page="../../main/main_footer.jsp"/>
		</div><!-- wrapper -->
		

		
    <!-- ================================================== -->

		<script
			src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
	
</body>
</html>
