<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@page import="kr.co.jtimes.common.vo.NewsCategoryVo"%>
<%@page import="kr.co.jtimes.common.vo.NewsTypeVo"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/reporter/commons/loginCheck.jsp" %>
<%
	ReporterEmployeeVo reporter = (ReporterEmployeeVo)session.getAttribute("loginReporter");

	request.setCharacterEncoding("utf-8");

	TbNewsDao dao = new TbNewsDao();
	NewsSignDao signDao = new NewsSignDao();
	ReporterEmployeeDao empDao = new ReporterEmployeeDao();
	
	int newsType = Integer.parseInt(request.getParameter("newstype"));
	int newsCategory = Integer.parseInt(request.getParameter("newscategory"));
	String newsLocation = request.getParameter("newslocation");
	String newsTitle = request.getParameter("title");
	String newsContents = request.getParameter("ir1");
	String mainImgPath = request.getParameter("mainimgpath");
	
	int firstSignerNo = Integer.parseInt(request.getParameter("firstsign"));
	int secondSignerNo = Integer.parseInt(request.getParameter("secondsign"));
	
	TbNewsVo news = new TbNewsVo();
	
	int newsNo = dao.getNewsNextSequence();
	news.setNewsNo(newsNo);
	news.setNewsType(new NewsTypeVo(newsType, ""));
	news.setCategory(new NewsCategoryVo(newsCategory, ""));
	news.setReporter(reporter);
	news.setNewsLocation(newsLocation);
	news.setNewsTitle(newsTitle);
	news.setNewsContents(newsContents);
	news.setNewsImgPath(mainImgPath);
	
	dao.insertNews(news);
	
	NewsSignVo sign = new NewsSignVo();
	
	ReporterEmployeeVo firstSigner = empDao.getReporterByNo(firstSignerNo);
	ReporterEmployeeVo secondSigner = empDao.getReporterByNo(secondSignerNo);
	
	sign.setWriter(reporter);
	sign.setNews(dao.getNewsBack(newsNo));
	sign.setFirstSigner(firstSigner);
	sign.setSecondSigner(secondSigner);
	
	signDao.insertNewsSign(sign);
	
	response.sendRedirect("/reporter/index.jsp");
%>
<script type="text/javascript">
	alert("기사 등록이 완료되었습니다.");
</script>

