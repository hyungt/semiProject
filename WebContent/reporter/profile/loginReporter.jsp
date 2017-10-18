<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = DigestUtils.sha256Hex(request.getParameter("pass"));
	String returnUrl = request.getParameter("returnUrl");
	
	ReporterEmployeeDao reporterEmployeeDao = new ReporterEmployeeDao();
	ReporterEmployeeVo	regReporter = reporterEmployeeDao.getReporterById(id);
	
	
	
	if(regReporter == null){
		response.sendRedirect("login.jsp?fail=1");
		return;
	}
	
	if(!regReporter.getReporterPw().equals(pw)){
		response.sendRedirect("login.jsp?fail=2");
		return;
	} else {
		session.setAttribute("loginReporter", regReporter);
		response.sendRedirect("/reporter/index.jsp");
	}
	

%>