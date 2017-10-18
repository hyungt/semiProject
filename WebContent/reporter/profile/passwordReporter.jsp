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

	String password1 = DigestUtils.sha256Hex(request.getParameter("pw"));
	String password2 = DigestUtils.sha256Hex(request.getParameter("repw"));
	ReporterEmployeeDao reDao = new ReporterEmployeeDao();
	ReporterEmployeeVo reporter  = (ReporterEmployeeVo) session.getAttribute("loginReporter");

	if (!password1.equals(password2)) {
		response.sendRedirect("updatePassword.jsp?fail=1");
		return;
	} else if (password1.equals(reporter.getReporterPw())) {
		response.sendRedirect("updatePassword.jsp?fail=2");
		return;
	} else {
		reporter.setReporterPw(password1);
		session.setAttribute("loginReporter", reporter);
		reDao.updateReporterPassword(reporter);
		response.sendRedirect("/reporter/profile/updateProfile.jsp?success=2");
	}
		
%>