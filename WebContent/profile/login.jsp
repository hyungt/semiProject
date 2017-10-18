<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	String returnUrl = request.getParameter("returnURL");
	if(returnUrl == null || "null".equals(returnUrl)) {
		returnUrl = "/";
	}
	
	if(id.equals("") || pwd.equals("")) {
		response.sendRedirect("userLogin.jsp?fail=2");
		return;
	}
	UserVo user = new UserVo();
	user.setId(id);
	user.setPwd(DigestUtils.sha256Hex(pwd));
	
	UserDao userDao = new UserDao();
	UserVo registeredUser = userDao.loginUser(user);
	
	if(registeredUser == null) {
		response.sendRedirect("userLogin.jsp?fail=1&returnUrl=" + returnUrl);
		return;
	}
	if(!registeredUser.getPwd().equals(DigestUtils.sha256Hex(pwd)) || !registeredUser.getId().equals(id)) {
		response.sendRedirect("userLogin.jsp?fail=1&returnUrl=" + returnUrl);
		return;
	}
	//로그인 처리
	session.setAttribute("userLogin", registeredUser);

	response.sendRedirect(returnUrl);
%>