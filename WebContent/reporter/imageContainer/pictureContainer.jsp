<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
  	.container{
          width: 1024px;
          margin: 0 auto;
     } 
  	.pp{
		background-color: white;
  	}
  </style>
</head>
<body>
<% pageContext.setAttribute("cp", "img"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<div class="container well">
	<div class="row">
	<%
		String path = request.getParameter("path");
		String title = request.getParameter("title");
		String regDate = request.getParameter("regDate");
		String reporterNo = request.getParameter("reporterNo");
		String category = request.getParameter("category");
		String explanation = request.getParameter("explanation");
		String location = request.getParameter("location");
		String type = request.getParameter("type");
		
	%>
  		<div class="col-xs-4" id="img-box" align="center">
  			<img id="pic" alt=<%=title %> src="/imgdata/<%=path %>" width="300" height="400" border="1">
  		</div>
  		<div class="col-xs-2">
  		</div>
  		<div class="col-xs-6 well">
  			<div>
  				<label>제목 </label><p class="well pp"><%=title %></p>
  				<label>카테고리 </label><p class="well pp"><%=category %></p>
  				<label>설명 </label><p class="well pp"><%=explanation %></p>
  				<label>날짜 </label><p class="well pp"><%=regDate %></p>
  				<label>작성자 </label><p class="well pp"><%=reporterNo %></p>
  			</div>
  		</div>
  	</div>
  	<div class="col-xs-8 text-center" style="padding-left: 390px;">
  		<a href="javascript:history.back()" class="btn btn-primary btn-sm">목록</a>
  	</div>
  	<div class="col-xs-4 text-right">
  		<a href="/down.html?path=<%=path %>" class="btn btn-info btn-sm">다운로드</a>
  		<a href="updatePicture.jsp?path=<%=path %>&title=<%=title %>&regDate=<%=regDate %>&reporterNo=<%=reporterNo %>&category=<%=category %>&explanation=<%=explanation %>&location=<%=location %>&type=<%=type %>" class="btn btn-success btn-sm">수정</a>
  	</div>
</div>
</body>
</html>