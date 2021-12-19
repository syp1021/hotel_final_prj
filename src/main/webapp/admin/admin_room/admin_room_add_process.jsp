<%@page import="kr.co.sist.admin.room.UploadImgList"%>
<%@page import="kr.co.sist.admin.room.RoomInsert"%>
<%@page import="kr.co.sist.admin.room.RoomVO"%>
<%@page import="kr.co.sist.admin.room.RoomSelect"%>
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
    pageEncoding="UTF-8" 
    info="객실 추가 프로세스"%>
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
<!-- 파라미터 없는 루트로 들어왔을 때 redirect -->
<c:if test="${empty param.roomName}">
	<c:redirect url="http://team3.aws.sist.co.kr/admin/admin_room_add.jsp"/>
</c:if>

<!-- 웹 파라미터 받기 -->
<jsp:useBean id="roomVO" class="kr.co.sist.admin.room.RoomVO" scope="page"/>
<jsp:setProperty property="*" name="roomVO"/>
<%
String img = request.getParameter("img");
if(img != ""){
String mainImg = img.substring(0,img.indexOf("."))+"_main"+img.substring(img.indexOf("."));
roomVO.setImg(mainImg);
}//end if
%>
<c:catch var ="e">
<%
String rName = request.getParameter("roomName");
String rStatus = "Y";
RoomSelect rs = new RoomSelect();
List<RoomVO> list = rs.selectRoomInfo(rName, rStatus);
if(list.size()!=0){ // 객실 이름 중복 체크
%>
<script type="text/javascript">
	alert("동일한 이름의 객실은 추가할 수 없습니다.");
	history.back();
</script>
<% return;}
RoomInsert ri = new RoomInsert();
if(ri.insertProcess(roomVO)){
%>
<script type="text/javascript">
	alert("객실이 정상적으로 추가되었습니다.");
	location.href="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_main.jsp";
</script>
<% }else{
%>
<script type="text/javascript">
	alert("죄송합니다. 잠시 후 다시 시도해주세요.");
	location.href="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_add.jsp";
</script>
<% }%>
</c:catch>

<c:if test="${not empty e}">
	${e}
	<strong>죄송합니다. 객실 추가 작업 중 문제가 발생했습니다.</strong><br/>
	<strong>잠시 후 다시 시도해주세요.</strong><br/>
	<a href="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_add.jsp">뒤로 가기</a>
</c:if> 

</body>
</html>