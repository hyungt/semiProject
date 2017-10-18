<%@page import="kr.co.jtimes.common.vo.DepartmentVo"%>
<%@page import="kr.co.jtimes.common.vo.ReporterPositionVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.common.dao.CommonsDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>PROFILE MANAGER</title>
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
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "reporter"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%
	CommonsDao commonsDao = new CommonsDao();
	List<ReporterPositionVo> posList = commonsDao.getAllPosition();
	List<DepartmentVo> deptList = commonsDao.getAllDepartment();
%>
	<div class="container">
		<div class="row">
			<div class="col-sm-offset-2 col-sm-7">
				<form id="frm" class="form-horizontal well" method="post" action="/reporter/profile/addReporterReg.jsp">
						<%
	                	final String FAIL_CODE_SAME_ID = "1";
	                	final String SUCCESS_CODE_SAVE = "1";
	                	
	                	String failCode = request.getParameter("fail");
	                	String successCode = request.getParameter("success");
		                %>
		                
		                <%if(FAIL_CODE_SAME_ID.equals(failCode)) {%>
		                	<div class="alert alert-danger">
		                		<strong>오류</strong> 중복되는 <%=request.getParameter("id")%>가 있습니다.
		                	</div>
		                <%}%>
		                <%if(SUCCESS_CODE_SAVE.equals(successCode)) {%>
							<div class="alert alert-info">
								<strong>성공</strong> 입력하신 아이디<%=request.getParameter("id")%>가 성공적으로 등록되었습니다.
							</div>	
						<%}%>
					<h1 class="text-center">기자 신규 정보 입력</h1>
           				<div class="form-group">
               				<label class="control-label col-sm-2">ID</label>
               					<div class="col-sm-9">
                   					<input id="id" name="id" type="text" class="form-control" >
               					</div>
           				</div>
           				<div id="alert-box"></div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">성   명</label>
              					<div class="col-sm-4">
              						<input id="name" name="name" type="text" class="form-control" >
              					</div>
              						<label class="control-label col-sm-2">직급</label>
              							<div class="col-sm-3">
                        					<select name="joblv" id="joblv" class="form-control">
                        					<%for(ReporterPositionVo pos : posList){ %>
                            					<option value="<%=pos.getPositionNo() %>"><%=pos.getPositionName() %></option>
                           					<%} %>
                        					</select>
                    					</div>
              			</div>
              			<div class="form-group">
     						<label class="control-label col-sm-2">부서명</label>
     							<div class="col-sm-9">
               					<select id="dept" name="dept" class="form-control">
               					<%for(DepartmentVo dept : deptList){ %>
                   					<option value="<%=dept.getNo() %>"><%=dept.getName() %></option>
               					<%} %>
               					</select>
           					</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">PASSWORD</label>
               					<div class="col-sm-9">
                  					<input type="password" class="form-control" id="password" name="password">
               					</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">email</label>
               					<div class="col-sm-9">
                  					<input type="email" class="change-email form-control" id="email" name="email" placeholder="@을 포함하여 도메인을  정확하게 입력해주세요!"/>
               					</div>
              			</div>
              			<div class="form-group">
              				<label class="control-label col-sm-2">전화번호</label>
                				<div class="col-sm-3">
                        			<select name="front-number" class="form-control" id="front-number">
                            			<option value="010">010</option>
                            			<option value="011">011</option>
                            			<option value="017">017</option>
                            			<option value="019">019</option>
                        			</select>
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="sec-number" name="sec-number" oninput="maxLengthCheck(this)"/>
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="thr-number" name="thr-number" oninput="maxLengthCheck(this)"/>
                    			</div> 
              			</div>
						<div class="form-group text-right font-size:20px">
							<div class="col-sm-11 font-size-large">
								<button  class="btn btn-danger" id="btn-confirm" type="submit">등록</button>
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
		var id = document.getElementById("id").value;
		var name = document.getElementById("name").value;
		var joblv = document.getElementById("joblv").value;
		var dept = document.getElementById("dept").value;
		var pw = document.getElementById("password").value;
		var emailValue = document.getElementById("email").value;
		var frontNumber = document.getElementById("front-number").value;
		var secNumber = document.getElementById("sec-number").value;
		var thrNumber = document.getElementById("thr-number").value;
		if(emailValue == "" || frontNumber == "" || secNumber == ""|| thrNumber == "" || id == "" || name == "" || joblv == "" || dept == "" || pw == ""){
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