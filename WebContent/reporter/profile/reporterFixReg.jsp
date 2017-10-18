<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterDeptVo"%>
<%@page import="kr.co.jtimes.common.vo.ReporterPositionVo"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int no = Integer.parseInt(request.getParameter("no"));
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	int joblv = Integer.parseInt(request.getParameter("joblv"));
	int dept = Integer.parseInt(request.getParameter("deptNo"));
	String pw = request.getParameter("password");
	String emailValue = request.getParameter("email");
	String phone = (request.getParameter("front-number")+"-"+request.getParameter("sec-number")+"-"+request.getParameter("thr-number"));

	
	ReporterPositionVo reporterPos = new ReporterPositionVo(); 
	reporterPos.setPositionNo(joblv);
	
	ReporterDeptVo reporterDeptVo = new ReporterDeptVo();
	reporterDeptVo.setDeptNo(dept);
	
	ReporterEmployeeDao reporterDao = new ReporterEmployeeDao();

	ReporterEmployeeVo reporter = reporterDao.getReporterByNo(no);
	reporter.setReporterNo(no);
	reporter.setReporterEmail(emailValue);
	reporter.setReporterPhone(phone);
	if (!pw.isEmpty()) {
		reporter.setReporterPw(DigestUtils.sha256Hex(pw));
	}
	reporter.setReporterPos(reporterPos);
	reporter.setReporterName(name);
	reporter.setReporterId(id);
	reporter.setDeptNo(reporterDeptVo);
	
	
	reporterDao.masterUpdate(reporter);
	
	response.sendRedirect("/reporter/profile/reporterList.jsp");
	
%>