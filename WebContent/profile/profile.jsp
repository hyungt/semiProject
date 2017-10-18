<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");

	
	
	String pwd = request.getParameter("password");
	String rePwd = request.getParameter("repassword");
	String email = request.getParameter("email");
	String pwdQuestion = request.getParameter("question");
	String pwdAnswer = request.getParameter("answer");
	
	if(!pwd.equals(rePwd)) {
		response.sendRedirect("profileFix.jsp?fail=3");
		return;
	}
	
	if(pwd.equals("") || email.equals("") || pwdQuestion.equals("") || pwdAnswer.equals("")) {
		response.sendRedirect("profileFix.jsp?fail=2");
		return;
	}
	
	
	
	UserVo user = new UserVo();
	user = (UserVo) session.getAttribute("userLogin");
	user.setPwd(DigestUtils.sha256Hex(pwd));
	user.setEmail(email);
	user.setPwdQuestion(pwdQuestion);
	user.setPwdAnswer(pwdAnswer);
	
	
	UserDao userDao = new UserDao();
	userDao.profileFix(user);
	
	response.sendRedirect("profileSuccess.jsp");
	
	
	
	
%>