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
	href="http://localhost/hotel_final_prj/common/css/main_v20211012.css">

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
	href="http://localhost/hotel_final_prj/admin/css/admin_main.css">
	
	
<style type="text/css">

#memberSearch{
	font-size: 16px;
	font-weight: bold;
	margin-left :20px;
	padding-top :20px;
	padding-left :10px;
	padding-bottom :65px;
	border-bottom: 1px solid #454D55;
	width:100%;
	hegiht:200px;
}

#memberList{
   width:100%;
   padding-left:25px;
}

#id{
	width:200px;
	margin-right: 5px;
	font-size: 15px;
	color:#000000;
	position: absolute;
	top: 165px;
	left: 85px;	
}

#searchBtn{
	position:absolute;
	top: 125px;
	left: 310px;
	width: 80px;
	height: 70px;
}

.table{
	width:1400px;
	margin-top: 40px;
	}

.table-bordered>tbody>tr>th{
	height:40px;
	font-size: 16px;
	text-align: center;
	vertical-align: middle;
	background-color: #dfdfdf;
	border:1px solid #C0C5CE;
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
.btn{
	font-weight: bold;
}

#page {
	margin-top: 50px;
	padding-left: 600px;
}

.pagination>li>a {
	color: #343A40;
	font-size: 17px;
}

#navMember{
	background-color: #454D55;
	text-decoration: none;
}

input[type=radio]{	
	width: 18px;
	height: 18px;
	margin: 5px 5px 5px
}
</style>

<script type="text/javascript">
//예약삭제 결과 메시지
<c:choose>
	<c:when test="${delResult eq 'true'}">
		alert("회원이 삭제되었습니다.");
	</c:when>
	<c:when test="${delResult eq 'false'}">
		alert("죄송합니다. 잠시 후 다시 시도해주세요.");
	</c:when>
</c:choose>

$(function(){
	//회원 구분별 조회
	$("#searchBtn").click(function(){
		 //일반회원, 탈퇴회원 중 선택한 회원값을 히든에 할당
		 var radioVal = $('input[name="activeType"]:checked').val();
		 $("#m_status").val(radioVal);
		 
		$("#frm_search").submit();
	})//click
	
/* 페이지네이션 클릭시 현재페이지 전송 */
	$(".pagination li").click(function () {
		let page = $(this).text();
		let currentPage = ${currentPage};
		let totalPage = ${totalPage};
	
		//이전 버튼 클릭
		if(page == '<<') {
			if(currentPage == 1) { //현재 1 페이지면 1 반환
				page = 1; 
			} else {
				page = currentPage-1;
			}//end else
		}//end if  
		
		//다음 버튼 클릭
		if(page == ">>") {
			if(currentPage == totalPage) {//현재 끝 페이지면 끝 반환
				page = totalPage; 
			} else {
				page = currentPage+1;
			}//end else
		}//end if  
	 	
		 //일반회원, 탈퇴회원 중 선택한 회원값을 히든에 할당
		 var radioVal = $('input[name="activeType"]:checked').val();
		 $("#m_status").val(radioVal);
		 $("#page").val(page);
		 
		 $("#frm_search").submit();
	});//페이지네이션 click

	$(".delBtn").click(function(){
		//선택된 버튼 할당
		var delBtn = $(this);
		//선택된 버튼에 해당하는 행과 각 td
		let tr = delBtn.parent().parent(); 
		let td = tr.children();
		//삭제번호 얻기
		let id = td.eq(1).text();
		if(confirm("["+id+"] 회원을 삭제하시겠습니까?")){
			$("#delId").val(id);
			$("#delFrm").submit();
		}else{
			alert("회원 삭제를 취소합니다.");
		}//end else
	});//click
	
	
	$('input[name="activeType"]:radio').change(function(){
		$("#id").val("");
	});//change
	
})//ready

