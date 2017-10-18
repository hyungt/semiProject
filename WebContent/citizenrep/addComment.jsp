<%@page import="kr.co.jtimes.citizenrep.dao.CitizenRepDao"%>
<%@page import="kr.co.jtimes.citizenrep.vo.CitizenRepVo"%>
<%@page import="kr.co.jtimes.citizenrep.comments.vo.CrCommentsVo"%>
<%@page import="kr.co.jtimes.citizenrep.comments.dao.CrCommentsDao"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int cireNo = Integer.parseInt(request.getParameter("cireno"));
	String contents = request.getParameter("cmt-contents");
	
	UserVo loginUser = (UserVo) session.getAttribute("userLogin");
	
	CrCommentsDao commentsDao = new CrCommentsDao();
	
	CitizenRepDao citizenRepDao = new CitizenRepDao();
	CitizenRepVo citizenRepVo = citizenRepDao.getCitRepByNo(cireNo);
	
	CrCommentsVo comments = new CrCommentsVo();
	comments.setContents(contents);
	comments.setUserVo(loginUser);
	comments.setCitizenRepVo(citizenRepVo);
	
	commentsDao.addCrComment(comments);
	
	response.sendRedirect("detail.jsp?bno="+cireNo);
%>