<%@page import="kr.co.jtimes.profile.common.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%
	String cp = (String) pageContext.getAttribute("cp");
  
  	UserVo userLogin = (UserVo) session.getAttribute("userLogin");
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
  	  color: white;
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
	.nav.navbar-nav a strong {
font-size : 20px;
line-height:20px;
vertical-align:bottom;
}
	
  </style>
<nav class="navbar navbar-inverse">
  <div class="container">

    <div class="navbar-header">
      <a class="navbar-brand" href="/index.jsp"><img src="/commons/img/logo.png" alt="logoImage" /></a>
    </div>
    <ul class="nav navbar-nav">
      <li class="<%="eve".equals(cp)?"active":"" %>"><a href="/news/events.jsp"><strong>시사</strong></a></li>
      <li class="<%="eco".equals(cp)?"active":"" %>"><a href="/news/economy.jsp"><strong>경제</strong></a></li>
      <li class="<%="spo".equals(cp)?"active":"" %>"><a href="/news/sports.jsp"><strong>스포츠</strong></a></li>
      <li class="<%="ent".equals(cp)?"active":"" %>"><a href="/news/entertainment.jsp"><strong>연예</strong></a></li>
      <li class="<%="join".equals(cp)?"active":"" %>"><a href="/citizenrep/list.jsp"><strong>참여마당</strong></a></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
    <%
    	String url = request.getRequestURI() + (request.getQueryString() == null? "" : ("?" + request.getQueryString()));
    	if(userLogin == null) { 
    
    %>
      <li class="<%="add".equals(cp)?"active":"" %>"><a href="/profile/addUser.jsp"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
      <li class="<%="log".equals(cp)?"active":"" %>"><a href="/profile/userLogin.jsp?returnURL=<%=url %>"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
     <%} else { %>
     	<li class="<%="fix".equals(cp)?"active":"" %>"><a href="/profile/profileFix.jsp">프로필 수정</a></li>
    	<li><a href="/profile/logout.jsp?returnURL=<%=url %>"><span class="glyphicon glyphicon-log-out">로그아웃</span></a></li>
     <%} %>
    </ul>

  </div>
</nav>