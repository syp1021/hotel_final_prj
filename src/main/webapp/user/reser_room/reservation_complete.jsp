<%@page import="kr.co.sist.user.member.User_Decryption"%>
<%@page import="kr.co.sist.user.card.ModifyCard"%>
<%@page import="kr.co.sist.user.reservation.ReservationInsert"%>
<%@page import="kr.co.sist.user.reservation.ReservationVO"%>
<%@page import="kr.co.sist.user.card.CardVO"%>
<%@page import="kr.co.sist.user.card.InsertCard"%>
<%@page import="kr.co.sist.user.member.MemberVO"%>
<%@page import="kr.co.sist.user.member.MemberSelect"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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

#resConf {width: 1000px; height: 60px; font-size: 20px; font-weight: bold}
.resChk { width: 1000px; height: 1800px; color: #5A5A5A; margin: 0px auto; text-align: center;}

.chkDiv {width: 1000px; color: #5A5A5A; margin: 0px auto; text-align: center; }
.chkTab {width: 1000px; height: 450px; color: #5A5A5A; text-align: left; margin: 0px auto; table-layout: fixed;
		}


.guide {font-size: 17px; font-weight: bold; padding-left: 20px; }				
.guideText {font-size: 15px; }				

#chkSubTab {width: 500px; border: 1px solid #d3d3d3;}
.guideTextP {font-size: 15px; padding-left: 20px; padding-top: 10px; padding-bottom: 10px}				
.guideTextPR {font-size: 15px;  padding-right: 20px; padding-top: 10px; padding-bottom: 10px; float: right; font-weight: bold}				

.total {width: 1000px; height: 70px; font-size: 20px; font-weight: bold; color: #333; table-layout: fixed;}

.guideDiv {width: 1000px; height: 300px; /* border: 10px solid #FFFF00 */}
.guideTitle {width: 1000px; height: 40px;color: #333;; font-size: 20px; font-weight: bold;
				text-align: left;}
.back {width: 1000px; height: 200px; background-color: #FAFAFA; padding: 50px}
.backTab {width: 900px; height: 100px; margin: 0px auto; table-layout: fixed;}


#goHomeBtn {
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

#goHomeBtn:hover {
	background-color: #F5dF4D;
	color: #000000;
	cursor: pointer;
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
	



<!-- daum map -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4770be2574c85940d843f0c412764fd2"></script>

<script>
$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.51271451389996, 127.10252419812018), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.51271451389996, 127.10252419812018); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;"><strong>Hotel Ritz Seoul</strong> <br><a href="https://map.kakao.com/link/map/Hotel Ritz Seoul,37.51271451389996, 127.10252419812018" style="color:#333" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hotel Ritz Seoul,37.51271451389996, 127.10252419812018" style="color:#333" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new kakao.maps.LatLng(37.51271451389996, 127.10252419812018); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 

});//end ready
</script>

<script type="text/javascript">
$(function(){
	$("#goHomeBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp";
	})//table click
	
}); //ready

</script>	
	
</head>

<!-- NAVBAR
================================================== -->
<body>

<%
request.setCharacterEncoding("UTF-8");
//예약정보 파라메터 받기
String paramSd = request.getParameter("sd");
String paramEd = request.getParameter("ed");
String paramAdult = request.getParameter("adult");
String paramChild = request.getParameter("child");	
String addReq = request.getParameter("addReq"); 
String strResNo = request.getParameter("resNo"); 
String DiffDays = request.getParameter("diffDays");
String paramRoomNo = request.getParameter("room_no");
int room_no = Integer.parseInt( paramRoomNo );
int diffDays = Integer.parseInt( DiffDays );
int adult = Integer.parseInt( paramAdult );

int child = 0;
if (paramChild == ""){
	child = 0;
}else {
	child = Integer.parseInt( paramChild );
}

