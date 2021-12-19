<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.login.memberVO"%>
<%@page import="kr.co.sist.user.login.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


 <jsp:useBean id="loginVO" class="kr.co.sist.user.login.memberVO" scope="page"/>
<jsp:setProperty property="*" name="loginVO"/><!--  입력정보-->
  <%
  request.setCharacterEncoding("UTF-8");
  %>
  
  <!-- 이전 페이지에서 날아온 웹파라미터 이 페이지에서 받아서 설정하기 -->
  <jsp:useBean id="mVO" class="kr.co.sist.user.login.memberVO"/>  
  <!-- *써서 setter method 다 실행해서 세팅됨 -->
  <jsp:setProperty property="*" name="mVO"/>
  
<%
request.setCharacterEncoding("utf-8");
// form으로부터 전달된 데이터 전달.
//id는 세션에서 전달되고 
String id=(String)session.getAttribute("id");

String pass=request.getParameter("pass");

MemberDAO mDAO=new MemberDAO();

mVO.setId(id);//세션의아이디와
mVO.setPass(DataEncrypt.messageDigest("SHA-512", mVO.getPass()));
try{
String name=mDAO.selectLogin(mVO) ;//아이디와 비밀번호가 맞으면 이름이 나옵니다.

	%>
	<script type="text/javascript">
	location.href="correction_member.jsp"; 
	</script>
	<%}catch(DataAccessException se){%>
		<script type="text/javascript">
	alert("비밀번호를 확인하여주세요");
	history.back();

	</script>
	<%}//end catch%> 


