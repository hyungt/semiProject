<%@page import="kr.co.jtimes.common.vo.NewsTypeVo"%>
<%@page import="kr.co.jtimes.common.vo.NewsCategoryVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.common.dao.CommonsDao"%>
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
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "img"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<%
	CommonsDao commonsDao = new CommonsDao();
	
	List<NewsCategoryVo> categoryList = commonsDao.getAllCategory();
	List<NewsTypeVo> typeList = commonsDao.getAllNewsType();
	
%>
<div class="container">
   <form method="post" action="/reporter/upload.html" enctype="multipart/form-data">
        <div class="row well">
            <div class="col-xs-4">
                <div class="img-modified">
                    <img id="imgpreview" src="#" alt="">    
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
                    <input type="text" class="form-control" id="submit-title" name="imgname" placeholder="제목">
               </div>
               
                <div class="form-group">
                    <label for="submit-news" style="display: none;"></label>
                    <select name="newstype" id="submit-news" class="form-control">
                        <%for(NewsTypeVo type : typeList){
					%>
						<option value="<%=type.getNewsTypeNo() %>"><%=type.getNewsTypeName()%></option>
					<%} %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-category" style="display: none;"></label>
                    <select name="newscat" id="submit-category" class="form-control">
                        <%for(NewsCategoryVo category : categoryList){
					%>
						<option value="<%=category.getCategoryNo() %>"><%=category.getCategoryName()%></option>
					<%} %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-nation" style="display: none;"></label>
                    <select name="loc" id="submit-nation" class="form-control">
                        <option value="국내">국내</option>
                        <option value="해외">해외</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="submit-contents" style="display: none;"></label>
                    <textarea name="contents" id="submit-contents" cols="10" rows="5" class="form-control" placeholder="내용"></textarea>
                </div>
            </div>
        
            <div class="row">
                <div class="col-xs-11">

                </div>

                <div class="col-xs-1">
                    <button class="btn btn-primary">등록</button>            
                </div>        
            </div>
        </div>
    </form>
<%@include file="/reporter/commons/reporterFooter.jsp" %>
</div>

</body>
</html>