//카드정보 파라메터 받아오기
String card_no = request.getParameter("card_no");
String cardCompany = request.getParameter("cardCompany");
String val_MM = request.getParameter("val_MM");
String val_YY = request.getParameter("val_YY");
String paramCardSave = request.getParameter("saveYN");
String paramCcAgree = request.getParameter("ccYN");
String paramPiAgree = request.getParameter("piYN");
String saveFlag = request.getParameter("saveFlag"); //기존 카드저장정보가 있는 사용자의 flag=0

// 룸넘버로 룸정보 조회
RoomSelect rs = new RoomSelect();
RoomVO rv = rs.selectRoomInfo(room_no);  

//id로 회원정보 조회
String id = (String)session.getAttribute("id");


//사용자정보 복호화
User_Decryption ud = new User_Decryption();
MemberVO mv = ud.DecryptSelectMemInfo(id);



//  예약 insert
ReservationVO rsVO = new ReservationVO();
rsVO.setRes_no(strResNo);
rsVO.setId(id);
rsVO.setRoom_no(room_no);
rsVO.setAdult(adult);
rsVO.setChild(child);
rsVO.setChkin_date(paramSd);
rsVO.setChkout_date(paramEd);
rsVO.setAdd_req(addReq);
rsVO.setCc_agree(paramCcAgree);
rsVO.setPi_agree(paramPiAgree);
rsVO.setCard_no(card_no);
rsVO.setCompany(cardCompany);

// 예약 insert
ReservationInsert resInsert = new ReservationInsert();
int cnt = resInsert.insertRes(rsVO);
pageContext.setAttribute("cnt", cnt);



// 카드저장을 체크한, 기존 카드정보가 없는 사용자
if ( paramCardSave.equals("Y") && saveFlag.equals("0")){
 // 카드정보 insert
 
CardVO cardVO = new CardVO();
cardVO.setCard_no(card_no);
cardVO.setCompany(cardCompany);
cardVO.setId(id);
cardVO.setRes_no(strResNo);
cardVO.setVal_mm(val_MM);
cardVO.setVal_yy(val_YY);
 
InsertCard icard = new InsertCard();
icard.insertCard(cardVO);

 System.out.println("------카드추가-------------"+saveFlag);
}//end if


// 카드저장을 체크한, 기존 카드정보가 있는 사용자
if ( paramCardSave.equals("Y") && !saveFlag.equals("0")){
 // 카드정보 변경
 CardVO cVO = new CardVO();
 cVO.setCard_no(card_no);
 cVO.setId(id);
 System.out.println("------카드변경-------------"+cVO);
  
 ModifyCard mc = new ModifyCard();
 pageContext.setAttribute("cardCnt", mc.updateCard(cVO));
  
}




