<%@page import="kr.co.sist.user.member.MemberVO"%>
<%@page import="kr.co.sist.user.member.MemberSelect"%>
<%@page import="kr.co.sist.uesr.room.RoomVO"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info = "카드정보"%>
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


</script>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
String paramRoomNo = request.getParameter("room_no");
int room_no = Integer.parseInt( paramRoomNo );

RoomSelect rs = new RoomSelect();
RoomVO rv = rs.selectRoomInfo(room_no);  

String id = (String)session.getAttribute("id");

MemberSelect ms = new MemberSelect();
MemberVO mv = ms.selectMemInfo(id);


%>

</body>
</html>