<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	String email = request.getParameter("email");
	String pwdQuestion = request.getParameter("question");
	String pwdAnswer = request.getParameter("answer");
	
	if(name.equals("") || id.equals("") || pwd.equals("") || email.equals("") || pwdQuestion.equals("") || pwdAnswer.equals("")) {
		response.sendRedirect("addUser.jsp?fail=2");
		return;
	}
	
	UserVo user = new UserVo();
	user.setName(name);
	user.setId(id);
	user.setPwd(DigestUtils.sha256Hex(pwd));
	user.setEmail(email);
	user.setPwdQuestion(pwdQuestion);
	user.setPwdAnswer(pwdAnswer);
	
	
	
	UserDao userDao = new UserDao();
	UserVo registeredUser = userDao.getUserById(id);
	
	if(registeredUser != null) {

		response.sendRedirect("addUser.jsp?fail=1");
		return;
	}
		
		userDao.addUser(user);
		response.sendRedirect("success.jsp");


%>