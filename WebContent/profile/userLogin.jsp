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
<style type="text/css">
	.container {
		width: 1024px;
		margin: 0 auto;
	}
</style>
</head>
<body>
<%
	pageContext.setAttribute("cp", "log");
	String returnURL = request.getParameter("returnURL");
	if(returnURL == null) {
		returnURL = "";
	}
%>
<%@ include file="/commons/clientNavi.jsp" %>
	<div class="container">
        <div class="row">
            <div class="col-xs-offset-4 col-xs-4 panel panel-body">
                <h1 class="text-center">J Times</h1>
                	<%
		             	final String FAIL_CODE_DUP_ID = "1";
		            	final String FAIL_CODE_NULL = "2";
		
		             	
		             	String failCode = request.getParameter("fail");
		             %>
                	<% 
						if(request.getParameter("fail") !=null) {
					%>
							<div class="alert alert-danger">
								<strong>오류</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
							</div>
					<%
						}
					%>
	
                <form class="well" method="post" action="login.jsp">
					<input type="hidden" name="returnURL" value="<%=returnURL%>"/>
                    <div class="form-group">
                        <label>아이디</label>
                        <div class="input-group">
	                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
	                        <input id="id" type="text" class="form-control" name="id" placeholder="아이디"/>
                    	</div>
                    </div>
                    <div class="form-group">
                        <label>비밀번호</label>
                        <div class="input-group">
						    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
						    <input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
						</div>
                    </div>
                    <div class="form-group">
                        <button id="login-btn" class="btn btn-lg btn-danger btn-block" type="submit">로그인</button>
                    </div>
                    <p class="text-right"><a href="/profile/addUser.jsp">회원가입</a> / <a href="/profile/findUserId.jsp">아이디 찾기</a> / <a href="/profile/findUserPassword.jsp">비밀번호 찾기</a></p>
                </form>
            </div>
                
        </div>
    </div>
</body>

</html>