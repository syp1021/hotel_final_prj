<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="관리자 공통 디자인 - header, navi"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:if test = "${empty sessionScope.mg_id}">
  	<script type="text/javascript">
 	alert("로그인 되지 않았습니다.");
 	location.href="admin_login_form.do";
 	</script>  
</c:if>
		<div id="header">
		Hotel Ritz Seoul  &nbsp; &nbsp;
		<span id="homeBtn" class="glyphicon glyphicon-home cursor" aria-hidden="true" onclick="location.href='admin_main.do'"></span>
		<span class="glyphicon glyphicon-user" aria-hidden="true" id="adminImg" ></span>
		<span style="position: absolute; right: 3px; top: 7px;"><strong> ${sessionScope.mg_id} </strong></span>
		<span id="logOut" class="cursor" onclick="location.href='admin_logout.do'">로그아웃</span>
		</div>

		<nav id="naviBar">
			<ul>
				<li class="navLi"><a id="navMember" href="search_member.do"><span
						class="glyphicon glyphicon-triangle-right"></span> 회원관리</a></li>
				<li class="navLi"><a id="navReserv" href="search_res_list.do"><span
						class="glyphicon glyphicon-triangle-right"></span> 예약관리</a></li>
				<li class="navLi"><a id="navRoom" href="search_room.do"><span
						class="glyphicon glyphicon-triangle-right"></span> 객실관리</a></li>
			</ul>
		</nav>
		
