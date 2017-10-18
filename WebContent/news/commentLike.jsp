<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jtimes.news.comment.vo.NewCommentVo"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentDao"%>
<%@page import="kr.co.jtimes.news.comment.vo.CommentLikeVo"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentLikeDao"%>
<%@page import="kr.co.jtimes.news.vo.TbSuggestVo"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

	<%@include file="/profile/logincheck.jsp" %>
	
	<%
		request.setCharacterEncoding("utf-8");
		int commentNo = Integer.parseInt(request.getParameter("commentNo"));
		String pref = request.getParameter("pref");
		
		UserVo loginUser = (UserVo) session.getAttribute("userLogin");

		NewCommentVo comment = new NewCommentVo();
		comment.setCommentNo(commentNo);
		
		CommentLikeVo commentLikes = new CommentLikeVo();
		commentLikes.setCno(comment.getCommentNo());
		commentLikes.setUno(loginUser.getNo());
		commentLikes.setPreference(pref);
		
		PrintWriter pw = response.getWriter();

		CommentLikeDao commentLikeDao = new CommentLikeDao();
		try{
			commentLikeDao.addCommentLike(commentLikes);
		} catch(Exception e) {
			pw.write("samesame");
			return;
		}
		
		int likes = commentLikeDao.getCommentLikeByCommentNo(commentNo, pref);
		
		Gson gson = new Gson();
		Integer cnt = new Integer(likes);
		String text = gson.toJson(cnt);
		
		pw.write(text);
	%>