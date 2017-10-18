<%@page import="java.net.URLDecoder"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@page import="kr.co.jtimes.common.vo.NewsCategoryVo"%>
<%@page import="kr.co.jtimes.common.vo.NewsTypeVo"%>
<%@page import="kr.co.jtimes.news.vo.TemporaryNewsVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% 
	ReporterEmployeeVo reporter = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	request.setCharacterEncoding("utf-8");
	int newsType = 0, newsCategory = 0, firstSigner = 0, secondSigner = 0;
	String newsLocation = "", newsTitle = "", newsContents = "", mainPath = "";
	
	try {
		newsType = Integer.parseInt(request.getParameter("newsType"));
	} catch (Exception e) {}
	
	try {
		newsCategory = Integer.parseInt(request.getParameter("newsCategory"));
	} catch (Exception e) {
		System.out.println("newsCategory error");
		e.printStackTrace();
	}
	
	try {
		firstSigner = Integer.parseInt(request.getParameter("firstSigner"));
	} catch (Exception e) {
		System.out.println("firstSigner error");
		e.printStackTrace();
	}
	
	try {
		secondSigner = Integer.parseInt(request.getParameter("secondSigner"));
	} catch (Exception e) {
		System.out.println("secondSigner error");
		e.printStackTrace();
	}
	
	try {
		newsLocation = request.getParameter("newsLocation");
	} catch (Exception e) {
		System.out.println("newsLocation error");
		e.printStackTrace();
	}
	
	try {
		newsTitle = request.getParameter("newsTitle");
	} catch (Exception e) {
		System.out.println("newsTitle error");
		e.printStackTrace();
	}
		
	try {
		newsContents = request.getParameter("ir1");
		
	} catch (Exception e) {
		System.out.println("ir1 error");
		e.printStackTrace();
	}
	try {
		mainPath = request.getParameter("mainPath");
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	TemporaryNewsVo news = new TemporaryNewsVo();
	
	NewsTypeVo type = new NewsTypeVo();
	type.setNewsTypeNo(newsType);
	
	NewsCategoryVo category = new NewsCategoryVo();
	category.setCategoryNo(newsCategory);
	
	news.setType(type);
	news.setReporter(reporter);
	news.setCategory(category);
	news.setLocation(newsLocation);
	news.setImgPath(mainPath);
	news.setTitle(newsTitle);
	news.setContents(newsContents);
	TbNewsDao newsDao = new TbNewsDao();
	
	newsDao.insertTemporaryNews(news);
	
%>