<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
session.invalidate();
response.sendRedirect("http://team3.aws.sist.co.kr/admin/common/admin_logout_view.jsp");
%>
