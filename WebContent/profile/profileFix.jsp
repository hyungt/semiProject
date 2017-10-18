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
	pageContext.setAttribute("cp", "fix");
	pageContext.setAttribute("url", "/profile/userLogin.jsp");	 
%>

<%
	UserVo user = new UserVo();
	user = (UserVo) session.getAttribute("userLogin");
	
	if(user == null) {
		response.sendRedirect("userLogin.jsp?deny=1");
		return;
	}
	
	String id = (String) user.getId();
	String name = (String) user.getName();
	String email = (String) user.getEmail();
	String pwdQuestion = (String) user.getPwdQuestion();
	String pwdAnswer = (String) user.getPwdAnswer();

%>
<%@ include file="/commons/clientNavi.jsp" %>

	<div class="container">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-8">
            	<div class="col-sm-offset-2 col-sm-8 panel panel-body">
	                <h1>프로필 수정</h1>
	                 <%
	                	final String FAIL_CODE_DUP_ID = "1";
	                	final String FAIL_CODE_NULL = "2";
	                	final String FAIL_CODE_PWD = "3";
	                	
	                	String failCode = request.getParameter("fail");
	                %>
	                
	                <%if(FAIL_CODE_DUP_ID.equals(failCode)) {%>
	                	<div class="alert alert-danger">
	                		<strong>오류</strong> 유효한 값을 입력해주세요.
	                	</div>
	                <%}%>
	                <%if(FAIL_CODE_PWD.equals(failCode)) {%>
	                	<div class="alert alert-danger">
	                		<strong>오류</strong> 비밀번호가 일치하지 않습니다.
	                	</div>
	                <%}%>
	                <% 
						if(FAIL_CODE_NULL.equals(failCode) ) {
					%>
							<div class="alert alert-danger">
								<strong>오류</strong> 유효한 정보를 입력해주세요.
							</div>
					<%
						}
					%>

	                <form class="well" method="post" name="pro" action="profile.jsp">
						<fieldset disabled>
		                    <div class="form-group">
		                    	<div class="input-group">
			                    	<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		      						<input type="text" id="disabledTextInput" class="form-control" placeholder="<%=id%>">   
	      						</div>
	  						</div>
	  					</fieldset>

	                     <!-- 
						 	브라켓 부트스트랩 데모7-폼에 
						 	success, fail 있음
						 -->
	                    
	                    <div class="input-group">
						    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
						    <input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
						</div>
						<div class="form-group" id="pwdCheck"></div>
	                    
	                    <div class="input-group">
						    <span class="input-group-addon"><i class="glyphicon glyphicon-ok"></i></span>
						    <input id="repassword" type="password" class="form-control" name="repassword" placeholder="비밀번호 확인">
						</div>
						<div class="form-group" id="rePwdCheck"></div>
	                    <div class="form-group">
		                  
							<fieldset disabled>
		                    <div class="form-group">
		                    	<div class="input-group">
			                    	<span class="input-group-addon"> 이름 </span>
		      						<input type="text" id="disabledTextInput" class="form-control" placeholder="<%=name%>">   
	      						</div>
	  						</div>
	  						</fieldset>
		                   	
		                   	<div class="input-group">
							    <span class="input-group-addon">Email</span>
							    <input id="email" type="text" class="form-control" name="email" value="<%=email %>">
							</div>
	                    </div>
       					<div class="form-group">
       					
				        	<select class="form-control" name="question" id="question">
				  				<option value="q1"<%="q1".equals(pwdQuestion) ? "selected": ""%>>나의 아버지 성함은?</option>
				  				<option value="q2"<%="q2".equals(pwdQuestion) ? "selected": ""%>>나의 어머니 성함은?</option>
				  				<option value="q3"<%="q3".equals(pwdQuestion) ? "selected": ""%>>나의 출신 고등학교는?</option>
				  				<option value="q4"<%="q4".equals(pwdQuestion) ? "selected": ""%>>나의 출신 중학교는?</option>
				  				<option value="q5"<%="q5".equals(pwdQuestion) ? "selected": ""%>>나의 출신 초등학교는?</option>
							</select>
							
							
							<div class="input-group">
							    <span class="input-group-addon"><i class="glyphicon glyphicon-pushpin"></i></span>
								<input type="text" class="form-control" name="answer" value="<%=pwdAnswer%>"/>
							</div>
						</div>
						

						
	                    <div class="form-group text-right">
                			<a href="../index.jsp" class="btn btn-danger">취소</a>
	                 	 	<button id="login-btn" class="btn btn-primary">변경</button>
	            		</div>
	                </form>
	             </div>
	             </div>
            </div>
        </div>

</body>
</html>