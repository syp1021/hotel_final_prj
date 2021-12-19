<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="kr.co.sist.admin.room.UploadImgVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.admin.room.UploadImgList"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="객실 추가 시 이미지 삭제 프로세스"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//부적절한 페이지 이동시 redirect
if (request.getContentType() == null) {
	response.sendRedirect("admin_room_add.jsp");
	return;
}//end if
	
	String fileName = request.getParameter("imgName");
	UploadImgList uil = new UploadImgList();
	
	//특정이미지 삭제 후 temp폴더에 있는 이미지 리스트 재조회
	uil.removeSelectedImg(fileName);
	List<UploadImgVO> imgList = uil.searchImgList();
		
	//다시 조회한 이미지 리스트 json에 할당
	JSONObject imgJson = new JSONObject();
	
	JSONArray ja = new JSONArray();
	JSONObject jo = new JSONObject();
	for(UploadImgVO imgVO : imgList){
		jo = new JSONObject();
		jo.put("imgName", imgVO.getImgName());
		jo.put("imgLeng", imgVO.getImgLeng() + " KB");
		ja.add(jo);
	}//end for
	
	imgJson.put("imgData", ja);
	
	out.println(imgJson.toJSONString());
	
%>
