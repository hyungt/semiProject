<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.vo.TbSuggestVo"%>
<%@page import="kr.co.jtimes.news.dao.TbSuggestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		pageContext.setAttribute("url", "/index.jsp");	
	%>
	<%@include file="/profile/logincheck.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
	
   		int no = Integer.parseInt(request.getParameter("newsNo"));
   
		UserVo loginUser = (UserVo) session.getAttribute("userLogin");
   		
   		TbNewsVo news = new TbNewsVo();
   		news.setNewsNo(no);
   		
   		TbSuggestVo suggest = new TbSuggestVo();
   		suggest.setTbNewsVo(news);
   		suggest.setUserNo(loginUser);
   		
   		TbSuggestDao suggestDao = new TbSuggestDao();
   		suggestDao.addSuggest(suggest);

   		int likes = suggestDao.getSuggests(no);
   		
   		PrintWriter pw = response.getWriter();
   		
   		Gson gson = new Gson();
   		Integer cnt = new Integer(likes);
   		String text= gson.toJson(cnt);
   		
   		pw.write(text);
   %>
   