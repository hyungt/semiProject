<%@page import="kr.co.jtimes.util.EmailUtil"%>
<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	if(email.equals("") || name.equals("")) {
		response.sendRedirect("findUserId.jsp?fail=2");
		return;
	}	
	
	
	UserDao userDao =new UserDao();
	
	UserVo user = new UserVo();
	user.setEmail(email);
	user.setName(name);
	
	UserVo findUser = userDao.getLoginId(user);
	
	if(findUser == null){
		response.sendRedirect("findUserId.jsp?fail=2");
		return;
	}
	
	String userId = findUser.getId();
	String userEmail = findUser.getEmail();
	String userName = findUser.getName();


	if(!userEmail.equals(email) || !userName.equals(name)) {
		response.sendRedirect("findUserId.jsp?fail=1");
		return;
	} else if(userId != null) {
		int cnt = userId.length();
		String changeId = userId.substring(0, cnt-3);
		changeId += "***";
		
		
		EmailUtil.sendEmail("J times 회원님의 아이디 입니다.", "회원님의 아이디는 "+changeId+" 입니다.", email);
		response.sendRedirect("sendId.jsp");

	} 

%>