<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.sist.user.images.ImagesVO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="kr.co.sist.user.images.ImageCount"%>
<%@page import="kr.co.sist.admin.room.OtherImgVO"%>
<%@page import="kr.co.sist.admin.room.RoomVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	

<style type="text/css">
.hr1 {border-bottom: 1px solid #d3d3d3; }

.roomImgList {width: 720px; height: 405px;}
.roomName {font-size: 25px; font-weight: bold; color: #5A5A5A; margin: 0px auto; text-align: center;}
.roomBox { width: 1000px; height: 1000px; color: #5A5A5A; margin: 0px auto; text-align: center;}
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

/*
div { border: 1px solid #FF0000}
td { border: 1px solid #FF0000}
tr { border: 1px solid #FF0000}
*/

#remoCon {
	position: fixed;
	right: 45px;
	top : 200px;
	display: none;
	color: #5A5A5A;
 } 

#remoConTd{
	padding:15px;
	hegiht: 50px;
	border:1px solid #d3d3d3;
	font-size: 15px;
	font-weight:bold;
	color: #5A5A5A;
}

#subTd{
	padding:8px;
	width:150px;
	hegiht: 40px;
	border:1px solid #d3d3d3;
	font-size: 13px;
	font-weight:bold;
	color: #FFFFFF;
	text-align: center;
	background-color: #2F2F2F; 
}

#remoConTd:hover{
	cursor: pointer;
	background-color: #FCF4C0
}

#targetA{
	text-decoration : none;
	color: #FFFFFF;
}

#eachRoom{
	font-size: 13px;
	color: #5A5A5A;
}

.height_fix {
    margin-top: -100px;
    padding-top: 100px;
}


#roomReserBtn:hover {
	background-color: #FCF4C0  ;
	color: #333;
	cursor: pointer;
}

#roomReserBtn {
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


#roomIntroBtn {
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


#roomIntroBtn:hover {
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

<script type="text/javascript">
$(function(){
	$("#roomIntroBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_intro.jsp";
	})//table click
	
	$("#roomReserBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/reser_room/room_date.jsp";
	})//table click

	//리모콘 이벤트
	$(document).scroll(function(){
		var con = $("#remoCon");
		var position = $(window).scrollTop();

		if(position > 400 ){ con.fadeIn(500); }
		if(position < 400 ){ con.fadeOut(500); }
	 });

}); //ready

</script>

</head>

