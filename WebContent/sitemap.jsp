<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Site Map</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="dist/jquery.mark.min.js"></script>
</head>
<body>
<%@include file="/commons/clientNavi.jsp" %>
<div class="container">
	<div class=" row col-xs-4 jumbotron">
		<div class="inner well">
		<p>News</p>
		<ul>
			<li><a href="/">메인</a></li>
			<li><a href="/news/events.jsp">시사</a></li>
			<li><a href="/news/economy.jsp">경제</a></li>
			<li><a href="/news/sports.jsp">스포츠</a></li>
			<li><a href="/news/entertainment.jsp">연예</a></li>
		</ul>
		</div>
	</div>
	<div class="row col-xs-4 jumbotron">
		<div class="inner well">
		<p>시민 참여</p>
		<ul>
			<li><a href="/citizenrep/list.jsp">제보</a></li>
		</ul>
		</div>
	</div>
	<div class=" row col-xs-4 jumbotron">
		<div class="inner well">
		<p>회원 관리</p>
		<ul>
			<%if(userLogin != null){%>
				<li><a href="/profile/profileFix.jsp">개인정보수정</a></li>
				<li><a href="/profile/logout.jsp?returnURL=/index.jsp">로그아웃</a></li>
			<%} else {%>
				<li><a href="/profile/addUser.jsp">회원가입</a></li>
				<li><a href="/profile/userLogin.jsp?returnURL=/index.jsp">로그인</a></li>
			<%} %>
		</ul>
		</div>
	</div>
</div>
<%@include file="/commons/clientFooter.jsp" %>
</body>
<script type="text/javascript">
	var elements = document.getElementsByClassName('inner');

	var elementHeights = Array.prototype.map.call(elements, function(el)  {
  		return el.clientHeight;
	});

	var maxHeight = Math.max.apply(null, elementHeights);

	Array.prototype.forEach.call(elements, function(el) {
  		el.style.height = maxHeight + "px";
	});
</script>
</html>