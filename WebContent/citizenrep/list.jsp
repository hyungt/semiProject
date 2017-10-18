<%@page import="kr.co.jtimes.common.criteria.Criteria"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.jtimes.citizenrep.util.StringUtils"%>
<%@page import="kr.co.jtimes.util.DateUtils"%>
<%@page import="kr.co.jtimes.citizenrep.vo.CitizenRepVo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.citizenrep.dao.CitizenRepDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>JTimes :: 시민 제보</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style type="text/css">
.container {
	width: 1024px;
	margin: 0 auto;
}
</style>
<body>
	<%
		pageContext.setAttribute("cp", "join");
		pageContext.setAttribute("url",  request.getRequestURI() + "?" + request.getQueryString());
	%>
	<%
		//한 화면에 표시할 데이터 행의 갯수
		final int rowsPerPage = 10;
		//한 화면에 표시할 페이지 네비게이션 갯수
		final int naviPerPage = 5;

		//현재 페이지 번호 계산
		int p = StringUtils.strToNumber(request.getParameter("p"), 1);
		CitizenRepDao citizenRepDao = new CitizenRepDao();
	%>
	<%@include file="/commons/clientNavi.jsp"%>
	<%
		try {
	%>
	<div class="container">
		<div class="row">
			<h2 class="well">
				참여마당<small> - 구독자가 만드는 기사</small>
			</h2>
			<div class="panel panel-default">
				<table class="table table-condensed table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<CitizenRepVo> gongji = citizenRepDao.getAllCitRepMaster();
							if(gongji.size()>=3){
							for(int i = 0; i<3; i++){
						%>
						<tr style="background-color: mistyrose;">
							<td><%=gongji.get(i).getCitizenRepNo() %></td>
							<td><a href="/citizenrep/detail.jsp?bno=<%=gongji.get(i).getCitizenRepNo() %>"><%=gongji.get(i).getCitizenRepTitle() %></a></td>
							<td><%=gongji.get(i).getWriter().getId() %></td>
							<td><%=DateUtils.yyyymmddhhmmss(gongji.get(i).getCitizenRepCreateDate()) %></td>
						</tr>
						<%	}} else{
							for(CitizenRepVo vo : gongji){%>
							<tr style="background-color: mistyrose;">
								<td><%=vo.getCitizenRepNo() %></td>
								<td><a href="/citizenrep/detail.jsp?bno=<%=vo.getCitizenRepNo() %>"><%=vo.getCitizenRepTitle() %></a></td>
								<td><%=vo.getWriter().getId() %></td>
								<td><%=DateUtils.yyyymmddhhmmss(vo.getCitizenRepCreateDate()) %></td>
							</tr>
						<%	
						}}
							int totalRows = citizenRepDao.getTotalRows();						//전체행 조회
							int totalPages = (int) Math.ceil((double)totalRows/rowsPerPage);	//전체 페이지 갯수 계산
							int totalNaviBlocks = (int) Math.ceil((double)totalPages/naviPerPage);	//현재 페이지 네비게이션 블록번호 계산
							int currentNaviBlock = (int) Math.ceil((double)p/naviPerPage);		//페이지 네비 표시할 시작,끝 페이지번호 계산
							int beginPage = (currentNaviBlock-1)*naviPerPage+1;
							int endPage = (currentNaviBlock*naviPerPage);
							if(currentNaviBlock == totalNaviBlocks){
								endPage = totalPages;
							}	
							int beginIndex = (p-1)*rowsPerPage +1;
							int endIndex = p*rowsPerPage;
							Criteria criteria = new Criteria();
							criteria.setBeginIndex(beginIndex);
							criteria.setEndIndex(endIndex);
							List<CitizenRepVo> citizenReps = citizenRepDao.getCitReps(criteria);
							for (CitizenRepVo repVo : citizenReps) {
						%>
						<tr>
							<td><%=repVo.getCitizenRepNo()%></td>
							<td><a
								href="/citizenrep/detail.jsp?bno=<%=repVo.getCitizenRepNo()%>">
									<%=repVo.getCitizenRepTitle()%></a></td>
							<td><%=repVo.getWriter().getId()%></td>
							<td><%=DateUtils.yyyymmddhhmmss(repVo.getCitizenRepCreateDate())%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="panel-body text-center">
					<ul class="pagination">
						<li><a href="list.jsp">맨앞으로</a></li>
						<%
							if(currentNaviBlock >1){
								%><li><a href="list.jsp?p=<%=((currentNaviBlock-1)*naviPerPage) %>">&laquo</a></li>
							<% }if(p >1){
								%><li><a href="list.jsp?p=<%=(p-1) %>">&lt</a></li>
							<% }
							for(int i = beginPage; i<=endPage; i++){
						%>
						<li class="<%=p==i?"active":"" %>"><a href="list.jsp?p=<%=i %>"><%=i %></a></li>
						<%} if(p<totalPages){%>
						<li><a href="list.jsp?p=<%=(p+1)%>">&gt</a></li>
						<%} if(currentNaviBlock<totalNaviBlocks){%>
						<li><a href="list.jsp?p=<%=(currentNaviBlock+1)*naviPerPage%>">&raquo</a></li>
						<%}if(totalPages==0)totalPages=1;%>
						<li><a href="list.jsp?p=<%=totalPages %>">맨뒤로</a></li>
					</ul>
					<%
						if (userLogin != null) {
					%>
					<a href="/citizenrep/form.jsp"
						class="btn btn-primary btn-sm pull-right" id="btn-write">글쓰기</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
	%>
	<%@include file="/commons/clientFooter.jsp" %>
</body>
</html>