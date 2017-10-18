<%@page import="java.util.Random"%>
<%@page import="kr.co.jtimes.ad.vo.AdVo"%>
<%@page import="kr.co.jtimes.ad.dao.AdDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.jtimes.common.criteria.Criteria"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	.container {
		width: 1024px;
		margin: 0 auto;
	}
	
	a { color: black; }
	
	#reporter { color: darkgray; }
	
	#ad { margin-top : 30px; }
	
	#ad-img {
		width: 250px; 
		height: 250px;
	}
</style>
</head>
<body>
<%
	pageContext.setAttribute("cp", "main");
%>
<%@include file="/commons/clientNavi.jsp" %>
	<div class="container">
	<%
		TbNewsDao newsDao = new TbNewsDao();
	
		TbNewsVo mainNews = newsDao.getMainNews();
		
		String parse = mainNews.getNewsContents();
		Document doc = Jsoup.parse(parse);
		String result = doc.text();
		if(result.length() > 200) {
			result = result.substring(0, 200);
			result += "...";
		}
	%>
	
	<%
		if (mainNews.getNewsTitle().length() >= 25) {
			String mainsNewsTitlte = mainNews.getNewsTitle().substring(0, 25) + "...";
	%>
	
 		<div class="col-xs-6 panel panel-body">
 			<div class="row">
 			<%if(mainNews.getNewsImgPath() != null){ %>
	 			<div class="col-xs-6">
		 			<a href="/news/addHit.jsp?newsNo=<%=mainNews.getNewsNo()%>" ><img alt="" src="<%=mainNews.getNewsImgPath() %>" class="img-thumbnail" width="250px" height="250px"></a>
	 			</div>
	 		<%}%>
	 			<h3 class="text-left"><a href="/news/addHit.jsp?newsNo=<%=mainNews.getNewsNo()%>"><%=mainsNewsTitlte %></a></h3>
	<%
	 			} else {
			String mainsNewsTitlte = mainNews.getNewsTitle();
	%>
				<h3 class="text-left"><a href="/news/addHit.jsp?newsNo=<%=mainNews.getNewsNo()%>"><%=mainsNewsTitlte %></a></h3>
	<%
		}
	%>
	 			
	 			<p><%=result %></p>
 			</div>
 			<hr />
	
				<%
					TbNewsDao tbNewsDao = new TbNewsDao();
					List<TbNewsVo> tbNewsVos = tbNewsDao.getTodayNewsList();
					
					for(TbNewsVo tbNewsVo : tbNewsVos) {
				%>
				<%
					if (tbNewsVo.getNewsTitle().length() >= 35) {
						String newsesTitlte = tbNewsVo.getNewsTitle().substring(0, 35) + "...";
				%>
					
						<p><strong><a href="/news/addHit.jsp?newsNo=<%=tbNewsVo.getNewsNo()%>"><%=newsesTitlte%></a></strong></p>
					
				<%	
						} else {
							String newsesTitlte = tbNewsVo.getNewsTitle();
				%>
					
						<p><strong><a href="/news/addHit.jsp?newsNo=<%=tbNewsVo.getNewsNo()%>"><%=newsesTitlte%></a></strong></p>
					
				<%
						}
				
					}
				%>
 		</div>
 		<div class="col-xs-offset-1 col-xs-5">
 		<div class="row">
 			<div class="row">
 				<h3>최근 이슈</h3>
 		<%
					List<TbNewsVo> importantNewsList = newsDao.getYesterdayImportantNewses();
 					for(TbNewsVo importantNews : importantNewsList) {
 		%>
			</div>
			<div class="row">
 			<div class="col-xs-2">
 		<%
 						if (importantNews.getNewsTitle().length() >= 10) {
 						String subNewsTitlte = importantNews.getNewsTitle().substring(0, 10) + "...";
		%>		<%if(importantNews.getNewsImgPath() != null){ %>
	 			<a href="/news/addHit.jsp?newsNo=<%=importantNews.getNewsNo()%>" ><img alt="" src="<%=importantNews.getNewsImgPath()%>" class="img-thumbnail" width="50px" height="50px"></a>
	 			<%}%>
 			</div>
			<h4 class="text-left"><a href="/news/addHit.jsp?newsNo=<%=importantNews.getNewsNo()%>"><%=subNewsTitlte %></a></h4>
		<%
 						} else {
 							String subNewsTitlte = importantNews.getNewsTitle();
		%>
			<h4 class="text-left"><a href="/news/addHit.jsp?newsNo=<%=importantNews.getNewsNo()%>"><%=subNewsTitlte %></a></h4>
		<%		
						}	
 	
			}
		%>
			</div>
		</div>
		
		<div class="row">
			<%
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				
				AdDao adDao = new AdDao();
				List<AdVo> adList = adDao.getAdByDate();
				int adCount = adList.size();
				
				Random random = new Random();
				int firstAd = random.nextInt(adCount);
				int secondAd = random.nextInt(adCount);
				if(firstAd == secondAd){
					while(firstAd == secondAd){
						secondAd = random.nextInt(adCount);
						
					}
				}
				AdVo ad1 = adList.get(firstAd);
				AdVo ad2 = adList.get(secondAd);
				
			%>

				<div class="row" id="ad">
					<a href="<%=ad1.getAdLink()%>"><img src="/img/<%=ad1.getAdImgPath() %>" class="img-thumbnail" id="ad-img"></a>
				</div>
				<div class="row" id="ad">
					<a href="<%=ad2.getAdLink()%>"><img src="/img/<%=ad2.getAdImgPath() %>" class="img-thumbnail" id="ad-img"></a>
				</div>
			</div>
 		</div>
	</div>
<%@include file="/commons/clientFooter.jsp" %>
</body>
</html>