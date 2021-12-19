<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:catch var="e">
<%
request.setCharacterEncoding("utf-8");

// form으로부터 전달된 데이터 전달.
String mg_id = request.getParameter("userid");   
String pass = request.getParameter("password");   


MemberSelect ms = new MemberSelect();
String reId = ms.loginChk(mg_id, pass);// admin01
session.setAttribute("mg_id", reId);
if(reId.equals(mg_id)) {
%>    <!-- 로그인성공시 메인페이지로 이동 -->
<script type="text/javascript">
location.href="http://team3.aws.sist.co.kr/admin/common/admin_main.jsp";
</script>
 <%} 
 %>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
alert("아이디와 비밀번호를 확인해주세요.");
location.href="http://team3.aws.sist.co.kr/admin/common/admin_login.jsp";
</script>
</c:if>
