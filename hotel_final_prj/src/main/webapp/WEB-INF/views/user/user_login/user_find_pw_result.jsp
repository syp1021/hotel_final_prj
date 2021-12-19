<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info = "Hotel Ritz Seoul"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
   <!-- Bootstrap core CSS -->
	<!-- jQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	
	<!-- Bootstrap CDN -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
    <script src="http://localhost/hotel_final_prj/common/bootstrap/holder.js"></script>
    <script src="http://localhost/hotel_final_prj/common/bootstrap/ie-emulation-modes-warning.js"></script>
     <!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://localhost/hotel_final_prj/user/css/main.css">
    
    
	<style type = "text/css">
	.findTitle {
		color: #333;
		font-weight: bold;
		font-size: 25px
	}
	
	#result{
	width: 700px;
	text-align: center;
	vertical-align:middel; 
	margin: 0px auto;
	font-size:16px;
	color : #000000;
	}
	
	#markPW{
	font-weight:bold;
	font-size:16px;
	color : #0066B4;
	}
	
	.button {
		border: 1px solid #E9E9E9;
		font-size : 15px;
		font-weight: bold;
		background-color: #FAFAFA;
		color: #333;
		width: 150px;
		height : 40px;
		cursor: pointer;
		border-radius: 7px;
	}

	.button:hover{
		background-color: #FCF4C0  ;
		color: #333;
		cursor: pointer;
	}
}
	</style>
	<script type="text/javascript">
	$(function(){
		$("#loginBtn").click(function(){
			location.href="user_login.do";
		})
		$("#backBtn").click(function(){
			location.href="user_find_form.do";
		})
		
		$("#passBtn").click(function(){
			location.href="user_find_form.do";
		})
	})//ready
	</script>

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
	<jsp:include page="/user/common/main_header_nav.jsp"/>
		
	<!-- Standard button -->

  <div class="container">
  <br/><br/>
  <div style="width: 300px; text-align: center; margin: 0px auto;">
    <br/>
  <br/>
  <br/>
  <br/>
  <p class="findTitle">비밀번호 찾기</p>
  <br/>
  </div>
  <hr style="width: 900px"/>
  <br/>
  
  <div  id="result">
  <c:choose>
  <c:when test="${not empty tempPass}">
  <br/>
	임시 비밀번호는 <span id="markPW"><c:out value="${tempPass}"/></span> 입니다. <br/>
	로그인 후 마이페이지에서 비밀번호를 다시 설정해주시기 바랍니다.<br/><br/><br/><br/>
	<input type="button" id="loginBtn" class="button" value="로그인"/>
  <br/><br/>
  </c:when>
  <c:otherwise>
  <br/><br/>
  유효한 회원 정보가 아닙니다.
  <br/><br/><br/><br/>
	<input type="button" id="backBtn" class="button" value="뒤로 가기"/>
  </c:otherwise>
  </c:choose>
  </div>
  
  </div>
    
    <br/><br/><br/><br/><br/><br/><br/><br/><br/>
      <!-- FOOTER -->
	<jsp:include page="/user/common/main_header_nav.jsp"/>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/jsp_prj/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
