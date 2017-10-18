<%@page import="kr.co.jtimes.citizenrep.util.StringUtils"%>
<%@page import="kr.co.jtimes.citizenrep.comments.dao.CrCommentsDao"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.citizenrep.comments.vo.CrCommentsVo"%>
<%@page import="kr.co.jtimes.util.DateUtils"%>
<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@page import="kr.co.jtimes.citizenrep.vo.CitizenRepVo"%>
<%@page import="kr.co.jtimes.citizenrep.dao.CitizenRepDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>JTimes :: 시민 제보</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
	.container {
		width: 1024px;
		margin: 0 auto;
	}
</style>
</head>
<body>
<%
		pageContext.setAttribute("cp", "join");
%>
<% 
	int no = Integer.parseInt(request.getParameter("bno"));
	int p = StringUtils.strToNumber(request.getParameter("p"), 1);
	CitizenRepDao citizenRepDao = new CitizenRepDao();
	CitizenRepVo citizenRepVo = citizenRepDao.getCitRepByNo(no);
	CrCommentsDao commentsDao = new CrCommentsDao();
	List<CrCommentsVo> comments = commentsDao.getAllCommentByCrNo(no);
%>
<%@include file="/commons/clientNavi.jsp" %>
<div class="container">
	<div class="row">
		<h2 class="well">참여마당<small> - 구독자가 만드는 기사</small></h2>
	</div>
	<div class="panel panel-default">
		<table class="table">
			<colgroup>
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<col width="15%">
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td colspan="5"><%=citizenRepVo.getCitizenRepTitle() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=citizenRepVo.getWriter().getId() %></td>
					<th>날짜</th>
					<td><%=DateUtils.yyyymmddhhmmss(citizenRepVo.getCitizenRepCreateDate()) %></td>
				</tr>
				<tr>
					<td colspan="6">
						<%=citizenRepVo.getCitizenRepContents() %>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="panel-footer text-right">
		<%
			UserVo userVo = (UserVo) session.getAttribute("userLogin");
			if(userLogin != null){
				if(citizenRepVo.getWriter().getNo() == userVo.getNo()){
		%>
			<a href="editorForm.jsp?bno=<%=no %>" class="btn btn-warning btn-sm">수정</a>
			<a href="delete.jsp?bno=<%=no %>" class="btn btn-danger btn-sm">삭제</a>
		<%}else if(userVo.getNo() == 0){%>
			<a href="delete.jsp?bno=<%=no %>" class="btn btn-danger btn-sm">삭제</a>
		<% }}%>
			<a href="list.jsp?p=<%=p %>" class="btn btn-primary btn-sm">목록</a>
		</div>
		
	</div>
	<%if(userLogin != null){ %>
	<div class="row">
		<form class="form-horizontal" method="post" action="addComment.jsp">
			<input type="hidden" name="cireno" value="<%=citizenRepVo.getCitizenRepNo() %>">
			<div class="form=group">
				<div class="col-xs-offset-1 col-xs-9">
					<textarea rows="1" class="form-control" name="cmt-contents" onclick="this.value=''">댓글을 입력하세요</textarea>
				</div>
				<div class="com-xs-2">
					<button type="submit" class="btn btn-default">등록</button>
				</div>
			</div>
		</form>
	</div>
	<%} %>
	<br/>
	<%if(comments != null){ %>
	<div class="row col-xs-offset-1 col-xs-10 well">
		<%
			for( CrCommentsVo comment : comments){
		%>
		<div class="panel panel-default">
			<div class="panel-body">
				<p>작성자 : <%=comment.getUserVo().getId() %> <small class="pull-right">작성일 : <%=DateUtils.yyyymmddhhmmss(comment.getRegDate()) %></small></p>
				<p><%=comment.getContents() %></p>
				<%
					if(userLogin != null){
						if(comment.getUserVo().getNo() == userVo.getNo() || userVo.getNo() == 0) {%>
				<p class="text-right"><a href="deleteComment.jsp?bno=<%=no %>&cmtno=<%=comment.getNo() %>" class="btn btn-xs btn-danger pull-right">삭제</a></p>
				<%}} %>
			</div>
		</div>
		<%} %>
	</div>
	<%} %>
</div>
<%@include file="/commons/clientFooter.jsp" %>
</body>
</html>