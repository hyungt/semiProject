<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PASSWORD FIND</title>
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
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-2 col-sm-7">
				<form id="frm" class="form-horizontal well" method="post" action="/reporter/profile/findSendEmail.jsp">
					<h1 class="text-center">PASSWORD FIND</h1>
					<%
                        request.setCharacterEncoding("utf-8");
	                	final String FAIL_CODE_NOT_EQUALS_INFO = "1";
	                	
	                	String failCode = request.getParameter("fail");
		                %>
		                
		                <%if(FAIL_CODE_NOT_EQUALS_INFO.equals(failCode)) {%>
		                	<div class="alert alert-danger">
		                		<strong>오류</strong> 입력정보가 일치하지 않습니다. 확인후 다시 입력해주세요.
		                	</div>
		                <%}%>
           			<div class="form-group">
               			<label class="control-label col-sm-2">성   명</label>
               				<div class="col-sm-9">
                   				<input type="text" id="reporter-name" name="reporter-name" class="form-control" placeholder="이름을 입력하세요"/>
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
                        		<input type="number" max="9999" maxlength="4" class="form-control" id="sec-number" name="sec-number" oninput="maxLengthCheck(this)" />
                   			</div>
                   			<div class="col-sm-3">
                       			<input type="number" max="9999" maxlength="4" class="form-control" id="thr-number" name="thr-number" oninput="maxLengthCheck(this)" />
                   			</div> 
                   </div>
	  				<div class="form-group text-right">
	  					<div class="col-sm-11">
							<button type="submit" class="btn btn-danger" id="agree-btn">확인</button>
							<a href="/reporter/profile/login.jsp" class="btn btn-info">로그인</a>
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
</script>
</html>