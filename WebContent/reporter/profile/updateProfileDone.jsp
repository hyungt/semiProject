<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 되지 않은 사용자가 접근했을 때 로그인후 되돌아갈 url 지정
pageContext.setAttribute("url", "/reporter/profile/login.jsp"); 
%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%

	request.setCharacterEncoding("utf-8");

	ReporterEmployeeVo re = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	ReporterEmployeeDao reporterEmployeeDao = new ReporterEmployeeDao();	
	
	
	re.setReporterEmail(request.getParameter("email"));
	
	
	re.setReporterPhone(request.getParameter("front-number")+"-"+request.getParameter("sec-number")+"-"+request.getParameter("thr-number"));
	
	
	
	
	reporterEmployeeDao.updateReporterAll(re);
	
	
	response.sendRedirect("/reporter/profile/profile.jsp?success=1");
			
		
	


%>