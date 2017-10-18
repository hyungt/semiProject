<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));

	TbNewsDao dao = new TbNewsDao();
	dao.deleteTemporaryNews(no);
%>