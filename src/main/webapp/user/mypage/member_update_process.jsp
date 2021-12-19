<%@page import="kr.co.sist.user.login.UpdateMemDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.login.UpdateDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <jsp:useBean id="mVO" class="kr.co.sist.user.login.MemberChgVO" scope="page"/><!-- 아이디 비밀번호 새로운 비번을 저장할 수 있는 VO  -->
<jsp:setProperty property="*" name="mVO"/><!--  입력정보-->

<%
request.setCharacterEncoding("utf-8");
// form으로부터 전달된 데이터 전달.

String id=(String)session.getAttribute("id");
mVO.setId(id); //VO에 세션에서 꺼내온 아이디를 넣는다.

DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
mVO.setKname(de.encryption(mVO.getKname()) );//이름
mVO.setEmail(de.encryption(mVO.getEmail()));//이메일
mVO.setTel(de.encryption(mVO.getTel()));//번호


UpdateMemDAO mDAO=new UpdateMemDAO();
int cnt=mDAO.updateMem(mVO);

if(cnt==1){ 
%>
	<script type="text/javascript">
	location.href="correction_member.jsp"; 
	alert("변경 되었습니다");
	</script>
	<%}else{%>
		<script type="text/javascript">
	alert("다시 확인하여주세요");
	history.back();

	</script>
	<%}//end catch%>
