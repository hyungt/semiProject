<%@page import="kr.co.jtimes.util.EmailUtil"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.util.Random"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("reporter-name");
	String phoneNumber = (request.getParameter("front-number")+"-"+request.getParameter("sec-number")+"-"+request.getParameter("thr-number"));
	

	if(name.equals("") || phoneNumber.equals("")) {
		response.sendRedirect("/reporter/profile/findPassword.jsp?fail=1");
		return;
	}
	
	ReporterEmployeeDao reporterDao = new ReporterEmployeeDao();

	ReporterEmployeeVo reporter = new ReporterEmployeeVo();
	reporter.setReporterName(name);
	reporter.setReporterPhone(phoneNumber);

	ReporterEmployeeVo getEmailPwd = reporterDao.getEmailPwd(reporter);
	
	if (getEmailPwd != null) {
		int d = 0;
		String str = "";
		for (int i = 1; i <= 8; i++) {
			Random r = new Random();
			d = r.nextInt(9);
			str = str + Integer.toString(d);
		}
		reporter.setReporterPw(DigestUtils.sha256Hex(str));
		reporterDao.findPassword(reporter);
		String email = getEmailPwd.getReporterEmail();
		
		EmailUtil.sendEmail("J times 회원님의 임시 비밀번호 입니다.", "임시비밀번호는 "+str+" 입니다", email);
		response.sendRedirect("/reporter/profile/login.jsp?success=2");
	} else {
		response.sendRedirect("/repoter/profile/findPassword.jsp?fail=1");		
	}
	

%>