<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        .profile {
            border-bottom: 3px solid black;
        }
        .margintop {margin-top: 150px;}
        .container {margin: 0 auto; width:1024px;}
        .newscon {
            margin-top: 50px;
            border: 2px solid silver;
            border-radius: 5px;
            padding-bottom: 20px;
            padding-top: 20px;
        }
        a {cursor: pointer;}
        .legend-con {width:auto; margin-left:150px; border: none;}
        .display-inline{display: inline;}
        .btn-confirm {margin-left:50px; margin-top: 20px;}
        .btn-category {margin-left:50px; margin-top: 20px;}
        a.newstitle {margin-left: 50px; text-decoration: none; width:500px; overflow: hidden;}
    </style>
    <title>메인 페이지</title>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "p"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"%>
<%	
	ReporterEmployeeVo re = (ReporterEmployeeVo)session.getAttribute("loginReporter");
%>
    <div class="container">
        <div class="profile row">
            <div class="col-xs-offset-5 col-xs-4 text-right">
                <h4 class="display-inline"><span class="label label-default"><%=re.getReporterPos().getPositionName() %></span></h4>
                <h4 class="display-inline"><span class="label label-default"><%=re.getReporterName() %>(<%=re.getReporterId() %>)님 환영합니다.</span></h4>
            </div>
            <div class="col-xs-3 text-right">
                <a href="/reporter/profile/updateProfile.jsp" class="btn btn-primary btn-xs">프로필 수정</a>
                <a href="/reporter/news/addNews.jsp" class="btn btn-warning btn-xs">기사 작성</a>
            </div>
        </div>

        <fieldset class="newscon">
            <legend class="display-inline legend-con">[ 시사 ]</legend>
            <div id="news-box-10"></div>
            <div class="text-center">
                <ul class="pagination pagination-sm" id="news-page-10"></ul>
            </div>
        </fieldset>
        <fieldset class="newscon">
            <legend class="display-inline legend-con">[ 경제 ]</legend>
            <div id="news-box-20"></div>
            <div class="text-center">
                <ul class="pagination pagination-sm" id="news-page-20"></ul>
            </div>
        </fieldset>
        
        <fieldset class="newscon">
            <legend class="display-inline legend-con">[ 스포츠 ]</legend>
            <div id="news-box-30"></div>
            <div class="text-center">
                <ul class="pagination pagination-sm" id="news-page-30"></ul>
            </div>
        </fieldset>
        <fieldset class="newscon">
            <legend class="display-inline legend-con">[ 연예 ]</legend>
            <div id="news-box-40"></div>
            <div class="text-center">
                <ul class="pagination pagination-sm" id="news-page-40"></ul>
            </div>
        </fieldset>
    </div>
   <%@ include file="/reporter/commons/reporterFooter.jsp"  %>
</body>
<script type="text/javascript">
	function requestNews(newsCategory, pageNo){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var jsonText = xhr.responseText;
				var news = JSON.parse(jsonText);
				var beginPage = news.beginPage;
				var endPage = news.endPage;
				var currentNaviBlock = news.currentNaviBlock;
				var totalNaviBlock = news.totalNaviBlock;
				var newsList = news.newsList;
				var newsCategory = news.newsCategory;
				var totalPages = news.totalPages;
				
				var htmlContents = "";
				newsList.forEach(function (newsItem, index) {
					var stateStr;
					var className;
					if(newsItem.newsSignState == "N") {
						stateStr = "승인대기";
						className = "label-warning";
					} else {
						stateStr = "승인완료";
						className = "label-success";
					}
					var newsTypeClass;
					if(newsItem.newsType.newsTypeNo == 100) {
						newsTypeClass = "label-default";
					} else if(newsItem.newsType.newsTypeNo == 200){
						newsTypeClass = "label-info";
					} else {
						newsTypeClass = "label-danger";
					}
					
					htmlContents += '<h4 class="display-inline col-xs-1"><span class="label '+className+' btn-confirm">'+stateStr+'</span></h4>';
					htmlContents += '<h4 class="display-inline col-xs-1"><span class="label '+newsTypeClass+' btn-category">'+newsItem.newsType.newsTypeName+'</span></h4>';
					htmlContents += '<a href="/reporter/news/detailNews.jsp?type=view&newsNo='+newsItem.newsNo+'" class="newstitle btn col-xs-7">'+newsItem.newsTitle+'</a>';
					htmlContents += '<h4 class="display-inline col-xs-2"><span class="label label-primary ">'+newsItem.regdate+'</span></h4>';
					htmlContents += '<h4 class="display-inline col-xs-1"><span class="label label-primary ">'+newsItem.reporter.reporterName+'</span></h4>';
				});
				document.getElementById("news-box-"+newsCategory).innerHTML = htmlContents;
				
				var pageHTML = "";
                if(pageNo != 1) {
                	pageHTML +='<li><a onclick="javascript:requestNews('+newsCategory+','+(pageNo-1)+')">&lt;</a></li>';
                }
				for(var i = beginPage; i <= endPage; ++i) {
					pageHTML += '<li class="'+((i == pageNo)?'active':'')+'"><a onclick="javascript:requestNews('+newsCategory+','+ i +')">' + i + '</a></li>'
				}
				if(!(pageNo >= totalPages)){
					pageHTML += '<li><a onclick="javascript:requestNews('+newsCategory+','+(pageNo+1)+')">&gt;</a></li>';
				}
				document.getElementById("news-page-"+newsCategory).innerHTML = pageHTML;
			}
		};
		xhr.open("GET", "/reporter/news/getNewsProcess.jsp?category="+newsCategory+"&pno="+pageNo);
		xhr.send(null);
	}
	requestNews(10, 1);
	requestNews(20, 1);
	requestNews(30, 1);
	requestNews(40, 1);
</script>
</html>