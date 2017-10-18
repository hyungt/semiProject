<%@page import="kr.co.jtimes.common.criteria.CommentCriteria"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.jtimes.news.comment.vo.CommentLikeVo"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentLikeDao"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jtimes.news.vo.TbSuggestVo"%>
<%@page import="kr.co.jtimes.news.dao.TbSuggestDao"%>
<%@page import="kr.co.jtimes.news.comment.vo.NewCommentVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.news.comment.Dao.CommentDao"%>
<%@page import="kr.co.jtimes.news.vo.TbNewsVo"%>
<%@page import="kr.co.jtimes.news.dao.TbNewsDao"%>
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
  <style>
  	#write-date, #reporter-name, #one-line {color: darkgray;}
  	.container {
		width: 1024px;
		margin: 0 auto;
	}
  </style>
  <script type="text/javascript">
  
	// 댓글 좋아요 기능
	
	function commentLike(commentNo, commentUploaderNo, loginUserNo) {
		if(commentUploaderNo == loginUserNo) {
			alert('본인이 쓴 글입니다');
			return;
		}
		if(!loginUserNo) {
			alert('로그인이 필요한 서비스 입니다.');
			return;
		}
		
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var likes = xhr.responseText
				if(likes == "samesame") {
					alert("이미 추천하셨습니다.");
					return;
				}
				document.getElementById("comment-no-"+commentNo).innerHTML = likes;
			} 
		}
		
		xhr.open("GET", "/news/commentLike.jsp?commentNo="+commentNo+"&pref=Y");
		xhr.send(null);
	};
	
	// 댓글 싫어요 기능
	
	function commentDislike(commentNo, commentUploaderNo, loginUserNo) {
		if(commentUploaderNo === loginUserNo) {
			alert('본인이 쓴 글입니다.');
			return;
		}
		if(!loginUserNo) {
			alert('로그인이 필요한 서비스 입니다.');
			return;
		}
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var disLikes = xhr.responseText
				if(disLikes == "samesame") {
					alert("이미 비추천하셨습니다.");
					return;
				}
				document.getElementById("dis-comment-no-"+commentNo).innerHTML = disLikes;
			}
		}
		
		xhr.open("GET", "/news/commentLike.jsp?commentNo="+commentNo+"&pref=N");
		xhr.send(null);
	};
  </script>
</head>
<body>
<%
	int no = Integer.parseInt(request.getParameter("newsNo"));
	pageContext.setAttribute("url",  request.getRequestURI() + "?" + request.getQueryString());
%>

<%@include file="/commons/clientNavi.jsp" %>

<%

	UserVo loginUser = (UserVo) session.getAttribute("userLogin");
	
	TbNewsDao tbNewsDao = new TbNewsDao();
	TbNewsVo tbNewsVo = tbNewsDao.getNews(no);
	
	PrintWriter pw = response.getWriter();
	
	CommentDao commentDao = new CommentDao();
	CommentCriteria criteria = new CommentCriteria();
	criteria.setNewsNo(no);
	criteria.setBeginIndex(1);
	criteria.setEndIndex(4);
	List<NewCommentVo> commentList = commentDao.getCommentByNewsNo(criteria);
	
	UserVo user = new UserVo();
	user.setNo(no);
	
	TbSuggestDao suggestDao = new TbSuggestDao();
	TbSuggestVo suggest = new TbSuggestVo();
	
	CommentLikeDao commentLikeDao = new CommentLikeDao();
	
