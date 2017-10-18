<%@page import="kr.co.jtimes.util.JsonDateConvertor"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsResult"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.jtimes.common.criteria.NewsCriteria"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%
	final int rowsPerPage = 5, naviPerPage = 5;
	TbNewsDao newsDao = new TbNewsDao();
	
	int category_no = Integer.parseInt(request.getParameter("category"));
	int page_no = Integer.parseInt(request.getParameter("pno"));
	int totalRow = newsDao.getNewsCountAllByCategory(category_no);
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
	
	NewsCriteria criteria = new NewsCriteria();
	criteria.setBeginIndex(beginIndex);
	criteria.setEndIndex(endIndex);
	criteria.setCategoryNo(category_no);
	
	List<TbNewsVo> newsList = newsDao.getNewsByCategory(criteria);
	TbNewsResult result = new TbNewsResult();
	
	result.setBeginPage(beginPage);
	result.setEndPage(endPage);
	result.setCurrentNaviBlock(currentNaviBlock);
	result.setTotalNaviBlocks(totalNaviBlocks);
	result.setNewsList(newsList);
	result.setNewsCategory(category_no);
	result.setTotalPages(totalPages);
	
	GsonBuilder builder = new GsonBuilder();
	builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
	Gson data = builder.create();
	String jsonData = data.toJson(result);
	
	response.getWriter().println(jsonData);
%>