<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	
  </script>
<style type="text/css">
.container {
	width: 1024px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-6">
				<form class="form-horizontal well" method="post" action="/reporter/profile/loginReporter.jsp">
					<div>
						<h1 class="text-center">LOGIN</h1>
						<%
	                	final String SUCCESS_CODE_DONE = "1";
	                	final String SUCCESS_CODE_SEND_MAIL = "2";
	                	final String FAIL_CODE_ALL = "1";
	                	final String FAIL_CODE_PASSWORD = "2";
	                	String successCode = request.getParameter("success");
	                	String failCode = request.getParameter("fail");
		                %>
		                <%if(SUCCESS_CODE_DONE.equals(successCode)) {%>
		                	<div class="alert alert-info">
		                		<strong>완료</strong> 성공적으로 로그아웃되었습니다. 로그아웃을 생활화!!
		                	</div>
		                <%}%>
		                <%if(SUCCESS_CODE_SEND_MAIL.equals(successCode)) {%>
		                	<div class="alert alert-info">
		                		<strong>성공</strong> 성공적으로 이메일이 발송되었습니다. 이메일 확인후 임시비밀번호로 로그인하여 주세요
		                	</div>
		                <%}%>
		                <%if(FAIL_CODE_ALL.equals(failCode)) {%>
		                	<div class="alert alert-danger">
		                		<strong>실패</strong> 아이디와 비밀번호를 확인하여 주십시오!
		                	</div>
		                <%}%>
		                <%if(FAIL_CODE_PASSWORD.equals(failCode)) {%>
		                	<div class="alert alert-danger">
		                		<strong>실패</strong> 비밀번호가 틀렸습니다. 비밀번호를 확인하여 주십시오
		                	</div>
		                <%}%>
						<%
					 		if(request.getParameter("deny") != null) {
					 	%>		
					 		<div class="alert alert-danger">
					 			<strong>오류</strong> 로그인이 필요합니다.
					 		</div>	
					 	<%	
					 		}
					 	%>
					</div>
           			<div class="form-group">
           				<div class="col-sm-2">
           				</div>
               				<div class="col-sm-8">
               					<div class="input-group">
               						<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                   					<input type="text" class="form-control" id="id" name="id" placeholder="ID"/>
               					</div>
               				</div>
           			</div>
              		<div class="form-group">
						<div class="col-sm-2">
						</div>
							<div class="col-sm-8">
								<div class="input-group">
									<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
									<input type="password" class="form-control" id="pass" name="pass" placeholder="Password"/>
								</div>
							</div>
			 		</div>
			 		<div class="form-group"> 
    					<div class="col-sm-offset-2 col-sm-10">
      						<div class="checkbox">
       							 <label><input type="checkbox">저장</label>
      						</div>
    					</div>
  					</div>
					<div class="form-group text-right">
						<div class="col-sm-10">
							<a class="btn btn-warning" href="findPassword.jsp">PW찾기</a>
							<button class="btn btn-danger" type="submit" id="login-btn" >Login</button>
						</div>
					</div>
			 	</form>
				
			</div>
         </div>
	</div>		
</body>
<script type="text/javascript">
	document.getElementById("login-btn").addEventListener('click',function(event){
		var id = document.getElementById("id").value;
		var pass = document.getElementById("pass").value;
		if(id == '' || pass == '') {
			alert("아이디와 비밀번호를 확인하여주세요");
			document.getElementById("id").value = "";
			document.getElementById("pass").value = "";
		} 
	});
</script>
</html>