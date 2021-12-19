<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 관리자 메인</title>
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

.table{
	margin-top: 80px;
	margin-left: 50px;
	border: 1px solid #333;
	font-size: 15px;
	margin-bottom:0px;
	text-align: center;
	width:1100px;
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

tr:hover td {
	background-color: #F1F3F4;
	cursor:pointer;
}

.pagination>li>a {
	color:#343A40;
	font-size: 17px;
}

#page{
	margin-top : 60px;
	padding-left: 500px;
}
</style>

<script type="text/javascript">
$(function(){
/* 예약메인 이동*/
$("#toDayList tr").click(function(){
	//현재 선택된 tr과 td
	let tr = $(this);
	let td = tr.children();

	//선택된 행에서 예약번호 얻어오기
	let resNum = td.eq(0).text();
	
	if(resNum != "예약번호" && resNum != null){
		$("#moveFrm").submit();
	}//end if
});//table click

/* 페이지네이션 클릭시 현재페이지 전송 */
$(".pagination li").click(function() {
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
 	
	location.href="admin_main.do?page="+page;
});//페이지네이션 click


})//ready
</script>
</head>
<body>

	<div id="wrap">
		<!-- header/navibar import -->
		<jsp:include page="/admin/common/admin_header_nav.jsp"/>
		
		<div id="container">
			<span id="mainMenu" onclick="location.href='admin_main.do'">오늘의 예약</span><br/>
		
		<div id="todayRes">
		<table  class="table table-bordered" id="toDayList">
			<tr>
			<th>No.</th>
			<th>예약번호</th>
			<th>예약자명</th>
			<th>객실</th>
			<th>투숙기간</th>
			<th>인원수</th>
			<th>예약일자</th>
		<tr>
				
		<c:if test="${ empty todayList }">
		<tr>
			<td onclick="event.cancelBubble=true" colspan="7" style="font-weight: bold">
			예약 정보가 존재하지 않습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach var="data" items="${ todayList }">
		  <tr>
			<td><c:out value="${ data.rNum }"/></td>
			<td><c:out value="${ data.resNo }"/></td>
			<td><c:out value="${ data.kName }"/></td>
			<td><c:out value="${ data.rName }"/></td>
			<td><c:out value="${ data.stayDate }"/></td>
			<td><c:out value="${ data.guest }"/></td>
			<td><c:out value="${ data.resDate }"/></td>
		  </tr>
		</c:forEach>
		
		</table>
		</div>
		
		<!-- 테이블의 예약건(행) 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="moveFrm" id="moveFrm" action="search_res_list.do" method="get">
		 <c:if test="${ not empty today }">
		 	<input type="hidden" name="year" id="year" value="${today.year}"/>
		 	<input type="hidden" name="month" id="month" value="${today.month}"/>
		 	<input type="hidden" name="day" id="day" value="${today.day}"/>
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

		</div><!-- container div -->
		
		<!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
		
	</div> <!-- wrap div -->

</body>
</html>