<!-- NAVBAR
================================================== -->
<body>
	<div class="wrapper">
		<!-- header/navibar import -->
		<c:import url="http://team3.aws.sist.co.kr/main/main_header_nav.jsp" />
		
		<br/><br/><br/><br/><br/><br/>
		
		<div style="width: 1130px; text-align: center; margin: 0px auto">
 		 <input type="button" id = "roomIntroBtn" value="객실소개"  style="width: 100px;">	
  			&nbsp;	&nbsp; 	&nbsp;
 		 <input type="button" id = "roomReserBtn" value="객실예약"  style="width: 100px;" ><br/><br/>
  		<hr class = "hr1">
  		</div>
  		<br/><br/><br/><br/>
		
		
		<%
		//전 객실 조회
		RoomSelect rs = new RoomSelect();
		List<RoomVO> roomList = rs.selectRoomInfo(null, "Y"); // 활성화된 방만 조회
		pageContext.setAttribute("roomList", roomList);
		pageContext.setAttribute("newLineChar", "\n");
		
		//기타 이미지 조회
		List<List<OtherImgVO>> imgVOList = new ArrayList<List<OtherImgVO>>();
		List<OtherImgVO> list = null; //객실별 조회할 거 
		List<Integer> cnt = new ArrayList<Integer>(); //객실당 이미지 개수
		for(RoomVO rVO : roomList){
			list = new ArrayList<OtherImgVO>();
			list = (rs.selectOtherImg(rVO.getRoomName()));
			cnt.add(Integer.valueOf(list.size()));
			imgVOList.add(list);
		}//end for
		pageContext.setAttribute("imgVOList", imgVOList);
		%>
		
		<% int i =0; %>
		<c:forEach var="room" items="${roomList}"> 
		<span id="target<%=i+1%>" class="height_fix"></span><br/><br/>
		<div class ="roomName" ><c:out value="${room.roomName}"/></div><br/>
		<!-- Carousel
    ================================================== -->
		<div id="myCarousel_<%=i %>" class="carousel slide" data-ride="carousel" style="width: 1000px; margin: 0px auto;">
			
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel_<%=i %>" data-slide-to="0" class="active"></li>
				<c:forEach var = "i" begin = "1" end = "<%=cnt.get(i) %>" step = "1">
					<li data-target="#myCarousel_<%=i %>" data-slide-to= "<%=cnt.get(i) %>"></li>
				</c:forEach>
			</ol>
			
			<!-- carousel-inner -->
			<div class="carousel-inner" role="listbox">
							<!-- 메인이미지 -->
				<div class="item active" style = "width: 1000px">
					<img class="first-slide" 
						src="http://team3.aws.sist.co.kr/roomImages/${room.img}"
						alt="mainImg">
				</div>
				
				<!-- 기타이미지 -->
				<%int j = 0; %>				
				<c:forEach var="eachList" items="${imgVOList}">
				<%if(j==i){ %>
				<c:forEach var="imgVO" items="${eachList}">
				<div class="item" style = "width: 1000px">
					<img 
						src="http://team3.aws.sist.co.kr/roomImages/${imgVO.imgSrc}"
						alt="otherImgs">
				</div>
				</c:forEach>
				<%}//end if
					j++;%>
				</c:forEach>	
			</div> 
			
			<!-- carousel control -->
			<a class="left carousel-control" href="#myCarousel_<%=i %>" role="button"
				data-slide="prev" > <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="right carousel-control" href="#myCarousel_<%=i %>" role="button"
				data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
			
		</div> 
		
		<!-- /.carousel -->
		<br/><br/>

		<!--================================================== -->

		<div class = "roomBox">
			<div class = "roomDesc">
			${fn:replace(room.mainDesc, newLineChar,"<br>")}
			</div><br/><br/>
			<table class = "roomSumm">
			<tr>
			<td id =  "summTitle">객실개요</td>
			<td>
				<table class = "summSubTab">
				<tr>
				<th class = "summSubTh">침대타입</th>
				<td class = "summSubTd"><c:out value="${room.type}"/></td>
				<th class = "summSubTh">투숙인원</th>
				<td class = "summSubTd"><c:out value="${room.guestNum}"/>명</td>
				<th class = "summSubTh">전망</th>
				<td class = "summSubTd"><c:out value="${room.view}"/></td>
				</tr>
				<tr>
				<th class = "summSubTh">객실면적</th>
				<td class = "summSubTd"><c:out value="${room.roomSize}"/>m<sup>2</sup></td>
				<th class = "summSubTh">체크인/체크아웃</th>
				<td class = "summSubTd"><c:out value="${room.chkIn}"/> / <c:out value="${room.chkOut}"/></td>
				<th></th>
				<td></td>
				</tr>
				</table>
			</td>
			</tr>
			</table><br/><br/>
			
			<div class = "guideC">
				<div class = "guideTitle"> 특별서비스 </div>
				<div class = "guideText">
				• ${fn:replace(room.specialServ, newLineChar,"<br>• ")}
				</div>
			</div><br/>
			<hr class = "hr1"><br/>
			<div class = "guide">
				<div class = "guideTitle"> 어메니티 </div>
				<table id = "amntTab">
				<tr>
				<th class = "amntTh">일반</th>
				<td class = "amntTd"><c:out value="${room.generalAmn}"/></td>
				</tr>
				<tr>
				<th class = "amntTh">욕실</th>
				<td class = "amntTd"><c:out value="${room.bathAmn}"/></td>
				</tr>
				<tr>
				<th class = "amntTh">기타</th>
				<td class = "amntTd"><c:out value="${room.otherAmn}"/></td>
				</tr>
				</table>
			</div>
			<hr class = "hr1"><br/>
			
			<div class = "guideC">
				<div class = "guideTitle"> 추가정보 </div>
				<div class = "guideText">
				• ${fn:replace(room.moreInfo, newLineChar,"<br>• ")}
				</div>
			</div><br/>
				
			</div><!-- roomBox -->
			<% i++;%>
			
			<br/><br/>
			<% if( i != roomList.size()){ %>
				<hr class = "hr1"><br/><br/><br/>
			<%}//end if %>
			</c:forEach> <!-- end for roomList -->
			
			<br/><br/><br/><br/>

			<!-- footer import -->
			<c:import url="http://team3.aws.sist.co.kr/main/main_footer.jsp" />

		<!-- 객실 리모콘 -->
		<table id="remoCon">
		<tr>
		<td id="subTd"> 리모콘 </td>
		</tr>
		<c:forEach var="room" items="${roomList}">
		<c:set var="num" value="${num+1}"/> 
		<tr>
		<td id="remoConTd"><a href="http://team3.aws.sist.co.kr/user/reser_room/room_intro.jsp?#target${num}" id="targetA">
		<span id="eachRoom">${room.roomName}</span></a></td>
		</tr>
		</c:forEach>
		<tr>
		<td id="subTd" onclick="event.cancelBubble=true" style="cursor:pointer"> <span onclick="window.scrollTo(0,0);"> 상단으로 이동</span> </td>
		</tr>
		</table>

		</div><!-- wrap -->
		
		
    <!-- ================================================== -->

		<script
			src="http://team3.aws.sist.co.kr/jsp_prj/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
