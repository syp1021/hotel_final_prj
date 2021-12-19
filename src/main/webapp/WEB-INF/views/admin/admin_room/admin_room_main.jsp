<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="객실관리 메인"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hotel Ritz - 객실관리</title>
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
	
<!-- viewroom CSS -->
<link rel="stylesheet" type="text/css"
	href="http://localhost/hotel_final_prj/admin/css/admin_room_roomview.css">
	
<style type="text/css">
#addBtn{
	margin-top:30px;
	margin-left:40px;
}

#roomList{
	width:100%;
	margin-top:0px;
	margin-left:20px;
	border-bottom: 1px solid #454D55;
}

#roomTab{
	text-align: left;
}

.mainTd{
	width : 170px;
	height: 220px;
	padding-left:0px;
	padding-right : 10px;
	font-size: 15px;
	font-weight: bold;
	color:#000000;
	text-align: center;
}

.imgTd{
	width:10px;
	height:20px;
	text-align:center;
	padding:0px;
	margin:0px
}

.rStatus{
	width:120px;
	margin-bottom: 10px;
	border : 1px solid #454D55
}

.rStatus:hover{
	cursor:pointer;
}

#navRoom{
	background-color: #454D55;
	text-decoration: none;
}

</style>
<script type="text/javascript">
//객실추가 결과 메시지
<c:choose>
<c:when test="${insertResult eq 'true'}">
	alert("객실이 추가되었습니다.");
</c:when>
<c:when test="${insertResult eq 'false'}">
	alert("죄송합니다. 잠시 후 다시 시도해주세요.");
</c:when>
</c:choose>
//객실상태변경 결과 메시지
<c:choose>
<c:when test="${updateStatusResult eq 'true'}">
	alert("객실 상태가 변경되었습니다.");
</c:when>
<c:when test="${updateStatusResult eq 'false'}">
	alert("죄송합니다. 잠시 후 다시 시도해주세요.");
</c:when>
</c:choose>
//객실정보수정 결과 메시지
<c:choose>
<c:when test="${updateRoomResult eq 'true'}">
	alert("객실 정보가 변경되었습니다.");
</c:when>
<c:when test="${updateRoomResult eq 'false'}">
	alert("죄송합니다. 잠시 후 다시 시도해주세요.");
</c:when>
</c:choose>
//객실정보수정 시 객실이름 체크 결과 메시지
<c:if test="${dupRNameChk eq true}">
alert("동일한 이름의 객실이 존재하여 객실정보수정을 취소합니다.");
</c:if>
$(function(){
	
	//객실추가 시 
	 $("#addBtn").click(function(){
		 location.href="add_room_form.do";
	 });//click
	 
	 //객실정보수정 시
	 $("#chgBtn").click(function(){
		 var room =$("#roomName").val();
		 $("#selectedRName").val(room);
		 
		//조회된 이미지명을 담은 input type을 생성하여 form에 추가 후 submit 
			var imgList = document.getElementById("imgTable");
		    var chgFrm = $("#chgFrm")[0]; // 객실추가 form
		    var otherImgArr = new Array(); //기타이미지 담을 배열
		    var imgName; //for에서 이미지명 담을 변수
		    
			for (var i = 0; i < imgList.rows[0].cells.length; i++) {
				var imgName = imgList.rows[0].cells[i].innerText;
				if((imgName.indexOf("main")) != -1){
					var mainInput = document.createElement("input");
					mainInput.type = "hidden";
					mainInput.name = "mainImg";
					mainInput.value = imgName;
					chgFrm.appendChild(mainInput);
				}else{
					otherImgArr.push(imgName)
				}//end else
			}//end for
			
				var otherInput = document.createElement("input");
				otherInput.type = "hidden";
				otherInput.name = "otherImgs";
				otherInput.value = otherImgArr;
				chgFrm.appendChild(otherInput);
		 
		$("#chgFrm").submit();
	 });//click
	 
});//ready 

