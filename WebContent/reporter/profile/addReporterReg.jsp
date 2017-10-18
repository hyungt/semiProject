<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterDeptVo"%>
<%@page import="kr.co.jtimes.common.vo.ReporterPositionVo"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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


	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	int joblv = Integer.parseInt(request.getParameter("joblv"));
	int dept = Integer.parseInt(request.getParameter("dept"));
	String pw = DigestUtils.sha256Hex(request.getParameter("password"));
	String emailValue = request.getParameter("email");
	String phone = (request.getParameter("front-number")+"-"+request.getParameter("sec-number")+"-"+request.getParameter("thr-number"));

	ReporterPositionVo reporterPos = new ReporterPositionVo(); 
	reporterPos.setPositionNo(joblv);
	
	ReporterDeptVo reporterDeptVo = new ReporterDeptVo();
	reporterDeptVo.setDeptNo(dept);
	
	ReporterEmployeeVo reporter = new ReporterEmployeeVo();
	reporter.setReporterId(id);
	reporter.setReporterName(name);
	reporter.setReporterPos(reporterPos);
	reporter.setDeptNo(reporterDeptVo);
	reporter.setReporterPw(pw);
	reporter.setReporterEmail(emailValue);
	reporter.setReporterPhone(phone);
	

	ReporterEmployeeDao reporterDao = new ReporterEmployeeDao();
	ReporterEmployeeVo regReporter = reporterDao.getReporterById(id);
	if(regReporter != null) {
		response.sendRedirect("/repoter/profile/addReporter.jsp?fail=1&id="+id);
		return;
	}else{
		reporterDao.addReporter(reporter);
		response.sendRedirect("/reporter/profile/addReporter.jsp?success=1&id="+id);
	}
	
	
	
	
%>