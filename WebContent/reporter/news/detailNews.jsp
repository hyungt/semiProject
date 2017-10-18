<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<!-- 
<style type="text/css">
	.news {line-height: 40px;}
</style>
 -->
 <style>
 	div.info {
 		color:gray;
 	}
 	span {
 		line-height:40px; 
 		color:gray;
 	}
 	.container {
 		width:1024px;
 		margin: 0 auto;
 	}
 	.profile {
            border-bottom: 3px solid black;
    }
    .display-inline{display: inline;}
 </style>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "news"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%	
	ReporterEmployeeVo re = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	String returnURL = request.getParameter("returnURL");
	int newsNo = Integer.parseInt(request.getParameter("newsNo"));
	int signNo = 0;
	try {
		signNo = Integer.parseInt(request.getParameter("signNo"));
	} catch(NumberFormatException e) {
		try{
			signNo = new NewsSignDao().getNewsSignByNewsNo(newsNo).getNo();
		} catch (Exception e1) {
			signNo = 0;
		}
	}
	String type = request.getParameter("type");

	TbNewsDao newsDao = new TbNewsDao();
	
	TbNewsVo news = newsDao.getNewsBack(newsNo);
%>
<div class="container">
	<div class="profile row">
            <div class="col-xs-offset-5 col-xs-4 text-right">
                <h4 class="display-inline"><span class="label label-default"><%=re.getReporterPos().getPositionName() %></span></h4>
                <h4 class="display-inline"><span class="label label-default"><%=re.getReporterName() %>(<%=re.getReporterId() %>)님 환영합니다.</span></h4>
            </div>
            <div class="col-xs-3 text-right">
                <a href="/reporter/profile/profile.jsp" class="btn btn-primary btn-xs">프로필 수정</a>
                <a href="/reporter/news/addNews.jsp" class="btn btn-warning btn-xs">기사 작성</a>
            </div>
        </div>
	<div class="row">
		<div>
			<div class="row panel panel-body">
				<h3><strong><%=news.getNewsTitle() %></strong></h3>
			</div>
			<div class="info">
				<span><small>기사입력 <%=news.getRegdateFormatYYMMDDHHMMSS() %></small></span>
			</div>
			<div class="row">
				<%=news.getNewsContents() %>
			</div>
			<div class="form-group text-right">
				<%
					NewsSignDao signDao = new NewsSignDao();
					boolean ok = false;
					String signState = "";
					NewsSignVo sign = signDao.getNewsSignByNewsNo(newsNo);
					if(loginReporter.getReporterPos().getPositionNo() == 200) {
						signState = sign.getFirstSignState();
					} 
					if(loginReporter.getReporterPos().getPositionNo() == 100) {
						signState = sign.getSecondSignState();
					}
					
					
					
					if("sign".equals(type)){ 
						if(!"Y".equals(signState)) {
				%>
	            	<a class="btn btn-danger" href="/reporter/news/confirmProcess.jsp?newsNo=<%=newsNo%>&signNo=<%=signNo%>">결재</a>
	            <%
						} else {
				%>
					<a class="btn btn-danger" href="/reporter/">돌아가기</a>
				<%
						}
					} else { 
	            	if(news.getReporter().getReporterNo() == re.getReporterNo() && !"Y".equals(sign.getSecondSignState())){
	            %>
				<a class="btn btn-danger" href="/reporter/news/modifyNews.jsp?newsNo=<%=newsNo%>&signNo=<%=signNo%>">수정</a>
	            <%}%>
	            <a class="btn btn-danger" href="/reporter/<%=(returnURL == null)? "" : "news/"+returnURL+".jsp"%>">돌아가기</a>
	            <%} %>
	        </div>
		</div>
		<div class="col-sm-3">
		</div>
	</div>
</div>
<%@include file="/reporter/commons/reporterFooter.jsp" %>
</body>
</html>