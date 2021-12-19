<%@page import="kr.co.sist.admin.room.RoomModify"%>
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
    info="객실 정보 수정 프로세스"%>
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
	<c:redirect url="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_main.jsp"/>
</c:if>
 
<!-- 웹 파라미터 받기 -->
<jsp:useBean id="roomVO" class="kr.co.sist.admin.room.RoomVO" scope="page"/>
<jsp:setProperty property="*" name="roomVO"/>
<%
//가격 세팅
String price1 = request.getParameter("price");
String price = price1.replaceAll(",", "");
roomVO.setPrice(price);
//main 이미지 세팅
String img = request.getParameter("img");
if(img != ""){
	if(img.indexOf("main")==-1){
		img= img.substring(0,img.indexOf("."))+"_main"+img.substring(img.indexOf("."));
}//end if
	roomVO.setImg(img);
}//end if
%>

<c:catch var ="e">
<%
String rName = request.getParameter("roomName");
RoomSelect rs = new RoomSelect();
List<String> list = rs.selectRoomName(rName, roomVO.getRoomNum());
if(list.size()!=0){ // 변경하려는 rName이 자기 자신 제외하고 더 존재하면 수정 불가
%>
<script type="text/javascript">
	alert("수정될 객실 이름과 동일한 객실이 존재하여 수정할 수 없습니다.");
	history.back();
</script>
<% return;}

RoomModify rm = new RoomModify();
boolean flag1 = rm.updateRoom(roomVO);
boolean flag2 = rm.deleteImg(roomVO);
boolean flag3 = new RoomInsert().insertImg(roomVO);
if(flag1 && flag2 && flag3){
%>
<script type="text/javascript">
	alert("객실 정보가 정상적으로 수정되었습니다.");
	location.href="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_main.jsp";
</script>
<% 
String[] imgList = request.getParameterValues("imgList");
UploadImgList ul = new UploadImgList();
// 객실 수정 완료 후, images폴더 정리 / temp 폴더->images 폴더로 사진 이동 => temp 파일 삭제
ul.removeOriginalImg(imgList, img, rName);
ul.moveRoomImg();
ul.removeAllImg();//temp 파일 삭제
}else{
%>
<script type="text/javascript">
	alert("죄송합니다. 잠시 후 다시 시도해주세요.");
	//location.href="http://team3.aws.sist.co.kr/admin/admin_room_main.jsp";
</script>
<% }%>
</c:catch>

<c:if test="${not empty e}">
	<strong>죄송합니다. 객실 추가 작업 중 문제가 발생했습니다.</strong><br/>
	<strong>잠시 후 다시 시도해주세요.</strong><br/>
	<a href="http://team3.aws.sist.co.kr/admin/admin_room/admin_room_main.jsp">뒤로 가기</a>
</c:if> 

</body>
</html>