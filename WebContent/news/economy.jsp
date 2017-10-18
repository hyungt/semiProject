<%@page import="java.util.Random"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.jtimes.ad.vo.AdVo"%>
<%@page import="kr.co.jtimes.ad.dao.AdDao"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="kr.co.jtimes.common.criteria.NewsCriteria"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
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
	a { color: black; }
	.container {
		width: 1024px;
		margin: 0 auto;
	}
	
	#ad { margin-top : 50px; }
	
	#ad-img {
		width: 300px; 
		height: 300px;
	}
</style>
</head>
<body>
<%
	pageContext.setAttribute("cp", "eco");
	pageContext.setAttribute("url",  request.getRequestURI() + "?" + request.getQueryString());
%>

<%@include file="/commons/clientNavi.jsp" %>

<div class="container">
		<%
			TbNewsDao tbNewsDao = new TbNewsDao();
			
			NewsCriteria criteria = new NewsCriteria();
			criteria.setBeginIndex(1);
			criteria.setEndIndex(5);
			criteria.setCategoryNo(20);
			
			List<TbNewsVo> newsList = tbNewsDao.getNewsByCategoryAndSign(criteria);
			
			TbNewsVo TbNews = new TbNewsVo();
		%>
		
	<div class="col-xs-9 panel panel-body">
		<%
			for (TbNewsVo newses : newsList) {
					String parse = newses.getNewsContents();
					Document doc = Jsoup.parse(parse);
					String result = doc.text();
					if(result.length() > 200) {
						result = result.substring(0, 200);
						result += "...";
					}
			%>	
			<%
				String titleCut;
				if(newses.getNewsTitle().length() >= 25) {
					titleCut = newses.getNewsTitle().substring(0,25) + " ...";

				} else {
					titleCut = newses.getNewsTitle();
				}
			%>
				<%if (newses.getNewsImgPath() == null) {%>
				<div class="row">
					<div class="col-xs-12">
						<div>
							<h3><a href="/news/addHit.jsp?newsNo=<%=newses.getNewsNo()%>"> <%=titleCut%></a></h3>
							<p style="color:gray"><%=result %></p>
						</div>
					</div>
				</div>
				<%} else { %>
				<div class="row">
					<div class="col-xs-3">
						<a href="/news/addHit.jsp?newsNo=<%=newses.getNewsNo()%>"><img src="<%=newses.getNewsImgPath() %>" class="img-thumbnail"></a>
					</div>
					<div class="col-xs-9">
						<div>
							<h3><a href="/news/addHit.jsp?newsNo=<%=newses.getNewsNo()%>"><%=titleCut%></a></h3>
							<p style="color:gray"><%=result %></p>
						</div>
					</div>
				</div>
				<%
				}
			
			}
		%>
	</div>

	<div class="col-xs-3 panel panel-body">
		<div class="col-xs-offset-1 col-xs-11">
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
</div>
<%@include file="/commons/clientFooter.jsp" %>
</body>
</html>