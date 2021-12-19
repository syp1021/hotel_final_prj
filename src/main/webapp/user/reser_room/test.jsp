<%@page import="kr.co.sist.user.images.ImageCount"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info = "카드정보"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
    
<title>Insert title here</title>
<link rel = "stylesheet" type = "text/css" href = "http://team3.aws.sist.co.kr/jsp_prj/common/css/main_v20211012.css" />

<style type="text/css">

</style>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
 $(function(){
	$("#btn").click(function(){
		if( $("#room_no").val() == "N/A"){
			alert("방번호 선택ㄱ");
			return;
		}//end if
	
		$("#frm").submit();	
	});//click
});//ready 



</script>
</head>
<body>


<%
	RoomSelect rs = new RoomSelect();
	pageContext.setAttribute("RoomNo", rs.selectAllRoomNo() );
	
	
	
%>

<form name = "frm" method = "get" id = "frm" action = "http://team3.aws.sist.co.kr/user/reser_room/room_reserve.jsp"> <!--action : url  -->

<select id = "room_no" name = "room_no" >
<option value = "N/A">---방번호-----</option>
<c:forEach var = "room_no" items = "${ RoomNo }">
<option value = "${ room_no }"><c:out value = "${ room_no }"/></option>
</c:forEach>
</select>

<input type = "button" value = "방조회" id = "btn" /> 



</form>


</body>
</html>