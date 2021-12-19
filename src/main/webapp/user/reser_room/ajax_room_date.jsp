<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.uesr.room.RoomVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.uesr.room.RoomSelect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info = "성인과 어린이의 수, 시작일과 끝날을 받아 JSONArray로 조회"
    trimDirectiveWhitespaces="true"
    %>


    
<%
String sd = request.getParameter("start_date");
String ed = request.getParameter("end_date");

String adult = request.getParameter("adult");
//int adultCount =  Integer.parseInt(adult);

String child = request.getParameter("child");
//int childCount =  Integer.parseInt(child);

//int adult = Integer.parseInt( adult );

RoomSelect rs = new RoomSelect();
List<RoomVO> list = rs.selectAvaileReserve(sd, ed, adult, child);

JSONObject jsonObj = new JSONObject();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
jsonObj.put("pubDate", sdf.format(new Date()));
jsonObj.put("searchStartDate", sd);
jsonObj.put("searchEndDate", ed);
jsonObj.put("adultCnt", adult);
jsonObj.put("childCnt", child);
jsonObj.put("dataRow", list.size() );
jsonObj.put("dataResult", !list.isEmpty() );

//JSONArray 생성
JSONArray jsonArr = new JSONArray();
JSONObject jsonTemp = new JSONObject();

//조회결과를 사용하여 JSONObject 생성
for( RoomVO rVO : list ){
	jsonTemp = new JSONObject();
	jsonTemp.put("room_no", rVO.getRoom_no());
	jsonTemp.put("r_name", rVO.getR_name());
	jsonTemp.put("description", rVO.getDescription());
	jsonTemp.put("price", rVO.getPrice());
	jsonTemp.put("main_img", rVO.getMain_img());
	jsonTemp.put("max_guest", rVO.getMax_guest());
	
	//생성된 JSONObject를 JSONArray에 추가
	jsonArr.add(jsonTemp);
}//end for

//JSONArray를 JSONObject에 할당
jsonObj.put("data", jsonArr);

//출력
out.print(jsonObj.toJSONString()); 
		
%>  

  