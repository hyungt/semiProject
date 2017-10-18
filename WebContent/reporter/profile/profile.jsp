<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY PROFILE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
.container {
	width: 1024px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%
	// 로그인 되지 않은 사용자가 접근했을 때 로그인후 되돌아갈 url 지정
	pageContext.setAttribute("url", "/reporter/profile/login.jsp"); 
	%>
	<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
	<%@ include file="/reporter/commons/loginCheck.jsp" %>
	<% 
	ReporterEmployeeVo re = new ReporterEmployeeVo();
	re = (ReporterEmployeeVo)session.getAttribute("loginReporter"); 
	String[] arrPhone=re.getReporterPhone().split("-");%>
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-2 col-sm-7">
				<form class="form-horizontal well"  >
					<h1 class="text-center">MY PROFILE</h1>
					<%
				 		if(request.getParameter("success") != null) {
				 	%>		
				 		<div class="alert alert-info">
				 			<strong>성공!</strong> 성공적으로 변경 되었습니다.
				 		</div>	
				 	<%	
				 		}
				 	%>
					<div class="form-group">
						<label class="control-label col-sm-2">ID</label>
						<div class="col-sm-9">
							<a type="text" class="form-control" ><%=re.getReporterId() %></a>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2">성   명</label>
						<div class="col-sm-4">
							<a type="text" class="form-control"  ><%=re.getReporterName() %></a>
						</div>
							<label class="control-label col-sm-2">직급</label>
						<div class="col-sm-3">
							<select name="front-joblv" class="form-control">
								<option value="" selected="selected" disabled><%=re.getReporterPos().getPositionName() %></option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2">Email</label>
							<div class="col-sm-9">
								<a type="text" class="form-control" ><%=re.getReporterEmail() %></a>
							</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2">전화번호</label>
							<div class="col-sm-3">
								<select name="front-number" class="form-control" >
									<option value="" selected="selected"><%=arrPhone[0] %></option>
								</select>
							</div>
							<div class="col-sm-3">
								<a type="text" class="form-control" ><%=arrPhone[1] %></a>
							</div>
							<div class="col-sm-3">
								<a type="text" class="form-control" ><%=arrPhone[2] %></a>
							</div>
					</div>
					<div class="form-group text-right">
						<div class="col-sm-11 font-size-large">
							<a href="/reporter/profile/updateProfile.jsp" id="btn-change" class="btn btn-danger">수정</a>
							<a href="/reporter/index.jsp"  class="btn btn-info">메인페이지</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>