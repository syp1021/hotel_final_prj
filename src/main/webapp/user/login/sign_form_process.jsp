<%@page import="kr.co.sist.user.login.memberVO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.user.login.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 처리"
    %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Hotel_Ritz_Seoul</title>
    <!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">
    
	<style type = "text/css">
			/* div {margin: 0px auto; width: 1130px;} */
	</style>

    <!-- Bootstrap core CSS -->
	<!-- jQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	

	<!-- Bootstrap CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/holder.js"></script>

    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie-emulation-modes-warning.js"></script>

    <link href="http://team3.aws.sist.co.kr/common/bootstrap/carousel.css" rel="stylesheet">
  </head>
  
<!-- NAVBAR
================================================== -->
  <body>
 <div class="wrapper">
 
		 <jsp:include page="../../main/main_header_nav.jsp"/>
	
	<br/><br/><br/>
	<div class="container marketing">
  <br/><br/>
  <div style="width: 300px;text-align: center;margin: 0px auto;">
  <br>
  <h2>가입완료</h2>
  </div>
  <hr style="width: 500px"/>
  <div style="width: 300px;text-align: center; margin: 0px auto;">

<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String email = request.getParameter("email");
String ename_fst = request.getParameter("ename_fst");
String ename_lst = request.getParameter("ename_lst");
String kname = request.getParameter("kname");
String birth_year = request.getParameter("birth_year");
String tel = request.getParameter("tel");
String req_agree = request.getParameter("req_agree");
String opt_agree = request.getParameter("opt_agree");
String m_status = request.getParameter("m_status");
%>
 <jsp:useBean id="mVO" class="kr.co.sist.user.login.memberVO" scope="page"/>
<jsp:setProperty property="*" name="mVO"/><!--  입력정보-->
<c:catch var="e">
  
<%
//비밀번호 암호화 
mVO.setPass(DataEncrypt.messageDigest("SHA-512", mVO.getPass()));

//이름 암호화
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
mVO.setKname(de.encryption(mVO.getKname()) );//이름
mVO.setEname_fst(de.encryption(mVO.getEname_fst()));  //영문이름
mVO.setEname_lst(de.encryption(mVO.getEname_lst()));//영문이름
mVO.setEmail(de.encryption(mVO.getEmail()));//이메일
mVO.setBirth_year(de.encryption(mVO.getBirth_year()));//생년월일
mVO.setTel(de.encryption(mVO.getTel()));//번호
 mVO.setId(mVO.getId());
mVO.setReq_agree(mVO.getReq_agree());
mVO.setOpt_agree(mVO.getOpt_agree());
mVO.setJoin_date(mVO.getJoin_date());
mVO.setOut_date(mVO.getOut_date());
mVO.setM_status(mVO.getM_status()); 

//DB작업
MemberDAO mDAO=new MemberDAO();
mDAO.insertMember(mVO);//추가성공 예외
%>

<c:out value="${ param.kname }"/>님 <c:out value="${ param.id }"/>로
회원 가입 되셨습니다.<br/>회원가입을 축하드립니다.<br/>
</c:catch>
<c:if test="${ not empty e }">
죄송합니다. 회원정보가 입력되지 않았습니다.
잠시 후 다시 시도해주세요.
</c:if>
</div>
</div>

  <br/><br/>
 <div style="width:150px; text-align: center; margin: 0px auto;">
  <input type="button" class="btn btn-default" style="width: 100px;" value="홈으로" onclick="location.href='http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp'">
  </div>
</div>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
      <!-- FOOTER -->
   <jsp:include page="../../main/main_footer.jsp"/>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
