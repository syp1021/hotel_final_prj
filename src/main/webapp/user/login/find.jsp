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

    <title>Hotel_Ritz_Seoul</title>
    <!-- 메인 CSS -->
	<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/main/main.css">
    
	<style type = "text/css">
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
    function main() {
		alert("메인 페이지로 이동합니다.");
		location.href = "http://team3.aws.sist.co.kr/main/Hotel_Ritz_Seoul.jsp"
	}
    
    $(function(){
    	//아이디찾기
    	$("#findIDBtn").click(function(){
    		
    		var id_kname = $("#id_kname").val();
    		var id_email = $("#id_email").val();
    		
    		//null check
    		if(id_kname =="" || id_email==""){
    			alert("이름과 이메일을 모두 입력해주세요.");
    			return;
    		}//end if
    		
    		//한글입력 check
            var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
       	 	if (regexp.test(id_kname)) {
       	 		alert("한글만 입력해주세요.");
       	 		return;
       		 }
            
            //이메일 형식 check
            var regExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            if(!(regExp2.test(id_email))){
            	alert("이메일 형식에 맞게 입력해주세요.")	;
            	return;
            }
            
    		$("#fidFrm").submit();
    	});//findIDBtn
    	
    	//비밀번호찾기
    	$("#findPWBtn").click(function(){
    		
    		var pw_id = $("#pw_id").val();
    		var pw_kname = $("#pw_kname").val();
    		var pw_email = $("#pw_email").val();
    		
    		//null check
    		if(pw_id=="" || pw_kname =="" || pw_email==""){
    			alert("아이디, 이름, 이메일을 모두 입력해주세요.");
    			return;
    		}//end if
    		

    		//한글입력 check
            var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
       	 	if (regexp.test(pw_kname)) {
       	 		alert("이름은 한글만 입력해주세요.");
       	 		return;
       		 }
            
            //이메일 형식 check
            var regExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            if(!(regExp2.test(pw_email))){
            	alert("이메일 형식에 맞게 입력해주세요.")	;
            	return;
            }
            
    		$("#fpwFrm").submit();
    	})//findPWBtn
    	
    });//ready
    
    
    function emailFormChk(ele){
    	var regExp2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    	if (ele.match(regExp2) == null) {
            return false;
        }else{
        	return true;
        }
    }//emailFormChk
    
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
  
  <form action="find_id.jsp" method="post" id="fidFrm" name="fidFrm">
  
  <div style="width: 300px; margin: 0px auto;">
  <h2 style="text-align: center; ">아이디 찾기</h2>
  </div>
  
  <hr style="width: 500px;"/>
  <br>
  
  <div style="width: 300px; text-align: center; margin: 0px auto;">
  
  <label>이름</label>
  <input type="text" class="form-control" name="id_kname" id="id_kname" placeholder="이름을 입력하세요" maxlength="10"/>
  
  <br/><br/>
  
  <label>이메일</label>
  <input type="text" class="form-control" name="id_email" id="id_email" placeholder="가입시 등록한 이메일을 입력하세요" maxlength="30"/>
  
  <br/><br/><br/><br/>
  <input type="button" class="button" id="findIDBtn" value="아이디 찾기">
  
  </div>
  
  <br/><br/>
  <hr/>
  <br/><br/>
  
  </form>
  
  <form action="find_pass.jsp" method="post" id="fpwFrm" name="fpwFrm">
  
  <div style="width: 300px; text-align: center; margin: 0px auto;">
  <h2 style="text-align: center;">비밀번호 찾기</h2>
  </div>
  <br>
  
  <hr style="width: 500px; margin: 0px auto;"/>
  <br>
  
  <div style="width: 300px; text-align: center; margin: 0px auto;">
  
  <label>아이디</label>
  <input type="text" class="form-control" name="pw_id" id="pw_id" placeholder="아이디를 입력하세요" maxlength="20"/>
  
  <br/><br/>
  
  <label>이름</label>
  <input type="text" class="form-control" name="pw_kname" id="pw_kname" placeholder="이름을 입력하세요" maxlength="10"/>
  
  <br/><br/>
  
  <label>이메일</label>
  <input type="text" class="form-control" name="pw_email" id="pw_email" placeholder="가입시 등록한 이메일을 입력하세요" maxlength="30">
  
  <br/><br/><br/><br/>
  
  <input type="button" class="button" value="비밀번호 찾기" id="findPWBtn"/>
  
  <br><br><br><br><br><br/><br/><br/><br/>
  
  </div>
  
  </form>
  
<div style="width: 1135px; text-align: center;">
<button type="button" class="button" style="width: 100px; height: 40px" onclick="main()">홈으로</button>
</div>
  
  </div>
  
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
      <!-- FOOTER -->
	<jsp:include page="../../main/main_footer.jsp"/>

</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://team3.aws.sist.co.kr/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
