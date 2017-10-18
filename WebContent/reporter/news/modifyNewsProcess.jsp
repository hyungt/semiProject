<%@page import="kr.co.jtimes.common.dao.CommonsDao"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% 
	ReporterEmployeeVo reporter = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	
	request.setCharacterEncoding("utf-8");
	
	TbNewsDao dao = new TbNewsDao();
	CommonsDao commonDao = new CommonsDao();	
	
	int newsType = Integer.parseInt(request.getParameter("newstype"));
	int newsCategory = Integer.parseInt(request.getParameter("newscategory"));
	int newsNo = Integer.parseInt(request.getParameter("newsNo"));
	String newsLocation = request.getParameter("newslocation");
	String newsTitle = request.getParameter("title");
	String newsContents = request.getParameter("ir1");
	String mainImgPath = request.getParameter("mainimgpath");
	
	TbNewsVo news = dao.getNewsBack(newsNo);

	news.setNewsType(commonDao.getNewsTypeByNo(newsType));
	news.setCategory(commonDao.getCategoryByNo(newsCategory));
	news.setNewsLocation(newsLocation);
	news.setNewsTitle(newsTitle);
	news.setNewsContents(newsContents);
	
	dao.updateToNews(news);

	response.sendRedirect("/reporter/news/writeList.jsp");
%>