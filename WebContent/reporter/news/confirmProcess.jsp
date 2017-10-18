<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%
	int newsNo = Integer.parseInt(request.getParameter("newsNo"));
	int signNo = Integer.parseInt(request.getParameter("signNo"));

	ReporterEmployeeVo loginUser = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	
	NewsSignDao signDao = new NewsSignDao();
	NewsSignVo newsSign = signDao.getNewsSign(signNo);
	
	if(loginUser.getReporterPos().getPositionNo() > 200) {
		response.sendRedirect("/reporter/");
		return;
	} else if(loginUser.getReporterPos().getPositionNo() == 200) {//부장일때
		newsSign.setFirstSignState("Y");
		signDao.updateSign(newsSign);
	} else {	//국장일때
		newsSign.setSecondSignState("Y");
		signDao.updateSign(newsSign);
		TbNewsDao newsDao = new TbNewsDao();
		TbNewsVo news = newsDao.getNewsBack(newsNo);
		news.setNewsSignState("Y");
		newsDao.updateToNews(news);
	}
	
	response.sendRedirect("/reporter/news/confirmNews.jsp");
%>