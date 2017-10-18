<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PASSWORD CHANGE</title>
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
			<div  class="col-sm-offset-3 col-sm-6">
				<form id="frm" class="form-horizontal well" method="post" action="/reporter/profile/passwordReporter.jsp">
					<h1 class="text-center">PASSWORD CHANGE</h1>
						<%
	                	final String FAIL_CODE_NOT_EQUALS_PW = "1";
	                	final String FAIL_CODE_EQUALS_PW_EXISTING = "2";
	                	
	                	String failCode = request.getParameter("fail");
		                %>
		                
		                <%if(FAIL_CODE_NOT_EQUALS_PW.equals(failCode)) {%>
		                	<div class="alert alert-danger">
		                		<strong>오류</strong> 비밀번호가 서로 일치하지 않습니다. 다시 확인하여 주십시오.
		                	</div>
		                <%}%>
		                <%if(FAIL_CODE_EQUALS_PW_EXISTING.equals(failCode)) {%>
							<div class="alert alert-danger">
								<strong>오류</strong> 기존비밀번호와 입력하신 번호가 일치합니다. 다른 비밀번호를 입력하여 주십시오.
							</div>	
						<%}%>
						<div id="alert-box"></div>
           				<div class="form-group">
               				<label class="control-label col-sm-3">PW</label>
               					<div class="col-sm-7">
                   					<input type="password" class="form-control" id="pw" name="pw" placeholder="변경할 비밀번호를 입력하세요"/>
               					</div>
           				</div>
              			<div class="form-group">
              		 			<label class="control-label col-sm-3">PW-CHECK</label>
               					<div class="col-sm-7">
                  	 				<input type="password" class="form-control" id="repw" name="repw" placeholder="확인을위해 다시입력하세요"/>
               					</div>
						</div>
						<div class="form-group text-center">
							<div class="col-sm-12">
								<button class="btn btn-danger" type="submit" id="pwch-btn" >변경</button>
								<a href="/reporter/profile/updateProfile.jsp" class="btn btn-info">프로필수정</a>
							</div>
						</div>			
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
		document.getElementById("frm").addEventListener('submit', function(event){
			event.preventDefault();
			var pw = document.getElementById("pw").value;
			var repw = document.getElementById("repw").value;
			if(pw != repw ){
				var html ='<div class="alert alert-danger text-center">';
	    		html += '<strong>오류</strong>';
	    		html += '<p>입력하신 비밀번호가 서로 다릅니다.</p>';
	    		html += '</div>';
	    		document.getElementById("alert-box").innerHTML = html;
				document.getElementById("pw").value = "";
				document.getElementById("repw").value = "";
				return;
			} else if(pw == '' || repw == ''){
				document.getElementById("pw").value = "";
				document.getElementById("repw").value = "";
				var html ='<div class="alert alert-danger">';
	    		html += '<strong>오류</strong> 비어있는 칸이 있습니다.';
	    		html += '</div>';
	    		document.getElementById("alert-box").innerHTML = html;
				return;
			} else if(pw.length > 14 || pw.length < 7) {
				var html ='<div class="alert alert-danger">';
	    		html += '<strong>오류</strong>';
	    		html += '<p>비밀번호가 너무 길거나 짧습니다.</p>';
	    		html += '<p>비밀번호는 8자리 이상 14자리 미만으로 적어주세요 !</p>';
	    		html += '</div>';
	    		document.getElementById("alert-box").innerHTML = html;
				document.getElementById("pw").value ="";
				document.getElementById("repw").value ="";
			} else{
				document.getElementById("frm").submit();
			}
		});
</script>
</html>