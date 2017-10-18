<%@page import="kr.co.jtimes.profile.common.dao.UserDao"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
    <%
    	request.setCharacterEncoding("utf-8");
    
    	String id = request.getParameter("id");
    	
    	UserVo user =new UserVo();
    	UserDao userDao = new UserDao();
    	
    	
    	UserVo checkId = userDao.getUserById(id);
    	String idState = null;
    	if(id == "") {
    		idState = "3"; 
    	} else if(checkId == null) {
    		idState = "1";
    	} else {
    		idState = "2";
    	}
    	response.getWriter().write(idState);
    %>