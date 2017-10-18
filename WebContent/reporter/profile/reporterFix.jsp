<%@page import="kr.co.jtimes.common.vo.DepartmentVo"%>
<%@page import="kr.co.jtimes.common.vo.ReporterPositionVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.common.dao.CommonsDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
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
	pageContext.setAttribute("cp", "de4");
	int no = Integer.parseInt(request.getParameter("no"));
	ReporterEmployeeDao reporterDao = new ReporterEmployeeDao();
	ReporterEmployeeVo re = reporterDao.getReporterByNo(no);
	
	String[] phone = re.getReporterPhone().split("-");
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
	<div id="alert-box"></div>
		<div class="row">
			<div class="col-sm-offset-2 col-sm-7">
				<form id="frm" class="form-horizontal well" method="post" action="/reporter/profile/reporterFixReg.jsp?no=<%=no%>">
					<h1 class="text-center">PROFILE CHANGE</h1>
					
					
           				<div class="form-group">
               				<label class="control-label col-sm-2">ID</label>
               					<div class="col-sm-9">
                   					<input type="text" class="form-control" id="id" name="id" value="<%=re.getReporterId() %>">
               					</div>
           				</div>
           				
           				
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">성   명</label>
              					<div class="col-sm-4">
              						<input type="text" class="form-control" id="name" name="name" value="<%=re.getReporterName() %>">
              					</div>
              						<label class="control-label col-sm-2">직급</label>
              							<div class="col-sm-3">
                        					<select id="joblv" name="joblv" class="form-control">
                            					<%for(ReporterPositionVo pos : posList){ %>
                            					<option value="<%=pos.getPositionNo() %>"><%=pos.getPositionName() %></option>
                           					<%} %>
                        					</select>
                    					</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">PASSWORD</label>
               					<div class="col-sm-9">
                  					<input type="password" class="form-control" id="password" name="password"/></a>
               					</div>
               					
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">부서번호</label>
               					<div class="col-sm-9">
                  					<select name="deptNo" class="form-control" id="deptNo">
                      					<%for(DepartmentVo dept : deptList){ %>
                   					<option value="<%=dept.getNo() %>"><%=dept.getName() %></option>
               					<%} %>
                   					</select>
               					</div>
              			</div>
              			<div class="form-group">
              	 			<label class="control-label col-sm-2">email</label>
               					<div class="col-sm-9">
                  					<input type="text" class="form-control" id="email" name="email" value="<%=re.getReporterEmail() %>"/>
               					</div>
              			</div>
              			<div class="form-group">
              				<label class="control-label col-sm-2">전화번호</label>
                				<div class="col-sm-3">
                        			<select name="front-number" class="form-control" name="front-number">
                            			<option value="010" <%="010".equals(phone[0])? "selected" : "" %>>010</option>
                            			<option value="011" <%="011".equals(phone[0])? "selected" : "" %>>011</option>
                            			<option value="017" <%="017".equals(phone[0])? "selected" : "" %>>017</option>
                            			<option value="019" <%="019".equals(phone[0])? "selected" : "" %>>019</option>
                        			</select>
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="sec-number" name="sec-number" oninput="maxLengthCheck(this)" value="<%=phone[1] %>" />
                    			</div>
                    			<div class="col-sm-3">
                        			<input type="number" max="9999" min="0001" maxlength="4" class="form-control" id="thr-number" name="thr-number" oninput="maxLengthCheck(this)" value="<%=phone[2] %>" />
                    			</div> 
              			</div>
						<div class="form-group text-right font-size:20px">
							<div class="col-sm-11 font-size-large">
								<a href="/reporter/profile/reporterList.jsp" class="btn btn-info" >메인페이지</a>
								<button  class="btn btn-danger" id="btn-confirm" type="submit">수정</button>
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
		var emailValue = document.getElementById("email").value;
		var secNumber = document.getElementById("sec-number").value;
		var thrNumber = document.getElementById("thr-number").value;
		if(emailValue == "" || secNumber == ""|| thrNumber == "" || id == "" || name ==""){
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
