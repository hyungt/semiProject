<%@page import="kr.co.jtimes.news.vo.TemporaryNewsResult"%>
<%@page import="kr.co.jtimes.news.vo.TemporaryNewsVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String processType = request.getParameter("processType");
	ReporterEmployeeVo reporter = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	Gson gson = new Gson();

	TbNewsDao dao = new TbNewsDao();
	String data = "";
	TemporaryNewsResult result = new TemporaryNewsResult();
	result.setProcessType(processType);
	
	if("l".equals(processType)) {
		List<TemporaryNewsVo> tempList = dao.getTemporaryNewsByReporterNo(reporter.getReporterNo());
		result.setTempList(tempList);
	} else {
		int no = Integer.parseInt(request.getParameter("tempNo"));
		TemporaryNewsVo temp = dao.getTemporaryNewsByNo(no);
		result.setTemp(temp);
		dao.deleteTemporaryNews(no);
	}
	
	data = gson.toJson(result);
	response.getWriter().println(data);
%>