%>
<div class="container">
	<div class=" col-xs-offset-1 col-xs-10">
		<div class="row text-center">
			<div class="panel panel-body">
				<h1><strong><%=tbNewsVo.getNewsTitle() %></strong></h1>
				<div class="text-right">
					<span id="write-date"><small><%=tbNewsVo.getRegdateFormatYYMMDDHHMMSS() %></small></span>
				</div>
			</div>
		</div>
		<div class="row text-right">
			<span><small>조회수:<%=tbNewsVo.getNewsViewCnt() %></small></span>
		</div>
		<div class="row text-right" id="count">	
			<span><small>추천수:<%=suggestDao.getSuggests(no) %></small></span>
		</div>
		<div class="row">
			<div class="panel panel-body">
				<div class="row">
					<p><%=tbNewsVo.getNewsContents() %></p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="form-group text-center">
			<%
				if (loginUser != null) {
			%>
				<a href="javascript:likeup(<%=no %>)" class="btn btn-default" id="add-like">추천</a>
			<%
				}
			%>
			</div>
		</div>
		<div class="row well">
			<form class="form-group" id="frm">
				<input type="hidden" name="newsNo" value="<%=tbNewsVo.getNewsNo()%>">
				<%if(loginUser != null) {%>
				<div class="form-group">
					<textarea rows="3" cols="100" class="form-control" name="contents" id="contents"></textarea>
				</div>
					<div class="form-group text-right">
						<button class="btn btn-sm btn-primary" id="comment-register">등록</button>
					</div>
				<%}%>
		
				<ul class="list-group" id="comment">
				<%
						for (NewCommentVo comments : commentList) {
							boolean isClick = true;
							if (loginUser == null) {
								isClick = false;
							}
							if (loginUser != null && loginUser.getId().equals(comments.getUserVo().getId())) {
								isClick = false;
							}
				%>
					<li class="list-group-item">
						<div>
							<p>
								<span id="comment-id"><%=comments.getUserVo().getId() %></span>
								<span class="pull-right" id="comment-date"> <%=comments.getRegdateFormatYYMMDDHHMMSS() %></span>
							</p>
							<p class="list-group-item-text"><%=comments.getCommentContents() %></p>
						</div>
					
					
						<div class="text-right" id="comment-like">
							
							<p>
						<%if (isClick) { %>
								<a  href="javascript:commentLike(<%=comments.getCommentNo()%>, <%=comments.getUserVo().getNo() %>, <%=loginUser.getNo() %>)" class="btn btn-sm">
								<span class="glyphicon glyphicon-thumbs-up"></span>
								</a>
								<span id="comment-no-<%=comments.getCommentNo()%>" class="badge"><%=commentLikeDao.getCommentLikeByCommentNo(comments.getCommentNo(), "Y") %></span>
								
								<a  href="javascript:commentDislike(<%=comments.getCommentNo()%>, <%=comments.getUserVo().getNo() %>, <%=loginUser.getNo() %>)" class="btn btn-sm" style="color: red;">
								<span class="glyphicon glyphicon-thumbs-down"></span>
								</a> 
								<span id="dis-comment-no-<%=comments.getCommentNo()%>" class="badge"><%=commentLikeDao.getCommentLikeByCommentNo(comments.getCommentNo(), "N") %></span>
						<%
						} else {
						%>
								<span class="glyphicon glyphicon-thumbs-up" style="color: cornflowerblue;"></span>
								<span id="comment-no-<%=comments.getCommentNo()%>" class="badge"><%=commentLikeDao.getCommentLikeByCommentNo(comments.getCommentNo(), "Y") %></span>
								<span class="glyphicon glyphicon-thumbs-down" style="color: red;"></span>
								<span id="dis-comment-no-<%=comments.getCommentNo()%>" class="badge"><%=commentLikeDao.getCommentLikeByCommentNo(comments.getCommentNo(), "N") %></span>
								
						<%}%>
							</p>
						</div>
					</li>
					
		<%
						}
		%>
					<li id="btn-expand" class="list-group-item"><label class="btn btn-primary btn-block" id="expand" onclick="expand()">더 보기</label></li>
				</ul>
			</form>
		</div>
	</div>