</script>
</head>
<body>
	<div id="wrap">
		<!-- header/navibar import -->
		<jsp:include page="/admin/common/admin_header_nav.jsp"/>
			
		<!-- 컨테이너 시작 -->
		<div id="container">
		<span id="mainMenu" onclick="location.href='search_member.do'">회원 조회</span><br/><br/>
		
		<div id="memberSearch">
		<form id="frm_search" action="search_member.do" method="post">
			<input type="radio" name="activeType" value="Y" 
				${empty radioValue || radioValue eq '' || radioValue eq 'Y' ?' checked="checked"':""}/>일반회원 &nbsp;
			<input type="radio" name="activeType" value="N" 
				${radioValue eq 'N' ?' checked="checked"':""}/>탈퇴회원  &nbsp;
			<input type="hidden" name="m_status" id="m_status"/>
			<input type="hidden" name="page" id="page"/>
				<c:choose>
					<c:when test="${not empty requestScope.id}">
						<input type="text" name="id" value="${requestScope.id}"  class="form-control" id="id" maxlength="10"/>&nbsp;
					</c:when>
					<c:otherwise>
						<input type="text" name="id" placeholder="ID 조회"  class="form-control" id="id" maxlength="10"/>&nbsp;
					</c:otherwise>
				</c:choose>
					<input type="button" value="검색" name="search" class="searchBtn btn btn-default" id="searchBtn" />
		</form>	
		</div>
		
			<div id="memberList"> 
			<c:choose>
			<c:when test="${empty radioValue || radioValue eq '' || radioValue eq 'Y'}">
			<table class="table table-bordered"  id="table">
				<tr>
					<th>No.</th>
					<th style="width:130px">ID</th>
					<th style="width:100px">회원명</th>
					<th style="width:130px">영문이름</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>가입일자</th>
					<th>회원상태</th>
					<th>회원관리</th>
				</tr>	
			 <c:if test="${ empty acitveMemList }">
	   			<tr> 
	     		 <td colspan="10">회원정보가 존재하지 않습니다.</td>
	   			</tr>
   			</c:if>
				<c:forEach var="member" items="${acitveMemList}">
				<tr>
					<td><c:out value="${member.rNum }"/></td>
					<td><c:out value="${member.id }"/></td>
					<td><c:out value="${member.kname }"/></td>
					<td><c:out value="${member.ename_fst} ${member.ename_lst }"/></td>
					<td><c:out value="${member.birth_year }"/></td>
					<td><c:out value="${member.tel }"/></td>
					<td><c:out value="${member.email }"/></td>
					<td><c:out value="${member.join_date }"/></td>
					<td>정상</td>
					<td><input type="button" id="delBtn" name="delBtn" class="delBtn btn btn-danger" value="회원삭제"></td>
				</tr>
				</c:forEach>
			</table>
			</c:when>
			
			<c:when test="${radioValue eq 'N'}">
			<table class="table table-bordered" id="table">
				<tr>
					<th>No.</th>
					<th style="width:140px">ID</th>
					<th>회원명</th>
					<th>영문이름</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>탈퇴일자</th>
					<th>회원상태</th>
					<th>회원관리</th>
				</tr>
				<c:if test="${  empty inacitveMemList }">
					<tr>
						<td colspan="10">회원정보가 존재하지 않습니다.</td>
					</tr>
				</c:if>
					<c:forEach var="member" items="${inacitveMemList}">
						<tr>
							<td><c:out value="${member.rNum }" /></td>
							<td><c:out value="${member.id }" /></td>
							<td><c:out value="${member.kname }" /></td>
							<td> - </td>
							<td> - </td>
							<td> - </td>
							<td> - </td>
							<td><c:out value="${member.out_date }" /></td>
							<td>탈퇴</td>
							<td> - </td>
						</tr>
					</c:forEach>
			</table>
			</c:when>
			</c:choose>
		 </div>			
		 
		<c:if test="${totalPage ne 0}">
		<ul class="pagination" id="page">
		    <li><a href="#void">&lt;&lt;</a></li>
		    <c:forEach var="num" begin="1" end="${totalPage}" step="1">
		    	<c:if test="${num eq currentPage}">
		    		<c:set var="active" value="style='background:#dfdfdf'"/>
			    </c:if>
			    <li><a href="#void" ${active}><c:out value="${num}"/></a></li>
		    	<c:set var="active" value=""/>
		    </c:forEach>
		    <li><a href="#void">&gt;&gt;</a></li>
		 </ul>
		 </c:if>
		
		</div> <!-- 컨테이너 div  -->
		
		<!-- 삭제버튼 클릭시 hidden값 설정 및 페이지 이동 -->
		 <form name="delFrm" id="delFrm" action="delete_member.do" method="post">
		 	<input type="hidden" name="delId" id="delId"/>
		 </form>
		 
		<!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
		
	</div>
</body>
</html>