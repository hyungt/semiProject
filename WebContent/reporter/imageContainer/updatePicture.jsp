<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
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
        $(function() {
            $("#submit-upload").on('change', function(){
                readURL(this);
            });
        });
        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#imgpreview').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }


    </script>
</head>
<body>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<div class="container">
   <form method="post" action="javascript:submit(this)" name="submitform" enctype="multipart/form-data">
   <%
   		
		String path = request.getParameter("path");
		String title = request.getParameter("title");
		String regDate = request.getParameter("regDate");
		String reporterNo = request.getParameter("reporterNo");
		String category = request.getParameter("category");
		String explanation = request.getParameter("explanation");
		String location = request.getParameter("location");
		String type = request.getParameter("type");
	%>
        <div class="row well">
            <div class="col-xs-4">
                <div class="img-modified">
                    <img id="imgpreview" src="/imgdata/<%=path %>" alt="<%=title %>">    
                </div>
                
                <div class="img-file" style="margin-top: 95px ">
                    <label for="submit-upload" style="display: none;"></label>
                    <input type="file" class="form-control" id="submit-upload" name="file-upload">
                </div>
            </div>
            <div class="col-xs-2">

            </div>
            <div class="col-xs-6">
               <div class="form-group">
                    <label for="submit-title" style="display: none;"></label>
                    <input type="text" class="form-control" id="submit-title" name="imgname" value="<%=title %>">
               </div>
               
                <div class="form-group">
                    <label for="submit-news" style="display: none;"></label>
                    <select name="newstype" id="submit-news" class="form-control">
	                    <%
	                    	if("100".equals(type)) {
	                    %>
	                        <option value="100" selected="selected">일반</option>
	                    <% 
	                    	}else {
	                    %>
	                    	<option value="100">일반</option>
	                    <% 
	                    	}
	                    %>
                        
                        <%
	                    	if("200".equals(type)) {
	                    %>
	                        <option value="200" selected="selected">특보</option>
	                    <% 
	                    	}else {
	                    %>
	                    	<option value="200">특보</option>
	                    <% 
	                    	}
	                    %>
                        
                        <%
	                    	if("300".equals(type)) {
	                    %>
	                        <option value="300" selected="selected">속보</option>
	                    <% 
	                    	}else {
	                    %>
	                    	<option value="300">속보</option>
	                    <% 
	                    	}
	                    %>
                        
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-category" style="display: none;"></label>
                    <select name="newscat" id="submit-category" class="form-control">
                    <%
                    	if("시사".equals(category)) {
                    %>
                        <option value="10" selected="selected">시사</option>
                    <% 
                    	}else {
                    %>
                    	<option value="10">시사</option>
                    <% 
                    	}
                    %>
                    
                    <%
                    	if("경제".equals(category)) {
                    %>
                        <option value="20" selected="selected">경제</option>
                    <% 
                    	}else {
                    %>
                    	<option value="20">경제</option>
                    <% 
                    	}
                    %>
                    
                    <%
                    	if("연예".equals(category)) {
                    %>
                        <option value="30" selected="selected">연예</option>
                    <% 
                    	}else {
                    %>
                    	<option value="30">연예</option>
                    <% 
                    	}
                    %>
                    
                    <%
                    	if("스포츠".equals(category)) {
                    %>
                        <option value="40" selected="selected">스포츠</option>
                    <% 
                    	}else {
                    %>
                    	<option value="40">스포츠</option>
                    <% 
                    	}
                    %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-nation" style="display: none;"></label>
                    <select name="loc" id="submit-nation" class="form-control">
                    	<%
                    		if("국내".equals(location)) {
	                    %>
	                        <option value="국내" selected="selected">국내</option>
	                    <% 
	                    	}else {
	                    %>
	                    	<option value="국내">국내</option>
	                    <% 
	                    	}
	                    %>
	                    
	                    <%
                    		if("해외".equals(location)) {
	                    %>
	                        <option value="해외" selected="selected">해외</option>
	                    <% 
	                    	}else {
	                    %>
	                    	<option value="해외">해외</option>
	                    <% 
	                    	}
	                    %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-contents" style="display: none;"></label>
                    <textarea name="contents" id="submit-contents" cols="10" rows="5" class="form-control"><%=explanation %></textarea>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-11 text-center" style="padding-left: 220px;">
					<a href="javascript:history.back()" class="btn btn-primary btn-sm">상세화면</a>
                </div>

                <div class="col-xs-1 text-right">
                    <button class="btn btn-success btn-sm">수정</button>          
                </div>        
            </div>
        </div>
    </form>
</div>
<%@include file="/reporter/commons/reporterFooter.jsp" %>
</body>
<script type="text/javascript">
	function submit(el) {
		var imgFileValue = document.getElementById("submit-upload").value;
		var imgTitleValue = document.getElementById("submit-title").value;
		var imgNewsTypeValue = document.getElementById("submit-news").value;
		var imgCategoryValue = document.getElementById("submit-category").value;
		var imgNationValue = document.getElementById("submit-nation").value;
		
		if(imgFileValue == "") {
			alert("파일을 업로드하지 않았습니다. 파일을 업로드 해주세요.");
			return;
		} else if(imgTitleValue == "") {
			alert("제목을 입력하지 않았습니다. 제목을 입력해 주세요.");
			return;
		} else if(imgNewsTypeValue == "") {
			alert("뉴스타입을 입력해주세요.");
			return;
		} else if(imgCategoryValue == "") {
			alert("카테고리를 입력해 주세요");
			return;
		} else if(imgNationValue == "") {
			alert("네이션을 입력해주세요.");
			return;
		} else {		
			document.submitform.action = "/reporter/modified.html";
			document.submitform.submit();
		}
	}
</script>
</html>