<%@page import="kr.co.sist.admin.room.RoomSelect"%>
<%@page import="kr.co.sist.admin.reservation.ReserveSelect"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@page import="kr.co.sist.admin.member.MemberVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.sist.admin.reservation.ReserveUpdateVO"%>
<%@page import="kr.co.sist.admin.reservation.ReserveModify"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="예약관리 - 변경페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 예약변경</title>
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
#container {
	font-weight:normal;
}

#title{
	font-weight:bold;
	color:#000000;
}
#subTitle{
	font-weight:normal;
	color:#000000;
}

#resNum{
	font-weight:bold;
}

td{
	vertical-align: top;
	text-align: left;
	padding-top:10px;
	padding-left: 30px;
	padding-bottom: 25px;
	font-size:16px;
}

textarea{
	font-size:15px;
	color:#000000;
	border: 1px solid #A3A4A4;
	padding: 5px;
	resize: none;
}

.form-control{
	font-size:15px;
	color:#000000;
	height:40px;
}

#date{
	width:100px;
	margin-right:10px	
}

#btnGroup{
	margin-left:300px
}

.btn {
	margin:20px;
}

</style>

<script type="text/javascript">
$(function(){
	/* 예약변경 버튼 클릭  */
	$("#chgBtn").click(function(){
		
		var name = $("#kName").val();
		var inYear = $("input[name=inYear]").val();
		var inMonth = $("input[name=inMonth]").val();
		var inDay = $("input[name=inDay]").val();
		var outYear = $("input[name=outYear]").val();
		var outMonth = $("input[name=outMonth]").val();
		var outDay = $("input[name=outDay]").val();
		var adult = $("#adult").val();
		var child = $("#child").val();
		var room = $("#rName").val();
		
		//text 형식 공란 체크
		if(name == "" || inYear == "" || inMonth == "" || inDay == "" || outYear == ""
				|| outMonth == "" || outDay == ""){
			alert("수정하실 정보를 입력해주시기 바랍니다.");
			return;
		}//end if
		
		//날짜 유효성 체크
		//chkindate
	 	let inDate = inYear;
		inDate+='-'+inMonth;
		  inDate+='-'+inDay;
		//chkoutdate
		let outDate = outYear;
		outDate+='-'+outMonth;
		  outDate+='-'+outDay;
	 	//date 형식변환
		let ckInDate = Date.parse(inDate);
		let ckOutDate = Date.parse(outDate);
		
		//date형식 변환했을 때, 유효하지 않은 날짜는 NaN이 return
		if(isNaN(ckInDate) || isNaN(ckOutDate)){
			alert("정상적인 날짜를 입력해주세요.");
			return;
		}//end if
		
		//현재일자 구하기
	 	var toDay = new Date();

		if(toDay > ckInDate || toDay > ckOutDate){
			alert("체크인/체크아웃은 현재일 이후의 날짜로 입력해주세요.")
			return;
		}//end if 
		
		if(ckInDate > ckOutDate){
			alert("체크아웃 일자는 체크인 이후로 설정되어야 합니다.")
			return;
		}//end if

		if(ckInDate == ckOutDate){
			alert("체크인 일자와 체크아웃 일자는 다르게 설정되어야 합니다.")
			return;
		}//end if

		//인원수 체크
		if( adult =="none" || child=="none"){
			alert("인원을 선택해주세요.");
			return;
		}//end if

		//객실 체크
		if( room =="none"){
			alert("객실을 선택해주세요.");
			return;
		}//end if
		 
		$("#chgFrm").submit();
		
	})//click

	/* 취소 클릭 */
	$("#resetBtn").click(function(){
		alert("예약 변경을 취소합니다.");
		history.back();
	})//click
	
});	
</script>
</head>
<body>
	<!-- 예약관리 메인 페이지에서 넘어오지 않았을 경우 redirect 해주기 (예약번호 선택 필요) -->
	<c:if test="${empty param.resNum}">
  	  <c:redirect url="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp"/>
	</c:if>
		 
	<div id="wrap">
		
		<!-- header/navibar import -->
		<c:import url="../common/admin_header_nav.jsp" /> 
		
		<div id="container" style="padding:50px">
		<span id="mainMenu" onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_change.jsp">예약변경</span><br/><br/>
		<form name="chgFrm" id="chgFrm" action="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_update_process.jsp" method="post" class="form-inline">
		 
		 <% 
		 String resNum = request.getParameter("resNum");
		 ReserveSelect rs = new ReserveSelect();
		 ReserveUpdateVO rVO = rs.selectRes(resNum);
		 pageContext.setAttribute("rVO", rVO); // 예약정보
		 
		 RoomSelect room = new RoomSelect();
		 pageContext.setAttribute("rNameList", room.selectAllRName()); //등록된 모든 룸 리스트
		 %>
		 <table>
		 <tr>
		   <!-- 예약 메인 페이지에서 선택된 예약번호를 받아서 설정 -->
		   <td>	<label id="title">* 예약번호</label> </td>
	       <td> <input type="text" name="resNo" id="resNo" class="form-control" value="${rVO.resNo}" readonly="readonly"/> </td>
		 </tr>
		 <tr>
		   <td> <label id="title">* 예약자명</label> </td>
		   <td> <input type="text" name="kName" id="kName" class="form-control"  value="${rVO.kName}" readonly="readonly"/> </td>
		 </tr>
		 <tr>
		   <td> <label id="title">* 투숙날짜</label> </td>
		   <td>	<label id="subTitle">체크인</label><br/>
					<input type="text" id="date" name="inYear" class="form-control" value="${rVO.inYear}" maxlength="4"/>년 &nbsp;
		  			<input type="text" id="date" name="inMonth" class="form-control" value="${rVO.inMonth}"  maxlength="2"/>월 &nbsp;
		  			<input type="text" id="date" name="inDay" class="form-control" value="${rVO.inDay}"  maxlength="2"/>일 &nbsp;
				<br/>
				<label id="subTitle" style="margin-top:15px" >체크아웃</label><br/>
					<input type="text" id="date" name="outYear" class="form-control" value="${rVO.outYear}" maxlength="4"/>년 &nbsp;
		  			<input type="text" id="date" name="outMonth" class="form-control" value="${rVO.outMonth}" maxlength="2"/>월 &nbsp;
		  			<input type="text" id="date" name="outDay" class="form-control" value="${rVO.outDay}" maxlength="2"/>일 &nbsp;
		  	</td>
		  </tr>
		  <tr>
		   <td>	<label id="title">* 인원수</label> </td>
		  <td> <label id="subTitle">성인</label>
			<select name="adult" id="adult" class="form-control" style="margin-left:50px">
				<option value="none">--인원수 선택--</option>
				<c:forEach var="i" begin="1" end="4" step="1">
				<c:set var="selected" value=""/>
				<c:if test="${i eq rVO.adult}">
					<c:set var="selected" value="selected='selected'"/>
				</c:if>
				<option value="${i}" ${selected}><c:out value="${i}"/>명</option>
				</c:forEach>
		  	</select>
		  	<br/>
			<label id="subTitle" style="margin-top:15px">어린이</label>
			<select name="child" id="child" class="form-control" style="margin-left:32px;">
				<option value="none">--인원수 선택--</option> 
				<c:forEach var="i" begin="0" end="3" step="1">
				<c:set var="selected" value=""/>
				<c:if test="${i eq rVO.child}">
					<c:set var="selected" value="selected='selected'"/>
				</c:if>
				<option value="${i}" ${selected}><c:out value="${i}"/>명</option>
				</c:forEach>
		  	</select>
		  </td>
		  </tr>
		  <tr>
		  <td> <label id="title">* 객실</label> </td>
		  <td> <select name="rName" id="rName" class="form-control">
				<option value="none">--객실 선택--</option>
				<c:forEach var="rName" items="${ rNameList }">
					<c:set var="selected" value=""/>
					<c:if test="${rName eq rVO.rName}">
					<c:set var="selected" value="selected='selected'"/>
					</c:if>
					<option value="${rName}" ${selected}><c:out value="${rName}"/></option>
				</c:forEach>
		  	</select>
		  </td>
		  <tr> 
		  <td> <label id="title">* 추가 요청</label><br/>
		  	   <span style="font-size:14px;font-weight: bold">&nbsp;&nbsp; (선택사항)</span> </td>
		  <td> <textarea name="addReq" rows="3" cols="80"><c:out value="${rVO.addReq}"/></textarea> </td>
		  </tr>
		</table>
		
		<input type="hidden" id="chkInDate" name="chkInDate"/>
		<input type="hidden" id="chkOutDate" name="chkOutDate"/>
		
		<div id="btnGroup">
		<input type="button" id="chgBtn" name="chgBtn" class="btn btn-primary btn-lg" value="예약변경"/>
		<input type="reset" id="resetBtn" name="resetBtn" class="btn btn-default btn-lg" value="취소"/>
		</div>
		
		</form>
		</div>
		 
		<!-- footer import -->
		<c:import url="../common/admin_footer.jsp" />
		
	</div>
</body>
</html>