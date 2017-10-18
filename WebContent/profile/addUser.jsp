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
	pageContext.setAttribute("cp", "add");
	if(session.getAttribute("userLogin") != null) {
		response.sendRedirect("/");
		return;
	}
%>
<%@ include file="/commons/clientNavi.jsp" %>
	<div class="container">
        <div class="row">
            <div class="col-sm-offset-2 col-sm-8">
            	<div class="col-sm-offset-2 col-sm-8 panel panel-body">
	                <h1>회원가입</h1>
	                <%
	                	final String FAIL_CODE_DUP_ID = "1";
	                	final String FAIL_CODE_NULL = "2";
	                	
	                	String failCode = request.getParameter("fail");
	                %>
	                
	                <%if(FAIL_CODE_DUP_ID.equals(failCode)) {%>
	                	<div class="alert alert-danger">
	                		<strong>오류</strong> 유효한 값을 입력해주세요.
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
	                
	             
	                <form class="well" method="post" action="add.jsp">
	
	                    <div class="input-group">
    						<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
   							<input id="id" type="text" class="form-control" name="id" placeholder="아이디" type="text" onkeyup="fn_press_han(this);"  onblur="fn_press_han(this);" style="ime-mode:disabled;"/>
   						
  						</div>
	                    <div class="form-group" id="idCheck" name="idCheck"></div>
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
		                    <div class="input-group">
							    <span class="input-group-addon"> 이름 </span>
							    <input id="name" type="text" class="form-control" name="name">
							</div>
		                   	
		                   	<div class="input-group">
							    <span class="input-group-addon">Email</span>
							    <input id="email" type="text" class="form-control" name="email">
							</div>
	                    </div>
       					<div class="form-group">
       						
				        	<select class="form-control" name="question">
				  				<option value="q1">나의 아버지 성함은?</option>
				  				<option value="q2">나의 어머니 성함은?</option>
				  				<option value="q3">나의 출신 고등학교는?</option>
				  				<option value="q4">나의 출신 중학교는?</option>
				  				<option value="q5">나의 출신 초등학교는?</option>
							</select>
							
							
							<div class="input-group">
							    <span class="input-group-addon"><i class="glyphicon glyphicon-pushpin"></i></span>
								<input type="text" class="form-control" name="answer" placeholder="응답"/>
							</div>
						</div>
						
	
						
	                    <div class="form-group">
	                    	
	                        <button class="btn btn-lg btn-danger btn-block" type="submit">가입하기</button>
	                    </div>
	                </form>
	             </div>
	             </div>
            </div>
        </div>
</body>
<script type="text/javascript">

/* 한글입력 방지 */
function fn_press_han(obj)
{
    //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
    || event.keyCode == 46 ) return;
    //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
    var regexp = /[\ㄱ-ㅎㅏ-ㅣ가-힣]/g;
    console.log(obj);
    if (regexp.test(obj.value)) {
    	obj.value = "";
    } 
}


	document.getElementById("id").addEventListener("blur",function(event) {
		
		var xhr = new XMLHttpRequest();
		
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				
				var htmlContent = "";
				if(data === "1") {//중복된 아이디가 없을 때
					htmlContent +="<p style='color: green'>생성 가능한 아이디 입니다.</p>";
				} else if (data === "3") {// 중복된 아이디가 있을 때
					htmlContent +="<p>아이디를 입력하세요.(영문)</p>";
				} else if (data === "2"){
					htmlContent +="<p style='color: red'>중복된 아이디가 이미 존재합니다.</p>"
				} 
				
				
				document.getElementById("idCheck").innerHTML = htmlContent;
			}
		};
	
	xhr.open("GET", "/profile/idCheck.jsp?id="+document.getElementById("id").value);
	xhr.send(null);
	});
	
	document.getElementById("repassword").addEventListener("blur",function(event) {
		var pwd = document.getElementById("password").value;
		var repwd = document.getElementById("repassword").value;
		
//		alert(pwd.length);
		var htmlContents;
		
		if(pwd === "" || repwd === "") {
			htmlContents = "<p>비밀번호를 입력해주세요.</p>";
		} else if(pwd === repwd) {
			htmlContents = "<p style='color: green'>비밀번호가 일치합니다.</p>";
		} else {
			htmlContents = "<p style='color: red'>비밀번호가 일치하지않습니다.</p>";
		}
		
		
		
		document.getElementById("rePwdCheck").innerHTML = htmlContents
	});
	
	document.getElementById("password").addEventListener("blur",function(event) {
		
		var pwd = document.getElementById("password").value;
		
		if(pwd === "") {
			htmlContents = "<p>비밀번호를 입력해주세요. (8자리이상 14자리이하)</p>";
		} else if(pwd.length < 8 || pwd.length > 14) {
			htmlContents = "<p style='color: red'>비밀번호를 8자리이상 14자리이하로 입력해주세요.</p>";
		} else {
			htmlContents = "<p style='color: green'>사용가능한 비밀번호 입니다.</p>";
		}
		
		document.getElementById("pwdCheck").innerHTML = htmlContents;
	});
</script>
</html>