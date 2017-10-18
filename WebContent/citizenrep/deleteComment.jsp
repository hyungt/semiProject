<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@page import="kr.co.jtimes.citizenrep.comments.vo.CrCommentsVo"%>
<%@page import="kr.co.jtimes.citizenrep.comments.dao.CrCommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ include file="/profile/logincheck.jsp" %>
<%
	int no = Integer.parseInt(request.getParameter("cmtno"));
	int bno = Integer.parseInt(request.getParameter("bno"));

	CrCommentsDao crCommentsDao = new CrCommentsDao();
	List<CrCommentsVo> commentsVos = crCommentsDao.getAllCommentByCrNo(bno);
	
	UserVo loginUser = (UserVo) session.getAttribute("userLogin");
	for( CrCommentsVo vo : commentsVos){
		if(vo.getUserVo().getNo() == loginUser.getNo() || loginUser.getNo() == 0){
			crCommentsDao.deleteComment(no);
		}
	}
	response.sendRedirect("detail.jsp?bno="+bno);
%>