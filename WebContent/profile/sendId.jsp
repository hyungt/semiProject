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
	.container {
		width: 1024px;
		margin: 0 auto;
	}
</style>
</head>
<body>
<%
	pageContext.setAttribute("cp", "add");
%>
<%@ include file="/commons/clientNavi.jsp" %>
<div class="container">
	<div class="jumbotron">
	
		<h3>회원님의 아이디가 Email로 전송되었습니다. </h3>
	
		
	</div>
	
		<div class="form-group text-right">
            <a href="../index.jsp" class="btn btn-danger btn-lg">메인으로</a>
            <a href="userLogin.jsp" class="btn btn-primary btn-lg">로그인창으로</a>
        </div>
   
</div>
</body>
</html>