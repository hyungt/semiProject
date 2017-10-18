<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MY PROFILE CHANGE</title>
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
// 로그인 되지 않은 사용자가 접근했을 때 로그인후 되돌아갈 url 지정
pageContext.setAttribute("url", "/reporter/profile/login.jsp"); 
%>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-2 col-sm-7">
				<form id="frm" class="form-horizontal well" method="post" action="/reporter/profile/updateProfileDone.jsp">
					<h1 class="text-center">PROFILE CHANGE</h1>
           				<div class="form-group">
           				<%
	                	final String SUCCESS_CODE_DONE = "1";
	                	final String SUCCESS_CODE_PASSWORD_DONE = "2";
	                	String successCode = request.getParameter("success");
		                %>
		                <%if(SUCCESS_CODE_DONE.equals(successCode)) {%>
		                	<div class="alert alert-info">
		                		<strong>완료</strong> 개인 정보가 성공적으로 변경되었습니다.
		                	</div>
		                <%}%>
						<% if(SUCCESS_CODE_PASSWORD_DONE.equals(successCode)) {%>
		                	<div class="alert alert-info">
		                		<strong>완료</strong> 비밀번호가 성공적으로 변경되었습니다.
		                	</div>
		                <%}%>
						<% 
							ReporterEmployeeVo re = new ReporterEmployeeVo();
							re = (ReporterEmployeeVo)session.getAttribute("loginReporter"); 
							String[] arrPhone=re.getReporterPhone().split("-");%>
               				<label class="control-label col-sm-2">ID</label>
               					<div class="col-sm-9">
                   					<a type="text" class="form-control" ><%=re.getReporterId() %></a>
               					</div>
           				</div>
           				
           				<div id="alert-box"></div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">성   명</label>
              					<div class="col-sm-4">
              						<a type="text" class="form-control" ><%=re.getReporterName() %></a>
              					</div>
              						<label class="control-label col-sm-2">직급</label>
              							<div class="col-sm-3">
                        					<select name="front-joblv" class="form-control">
                            					<option value="" selected="selected" disabled><%=re.getReporterPos().getPositionName() %></option>
                        					</select>
                    					</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">PASSWORD</label>
               					<div class="col-sm-7">
                  					<a type="text" class="form-control" disabled="disabled" /></a>
               					</div>
               					<div class="pwchange col-sm-2">
                        			<a href="/reporter/profile/updatePassword.jsp"  class="btn btn-danger" >변경</a>
                    			</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">email</label>
               					<div class="col-sm-9">
                  					<input type="email" class="change-email form-control" id="email" name="email" value="<%=re.getReporterEmail() %>" placeholder="@을 포함하여 도메인을  정확하게 입력해주세요!"/>
               					</div>
              			</div>
              			<div class="form-group">
              				<label class="control-label col-sm-2">전화번호</label>
                				<div class="col-sm-3">
                        			<select name="front-number" class="form-control" name="front-number">
                            			<option value="010">010</option>
                            			<option value="011">011</option>
                            			<option value="017">017</option>
                            			<option value="019">019</option>
                        			</select>
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="sec-number" name="sec-number" oninput="maxLengthCheck(this)" value="<%=arrPhone[1] %>" />
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="thr-number" name="thr-number" oninput="maxLengthCheck(this)" value="<%=arrPhone[2] %>" />
                    			</div> 
              			</div>
						<div class="form-group text-right font-size:20px">
							<div class="col-sm-11 font-size-large">
								<button  class="btn btn-danger" id="btn-confirm" type="submit">수정</button>
								<a href="/reporter/index.jsp" class="btn btn-info" >메인페이지</a>
							</div>
						</div>
				</form>
			</div>
          </div>
	</div>				
</body>
<script type="text/javascript">
	function maxLengthCheck(object){
		if (object.value.length > object.maxLength){
			object.value = object.value.slice(0, object.maxLength);
		}    
	}
	document.getElementById("frm").addEventListener('submit', function(event){
		event.preventDefault();
		var emailValue = document.getElementById("email").value;
		var secNumber = document.getElementById("sec-number").value;
		var thrNumber = document.getElementById("thr-number").value;
		if(emailValue == "" || secNumber == ""|| thrNumber == ""){
			var html ='<div class="alert alert-danger">';
    		html += '<strong>오류</strong> 비어있는 칸이 있습니다.';
    		html += '</div>';
    		document.getElementById("alert-box").innerHTML = html;
		} else{
			document.getElementById("frm").submit();
		}
	});
</script>
</html>