</div>
<%@include file="/commons/clientFooter.jsp" %>
</body>
<script type="text/javascript">
	var begineIndex = 1;
	var endIndex = 4;
	// 댓글 추가 및 디스플레이 기능
	document.getElementById("frm").addEventListener("submit", function(event) {
		
		event.preventDefault();
		
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState ==4 && xhr.status == 200) {
				var commentList = JSON.parse(xhr.responseText);
				
				var htmlContent = "";
				console.log(commentList);
				commentList.forEach(function(comment, index){					
					
					htmlContent += '<li class="list-group-item">';
					htmlContent += '<div id="comment">';
					htmlContent += '	<p>';
					htmlContent += '		<span">'+comment.userVo.id+'</span>';
					htmlContent += '		<span class="pull-right">'+comment.commentRegDate+'</span>';
					htmlContent += '	</p>';
					htmlContent += '	<p class="list-group-item-text">'+comment.commentContents+'</p>';
					htmlContent += '</div>';
					htmlContent += '<div class="text-right" id="comment-like">';
					htmlContent += '	<p>';
					htmlContent += '		<a class="glyphicon glyphicon-thumbs-up" onclick="javascript:commentLike('+comment.commentNo+','+comment.userVo.no+'<%=(loginUser != null)?(","+loginUser.getNo()):"" %>)" class="btn btn-sm"></a> ';
					htmlContent += '		<span id="comment-no-'+comment.commentNo+'" class="badge">'+comment.likeCnt+'</span>';
					htmlContent += '		<a class="glyphicon glyphicon-thumbs-down" onclick="javascript:commentDislike('+comment.commentNo+','+comment.userVo.no+'<%=(loginUser != null)?(","+loginUser.getNo()):"" %>)" class="btn btn-sm" style="color: red;"></a> ';
					htmlContent += '		<span id="dis-comment-no-'+comment.commentNo+'" class="badge">'+comment.disLikeCnt+'</span>';
					htmlContent += '	</p>';
					htmlContent += '</div>';
					htmlContent += '</li>';
					
				});
				document.getElementById("comment").innerHTML = htmlContent;
				document.getElementById("contents").value = "";
				document.getElementById("comment").innerHTML += '<li id="btn-expand" class="list-group-item"><label class="btn btn-primary btn-block" id="expand" onclick="expand()">더 보기</label></li>';
				begineIndex = 1;
				endIndex = 4;
			}
		}
		xhr.open("POST", "/news/addComment.jsp");
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("contents="+document.getElementById("contents").value+"&no=" + <%=no %>);
		
	});
	
	// 추천수 띄우는 기능

	function likeup(pageNo) {
		
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var likes = xhr.responseText
				
				var htmlContent = "";
				
				htmlContent +='<span><small>추천수:'+likes+'</small></span>'
				
				document.getElementById("count").innerHTML = htmlContent;
				document.getElementById("add-like").setAttribute("class", "btn btn-danger");
				document.getElementById("add-like").innerText = "이미 추천하셨습니다.";
				document.getElementById("add-like").setAttribute("disabled", "disabled");
			}
		}
		
		xhr.open("GET", "/news/newsLike.jsp?newsNo="+pageNo);
		xhr.send(null);
	};
	
	
	function expand() {
		var expandId = document.getElementById("expand").id;
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function () {
			if (xhr.readyState == 4 && xhr.status == 200) {
					var commentResult = JSON.parse(xhr.responseText);
					var comments = commentResult.commentList;
					console.log(commentResult);
					var htmlContent = "";
					
					comments.forEach(function(comment, index) {
						htmlContent += '<li class="list-group-item">';
						htmlContent += '<div id="comment">';
						htmlContent += '	<p>';
						htmlContent += '		<span">'+comment.userVo.id+'</span>';
						htmlContent += '		<span class="pull-right">'+comment.commentRegDate+'</span>';
						htmlContent += '	</p>';
						htmlContent += '	<p class="list-group-item-text">'+comment.commentContents+'</p>';
						htmlContent += '</div>';
						htmlContent += '<div class="text-right" id="comment-like">';
						htmlContent += '	<p>';
						htmlContent += '		<a class="glyphicon glyphicon-thumbs-up" onclick="javascript:commentLike('+comment.commentNo+','+comment.userVo.no+'<%=(loginUser != null)?(","+loginUser.getNo()):"" %>)" class="btn btn-sm"></a> ';
						htmlContent += '		<span id="comment-no-'+comment.commentNo+'" class="badge">'+comment.likeCnt+'</span>';
						htmlContent += '		<a class="glyphicon glyphicon-thumbs-down" onclick="javascript:commentDislike('+comment.commentNo+','+comment.userVo.no+'<%=(loginUser != null)?(","+loginUser.getNo()):"" %>)" class="btn btn-sm" style="color: red;"></a> ';
						htmlContent += '		<span id="dis-comment-no-'+comment.commentNo+'" class="badge">'+comment.disLikeCnt+'</span>';
						htmlContent += '	</p>';
						htmlContent += '</div>';
						htmlContent += '</li>';
					});
					var btnex = document.getElementById("btn-expand");
					document.getElementById("comment").removeChild(btnex);
					document.getElementById("comment").innerHTML += htmlContent;
					if(commentResult.continueExpand != false){
						document.getElementById("comment").innerHTML += '<li id="btn-expand" class="list-group-item" ><label class="btn btn-primary btn-block" id="expand" onclick="expand()">더 보기</label></li>';
					}
				}
		}
		xhr.open("GET", "/article.do?begin="+(begineIndex+=4)+"&end="+(endIndex+=4)+"&newsNo=" + <%=no %>);
		xhr.send(null);
	}
	
	
</script>


</html>