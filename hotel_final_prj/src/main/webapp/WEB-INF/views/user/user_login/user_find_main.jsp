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
	.container{
		height:800px;
	}
	
	#idDiv{
		position: absolute;
		top: 200px;
		left: 350px;
		border: 1px solid #d3d3d3;
		width:500px;
		height:500px;
		padding:30px;
		border-radius: 30px;
		padding-top:40px;
	}
	
	#pwDiv{
		clear:both;
		position: absolute;
		top: 200px;
		left: 1000px;
		border: 1px solid #d3d3d3;
		width:500px;
		height:500px;
		padding:30px;
		border-radius: 30px;
		padding-top:40px;
	}
	
	
	.findTitle {
		color: #333;
		font-weight: bold;
		font-size: 25px
	}
	
	.findDiv{
		width: 700px; 
		text-align: center;
		margin: 0px auto;
		font-size:14px;
	}
	
	.findText{
		width : 250px;
		margin-left: 95px;
	}
	.searchBtn:hover {
		background-color: #FCF4C0  ;
		color: #333;
		cursor: pointer;
	}
	
	.searchBtn {
		border: 1px solid #E9E9E9;
		font-size : 15px;
		font-weight: bold;
		background-color: #FAFAFA;
		color: #333;
		width: 260px;
		height : 40px;
		cursor: pointer;
		text-align: center;
		border-radius: 7px;
	}
	#btn {
		border: 1px solid #E9E9E9;
		font-size : 17px;
		font-weight: bold;
		background-color: #000;
		color: #F5DF3C;
		cursor: pointer;
		text-align: center;
		border-radius: 7px;
		clear:both;
		position: absolute;
		top:800px;
		left:875px
	}
	
	#btn:hover {
		background-color: #F5dF4D;
		color: #000000;
		cursor: pointer;
	}
	</style>

    <script type="text/javascript">
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
	<jsp:include page="/user/common/main_header_nav.jsp"/>
	
	<!-- Standard button -->

  <div class = "container">	   
  <br/><br/>
  
  
  <div class="findDiv" id="idDiv">
  <p class="findTitle">아이디 찾기</p>
  <hr>
  <br/> <br/> <br/>
  
  <form action="user_find_id.do" method="post" id="fidFrm" name="fidFrm">
	  <label>이름</label>
	  <input type="text" class="findText form-control" name="id_kname" id="id_kname" placeholder="이름을 입력하세요." maxlength="10"/>
	  <br/>
	  <label>이메일</label>
	  <input type="text" class="findText form-control" name="id_email" id="id_email" placeholder="가입시 등록한 이메일을 입력하세요." maxlength="30"/>
	  <br/><br/><br/>
	  <input type="button" class="searchBtn button" id="findIDBtn" value="아이디 찾기">
	 
	  <br/><br/>
	  <br/><br/>
  </form>
  </div>
 
	
  <div class="findDiv" id="pwDiv">
  <p class="findTitle">비밀번호 찾기</p>
  <hr>
	  <br>
  <form action="user_find_password.do" method="post" id="fpwFrm" name="fpwFrm">
	  <label>아이디</label>
	  <input type="text" class="findText form-control" name="pw_id" id="pw_id" placeholder="아이디를 입력하세요." maxlength="20"/>
	  <br/>
	  <label>이름</label>
	  <input type="text" class="findText form-control" name="pw_kname" id="pw_kname" placeholder="이름을 입력하세요." maxlength="10"/>
	  <br/>
	  <label>이메일</label>
	  <input type="text" class="findText form-control" name="pw_email" id="pw_email" placeholder="가입시 등록한 이메일을 입력하세요." maxlength="30">
	  <br/><br/><br/>
	  <input type="button" class="searchBtn button" value="비밀번호 찾기" id="findPWBtn"/>
  </form>
  </div>
	<button type="button" id="btn" style="width: 100px; height: 40px"
		 onclick="location.href='http://localhost/hotel_final_prj/user/user_main/Hotel_Ritz_Seoul.do'">홈으로</button>
	  
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
 </div>
      <!-- FOOTER -->
	<jsp:include page="/user/common/main_footer.jsp" />
 </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="http://localhost/hotel_final_prj/common/bootstrap/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
