
<%@page import="kr.co.sist.user.member.User_Decryption"%>
<%@page import="kr.co.sist.user.card.CardVO"%>
<%@page import="kr.co.sist.user.card.SelectCard"%>
<%@page import="java.text.DateFormat"%>
<%@page import="kr.co.sist.user.member.MemberVO"%>
<%@page import="kr.co.sist.user.member.MemberSelect"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.sist.uesr.room.RoomVO"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
.hr1 {
	border-bottom: 1px solid #d3d3d3;
}

.resChk {
	width: 1000px;
	height: 2300px;
	color: #5A5A5A;
	margin: 0px auto;
	text-align: center;
}

.chkDiv {
	width: 1000px;
	color: #5A5A5A;
	margin: 0px auto;
	text-align: center;
}

.chkTab {
	width: 1000px;
	height: 450px;
	color: #5A5A5A;
	text-align: left;
	margin: 0px auto;
	table-layout: fixed;
}

.guide {
	font-size: 17px;
	font-weight: bold;
	padding-left: 20px;
}

.guideText {
	font-size: 15px;
}

#chkSubTab {
	width: 500px;
	border: 1px solid #d3d3d3;
}

.guideTextP {
	font-size: 15px;
	padding-left: 20px;
	padding-top: 10px;
	padding-bottom: 10px
}

.guideTextPR {
	font-size: 15px;
	padding-right: 20px;
	padding-top: 10px;
	padding-bottom: 10px;
	float: right;
	font-weight: bold
}

.total {
	width: 1000px;
	height: 70px;
	font-size: 20px;
	font-weight: bold;
	color: #333;
	table-layout: fixed;
}

.guideDiv {
	width: 1000px;
	height: 300px; /* border: 10px solid #FFFF00 */
}

.guideTitle {
	width: 1000px;
	height: 40px;
	color: #333;;
	font-size: 20px;
	font-weight: bold;
	text-align: left;
}

.back {
	width: 1000px;
	height: 200px;
	background-color: #FAFAFA;
	padding: 50px
}

.backTab {
	width: 900px;
	height: 100px;
	margin: 0px auto;
	table-layout: fixed;
}

.agreeDiv {
	width: 1000px;
	height: 300px;
	text-align: left;
	margin: 0px auto;
}

#ccAgree {
	font-size: 20px;
	font-weight: bold;
	text-align: left
}

.agreeBack {
	width: 1000px;
	height: 150px;
	background-color: #FAFAFA;
	padding: 20px;
	border: 1px solid #d3d3d3
}

.pAgreeBack {
	width: 1000px;
	height: 60px;
	background-color: #FAFAFA;
	padding: 20px;
	border: 1px solid #d3d3d3
}

.pAgreeDiv {
	width: 1000px;
	height: 450px;
	text-align: left;
	margin: 0px auto;
}

.cardTab {
	width: 1000px;
	height: 100px;
	table-layout: fixed;
}

.cardTd {
	font-size: 17px;
	font-weight: bold;
	padding-right: 20px;
	text-align: left
}

#cardNo {
	width: 250px;
	height: 40px;
	padding-top: 10px;
	font-size: 17px;
	font-weight: normal;
}

#val_MM {
	width: 60px;
	height: 40px;
	padding-top: 10px;
	font-size: 17px;
	font-weight: normal;
}

#val_YY {
	width: 60px;
	height: 40px;
	padding-top: 10px;
	font-size: 17px;
	font-weight: normal;
}
#company {
	width: 150px;
	height: 40px;
	padding-top: 10px;
	font-size: 17px;
	font-weight: normal;
}

#cardSave {
width: 200px;
	font-size: 15px;
	font-weight: bold;

	float: left
}

details>summary {
	padding-top: 15px;
	width: 1000px;
	height: 50px;
	border: 1px solid #d3d3d3;
	font-size: 15px;
	vertical-align: middle;
	text-align: center
}

details>p {
	padding: 20px;
	width: 1000px;
	border: 1px solid #d3d3d3;
	background-color: #FAFAFA;
}



#completeBtn {
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

#completeBtn:hover {
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

