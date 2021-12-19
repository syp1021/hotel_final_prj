<%@page import="java.util.Date"%>
<%@page import="kr.co.sist.user.login.UpdateDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://team3.aws.sist.co.kr/jsp_prj/common/css/main_v20211012.css" />   
<style type="text/css">

</style>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8");
String id=(String)session.getAttribute("id");
String m_status = request.getParameter("m_status");
%>

<jsp:useBean id="mVO" class="kr.co.sist.user.login.memberVO" scope="page"/>
<jsp:setProperty property="*" name="mVO"/><!--  입력정보-->
<%
mVO.setId(id);
mVO.setM_status(mVO.getM_status()); 
mVO.setOut_date(mVO.getOut_date());

UpdateDAO uDAO = new UpdateDAO();
int cnt = uDAO.delmember(mVO);

if(cnt ==1){
session.invalidate();
%>
<script type="text/javascript">
alert("회원 탈퇴가 완료되었습니다. \n그동안이용해주셔서 감사합니다");
location.href="http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp";
</script>	
<%}else{%>
<script type="text/javascript">
	alert("죄송합니다. 잠시 후 다시 시도해주십시오.");
	location.href="http://team3.aws.sist.co.kr/user/mypage/correction_member.jsp";
</script>
<%}%>
</body>
</html>