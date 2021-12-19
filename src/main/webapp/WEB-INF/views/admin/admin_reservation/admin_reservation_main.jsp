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
	href="http://localhost/hotel_final_prj/common/css/main_v20211012.css">

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
	href="http://localhost/hotel_final_prj/admin/css/admin_main.css">

<style type="text/css">
#date{
	font-size: 15px;
	font-weight: bold;
	margin: 20px;
	padding-bottom :30px;
	border-bottom: 1px solid #454D55;
	width:100%;
	hegiht:300px;
	padding-left:5px;
}

#resList{
	font-size: 15px;
	margin-left: 10px;
	margin-bottom:0px;
	padding-left:5px;
}

#year,#month,#day{
	width:120px;
	margin-right: 5px;
	font-size: 15px;
	color:#000000;
	
}

.table{
	width:1200px;
	margin-top: 40px;
	}

.table-bordered>tbody>tr>th{
	height:40px;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	background-color: #dfdfdf;
	border:1px solid #C0C5CE;
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
	margin-top : 60px;
	padding-left:500px;
}

.pagination>li>a {
	color:#454D55;
	font-size: 17px;
}

tr:hover td {
	background-color: #F1F3F4;
	cursor:pointer;
}

#navReserv{
	background-color: #454D55;
	text-decoration: none;
}

</style>

<script type="text/javascript">
//예약삭제 결과 메시지
<c:choose>
	<c:when test="${delResult eq 'true'}">
		alert("예약이 삭제되었습니다.");
	</c:when>
	<c:when test="${delResult eq 'false'}">
		alert("죄송합니다. 잠시 후 다시 시도해주세요.");
	</c:when>
</c:choose>
//예약수정 결과 메시지
<c:choose>
	<c:when test="${updateResult eq 'true'}">
		alert("예약이 변경되었습니다.");
	</c:when>
	<c:when test="${updateResult eq 'false'}">
		alert("죄송합니다. 잠시 후 다시 시도해주세요.");
	</c:when>
</c:choose>

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
	
	
	/* 페이지네이션 클릭시 현재페이지 & 날짜 전송 */
	$(".pagination li").click(function () {
		let page = $(this).text();
		let currentPage = ${currentPage};
		let totalPage = ${totalPage};

		//이전 버튼 클릭
		if(page == '<<') {
			if(currentPage == 1) { //현재 1 페이지면 1 반환
				page = 1; 
			} else {
				page = currentPage-1;
			}//end else
		}//end if  
		
		//다음 버튼 클릭
		if(page == ">>") {
			if(currentPage == totalPage) {//현재 끝 페이지면 끝 반환
				page = totalPage; 
			} else {
				page = currentPage+1;
			}//end else
		}//end if  
	 	
		$("#page").val(page);
		$("#dateFrm").submit();
	});//페이지네이션 click
	
	
	/* 예약 변경 */
	$("#resList tr").click(function(){
		//현재 선택된 tr과 td
		let tr = $(this);
		let td = tr.children();

		//선택된 행에서 예약번호 얻어오기
		let resNum = td.eq(1).text();
		
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
		let resNum = td.eq(1).text();
		
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
		<jsp:include page="/admin/common/admin_header_nav.jsp"/>

		<div id="container" >
		<form name="dateFrm" id="dateFrm" action="search_res_list.do" method="get" class="form-inline">
		 <span id="mainMenu" onclick="location.href='search_res_list.do'">예약 조회</span><br/><br/>
		
		 <div id="date">
		 <span style="font-size: 15px;color: #343A40;">&nbsp;※ 체크인 일자 검색</span><br/>
		 <!-- 날짜 입력/선택여부에 따라 value 설정-->
 		 	<c:choose>
		  	 <c:when test="${not empty param.year}">
		  	  <input type="text" id="year" name="year" class="form-control" value="${param.year}" maxlength="4" />년 &nbsp;
		  	  <input type="text" id="month" name="month" class="form-control" value="${param.month}" maxlength="2"/>월 &nbsp;
		  	  <input type="text" id="day" name="day" class="form-control" value="${param.day}" maxlength="2"/>일 &nbsp;
		  	 </c:when>
		  	 <c:otherwise>
		  	  <input type="text" id="year" name="year" class="form-control" placeholder="YYYY" maxlength="4" />년 &nbsp;
		  	  <input type="text" id="month" name="month" class="form-control" placeholder="MM" maxlength="2"/>월 &nbsp;
		  	  <input type="text" id="day" name="day" class="form-control" placeholder="DD" maxlength="2"/>일 &nbsp;
		  	 </c:otherwise>
		  	</c:choose>
		  	<input type="button" id="searchBtn" name="searchBtn" class="btn btn-default" value="검색"/>
		 </div>
		 
		 <input type="hidden" id="page" name="page"/> <!-- 페이지네이션의 현재 페이지 전송용 -->
		 </form>
		 
		 <div id="resList">
		 <table class="table table-bordered" id="resList">
		 <tr>
		 	<th style="">No.</th>
		 	<th>예약번호</th>
		 	<th>예약자명</th>
		 	<th>객실</th>
		 	<th>투숙기간</th>
		 	<th>인원수</th>
		 	<th>예약일자</th>
		 	<th>예약관리</th>
		 </tr>
		 
		<c:if test="${ empty resList }">
		<tr>
			<td onclick="event.cancelBubble=true" colspan="8" style="font-weight: bold">
			예약 정보가 존재하지 않습니다.</td>
		</tr>
		</c:if>
	
		<c:forEach var="res" items="${ resList }">
		  <tr>
			<td><c:out value="${ res.rNum }"/></td>
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
		 <form name="chgFrm" id="chgFrm" action="change_res_form.do" method="post">
		 	<input type="hidden" name="resNum" id="resNum"/>
		 </form>
		 
		 <!-- 삭제버튼 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="delFrm" id="delFrm" action="delete_res.do" method="post">
		 	<input type="hidden" name="delResNum" id="delResNum"/>
		 	<c:if test="${not empty param.year}">
		 		<input type="hidden" name="year" value="${param.year}"/>
		 		<input type="hidden" name="month" value="${param.month}"/>
		 		<input type="hidden" name="day" value="${param.day}"/>
		  	 </c:if>
		 </form>

		<c:if test="${totalPage ne 0}">
		<ul class="pagination" id="page">
		    <li><a href="#void">&lt;&lt;</a></li>
		    <c:forEach var="num" begin="1" end="${totalPage}" step="1">
		    	<c:if test="${num eq currentPage}">
		    		<c:set var="active" value="style='background:#dfdfdf'"/>
			    </c:if>
			    <li><a href="#void" ${active}><c:out value="${num}"/></a></li>
		    	<c:set var="active" value=""/>
		    </c:forEach>
		    <li><a href="#void">&gt;&gt;</a></li>
		 </ul>
		 </c:if>
		 
		</div> <!-- 컨테이너 div -->
		 
	    <!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
		
	</div>
</body>
</html>