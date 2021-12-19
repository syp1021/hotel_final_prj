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
    pageEncoding="UTF-8" info="객실 추가 시 이미지 업로드 프로세스"
    trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//부적절한 페이지 이동시 redirect
if (request.getContentType() == null) {
	response.sendRedirect("admin_room_add.jsp");
	return;
}//end if

	//temp폴더에 파일 업로드
	File uploadPath = new File("/usr/local/www/hotel_prj/temp");

	if(!uploadPath.exists()){ // 경로에 업로드 폴더가 없으면 생성
		uploadPath.mkdirs();
	}//end if
	
	int maxSize = 1024*1024*5; // 5 Mbyte
	MultipartRequest mr = new MultipartRequest(request, uploadPath.getAbsolutePath(), 
			maxSize, "UTF-8");
	
	UploadImgList uil = new UploadImgList();
	
	
	//main이미지로 등록되었으면 파일명 변경하여 저장
	String fileName = mr.getParameter("fileName");
	if(!(fileName.equals(""))){
		uil.markMainImg(fileName);
	}//end if

	//temp 파일에 있는 이미지 리스트 조회하여 JSONObject로 Return 
	List<UploadImgVO> imgList = uil.searchImgList();
	JSONObject imgJson = new JSONObject();
	
	JSONArray ja = new JSONArray();
	JSONObject jo = new JSONObject();
	for(UploadImgVO imgVO : imgList){
		jo = new JSONObject();
		jo.put("imgName", imgVO.getImgName());
		jo.put("imgLeng", imgVO.getImgLeng() + " KB");
		ja.add(jo);
	}//end if	
	
	imgJson.put("imgData", ja);
	
	out.println(imgJson.toJSONString());
	
%>
