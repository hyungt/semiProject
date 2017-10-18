<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	request.setCharacterEncoding("utf-8");

	String search = request.getParameter("search");
	response.sendRedirect("/reporter/profile/reporterList.jsp?search="+search);
%>