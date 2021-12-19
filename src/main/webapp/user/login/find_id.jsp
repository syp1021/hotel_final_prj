<%@page import="kr.co.sist.user.find.FindVO"%>
<%@page import="kr.co.sist.user.find.FindSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info = "Hotel Ritz Seoul"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	#result{
	width: 300px;
	text-align: center; 
	margin: 0px auto;
	font-size:16px;
	color : #000000;
	}
	
	#markID{
	font-weight:bold;
	font-size:16px;
	color : #0066B4;
	}
	.btn{
	width: 120px; 
	height: 40px
	}
	
	.button {
	border: 1px solid #E9E9E9;
	font-weight: bold;
	font-size: 15px;
	background-color: #000;
	color: #F5DF3C;
	width: 130px;
	height: 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

.button:hover{
	background-color: #FCF4C0 ;
	border: 1px solid #E9E9E9;
	font-weight: bold;
	font-size: 15px;
	color: #333;
	width: 130px;
	height: 40px;
	text-align: center;
	border-radius: 7px;
	cursor: pointer;
}
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

<script type="text/javascript">

$(function(){
	$("#backBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/login/find.jsp";
	})
	
	$("#passBtn").click(function(){
		location.href="http://team3.aws.sist.co.kr/user/login/find.jsp";
	})
})//ready
</script>

</head>
  
<!-- NAVBAR
================================================== -->
  <body>
 <div class="wrapper">
		<jsp:include page="../../main/main_header_nav.jsp"/>
	
	<!-- Standard button -->

   <div class="container marketing">
  <br/><br/>
  <div style="width: 300px;text-align: center; margin: 0px auto;">
  <br>
  <h2>아이디 찾기</h2>
  </div>
  <c:catch var="e">
  <%request.setCharacterEncoding("UTF-8"); 
  	String kname = request.getParameter("id_kname");
  	String email = request.getParameter("id_email");
  	
  	if(kname ==null || email == null){
  %>
  <c:redirect url="find.jsp"/>
  <%
  	}
  	FindSelect fs = new FindSelect();
  	String resultId = fs.findId(kname, email);
  	if(resultId==null){%>
  		<script type="text/javascript">
  		alert("잠시 후 다시 시도해주시기 바랍니다.");
  		history.back();
  		</script>
  	<%}
  	String id = resultId.substring(0,resultId.length()-2)+"**";
  	pageContext.setAttribute("kname", kname);
  	pageContext.setAttribute("id", id);
  %>
  
  <br>
  <hr style="width: 500px"/>
  <br>
  </c:catch>
  
  <div id="result">
  <c:choose>
  <c:when test="${not empty id}">
	  ${kname}님의 ID는 <span id="markID">${id}</span> 입니다.<br><br><br><br>
	<input type="button" id="loginBtn" class="button" value="로그인"/>&nbsp;
	<input type="button" id="passBtn" class="button" value="비밀번호 찾기"/>
  <br/><br/>
  </c:when>
  <c:otherwise>
  <br/><br/>
  유효한 회원 정보가 아닙니다.
  <br/><br/>
	<input type="button" id="backBtn" class="button" value="뒤로 가기"/>
  </c:otherwise>
  </c:choose>
  </div>
  </div>
    
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</div>

	<jsp:include page="../../main/main_footer.jsp"/>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/jsp_prj/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
