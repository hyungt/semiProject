<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@page import="kr.co.jtimes.citizenrep.vo.CitizenRepVo"%>
<%@page import="kr.co.jtimes.citizenrep.dao.CitizenRepDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%
	pageContext.setAttribute("url", "list.jsp");
%>
<%@ include file="/profile/logincheck.jsp" %>
<%
	int no = Integer.parseInt(request.getParameter("bno"));
	
	CitizenRepDao citizenRepDao = new CitizenRepDao();
	CitizenRepVo citizenRepVo = citizenRepDao.getCitRepByNo(no);
	
	//글 작성자와 로그인한 사용자가 동일한 사용자인지 체크
	UserVo loginUser = (UserVo) session.getAttribute("userLogin");
	if(citizenRepVo.getWriter().getNo() == loginUser.getNo() || loginUser.getNo() == 0){
		citizenRepDao.deleteCitRep(no);
	}
	response.sendRedirect("list.jsp");
%>