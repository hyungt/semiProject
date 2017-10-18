<%@page import="java.sql.Date"%>
<%@page import="kr.co.jtimes.common.criteria.AdCriteria"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.jtimes.ad.vo.AdVo"%>
<%@page import="kr.co.jtimes.ad.dao.AdDao"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>광고세부정보보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%
	String type = request.getParameter("type");
	if (type == null) {
		type = "A";
	}
	AdDao adDao = new AdDao();
	AdCriteria adcriteria = new AdCriteria();
	List<AdVo> adVoList = null;
	adcriteria.setPage(1);
	adcriteria.setType(type);
	if("A".equals(type)){
		adVoList = adDao.getAdByCriteria(adcriteria);
	} else if ("F".equals(type)){
		adVoList = adDao.getAdDone(adcriteria);
	} else if ("I".equals(type)) {
		adVoList = adDao.getAdByIng(adcriteria);
	}
%>
<style type="text/css">
.container {
	width: 1024px;
	margin: 0 auto;
}
</style>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "ad"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<input type="hidden" id="page" value="<%=2 %>">
<div class="container">
  		<div class="row">
			<ul class="nav nav-tabs navcontents" style="margin-top: 200px;">
	           		<li class="<%="A".equals(type)?"active":""%>"><a href="adView.jsp?type=A" id="category-all">전체</a></li>
                    <li class="<%="F".equals(type)?"active":""%>"><a href="adView.jsp?type=F" id="category-done">계약만료</a></li>
                    <li class="<%="I".equals(type)?"active":""%>"><a href="adView.jsp?type=I" id="category-ing">계약중광고</a></li>
					<li class="pull-right"><a class="btn btn-info" href="/reporter/AD/adAdd.jsp">광고등록</a></li>
			</ul>
			<div class="panel panel-default">
				<table class="table table-condensed table-hover">
						<thead>
							<tr>
								<th>광고번호</th>
								<th>광고_타이틀</th>
								<th>광고계약날자</th>
								<th>광고만료날자</th>
							</tr>
						</thead>
						<tbody id="all-add">
							<%
							for(AdVo ads : adVoList) {
								SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
								simpleDateFormat.format(ads.getAdStartDate());
							%>
								<tr>
									<td><a id="no"><%=ads.getAdNo() %></a></td>
									<td><a id="title" href="/reporter/AD/adDetail.jsp?no=<%=ads.getAdNo() %>"><%=ads.getAdTitle()%></a></td>
									<td><a id="startdate"><%=simpleDateFormat.format(ads.getAdStartDate())%></a></td>
									<td><a id="enddate"><%=simpleDateFormat.format(ads.getAdEndDate()) %></a></td>
								</tr>	
							<%} %>
							
						</tbody>
					</table>
				</div>      
  		</div>
	</div>
</body>
<%@ include file="/reporter/commons/reporterFooter.jsp"  %>
<script>


	function urlBuilder(data) {
	    return Object.keys(data).map(function(key) {
	        return [key, data[key]].map(encodeURIComponent).join("=");
	    }).join("&");
	}


   		(function() {
	         var count = 0;
	                  
	         window.onscroll = function(ev) {
	        	 
	             if ((window.innerHeight + window.pageYOffset) >= document.body.offsetHeight) {
	            	 	 
	                if(count == 0) {
	             
	                   
	                   count = 1;
	                   
	                   var inputPage = document.getElementById('page');
	                   var page = parseInt(inputPage.value);
	                   var no = document.getElementById('no').innerText;
	                   var title = document.getElementById('title').innerText;
	                   var startdate = document.getElementById('startdate').innerText;
	                   var enddate = document.getElementById('enddate').innerText;
	                   
	                   
	                   inputPage.value = page + 1;
	                   
	                   var htmlContent = '';
	                   var url = '/reporter/AD/adViewservlet.html?';
	                   var params = {
	                           'page': page,
	                           'type': '<%=type%>'
                        };
	                        
	                   url += urlBuilder(params);
	                   
	                   var xhr = new XMLHttpRequest();
	                   xhr.onload = function() {
	                      var ads = JSON.parse(xhr.responseText);
	                      
	                      var adSize = ads.length;
	                      var adContainer = document.getElementById('all-add');
	                      for(var i =0; i< adSize; i++) { 
	                         	var ad = ads[i];
	                         	console.log(ad);
								htmlContent += "<tr>"
								htmlContent += "<td><a>"+ad.adNo+"</a></td>"
	 							htmlContent += "<td><a href=/reporter/AD/adDetail.jsp?no="+ad.adNo+">"+ad.adTitle+"</a></td>" 
	 							htmlContent += "<td><a>"+ad.formatStartDate+"</a></td>" 
	 							htmlContent += "<td><a>"+ad.formatEndDate+"</a></td>" 
								htmlContent += "</tr>"
	                      }
	                      adContainer.innerHTML += htmlContent;
	                   };
	                   console.log(url);
	                   xhr.open('get', url);
	                   xhr.send(null);
	                   setTimeout(function() {
	                      count = 0;
	                   }, 500);
	                   
	                   
	                }
	                
	             }
	         };
   		})();
   </script> 
</html>