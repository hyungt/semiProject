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
	pageContext.setAttribute("url", "/profile/userLogin.jsp");
%>
<%@ include file="/commons/clientNavi.jsp" %>

	<div class="container">
        <div class="row">
            <div class="col-xs-offset-2 col-xs-8">
            <div class="col-xs-offset-2 col-xs-8">
            <h1>비밀번호 찾기</h1>
            <%
             	final String FAIL_CODE_DUP_ID = "1";
            	final String FAIL_CODE_NULL = "2";
             	
             	String failCode = request.getParameter("fail");
             %>
             
             <%if(FAIL_CODE_DUP_ID.equals(failCode)) {%>
             	<div class="alert alert-danger">
             		<strong>오류</strong> 올바르지 않은 정보 입니다.
             	</div>
             <%}%>
				
			<% 
				if(FAIL_CODE_NULL.equals(failCode) ) {
			%>
					<div class="alert alert-danger">
						<strong>오류</strong> 회원님의 정보를 입력해주세요.
					</div>
			<%
				}
			%>
                <form class="well" method="post" action="findPwd.jsp">

                    <div class="form-group">
                        <div class="input-group">
    						<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
   							<input id="id" type="text" class="form-control" name="id" placeholder="아이디">
  						</div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
						    <span class="input-group-addon"><i class="glyphicon glyphicon-send"></i></span>
						    <input id="email" type="text" class="form-control" name="email" placeholder="Email">
						</div>
						<div class="form-group" id="emailCheck"></div>
                    </div>
                    
                    <div class="form-group">
	                    <select class="form-control" name="question" id="question">
					  		<option value="q1">나의 아버지 성함은?</option>
			  				<option value="q2">나의 어머니 성함은?</option>
			  				<option value="q3">나의 출신 고등학교는?</option>
			  				<option value="q4">나의 출신 중학교는?</option>
			  				<option value="q5">나의 출신 초등학교는?</option>
						</select>
					<div class="input-group">
					    <span class="input-group-addon"><i class="glyphicon glyphicon-pushpin"></i></span>
						<input type="text" class="form-control" id="dap" name="dap" placeholder="응답"/>
					</div>
                	</div>
                <div class="form-group text-right">
                	<a href="../index.jsp" class="btn btn-danger">메인</a>
	                  <button id="login-btn" class="btn btn-primary">확인</button>
	            </div>
	            </form>
            </div>
            </div>      
        </div>
    </div>
</body>
</html>