<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="Hotel Ritz Seoul"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

	<!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">
	
    <title>Hotel_Ritz_Seoul</title>
    <!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">
	<style type = "text/css">
	
.hr1 {border-bottom: 1px solid #d3d3d3;}

.MyTitle {
	color: #333;
	font-weight: bold;
	font-size: 30px
}	
	
#pass {
	width: 250px;
	height : 40px;
	margin: 0px auto;
}

#btn:hover {
	background-color: #FCF4C0  ;
	color: #333;
	cursor: pointer;
}

#btn {
	border: 1px solid #E9E9E9;
	font-size : 15px;
	font-weight: bold;
	background-color: #FAFAFA;
	color: #333;
	width: 250px;
	height : 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

#gohome {
	border: 1px solid #E9E9E9;
	font-size : 14px;
	font-weight: bold;
	background-color: #000;
	color: #F5DF3C;
	width: 130px;
	height: 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

#gohome:hover {
	background-color: #F5dF4D;
	color: #000000;
	cursor: pointer;
}

/*
div { border: 1px solid #0000FF}
td { border: 1px solid #FF0000}
tr { border: 1px solid #FF0000}
span { border: 1px solid #FF00FF}
p { border: 1px solid #FF00FF}
*/
	</style>


<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<script type="text/javascript">

$(function() {
	$("#btn").click(function() {
		if($("#pass").val()==""){
			alert("비밀번호를 입력해 주세요.");
			return;
	}//end if

		$("#frm").submit();
	});//click	
	

});

function home(){
	alert("메인페이지로 이동합니다.");
	location.href="http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp"
}

</script>
</head>
 <jsp:useBean id="mVO" class="kr.co.sist.user.login.memberVO" scope="page"/>
<jsp:setProperty property="*" name="mVO"/><!--  입력정보-->
 <%
	String id=(String)session.getAttribute("id");
if(id==null){//세션이 존재하지 않으면 
	response.sendRedirect("http://team3.aws.sist.co.kr/user/login/login.jsp");
}//end if
%> 

<!-- NAVBAR
================================================== -->
  <body>
 		 <jsp:include page="../../main/main_header_nav.jsp"/>
 <form action="mypage_process.jsp"  method="post" id="frm" name="frm">
 
<br/><br/><br/><br/><br/><br/>
<div class="container" style="margin: 0px auto;">

<div style="text-align: center">
		<p class="MyTitle">마이페이지</p><br/>
 <hr class="hr1">
	</div>


<div style = "text-align: center; ">
<br/><br/><br/>
<input type="hidden" value="${ id }">
<p style = "font-size: 18px; font-weight: bold; ">비밀번호를 입력해주세요.</p>


<input type="password" name="pass" id="pass" class="form-control" placeholder="현재 비밀번호를 입력하세요">
<br/>
<button type="button" id="btn" >확인</button><!--  button으로 해야지 submit올 하면 실패하더라도전송됩니다.-->
<br/><br/><br/><br/><br/><br/>
<button type="button" id = "gohome" onclick="home()">홈으로</button>

</div>
</div>
   </form>
   
  <br/><br/><br/><br/><br/><br/>
</body>

  <!-- FOOTER -->

 <jsp:include page="../../main/main_footer.jsp"/>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>