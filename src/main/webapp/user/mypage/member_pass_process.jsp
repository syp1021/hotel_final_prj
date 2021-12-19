<%@page import="org.springframework.dao.DataAccessException"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.login.UpdateDAO"%>
<%@page import="kr.co.sist.user.login.memberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <jsp:useBean id="mVO" class="kr.co.sist.user.login.MemberChgPassVO" scope="page"/><!-- 아이디 비밀번호 새로운 비번을 저장할 수 있는 VO  -->
<jsp:setProperty property="*" name="mVO"/><!--  입력정보-->

<%
request.setCharacterEncoding("utf-8");
// form으로부터 전달된 데이터 전달.

String id=(String)session.getAttribute("id");
mVO.setId(id); 

mVO.setPass(DataEncrypt.messageDigest("SHA-512", mVO.getPass()));

mVO.setChange_pass(DataEncrypt.messageDigest("SHA-512", mVO.getChange_pass()));


UpdateDAO mDAO=new UpdateDAO();
int cnt=mDAO.updatePass(mVO);//

if(cnt==1){ ;//아이디와 비밀번호가 맞으면 이름이 나옵니다.
%>
	<script type="text/javascript">
	location.href="correction_member.jsp"; 
	alert("변경 되었습니다");
	</script>
	<%}else{%>
		<script type="text/javascript">
	alert("비밀번호를 확인하여주세요");
	history.back();

	</script>
	<%}//end catch%>

