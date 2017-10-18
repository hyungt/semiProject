<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.jtimes.ad.vo.AdVo"%>
<%@page import="kr.co.jtimes.ad.dao.AdDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
  <title>광고등록페이지</title>
  <style>
      
      .container{
          width: 1024px;
          margin: 0 auto;
      }
      
      
      .img-modified{
		border: 1px solid black;
		width: 450px;
		height: 300px;
      }
      
      #imgpreview{
      	width: 450px;
		height: 300px;
      }
  </style>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  function readURL(input) {
      if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
              var imgpath = ('#imgpreview').attr('src');
          }

        reader.readAsDataURL(input.files[0]);
      }
  }
  
  </script>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "ad"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<div class="container">
   <form id="frm" method="post" action="/reporter/AD/adupload.html" enctype="multipart/form-data">
        <div class="row well">
        	<%
        		AdDao adDao = new AdDao();
        		int no = Integer.parseInt(request.getParameter("no"));
        		AdVo adVo = adDao.getAdByNo(no);
        		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
        	%>
        	<h1>광고 등록</h1>
            <div class="col-xs-4">
                <div class="img-modified">
                    <img id="imgpreview" src="/img/<%=adVo.getAdImgPath()%>" >    
                </div>
            </div>
            <div class="col-xs-2">

            </div>
            <div class="col-xs-6">
               <div class="form-group">
		            <div id="alert-box"></div>
		            	
                    <label for="submit-title" style="display: inline;">광고제목</label>
                    <a type="text" class="form-control" id="submit-title"><%= adVo.getAdTitle() %></a>
               </div>
               
                <div class="form-group">
                    <label for="submit-news" style="display: inline;">광고시작날짜</label>
                    <a type="text" class="form-control" id="submit-startDate" ><%= simpleDateFormat.format(adVo.getAdStartDate()) %></a>
                </div>
                
                <div class="form-group">
                    <label for="submit-category" style="display: inline;">광고만료날짜</label>
                    <a type="text" class="form-control" id="submit-endDate"><%= simpleDateFormat.format(adVo.getAdEndDate()) %></a>
                </div>
                
                <div class="form-group">
                    <label for="submit-nation" style="display: inline;">광고연결페이지</label>
                    <a type="text" class="form-control" id="submit-link"><%= adVo.getAdLink() %></a>
                </div>
            </div>
        
            <div class="row">
                <div class="col-xs-11">

                </div>

                <div class="col-xs-1">
                    <a class="btn btn-primary" href="/reporter/AD/adView.jsp">목록으로</a>            
                </div>        
            </div>
        </div>
    </form>
<%@include file="/reporter/commons/reporterFooter.jsp" %>
</div>
</body>
<script type="text/javascript">

</script>
</html>