<%@page import="kr.co.jtimes.reporter.sign.vo.NewsSignVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.sign.dao.NewsSignDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style>
	.container {width:1024px; margin:0 auto;}
	#success,#wait {display: none;}
	label {cursor: pointer;}
	h3 {display: inline;}
	#loading {
	 width: 100%;  
	 height: 100%;  
	 top: 0px;
	 left: 0px;
	 position: fixed;  
	 display: block;  
	 opacity: 0.7;  
	 background-color: #fff;  
	 z-index: 99;  
	 text-align: center; } 
	  
	#loading-image {  
	 position: absolute;  
	 top: 50%;  
	 left: 50%; 
	 z-index: 100; }
</style>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "news"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%
	ReporterEmployeeVo user = (ReporterEmployeeVo)session.getAttribute("loginReporter");
%>
	<div class="container">
		<div class="row">
			<div>
				<h2>결재 목록</h2>
			</div>
			<div>
				<div class="form-group text-right panel panel-body">
					<input type="radio" name="list" value="N" id="wait" checked="checked" >
					<h3>
						<label id="list_wait" class="label label-primary" for="wait">결재 대기 목록</label>
					</h3>
					<input type="radio" name="list" value="Y" id="success">
					<h3>
						<label id="list_success" class="label label-default" for="success">결재 완료 목록</label>
					</h3>
				</div>
				<table class="table table-bordered table-hover">
					<colgroup>
						<col width="58%">
						<col width="12%">
						<col width="20%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr class="active">
							<th class="text-center">기사 제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성일</th>
							<th class="text-center">결제현황</th>
						</tr>
					</thead>
					<tbody id="table-body">
					</tbody>
				</table>
				<div class="text-center">
                	<ul class="pagination pagination-sm" id="sign-page"></ul>
            	</div>
			</div>
		</div>
	</div>
<div id="loading"><img id="loading-image" src="/commons/img/ajax-loader.gif" alt="Loading..." /></div>
</body>
<script type="text/javascript">
	var reporterPosition = <%=user.getReporterPos().getPositionNo() %>;
	if(reporterPosition != 100 && reporterPosition != 200) {
		alert("잘못된 접근입니다.");
		location.href = "/reporter/";
	}

	function mouseOver(el) {
		el.setAttribute("class", "label label-default");
	}
	function mouseLeave(el) {
		el.setAttribute("class", "label label-primary");
	}
	
	function ajaxProcess(pageNo, state) {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var sign = JSON.parse(xhr.responseText);
				var beginPage = sign.beginPage;
				var endPage = sign.endPage;
				var currentNaviBlock = sign.currentNaviBlock;
				var totalNaviBlock = sign.totalNaviBlock;
				var signList = sign.signList;
				var newsCategory = sign.newsCategory;
				var totalPages = sign.totalPages;
				var htmlContents = "";
				
				signList.forEach(function (signItem, index) {
					var state = (<%=user.getReporterPos().getPositionNo()%>==200)?signItem.firstSignState:signItem.secondSignState;
					var finalState = (state == "N")?"결재 대기중" : "결재 완료";
				
					htmlContents += '<tr class="list">';
					htmlContents += '<td class="text-center">';
					htmlContents += '<a href="/reporter/news/detailNews.jsp?type=sign&newsNo='+signItem.news.newsNo+'&signNo='+signItem.no+'&returnURL=confirmNews">'+signItem.news.newsTitle+'</a>';
					htmlContents += '</td>';
					htmlContents += '<td class="text-center">'+signItem.writer.reporterName+'</td>';
					htmlContents += '<td class="text-right">'+signItem.news.regdate+'</td>';
					htmlContents += '<td class="text-center">'+finalState+'</td>';
					htmlContents += '</tr>';
				});
				finalState = (state == "N")?"\'N\'" : "\'Y\'";
				document.getElementById("table-body").innerHTML = htmlContents;
				var pageHTML = "";
                if(pageNo != 1) {
                	pageHTML +='<li><a onclick="javascript:ajaxProcess('+ (pageNo-1) +', '+finalState+')">&lt;</a></li>';
                }
				for(var i = beginPage; i <= endPage; ++i) {
					pageHTML += '<li class="'+((i == pageNo)?'active':'')+'"><a onclick="javascript:ajaxProcess('+ i +', '+finalState+')">' + i + '</a></li>'
				}
				if(!(pageNo >= totalPages)){
					pageHTML += '<li><a onclick="javascript:ajaxProcess('+ (pageNo+1) +', '+finalState+')">&gt;</a></li>';
				}
				document.getElementById("sign-page").innerHTML = pageHTML;
				
				document.getElementById("loading").style.display = "none";
				document.getElementById("loading-image").style.display = "none";
				
			}
		}
		
		xhr.open("GET", "/reporter/news/confirmListSortProcess.jsp?state="+state+"&pno="+pageNo);
		xhr.send(null);
	}
	
	document.getElementById("list_success").addEventListener("click", function(event){
		document.getElementById("loading").style.display = "block";
		document.getElementById("loading-image").style.display = "block";
		document.getElementById("list_success").setAttribute("class", "label label-primary");
		document.getElementById("list_wait").setAttribute("class", "label label-default");
		ajaxProcess(1, 'Y');
	});
	document.getElementById("list_wait").addEventListener("click", function(event){
		document.getElementById("loading").style.display = "block";
		document.getElementById("loading-image").style.display = "block";
		document.getElementById("list_success").setAttribute("class", "label label-default");
		document.getElementById("list_wait").setAttribute("class", "label label-primary");
		ajaxProcess(1, 'N');
	});
	ajaxProcess(1, 'N');
	
</script>
</html>