<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.admin.member.MemberUpdate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원삭제 프로세스"
    %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://team3.aws.sist.co.kr/common/css/main_v20211012.css">

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
<c:catch var="e">
<%
//파라미터 받고 삭제 메소드 호출
request.setCharacterEncoding("utf-8");
String id=request.getParameter("delId");
DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");
MemberUpdate mu = new MemberUpdate();
int cnt = mu.memberFlag(id);
 
if(cnt ==1){
%>
<script type="text/javascript">
alert("회원이 정상적으로 삭제되었습니다.");
location.href="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_select.jsp";
</script>	
<%}else{%>
<script type="text/javascript">
	alert("이미 삭제된 회원입니다..");
	location.href="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_select.jsp";
</script>
<%}%>
</c:catch>

<c:if test="${not empty e}">
	<strong>죄송합니다. 삭제 작업 중 문제가 발생했습니다.</strong><br/>
	<strong>잠시 후 다시 시도해주세요.</strong><br/>
	<a href="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_select.jsp">뒤로 가기</a>
</c:if>
</body>
</html>