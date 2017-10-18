<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.jtimes.util.JsonDateConvertor"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageResult"%>
<%@page import="kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao"%>
<%@page import="kr.co.jtimes.common.criteria.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%
	final int rowsPerPage = 6, naviPerPage = 5;

	String categoryNo = request.getParameter("category");
	
	int cateNo = 0;
	try{
		cateNo = Integer.parseInt(categoryNo); 
	} catch(Exception e) {
		
	}
	
	String tabId = request.getParameter("tabId");
	int page_no = Integer.parseInt(request.getParameter("pageNo"));
	
	TbImageDao imgDao = new TbImageDao();
	
	Criteria imgCriteria = new Criteria();
	
	imgCriteria.setTapId(tabId);
	imgCriteria.setCategoryNo(cateNo);
	
	int totalRow = imgDao.getImageTotalRows(imgCriteria);
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
	
	imgCriteria.setBeginIndex(beginIndex);
	imgCriteria.setEndIndex(endIndex);
	
	if(cateNo != 0){
		imgCriteria.setCategoryRemainder(categoryNo);
	}
	
	List<TbImageVo> imgList = imgDao.getSearchBySelectSort(imgCriteria);
	
	TbImageResult result = new TbImageResult();
	
	result.setBeginPage(beginPage);
	result.setEndPage(endPage);
	result.setCurrentNaviBlock(currentNaviBlock);
	result.setTotalNaviBlocks(totalNaviBlocks);
	result.setTotalPages(totalPages);
	result.setImgList(imgList);
	
	GsonBuilder builder = new GsonBuilder();
	builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
	Gson data = builder.create();
	String jsonData = data.toJson(result);
	
	response.getWriter().println(jsonData);
%>