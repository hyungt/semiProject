<%@page import="kr.co.jtimes.util.EmailUtil"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.util.Random"%>
<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String question = request.getParameter("question");
	String dap = request.getParameter("dap");

	if(id.equals("") || email.equals("") || question.equals("") || dap.equals("")) {
		response.sendRedirect("findUserPassword.jsp?fail=2");
		return;
	}
	
	UserDao userDao = new UserDao();

	UserVo user = new UserVo();
	user.setId(id);
	user.setEmail(email);
	user.setPwdQuestion(question);
	user.setPwdAnswer(dap);

	UserVo findPwd = userDao.getLoginPwd(user);
	
	if (userDao.getLoginPwd(user) != null) {
		int d = 0;
		String str = "";
		for (int i = 1; i <= 8; i++) {
			Random r = new Random();
			d = r.nextInt(9);
			str = str + Integer.toString(d);
		}
		user.setPwd(DigestUtils.sha256Hex(str));
		userDao.updatePwd(user);
		
		EmailUtil.sendEmail("J times 회원님의 임시 비밀번호 입니다.", "임시비밀번호는 "+str+" 입니다", email);
		response.sendRedirect("/profile/sendPwd.jsp");
	} else {
		response.sendRedirect("findUserPassword.jsp?fail=1");		
	}
	

%>