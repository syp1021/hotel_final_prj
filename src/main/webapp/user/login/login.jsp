<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info = "Hotel Ritz Seoul"%>
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

    <!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">
     <title>Hotel_Ritz_Seoul</title>
	<style type = "text/css">
	
.hr1 {border-bottom: 1px solid #d3d3d3;}

.loginTitle {
	color: #333;
	font-weight: bold;
	font-size: 25px
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
	width: 230px;
	height : 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 7px;
}

#join:hover {color:#333; font-weight: bold;}

#find:hover {color:#333;  font-weight: bold;}
/*
div { border: 1px solid #0000FF}
td { border: 1px solid #FF0000}
tr { border: 1px solid #FF0000}
span { border: 1px solid #FF00FF}
p { border: 1px solid #FF00FF}
*/
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
  $(function() {
		$("#btn").click(function() {
			if($("#id").val()==""){
				alert("아이디를 입력해 주세요.");
				return;
		}//end if
	
			if($("#pass").val()==""){
				alert("비밀번호를 입력해 주세요.");
				return;
		}//end if
			
			
			$("#frm").submit();
		});//click	
		

  });
  </script>
  
  </head>

<!-- NAVBAR
================================================== -->
	<jsp:include page="../../main/main_header_nav.jsp"/>
  <body>

	
      	<br/><br/><br/><br/><br/>
    <div class = "container">	
    <div style="text-align: center">
		<p class="loginTitle">로그인</p>
    <hr class="hr1">
			</div>

    <br/><br/>
    <form action="login_process.jsp"  method="post" id="frm" name="frm">
    <table style="margin: 0px auto; width: 230px">
    	<tr>
    		<tr>
    			<td style = "padding: 10px"><input type="text" placeholder="아이디" style = "height: 40px" name="id" id="id" class="form-control"> </td>
    		</tr>
    		<tr>
    			<td  style = "padding: 10px"><input type="password" placeholder="비밀번호" style = "height: 40px" name="pass" id="pass" class="form-control"> </td>
    		</tr>
    		<tr>
    			<td  style = "padding: 10px"><input type="button"  value="로그인"  id="btn" ></td>
    		</tr>
    		<tr>
    			<td style = "padding: 5px">
    			&nbsp;&nbsp;
    			<a href="http://team3.aws.sist.co.kr/user/login/signIn.jsp" style="color: #C0C0C0" ><span id = "join">회원가입&nbsp;&nbsp;</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;
    			<a href="http://team3.aws.sist.co.kr/user/login/find.jsp" style="color: #C0C0C0"><span id = "find">아이디/비밀번호 찾기</span></a></td>
    		</tr>
    </table>
    </form>
    
    </div>
    
    
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
      <!-- FOOTER -->
    <jsp:include page="../../main/main_footer.jsp"/>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
    <script>

   		
    	
    </script>
  </body>
</html>