//이미지 클릭시 룸 상세보기
function showRoomDetail(roomName){
	$("#rName").val(roomName);
	$("#frm").submit();
}//showRoomDetail

</script>
</head>
<body>
	<div id="wrap">
	
		<!-- header/navibar import -->
		<jsp:include page="/admin/common/admin_header_nav.jsp"/>	
		
		<!-- 컨테이너 시작 -->
		<div id="container" style="padding:50px"> 
		<span id="mainMenu" onclick="location.href='search_room.do'">객실 조회</span><br/><br/>
		<input type="button" id="addBtn" class="btn btn-primary" value="객실 추가"/>
		
		<div id="roomList"> 
				
		<table id="roomTab">
		<tr>
		  <c:forEach var="roomList" items="${ roomList }">
	        <c:set var="rStatus" value="roomStatusY"/>
		    <c:set var="height" value=""/>
			<c:if test="${roomList.getrStatus() eq 'N'}">
		      <c:set var="rStatus" value="roomStatusN"/>
		      <c:set var="height" value="style='height:110px'"/>
		 	</c:if>
		 	<c:if test="${ not empty param.rName && param.rName eq roomList.getRoomName()}">
		      <c:set var="rStatus" value="roomStatusClick"/>
		      <c:set var="height" value=""/>
  			</c:if>
			<td class="mainTd">
  			<img src="http://localhost/hotel_final_prj/admin/room_status_img/${rStatus}.png" ${height} class="rStatus img-rounded"
  			onclick="showRoomDetail( '${roomList.getRoomName()}' )"/>
			<br/>
			<c:out value="${roomList.getRoomName()}"/></td>
		  </c:forEach>
		</tr>
		</table>
		</div> <!-- roomList div -->

		<form name="frm" id="frm" action="search_room.do" method="get">
			<input type="hidden" name="rName" id="rName"/>
		</form>
		
		<!-- 선택된 객실이 있으면 상세정보 보여줌 -->
		<c:if test="${ not empty param.rName }">
		
		<div id="viewRoom">
		<form name ="chgFrm" id ="chgFrm"  action="change_room_form.do" method="post">
		<input type="button" id="chgBtn" name="chgBtn" class="btn btn-primary" value="객실 정보 수정"/>
			<input type="hidden" name="selectedRName" id="selectedRName"/>
		<br/>
		<c:forEach var="rmVO" items="${ rmVO }">
		<label style="margin-left: 11px"> 활성화 여부</label><br/>
	    <input type="text" name="roomStatus" id="roomStatus" value ="${rmVO.rStatus=='Y'?'활성화':'비활성화'}" style="margin-left: 11px" class="form-control" maxlength="10" readonly="readonly"/>
		<table id="viewTab">	
		<tr>
			<td>
			  <label>객실명</label><br/>
			  <input type="text" name="roomName" id="roomName" value="${rmVO.roomName}" class="form-control" maxlength="10" readonly="readonly"/>
			</td>
			<td>
			  <label>1박 가격(원)</label><br/>
			  <input type="text" name="price" id="price" value="${rmVO.price}" class="form-control" maxlength="8" readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			  <label>메인 설명</label><br/>
			  <textarea id="mainDesc" name="mainDesc" rows="5" cols="100" readonly="readonly"><c:out value="${rmVO.mainDesc}"/></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			  <label>객실 개요</label><br/>
			  <table id="subTab">
			  <tr>
			  	<th>침대타입</th>
			 	<td class="subTd">
				  <input type="text" name="type" id="type" value="${rmVO.type}" class="form-control" maxlength="8" readonly="readonly"/>
			    </td>
			  	<th>투숙인원</th>
			 	<td class="subTd">
				  <input type="text" name="guestNum" id="guestNum" value="${rmVO.guestNum}명" class="form-control" maxlength="8" readonly="readonly"/>
				  <input type="hidden" name="guestNum" id="guestNum" value="${rmVO.guestNum}"/>
			    </td>
			  </tr>
			  <tr>
			  	<th>객실면적 (m<sup>2</sup>)</th>
			 	<td class="subTd">
			 	<input type="text" name="roomSize" id="roomSize" value="${rmVO.roomSize}" class="form-control" maxlength="10" readonly="readonly"/>
			    </td>
			  	<th>전망</th>
			 	<td class="subTd">
			 	<input type="text" name="view" id="view" value="${rmVO.view}" class="form-control" maxlength="10" readonly="readonly"/>
				</td>
				</tr>
				<tr>
			  	<th>체크인</th>
			 	<td class="subTd">
			 	<input type="text" name="chkIn" id="chkIn" class="form-control" maxlength="10" value="${rmVO.chkIn}" readonly="readonly"/>
			    </td>
			  	<th>체크아웃</th>
			 	<td class="subTd">
			 	<input type="text" name="chkOut" id="chkOut" class="form-control" maxlength="10" value="${rmVO.chkOut}" readonly="readonly" />
			   </td>
			  </tr>
			  </table>
			</td>
		<tr>
			<td colspan="2">
			  <label>특별 서비스</label><br/>
			  <textarea id="specialServ" name="specialServ" rows="6" cols="100" readonly="readonly"><c:out value="${rmVO.specialServ}"/></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			  <label>어메니티</label><br/>
			  <table>
			  <tr>
			  	<th>일반</th>
			  	<td class="subTd">
				 <textarea name="generalAmn" id="generalAmn" rows="2" cols="85" readonly="readonly"><c:out value="${rmVO.generalAmn}"/></textarea>
			  	</td>
			  </tr>
			  <tr>
			  	<th>욕실</th>
			  	<td class="subTd">
				 <textarea name="bathAmn" id="bathAmn" rows="2" cols="85" readonly="readonly"><c:out value="${rmVO.bathAmn}"/></textarea>
			  	</td>
			  </tr>
			  <tr>
			  	<th>기타</th>
			  	<td class="subTd">
				 <textarea name="otherAmn" id="otherAmn" rows="2" cols="85" readonly="readonly"><c:out value="${rmVO.otherAmn}"/></textarea>
			  	</td>
			  </tr>
			  </table>
		<tr>
			<td colspan="2">
			  <label>추가 정보</label><br/>
			  <textarea id="moreInfo" name="moreInfo" rows="7" cols="100" readonly="readonly"><c:out value="${rmVO.moreInfo}"/></textarea>
			</td>
		</tr>
		</table>
		<br/>
		
		<label style="margin-left:13px">객실 이미지 </label>
		<br/>
		<c:set var="mainImg" value="${rmVO.img}"/>
		</c:forEach>
		
		<table  id="imgTable" style="table-layout: fixed" >
		<tr><td class="imgTd">
		<img src="http://localhost/hotel_final_prj/roomImages/${mainImg}" title="${mainImg}" name="img" id="mainImg" class="viewImg" 
			style="padding:0px;margin:10px;border:7px solid #ffffff"/><br/>
		<span style="font-weight: bold;font-size: 14px"><c:out value="${mainImg}"/></span>
 		</td>
 		<c:if test="${not empty imgList}">
		 <c:forEach var="img" items="${imgList}">
		 <td class="imgTd">
		   <img src="http://localhost/hotel_final_prj/roomImages/${img.imgSrc}" title="${img.imgSrc}" name="img" id="otherImg" class="viewImg"
		   		style="padding:0px;margin:10px;border:7px solid #ffffff"/><br/>
			<span style="font-weight: bold;font-size: 14px"><c:out value="${img.imgSrc}"/></span>
		 </td>
		 </c:forEach>
		</c:if> <!-- not empty imgList -->
		</tr>
		</table>
		</form> <!-- chgFrm -->
		
		</div> <!-- view room div  -->
		</c:if> <!-- not empty param.rName  -->
		
		</div> <!-- 컨테이너 div -->
		
		<!-- footer import -->
		<jsp:include page="/admin/common/admin_footer.jsp"/>
		
	</div> <!-- wrap div -->
</body>
</html>