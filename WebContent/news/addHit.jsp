<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
	<%
		pageContext.setAttribute("url", "/index.jsp");
	%>
	
    <% 
		int no = Integer.parseInt(request.getParameter("newsNo"));
	
    	request.setCharacterEncoding("utf-8");
    
		TbNewsDao newsDao = new TbNewsDao();
		TbNewsVo news = newsDao.getNews(no);
		
		news.setNewsViewCnt(news.getNewsViewCnt() + 1);
		
		newsDao.updateNews(news);
		response.sendRedirect("/news/article.jsp?newsNo=" + no);
	%> 	