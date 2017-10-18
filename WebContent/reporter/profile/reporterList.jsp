
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.jtimes.common.criteria.ReporterCriteria"%>
<%@page import="kr.co.jtimes.citizenrep.util.StringUtils"%>
<%@page import="kr.co.jtimes.common.vo.ReporterPositionVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterDeptVo"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
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
</head>
<style type="text/css">
.container {
	width: 1024px;
	margin: 0 auto;
}
</style>
<body>

<%
request.setCharacterEncoding("utf-8");
pageContext.setAttribute("cp", "de4");
%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "reporter"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%
	ReporterDeptVo dept = new ReporterDeptVo();
	ReporterPositionVo position = new ReporterPositionVo();
	
	//한 화면에 표시할 데이터 행의 갯수
	final int rowsPerPage = 10;
	// 한화면에 표시할 페이지 내비게이션 갯수
	final int naviPerPage = 5;
	//현재 페이지 번호를 계산
	int p = StringUtils.strToNumber(request.getParameter("p"),1);
	String search = request.getParameter("search");
	
	ReporterEmployeeDao reporterEmployeeDao = new ReporterEmployeeDao();
	
	//전체 데이터 갯수 조회
	int totalRows = reporterEmployeeDao.getTotalEmployeeRows();
	
	//전체 데이터 갯수 조회
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	
	// 전체 페이지 내비게이션 블록 갯수 계산
	int totalNaviBlocks =  (int) Math.ceil(totalPages/(double) naviPerPage);
	
	// 현재 페이지 내비게이션 블록 번호 계산
	int currentNaviBlock = (int) Math.ceil(p/(double) naviPerPage);
	
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if(currentNaviBlock == totalNaviBlocks) {
		endPage = totalPages;
	}
	//현재 페이지 번호에 해당하는 데이터 조회에 사용할 시작 인덱스 계산
	int beginIndex = (p-1) * rowsPerPage +1;
	//현재 페이지 번호에 해당하는 데이터 조회에 사용할 끝인덱스 계산
	int endIndex = p * rowsPerPage;
	List<ReporterEmployeeVo> reporterList = null;
	ReporterCriteria criteria = new ReporterCriteria();
	criteria.setBeginIndex(beginIndex);
	criteria.setEndIndex(endIndex);

	if(search == null){
		reporterList = reporterEmployeeDao.getReporterAll(criteria);
	} else {
		criteria.setSearch(search);
		reporterList = reporterEmployeeDao.getReporterAllSearch(criteria);
	}
	//페이지번호에 해당하는 게시글 조회
	
%>
<div class="container">
	<div class="row">
			<h2 class="well">
				reporterList
			</h2>
			<div class="panel panel-default">
				<table class="table table-condensed table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>직급</th>
							<th>부서</th>
							<th>이메일</th>
							<th>전화번호</th>
						</tr>
					</thead>
					<tbody>
						<%for(ReporterEmployeeVo reporter : reporterList) {
							String deptName = null;
							int deptNo = reporter.getDeptNo().getDeptNo();
						%>
							<tr>
								<td><%=reporter.getReporterNo() %></td>
								<td><a href="/reporter/profile/reporterFix.jsp?no=<%=reporter.getReporterNo() %>"><%=reporter.getReporterName() %></a></td>
								<td><%=reporter.getReporterPos().getPositionName() %></td>
								<td><%=reporter.getDeptNo().getDeptName()%></td>
								<td><%=reporter.getReporterEmail() %></td>
								<td><%=reporter.getReporterPhone() %></td>
							</tr>
						<%} %>
					</tbody>
				</table>
	</div>
	<div>
		<div class="text-center">
			<ul class="pagination">
			<% if(p>1) {%>
				<li><a href="reporterList.jsp?p=<%=(p-1)%>">&lt;</a></li>
			<%} else {%>
				<li class='disabled'><a href="reporterList.jsp?p=1">&lt;</a></li>
			<%} %>
			<%for (int index=beginPage; index<=endPage; index++) {%>
				<li class="<%=p==index?"active":""%>"><a href="reporterList.jsp?p=<%= index%>"><%= index %></a></li>
			<%} %>
			<% if(p<totalPages) {%>
				<li><a href="reporterList.jsp?p=<%=(p+1)%>">&gt;</a></li>
			<%} else {%>
				<li class='disabled'><a href="reporterList.jsp?p=<%=p%>">&gt;</a></li>
			<%} %>
			</ul>
		</div>
		<div class="form-group">
		<div class="form-group col-xs-offset-4">
			<form class="form-inline" method="get" action="reporterList.jsp">
			    <div class="input-group">
			      <div class="input-group-addon">이름</div>
			      <input type="text" name="search" class="form-control" id="search">
			    </div>
			  <button type="submit" class="btn btn-default">Search</button>
			</form>
		</div>
		<div class="form-group text-right">
	        <a href="/reporter/index.jsp" class="btn btn-danger btn">메인으로</a>
	        <a href="/reporter/profile/addReporter.jsp" class="btn btn-primary btn">기자 등록</a>
	    </div>
	    </div>
    </div>
</div>
</div>
<script>

</script>
</body>
</html>