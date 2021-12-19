<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.user.reservation.ReservationUpdate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="rVO" class="kr.co.sist.user.reservation.ReservationVO" scope="page"/>
<jsp:setProperty name="rVO" property="*"/>
<script type="text/javascript">    
<%
	ReservationUpdate ruD = new ReservationUpdate();
	
	try{
		int cnt = ruD.reservationFlag(rVO);
		String msg = "예약 취소 실패";
			if(cnt == 1){
				msg = "예약 취소 완료";
			}//end if
%>
alert("<%= msg %>");
location.href = "reservation_inq.jsp";
<%
	}catch (DataAccessException dae){
		dae.printStackTrace();
%>
alert("문제발생");
<%
	}//endcatch
%> 
</script>
