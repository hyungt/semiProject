<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.jtimes.util.JsonDateConvertor"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignResult"%>
<%@page import="kr.co.jtimes.common.criteria.SignCriteria"%>
<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%
	final int rowsPerPage = 20, naviPerPage = 5;
	String state = request.getParameter("state");
	int page_no = Integer.parseInt(request.getParameter("pno"));
	
	NewsSignDao signDao = new NewsSignDao();
	ReporterEmployeeVo user = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	
	SignCriteria criteria = new SignCriteria();
	
	criteria.setSignerNo(user.getReporterNo());
	criteria.setState(state);
	
	int totalRow = 0;
	
	if(user.getReporterPos().getPositionNo() == 200) {
		totalRow = signDao.getTotalFirtsRows(criteria);
	} else if (user.getReporterPos().getPositionNo() == 100) {
		totalRow = signDao.getTotalSecondRows(criteria);
	}
	
	int totalPages = (int)Math.ceil((double)totalRow / rowsPerPage);	
	if(page_no > totalPages) {
		page_no = 1;
	}
	
	int beginIndex = (page_no - 1) * rowsPerPage + 1; 
	int endIndex = page_no * rowsPerPage;
	
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double)naviPerPage);
	int currentNaviBlock = (int) Math.ceil(page_no/(double)naviPerPage);
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if(currentNaviBlock >= totalNaviBlocks) {
		endPage = totalPages;
	}
	
	criteria.setBeginIndex(beginIndex);
	criteria.setEndIndex(endIndex);
	
	List<NewsSignVo> signList = new ArrayList<>();
	if(user.getReporterPos().getPositionNo() == 200) {
		signList = signDao.getFirstSignListByState(criteria);
	} else if (user.getReporterPos().getPositionNo() == 100) {
		signList = signDao.getSecondSignListByState(criteria);
	}
	
	NewsSignResult result = new NewsSignResult();
	result.setBeginPage(beginPage);
	result.setEndPage(endPage);
	result.setCurrentNaviBlock(currentNaviBlock);
	result.setTotalNaviBlocks(totalNaviBlocks);
	result.setSignList(signList);
	result.setTotalPages(totalPages);
	
	GsonBuilder builder = new GsonBuilder();
	builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
	Gson data = builder.create();
	String jsonData = data.toJson(result);
	
	response.getWriter().println(jsonData);
	
%>