<script type="text/javascript">
$(function() {
	
	$("#completeBtn").click(function() {

	let card_no = $("#card_no").val();
	let val_MM = $("#val_MM").val();
	let val_YY = $("#val_YY").val();
	let cardCompany = $("#cardCompany").val();
	
	//신용카드 정보 유효성 검사
	if((/[^0123456789-]/g.test(card_no)) // 숫자0-9와 - 만 입력 가능
		|| card_no.length != 19 // 총 문자길이 19자 검사
		|| card_no.substring(4, 5) != "-" // - 위치 검사
		|| card_no.substring(9, 10) != "-" // - 위치 검사
		|| card_no.substring(14, 15) != "-" // - 위치 검사
	){
		alert("카드번호를 0000-0000-0000-0000 형식으로 입력해주세요.");
		$("#card_no").focus();
		return;
	}//end if
	
	
	//신용카드 유효기간 월 유효성 검사
	if ( (/[^0123456789]/g.test(val_MM) )
		|| val_MM < 1 
		|| val_MM > 12
	){
		alert("카드 유효기간 (월) 숫자 1 ~ 12 로 입력해주세요.");
		$("#val_MM").focus();
		return;
	}//end if
	
	//신용카드 유효기간 월 유효성 검사
	if ( (/[^0123456789]/g.test(val_YY) )
			|| val_YY < 21 
			|| val_YY > 50
		){
			alert("카드 유효기간 (년) 20XX 숫자로 입력해주세요.");
			$("#val_YY").focus();
			return;
		}//end if
		
 	if( cardCompany == "none"){
 		alert("카드 종류를 선택해주세요.");
	return;
	}//end if 
		
	
	//취소규정 체크 여부 (필수)
	//if($( "[name = 'ccAgree']:checked").val() == "" ){
	if(!$("input:checkbox[name='ccAgree']").is(":checked") ){
		alert("위 취소규정 약관에 동의해 주세요.");
		return;
	}//end id
		
	//개인정보동의 체크 여부 (필수)
	if(!$("input:checkbox[name='piAgree']").is(":checked") ){
		alert("위 개인정보수집 약관에 동의해 주세요.");
		return;
	}//end id

	
	if ($("input:checkbox[name=CHECK_YN]").is(":checked") == true){
		$("#saveYN").val("Y");
	}else{
		$("#saveYN").val("N");
	}//end else
	
	if ($("input:checkbox[name=ccAgree]").is(":checked") == true){
		$("#ccYN").val("Y");
	}else{
		$("#ccYN").val("N");
	}//end else
	
	if ($("input:checkbox[name=piAgree]").is(":checked") == true){
		$("#piYN").val("Y");
	}else{
		$("#piYN").val("N");
	}//end else 
	
	
  $("#FFrm").submit();  
	
	});//click
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
	String addReq = request.getParameter("addReq");
	String paramRoomNo = request.getParameter("room_no");
	String DiffDays = request.getParameter("diffDays");
	int room_no = Integer.parseInt( paramRoomNo );
	int diffDays = Integer.parseInt( DiffDays );

	
	// 체크인월일 구하기 (res_no에 사용됨)
	String year = paramSd.substring(0, 4);
	String month = paramSd.substring(5,7);
	String day = paramSd.substring(8,10);
	
	
	// 룸넘버 0으로 두자리 만들기
	String zeroRoomNo = String.format("%02d", room_no);
	String zeroDiffDays = String.format("%03d", diffDays);
	
	//예약번호 생성 (년월일 - 박수(3자리) -R룸넘버)
	String strResNo = year + month + day + "-" + zeroDiffDays + "R" + zeroRoomNo;
	//String strResNo = month + day + "R" + zeroRoomNo;
	
	RoomSelect rs = new RoomSelect();
	RoomVO rv = rs.selectRoomInfo(room_no); 
	
	String id = (String)session.getAttribute("id");
	
	//사용자정보 복호화
	User_Decryption ud = new User_Decryption();
	MemberVO mv = ud.DecryptSelectMemInfo(id);
	
		
	// 사용자의 기본 카드 정보 확인하기
	SelectCard sc = new SelectCard();
	
	// 저장된 사용자의 카드 로우가 있는지 확인 -> 없으면 card_no을 0으로 반환
	CardVO cdVO = sc.checkSavedCard(id);
	String savedFlag = cdVO.getCard_no();
	
	pageContext.setAttribute("saveFlag", savedFlag);
	
	
 	 if( !savedFlag.equals("0")){
	 	// 사용자의 카드 정보 가져오기
		CardVO cVO = sc.selectCardInfo(id);
		String savedCard_no = cVO.getCard_no(); 
		String savedMM = cVO.getVal_mm();
		String savedYY = cVO.getVal_yy();
		String savedCompany = cVO.getCompany();
		pageContext.setAttribute("savedCard_no", savedCard_no); 
		pageContext.setAttribute("savedMM", savedMM); 
		pageContext.setAttribute("savedYY", savedYY); 
		pageContext.setAttribute("savedCompany", savedCompany); 
	} 

%>
	<div class="wrapper" style="width: 1130px">
		<!-- header/navibar import -->
		<jsp:include page="../../main/main_header_nav.jsp"/>
		<br />
		<br />
		<br /><br />
		<br />

		<!--================================================== -->

		<div class="resChk">
		<div>
		
			<div class="chkDiv">
				<table class="chkTab">
					<tr>
						<td style="width: 500px"><img
							src="http://team3.aws.sist.co.kr/roomImages/<%= rv.getMain_img() %>"
							width="480" height="330" /><br /> <br /></td>

						<td>
							<table id="chkSubTab">
								<tr>
									<td class="guide">객실</td>
									<td class="guideTextP"><%= rv.getR_name()%></td>
								</tr>
								<tr>
									<td class="guide">투숙 날짜</td>
									<td class="guideTextP"><%=paramSd %> - <%=paramEd %> (<%=diffDays %>박)</td>
								</tr>
								<tr>
									<td class="guide">인원</td>
									<td class="guideTextP">성인 : <%=paramAdult %>명 어린이 : <%=paramChild %>명</td>
								</tr>
							</table> <br />

							<table id="chkSubTab">
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
								<tr>
									<td class="guide">객실요금</td>
									<td class="guideTextPR"><fmt:formatNumber pattern = "#,###,###" value = "${ daysP }"/> KRW</td>
								</tr>
								<tr>
									<td class="guide">세금 및 봉사료</td>
									<td class="guideTextPR"><fmt:formatNumber pattern = "#,###,###" value = "${ daysTax }"/> KRW</td>
								</tr>
							</table> <br /> <span class="guide">요금정책</span><br /> <span
							class="guideText"> ㆍ 상기 요금에 세금 및 봉사료가 각 10%가 가산됩니다. (총
								21%) <br /> ㆍ 상기 요금에 조식은 포함되어 있지 않습니다.
						</span>
						</td>
					</tr>
				</table>

				<hr class="hr1">
				<table class="total">
					<tr>
						<td></td>
						<td>총 요금</td>
						<td><fmt:formatNumber pattern = "#,###,###" value = "${ daysTotal }"/> KRW</td>
					</tr>
				</table>
				<hr class="hr1">
			</div>
			<!-- chkDiv -->
			<br /> <br /> <br />


			<div class="guideDiv">
				<div class="guideTitle">예약자 정보</div>
				<div class="back">
					<table class="backTab">
						<tr>
							<td class="guide">성(영문)</td>
							<td class="guideText"><%= mv.getEname_lst() %></td>
							<td class="guide">연락처</td>
							<td class="guideText"><%= mv.getTel() %></td>

						</tr>
						<tr>
						<td class="guide">이름(영문)</td>
						<td class="guideText"><%= mv.getEname_fst() %></td>
						<td class="guide">이메일</td>
						<td class="guideText"><%= mv.getEmail() %></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- guideDiv -->
			<br />
		
 
			<form name="FFrm" action="http://team3.aws.sist.co.kr/user/reser_room/reservation_complete.jsp" id="FFrm" method="post">
 					<div class="guideDiv">
					<div class="guideTitle">신용카드 정보</div>
					<p class="guideText" style="float: left">신용카드 정보는 게런티/위약금 결제를
						위해 이용되며, 객실요금은 추후 체크인 시 결제됩니다.</p>
					<br />
					<hr class="hr1">

					<table class="cardTab">
						<tr>
						<!-- 사용자의 카드정보가 카드테이블에 저장되어 있을 때(saveFlag가 0이 아닐때), 카드정보 넣어서 보여주기  -->
							<td class="cardTd" style="width: 300px">신용카드번호*<br /> 
							<c:choose>
							<c:when test = "${ saveFlag eq '0' }">
							<input type="text" name="card_no" id="card_no" class="form-control" maxlength="19" style = "margin-top: 10px" />
							</c:when>
							<c:otherwise>
							<input type="text" name="card_no" id="card_no" class="form-control" maxlength="19" style = "margin-top: 10px" value = "${savedCard_no }" />
							</c:otherwise>
							</c:choose>
							</td>
							<td style = "width:35px">
							</td>
							<td class="cardTd" style="width: 200px">유효기간*<br /> 
							<table>
							<tr>
								<td>
									<c:choose>
									<c:when test = "${ saveFlag eq '0' }">
									<input type="text" name="val_MM"  class="form-control" id="val_MM" maxlength="2" placeholder="MM" style = "margin-top: 10px" />
									</c:when>
									<c:otherwise>
									<input type="text" name="val_MM"  class="form-control" id="val_MM" maxlength="2"  value = "${savedMM }" style = "margin-top: 10px" />
									</c:otherwise>
									</c:choose>
								</td>
								<td style = "width:15px">
								</td>
								<td>
									<c:choose>
									<c:when test = "${ saveFlag eq '0' }">
									<input type="text" name="val_YY"  class="form-control" id="val_YY" maxlength="2" placeholder="YY" style = "margin-top: 10px" />
									</c:when>
									<c:otherwise>
									<input type="text" name="val_YY"  class="form-control" id="val_YY" maxlength="2"  value = "${savedYY }" style = "margin-top: 10px" />
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</table>
							
							
							
							</td>
							
							<td class="cardTd">카드종류*<br /> 
							<c:choose>
							<c:when test = "${ saveFlag eq '0' }">
							<select name="cardCompany" id="cardCompany" class="form-control sel" style = "width:200px; margin-top: 10px">
									<option value="none">--선택--</option>
									<option value="VISA">VISA</option>
									<option value="MasterCard">MasterCard</option>
									<option value="UnionPay">UnionPay</option>
									<option value="AMEX">AMEX</option>
							</select>
							</c:when>
							<c:otherwise>
							<select name="cardCompany" id="cardCompany" class="form-control sel">
									<option value="none" <c:if test = "${savedCompany =='0'}">selected</c:if>>--선택--</option>
									<option value="VISA" <c:if test = "${savedCompany =='VISA'}">selected</c:if>>VISA</option>
									<option value="MasterCard" <c:if test = "${savedCompany =='MasterCard'}">selected</c:if>>MasterCard</option>
									<option value="UnionPay" <c:if test = "${savedCompany =='UnionPay'}">selected</c:if>>UnionPay</option>
									<option value="AMEX" <c:if test = "${savedCompany =='AMEX'}">selected</c:if>>AMEX</option>
							</select>
							</c:otherwise>
							</c:choose>
							
							</td>
						</tr>
					</table>
					<br /> <br />
					
					<label style = "float: left; "><div id="cardSave">
						<input type = "hidden"  id = "saveYN" name = "saveYN"/>
						<input type="checkbox" name="CHECK_YN" id = "CHECK_YN" style = "float: left; font-size: 20px" /> 
						<p>&nbsp;입력한 신용카드 정보 저장</p>
					</div></label>
					<p style="padding-left: 10px; width:800px">
					입력하신 신용카드 정보를 저장해 두시면 향후 예약 시 편리하게 이용하실 수 있습니다. </p>

					<br />

				</div>
			
			<!-- guideDiv -->
			<br />
			<br />
			<br />
			<br />
			<hr class="hr1">

			<div class="agreeDiv">
				<label><div class="guideTitle">
						<input type = "hidden" id = "ccYN" name = "ccYN"/>
						<input type="checkbox" id = "ccAgree" name="ccAgree"  >&nbsp;취소규정동의*
					</div></label>
				<div class="agreeBack">
					• 상기 홈페이지 요금은 정상가에서 할인된 금액으로 중복 할인은 불가능합니다. <br /> • 예약 취소 및 변경은
					체크인 하루 전 18:00(한국시간)까지 가능합니다. <br /> &nbsp;&nbsp;예약하신 일자에 체크인 되지
					않거나 또는 위의 지정 시간 이후에 예약을 취소했을 경우에는 예약 사항에 대해 노-쇼 (No Show) 처리 되며, <br />
					&nbsp;&nbsp;이에 따른 위약금으로 예약 첫날에 해당하는 1박 객실요금이 청구되오니 유의하시기 바랍니다.<br />
					• 일부 프로모션 특가상품은 별도의 취소규정이 적용되며, 취소 시 첫날 1박 요금의 100%가 위약금으로 부과됩니다.
				</div>

			</div>
			<hr class="hr1">

			<div class="pAgreeDiv">
				<label><div class="guideTitle">
						 <input type = "hidden" id = "piYN" name = "piYN"/>
						<input type="checkbox" id = "piAgree" name="piAgree" />&nbsp;필수적
						개인정보수집이용에 대한 동의(객실예약)*
					</div></label>
				<div class=" pAgreeBack">리츠호텔 객실예약과 관련하여 아래와 같이 귀하의 개인정보를 수집 및
					이용합니다.</div>
				<details>
					<summary>전체 보기 ▼ </summary>
					<p>
						<strong>1. 개인정보 수집항목</strong><br /> - 성명(영문), 연락처(모바일, 자택 또는 회사),
						이메일, 신용카드 정보(신용카드 종류, 신용카드번호 및 유효기간 포함)<br /> <br /> <strong>2.
							개인정보 수집 및 이용목적</strong><br /> - 객실 예약 서비스 제공, 예약 관련 안내 및 고지사항 전달, 익스프레스
						체크인 서비스 제공, 고객 불만 등 민원 처리, 부정이용 방지, 법적 분쟁 등의 처리<br /> * 수집된 신용카드
						정보는 개런티/위약금 결제를 위해 이용되며, 객실요금은 추후 체크인시 결제됩니다.<br /> <br /> <strong>3.
							개인 정보 보유 및 이용 기간</strong><br /> - 수집일로부터 2년. 단, 예약 취소 시 취소일로부터 5일후 파기됩니다.<br />
						<br /> <strong>4. 동의를 거부할 권리 및 동의를 거부할 경우의 불이익</strong><br /> -
						귀하는 위와 같은 개인정보의 수집이용에 대한 동의를 거부할 수 있으나, 동의 거부 시, 객실 예약이 불가능합니다.<br />
					</p>
				</details>
			</div>
			<!-- </form> -->
			<br />
			<input type="hidden" name="addReq" id="addReq" value = "${param.addReq}"/>
			<input type="hidden" name="room_no" id="room_no" value = "${param.room_no}"/> 
			<input type="hidden" id="Sd" name="sd" value = "<%= paramSd %>"/>
		 	<input type="hidden" id="Ed"  name="ed" value = "<%= paramEd %>"/>
			<input type="hidden" id="Adult" name="adult" value = "<%= paramAdult %>"/>
			<input type="hidden" id="Child" name="child" value = "<%= paramChild %>"/>
			<input type="hidden" id="diffDays" name="diffDays" value = "<%=diffDays %>"/>
			<input type="hidden" id="resNo" name="resNo" value = "<%= strResNo %>"/>
			<input type="hidden" id="saveFlag" name="saveFlag" value = "${saveFlag}"/>
			<button type="button" id = "completeBtn">예약하기</button>
</form>
			
		</div>
		<!-- resChk -->
		<br /> <br />

	</div>
	</div><!-- wrap -->
		<!-- footer import -->
	<jsp:include page="../../main/main_footer.jsp"/>

	<!-- ================================================== -->

	<script
		src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
