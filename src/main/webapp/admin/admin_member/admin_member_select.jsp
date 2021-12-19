<%@page import="kr.co.sist.admin.member.Admin_Decription"%>
<%@page import="kr.co.sist.user.login.MemberDAO"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.sist.admin.member.MemberUpdate"%>
<%@page import="kr.co.sist.admin.member.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="회원조회"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 회원관리</title>
<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/common/css/main_v20211012.css">

<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 관리자 메인 CSS -->
<link rel="stylesheet" type="text/css"
	href="http://team3.aws.sist.co.kr/admin/css/admin_main.css">
<style type="text/css">

.button {
	width: 70px;
	background-color: #454D55;
	color: #ffffff;
}

.member_select {
	background-color: #454D55;
}

#page {
	margin-top: 50px;
	padding-left: 420px;
}

.pagination>li>a {
	color: #343A40
}

.form-control{
	font-size:15px;
	color:#000000;
	height:40px;
	width: 180px;
	margin:0px;
}

.table{
	width:1100px;
	margin-top: 80px;
	margin-left: 60px;
	}

th{
	width:250px;
	height:40px;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	background-color: #dfdfdf;
	}
	
td{
	font-size: 16px;
	text-align: center;
	vertical-align: middel;
	color:#000000;
	background-color: #FFFFFF;
}
tr:hover td {
	background-color: #F1F3F4;
	cursor:pointer;
}

#id_search{
position: absolute; top: 80px; left: 1000px;
}

#search{
position: absolute; top: 80px; left: 1200px;
}

#roomList{
   width:100%;
   padding-left:20px;
   border-bottom: 1px solid #454D55;
}
</style>


<script type="text/javascript">
$(function(){
$("#search").click(function(){
	$("#frm_search").submit();
})//click

$(".delBtn").click(function(){
	//선택된 버튼 할당
	var delBtn = $(this);
	//선택된 버튼에 해당하는 행과 각 td
	let tr = delBtn.parent().parent(); 
	let td = tr.children();
	//삭제번호 얻기
	let id = td.eq(0).text();
	if(confirm("["+id+"] 회원을 삭제하시겠습니까?")){
		$("#delId").val(id);
		$("#delFrm").submit();
	}else{
		alert("회원 삭제를 취소합니다.");
	}//end else
})//click
})//ready

</script>
</head>
<body>
<jsp:useBean id="ev" class="kr.co.sist.admin.member.MemberVO" scope="page"/>
<jsp:setProperty property="*" name="ev"/>
<c:catch var="e">
<%
request.setCharacterEncoding("utf-8");
Admin_Decription ad = new Admin_Decription();
List<MemberVO> list = ad.allDecryptMemberData();

pageContext.setAttribute("memberData", list);
%>
</c:catch>
	<div id="wrap">
		<!-- header/navibar import -->
		 <c:import url="../common/admin_header_nav.jsp" />  
		<!-- 컨테이너 시작 -->
		<div id="container">
			<div id="naviBar2">
				<span id="mainMenu" onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_member/admin_member_select.jsp'">회원조회</span> &nbsp; 
				<span id="mainMenu" style="text-decoration: none" onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_member/admin_member_delete.jsp'">탈퇴회원</span>
				<form name="frm_search" action="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_specific_select.jsp" method="post">
				<input type="text" name="search" placeholder="ID조회" id="id_search" class="form-control" maxlength="10"/>
				<input type="submit" value="검색" name="search" class="btn btn-default" id="search" />
				</form>	
				<div id="roomList"> 
				<br/>
				<br/>
				<br/>
				</div>			
			</div>
			<table class="table table-bordered"  id="table">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>영문이름</th>
					<th>회원삭제</th>
				</tr>	
			 <c:if test="${ empty memberData }">
   			<tr> 
     		 <td colspan="7">회원정보가 존재하지 않습니다.</td>
   			</tr>
   			</c:if>
				<c:forEach var="member" items="${memberData}">
				<tr>
					<td><c:out value="${member.id }"/></td>
					<td><c:out value="${member.kname }"/></td>
					<td><c:out value="${member.birth_year }"/></td>
					<td><c:out value="${member.tel }"/></td>
					<td><c:out value="${member.email }"/></td>
					<td><c:out value="${member.ename_fst }${member.ename_lst }"/></td>
					<td><input type="button" id="delBtn" name="delBtn" class="delBtn btn btn-danger" value="회원삭제"></td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<!-- 삭제버튼 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="delFrm" id="delFrm" action="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_del_process.jsp" method="post">
		 	<input type="hidden" name="delId" id="delId"/>
		 </form>
		<!-- footer import -->
		<c:import url="../common/admin_footer.jsp" />
	</div>
</body>
</html>