%>
	<div class="wrapper">
		<!-- header/navibar import -->
		<jsp:include page="../../main/main_header_nav.jsp"/>
		<br/><br/><br/><br/><br/>
		
		
		<!--================================================== -->

		<div class = "resChk">
			<div class = "chkDiv">
			<div id = "resConf">
			예약이 완료되었습니다. 예약번호 : <%= strResNo%>
			</div>
			<table class = "chkTab">
			<tr >
				<td style = "width: 500px">
				<img src = "http://team3.aws.sist.co.kr/roomImages/<%= rv.getMain_img() %>" width="480" height="330"/><br/><br/>
				</td>
				
				<td >
				<table id = "chkSubTab">
				<tr>
					<td class = "guide">객실 </td>
					<td class = "guideTextP">no_${ param.room_no }&nbsp; <%= rv.getR_name()%></td>
				</tr>
				<tr>
					<td class = "guide">투숙 날짜</td>
					<td class = "guideTextP"><%=paramSd %> - <%=paramEd %>( <%=diffDays %> 박)</td>
				</tr>
				<tr>
					<td class = "guide">인원</td>
					<td class = "guideTextP"> 성인 <%=paramAdult %>명, 어린이 <%=paramChild %>명</td>
				</tr>
				</table> <br/>
				
				<table id = "chkSubTab">
				<%
				int price = rv.getPrice();
				pageContext.setAttribute("price", price);
				
				int tax = (int)(rv.getPrice()*0.21);
				pageContext.setAttribute("tax", tax);
				
				int totalP = (int)(rv.getPrice()+tax);
				pageContext.setAttribute("totalP", totalP);
				
				//박수가 곱해진 객실 가격
				int daysPrice = price*(int)diffDays;
				pageContext.setAttribute("daysP", daysPrice);

				//박수가 곱해진 텍스 
				int daysTax = tax*(int)diffDays;
				pageContext.setAttribute("daysTax", daysTax);
				
				//박수가 곱해진 총 가격
				int daysTotal = (daysPrice + daysTax);
				pageContext.setAttribute("daysTotal", daysTotal);
				%>
				
				<tr>
					<td class = "guide">객실요금</td>
					<td class = "guideTextPR"><fmt:formatNumber pattern = "#,###,###" value = "${ daysP }"/> KRW</td>
				</tr>
				<tr>
					<td class = "guide">세금 및 봉사료</td>
					<td class = "guideTextPR"><fmt:formatNumber pattern = "#,###,###" value = "${ daysTax }"/> KRW</td>
				</tr>
				</table><br/>
				
				<span class = "guide">요금정책</span><br/>
				<span class = "guideText"> ㆍ 상기 요금에 세금 및 봉사료가 각 10%가 가산됩니다. (총 21%) <br/>
				ㆍ 상기 요금에 조식은 포함되어 있지 않습니다. </span>
				</td>
			</tr>
			</table>
			
			<hr class = "hr1">
			<table class = "total">
			<tr>
				<td></td>
				<td>총 요금</td>
				<td><fmt:formatNumber pattern = "#,###,###" value = "${ daysTotal }"/> KRW</td>
			</tr>
			</table>
			<hr class = "hr1">
			</div><!-- chkDiv --><br/><br/><br/>
			
			
			<div class = "guideDiv">
			<div class = "guideTitle"> 예약자 정보</div>
			<div class = "back">
			<table class = "backTab">
			<tr>
				<td class = "guide">성(영문)</td>
				<td class = "guideText"><%= mv.getEname_lst() %></td>
				<td class = "guide">연락처</td>
				<td class = "guideText"><%= mv.getTel() %></td>
				
			</tr>
			<tr>
				<td class = "guide">이름(영문)</td>
				<td class = "guideText"><%= mv.getEname_fst() %></td>
				<td class = "guide">이메일</td>
				<td class = "guideText"><%= mv.getEmail() %></td>
			</tr>
			</table>
			</div>
			</div><!-- guideDiv --><br/>
			<button type="button" id = "goHomeBtn" >메인으로</button><br/><br/><br/><br/>
			
			
			<div id="map" style="width:1000px; height:500px;"></div>
			
			
			</div><!-- resChk -->
			<br/><br/>
			<%-- 
			<form name = "hiddenCard" action = "http://team3.aws.sist.co.kr/user/reser_room/card_process.jsp" id = "hiddenCard" method = "get" >
				<input type="hidden" id="card_no" name="card_no" value = "<%= card_no %>"/>
				<input type="hidden" id="company" name="company" value = "<%=cardCompany %>"/>
				<input type="hidden" id="val_mm" name="val_mm" value = "<%= val_MM %>"/>
				<input type="hidden" id="val_yy" name="val_yy" value = "<%= val_YY %>"/>
				<input type="hidden" id="id" name="id" value = "<%= id %>"/>
				<input type="hidden" id="res_no" name="res_no" value = "<%= strResNo %>"/>
			</form> --%>


			<!-- footer import -->
	<jsp:include page="../../main/main_footer.jsp"/>
		</div><!-- wrap -->
		

		
    <!-- ================================================== -->

		<script
			src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
	</div>
</body>
</html>
