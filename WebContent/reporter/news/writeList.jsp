<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.common.criteria.SignCriteria"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<META http-equiv="Expires" content="-1"> 
	<META http-equiv="Pragma" content="no-cache"> 
	<META http-equiv="Cache-Control" content="No-Cache"> 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
	.container {width:1024px; margin:0 auto;}
	#success,#wait {display: none;}
	label {cursor: pointer;}
	h3 {display: inline;}
	#loading {
	 width: 100%;  
	 height: 100%;  
	 top: 0px;
	 left: 0px;
	 position: fixed;  
	 display: block;  
	 opacity: 0.7;  
	 background-color: #fff;  
	 z-index: 99;  
	 text-align: center; } 
	  
	#loading-image {  
	 position: absolute;  
	 top: 50%;  
	 left: 50%; 
	 z-index: 100; }
</style>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "news"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%
	ReporterEmployeeVo user = (ReporterEmployeeVo)session.getAttribute("loginReporter");
	NewsSignDao signDao = new NewsSignDao();
	
	final int rowsPerPage = 20, naviPerPage = 5;
	String pageNo = request.getParameter("pno");
	int page_no = 1;
	
	if(pageNo != null){
		page_no = Integer.parseInt(pageNo);	
	}
	
	int totalRows = signDao.getTotalSignRowByReporterNo(user.getReporterNo());
	int totalPages = (int)Math.ceil((double)totalRows / rowsPerPage);
	if(page_no > totalPages) {
		page_no = 1;
	}
	int beginIndex = (page_no - 1) * rowsPerPage + 1; 
	int endIndex = page_no * rowsPerPage;
	
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double)naviPerPage);
	int currentNaviBlock = (int) Math.ceil(page_no/(double)naviPerPage);
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if(currentNaviBlock >= totalNaviBlocks) {
		endPage = totalPages;
	}
	
	SignCriteria criteria = new SignCriteria();
	criteria.setWriterNo(user.getReporterNo());
	
	criteria.setBeginIndex(beginIndex);
	criteria.setEndIndex(endIndex);

	List<NewsSignVo> signList = signDao.getSignListByReporterNo(criteria);
	
%>
	<div class="container">
		<div class="row">
			<div>
				<h2>작성 목록</h2>
			</div>
			<div>
				<table class="table table-bordered table-hover">
					<colgroup>
						<col width="60%">
						<col width="10%">
						<col width="10%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr class="active">
							<th class="text-center">기사 제목</th>
							<th class="text-center">1차 결제 현황</th>
							<th class="text-center">2차 결제 현황</th>
							<th class="text-center">작성일</th>
						</tr>
					</thead>
					<tbody id="table-body">
					<%for(NewsSignVo sign : signList){
						String firstSignState = ("Y".equals(sign.getFirstSignState())) ? "승인" : "결재 대기중";
						String secondSignState = ("Y".equals(sign.getSecondSignState())) ? "승인" : "결재 대기중";
					%>
						<tr>
							<td><a href="/reporter/news/detailNews.jsp?type=view&newsNo=<%=sign.getNews().getNewsNo() %>&signNo=<%=sign.getNo() %>&returnURL=writeList"><%=sign.getNews().getNewsTitle()%></a></td>
							<td><%=firstSignState %></td>
							<td><%=secondSignState %></td>
							<td><%=sign.getNews().getRegdateFormatYYMMDDHHMMSS() %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
				<div class="text-center">
                	<ul class="pagination pagination-sm" id="sign-page"></ul>
            	</div>
			</div>
		</div>
	</div>
</body>
</html>