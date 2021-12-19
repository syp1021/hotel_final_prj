<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.admin.member.Admin_Decription"%>
<%@page import="kr.co.sist.admin.member.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.member.MemberSelect"%>
<%@page import="kr.co.sist.admin.member.MemberDelete"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="특정 탈퇴회원 조회"
	%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 탈퇴회원조회</title>
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
	border-radius: 10px;
	width: 70px;
	background-color: #454D55;
	color: #ffffff;
}

.member_select {
	background-color: #454D55;
}

#page{
	margin-top : 50px;
	padding-left:420px;
}

.pagination>li>a {color:#343A40}

.form-control{
	font-size:15px;
	color:#000000;
	height:40px;
	width: 180px;
	margin:0px;
}

.table{
	margin-top: 80px;
	margin-left: 50px;
	font-size: 15px;
	margin-bottom:0px;
	width:1200px;
	text-align: center;
	
	}

th{
	width:80px;
	height:20px;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	background-color: #dfdfdf;
	}
	
td{
	font-size: 16px;
	height:20px;
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
	
</script>
</head>
<body>
	<div id="wrap">
		<!-- header/navibar import -->
		<c:import url="../common/admin_header_nav.jsp" /> 
		<div id="container">
			<div id="naviBar2">
				<span id="mainMenu" style="text-decoration: none"
					onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_member/admin_member_select.jsp'">회원조회</span>
				&nbsp; <span id="mainMenu"
					onclick="location.href='http://team3.aws.sist.co.kr/admin/admin_member/admin_member_delete.jsp'">탈퇴회원</span>
					
				<form name="frm_search" action="http://team3.aws.sist.co.kr/admin/admin_member/admin_member_specific_delete.jsp" method="post">
					<input type="text" name="search" placeholder="ID조회" id="id_search"class="form-control" maxlength="10" /> 
					<input type="submit"value="검색" name="search" class="btn btn-default" id="search" />
				</form>
			</div>
				<div id="roomList"> 
				<br/>
				<br/>
				<br/>
				</div>
			<table class="table table-bordered" id="table">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>탈퇴일자</th>
				</tr>	
					<c:catch var="e">
						<%	
						request.setCharacterEncoding("utf-8");
						String id = request.getParameter("search");
						DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");
						Admin_Decription ad = new Admin_Decription();
						pageContext.setAttribute("kname",ad.DecryptDeleteSearchData(id));
						%>
						<tr>
							<td><c:out value="${kname.id }" /></td>
							<td><c:out value="${kname.kname }" /></td>
							<td><c:out value="${kname.out_date }" /></td>
						</tr>
					</c:catch>
					<c:if test="${ not empty e }">
						<tr>
							<td colspan="3">
							<span style="color: #ff0000"><c:out value="${ param.search }" /></span>회원은 존재하지 않습니다.</td>
						</tr>
					</c:if>
					</table>
		</div>
	<!-- footer import -->
	<c:import url="../common/admin_footer.jsp" />
	</div>
</body>
</html>