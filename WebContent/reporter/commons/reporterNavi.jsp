<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	ReporterEmployeeVo loginReporter = (ReporterEmployeeVo) session.getAttribute("loginReporter");
    	String cp = (String)pageContext.getAttribute("cp");
    %>
<style type="text/css">

	.navbar-inverse .navbar-brand,
	.navbar-inverse .navbar-brand:hover,
	.navbar-inverse .navbar-brand:focus,
	.navbar-inverse .navbar-nav > li > a,
	.navbar-inverse .navbar-nav > li > a:hover,
	.navbar-inverse .navbar-nav > li > a:focus{
		
		font-size: 15px;
	}
	.navbar-inverse .navbar-nav > .active > a, 
	.navbar-inverse .navbar-nav > .active > a:hover, 
	.navbar-inverse .navbar-nav > .active > a:focus {
  	  
  	  background-color: #990000;
	}
	
	.navbar-header,
	.navbar-form{
		
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	.navbar-nav > li > a{
		padding-top: 25px;
		padding-bottom: 25px;
	}
	.navbar-brand img {
		height: auto;
		width:150px;
		
	}
</style>
	<nav class="navbar navbar-static-top navbar-inverse">
		<div class="container">
			<div class="navbar-header ">
				<a class="navbar-brand" href="/reporter/"><img src="/commons/img/logo.png" alt="logoImage" /></a>
			</div>
			<ul class="nav navbar-nav">
				<li class="<%="p".equals(cp)?"active":""%>"><a href="/reporter/"><strong>홈</strong></a></li>
				<li class="dropdown <%="news".equals(cp)?"active":""%>"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"><strong>기사 관리</strong><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="/reporter/news/addNews.jsp">기사 작성</a></li>
						<li ><a href="/reporter/news/writeList.jsp">작성 목록</a></li>
					<%
						int loginUserPos =((ReporterEmployeeVo)session.getAttribute("loginReporter")).getReporterPos().getPositionNo();
						if(loginUserPos == 100 ||loginUserPos == 200) {
					%>
						<li ><a href="/reporter/news/confirmNews.jsp">결재 목록</a></li>
					<%}%>
					</ul></li>
				<li class="dropdown <%="img".equals(cp)?"active":""%>"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"><strong>사진 관리</strong><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="/reporter/imageContainer/">사진 검색</a></li>
						<li ><a href="/reporter/imageContainer/addPicture.jsp">사진 등록</a></li>
					</ul></li>
				<%if(((ReporterEmployeeVo)session.getAttribute("loginReporter")).getDeptNo().getDeptNo() == 6000){ %>
				<li class="<%="reporter".equals(cp)?"active":""%>"><a href="/reporter/profile/reporterList.jsp"><strong>기자 관리</strong></a></li>
				<li class="<%="ad".equals(cp)?"active":""%>"><a href="/reporter/AD/adView.jsp"><strong>광고 관리</strong></a></li>
				<%} %>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			<%if(loginReporter == null) {%>
				<li class="<%="log".equals(cp)?"active":""%>"><a href="/reporter/profile/login.jsp"><span class="glyphicon glyphicon-log-in"></span>
						<strong>로그인</strong></a></li>
			<%} else { %>
				<li><a href="/reporter/profile/profile.jsp"><strong>프로필 확인</strong></a></li>
				<li><a href="/reporter/profile/reporterLogout.jsp"><span class="glyphicon glyphicon-log-out"></span><strong>로그아웃</strong></a></li>
			<%} %>
			</ul>
		</div>
	</nav>