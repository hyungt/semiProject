<%@page import="kr.co.jtimes.common.criteria.CommentCriteria"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.jtimes.util.JsonDateConvertor"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentLikeDao"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentDao"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@page import="kr.co.jtimes.news.dao.TbSuggestDao"%>
<%@page import="kr.co.jtimes.news.vo.TbSuggestVo"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.comment.vo.NewCommentVo"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
	
	<%@include file="/profile/logincheck.jsp" %>
	
    <% 
		request.setCharacterEncoding("utf-8");
    
		int newsNo = Integer.parseInt(request.getParameter("no"));
	   	String contents = request.getParameter("contents");
	    
	   	UserVo loginUser = (UserVo) session.getAttribute("userLogin");
	    
	   	TbNewsDao tbNewsDao = new TbNewsDao();
	   	
	    CommentDao commentDao = new CommentDao();	    
	   	
	    NewCommentVo comment = new NewCommentVo();
	   	comment.setCommentContents(contents);
	   	comment.setUserVo(loginUser);
	   	comment.setTbNewsVo(tbNewsDao.getNews(newsNo));
	   	
	   	commentDao.addComment(comment);
	   	
	   	CommentCriteria criteria = new CommentCriteria();
		criteria.setBeginIndex(1);
		criteria.setEndIndex(4);
		criteria.setNewsNo(newsNo);
	   	
	   	List<NewCommentVo> commentList = commentDao.getCommentByNewsNo(criteria);
	   	CommentLikeDao commentLikeDao = new CommentLikeDao();
	   	for(NewCommentVo c : commentList) {
	   		c.setLikeCnt(commentLikeDao.getCommentLikeByCommentNo(c.getCommentNo(), "Y"));
	   		c.setDisLikeCnt(commentLikeDao.getCommentLikeByCommentNo(c.getCommentNo(), "N"));
	   	}
	   	
	   	PrintWriter pw = response.getWriter();
	   	
	   	GsonBuilder builder = new GsonBuilder();
		builder.registerTypeAdapter(Date.class, new JsonDateConvertor());
		Gson gson = builder.create();
	   	
	   	
		String text = gson.toJson(commentList);
		
		pw.write(text);
	   	
	%>
	