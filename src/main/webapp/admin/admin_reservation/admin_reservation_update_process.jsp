<%@page import="kr.co.sist.admin.reservation.ReserveSelect"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="kr.co.sist.admin.member.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@page import="kr.co.sist.admin.reservation.ReserveUpdateVO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.sist.admin.reservation.ReserveModify"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="예약 건 수정"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- 파라미터 없는 루트로 들어왔을 때 redirect -->
<c:if test="${empty param.inYear}">
	<c:redirect url="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp"/>
</c:if>

<!-- 웹 파라미터 받기 -->
<jsp:useBean id="ruVO" class="kr.co.sist.admin.reservation.ReserveUpdateVO" scope="page"/>
<jsp:setProperty property="*" name="ruVO"/>
<jsp:setProperty property="chkInDate" name="ruVO" value="${ruVO.inYear}.${ruVO.inMonth}.${ruVO.inDay}"/>
<jsp:setProperty property="chkOutDate" name="ruVO" value="${ruVO.outYear}.${ruVO.outMonth}.${ruVO.outDay}"/>
<%
ReserveSelect rs = new ReserveSelect();

//인원수 검증
int adult = Integer.parseInt(request.getParameter("adult"));
int child = Integer.parseInt(request.getParameter("child"));

int maxGuest = rs.selectMaxGuest(ruVO.getrName());

if((adult+child) > maxGuest){ 
%>
<script type="text/javascript">
	alert("<%=ruVO.getrName()%>의 최대 인원수는 <%=maxGuest%>명 입니다.");
	history.back();
</script>
<%return; }%>

<!-- 입력한 체크인일자로 숙박 가능한지 기존에약건과 예약일자 범위 체크 -->
<% List<String> resList = rs.selectStayDateRange(ruVO);
	if(!(resList.isEmpty())) { // 조회결과가 비어있지 않다면 return %>
<script type="text/javascript">
	alert("해당 기간 중 다른 예약이 존재합니다.");
	history.back();
</script>
<%return; }%>

<!-- 검증 통과 / update 진행 -->
<c:catch var="e">
<%
ReserveModify rm = new ReserveModify();
int cnt = rm.updateRes(ruVO);
//1 이라면 예약상태 N으로 변경 성공!
if(cnt == 1){
%>
<script type="text/javascript">
	alert("해당 예약 건이 정상적으로 변경되었습니다.");
	location.href="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp";
</script>
<%} else {%>
<script type="text/javascript">
	alert("죄송합니다. 잠시 후 다시 시도해주십시오.");
	location.href="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp";
</script>
<%}%>
</c:catch>

<c:if test="${not empty e}">
${e}
	<strong>죄송합니다. 삭제 작업 중 문제가 발생했습니다.</strong><br/>
	<strong>잠시 후 다시 시도해주세요.</strong><br/>
	<a href="http://team3.aws.sist.co.kr/admin/admin_reservation/admin_reservation_main.jsp">뒤로 가기</a>
</c:if> 
</html>