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
<% pageContext.setAttribute("cp", "ad"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"  %>
<div class="container">
   <form id="frm" method="post" action="/reporter/AD/adupload.html" enctype="multipart/form-data">
        <div class="row well">
           <h1>광고 등록</h1>
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
                  <div id="alert-box"></div>
                     <%
                      final String SUCCESS_CODE = "1";
                      final String FAIL_CODE = "1";
                      
                      String successCode = request.getParameter("success");
                      String failCode = request.getParameter("fail");
                      %>
                      
                      <%if(SUCCESS_CODE.equals(successCode)) {%>
                         <div class="alert alert-info">
                            <strong>성공</strong> 광고정보가 성공적으로 등록되었습니다.
                         </div>
                      <%}%>
                      <%if(FAIL_CODE.equals(failCode)) {%>
                         <div class="alert alert-danger">
                            <strong>실패</strong> 계약기간을 확인하세요.
                         </div>
                      <%}%>
                    <label for="submit-title" style="display: inline;">광고제목</label>
                    <input type="text" class="form-control" id="submit-title" name="imgname">
               </div>
               
                <div class="form-group">
                    <label for="submit-news" style="display: inline;">광고시작날짜</label>
                    <input type="date" class="form-control" id="submit-startDate" name="submit-startDate">
                </div>
                
                <div class="form-group">
                    <label for="submit-category" style="display: inline;">광고만료날짜</label>
                    <input type="date" class="form-control" id="submit-endDate" name="submit-endDate">
                </div>
                
                <div class="form-group">
                    <label for="submit-nation" style="display: inline;">광고연결페이지</label>
                    <input type="text" class="form-control" id="submit-link" name="submit-link">
                </div>
            </div>
        
            <div class="row">
                <div class="col-xs-9">

                </div>

                <div class="col-xs-3">
                    <button class="btn btn-primary">등록</button>       
                    <a class="btn btn-info" href="/reporter/AD/adView.jsp">광고 리스트</a>            
                </div>        
            </div>
        </div>
    </form>
<%@include file="/reporter/commons/reporterFooter.jsp" %>
</div>
</body>
<script type="text/javascript">
   document.getElementById("frm").addEventListener('submit', function(event){
      event.preventDefault();
      var imginput = document.getElementById("imgpreview").value;
      var title = document.getElementById("submit-title").value;
      var startdate = document.getElementById("submit-startDate").value;
      var enddate = document.getElementById("submit-endDate").value;
      var link = document.getElementById("submit-link").value;
      
      if(imginput == "" || title == "" || startdate == "" || enddate == "" || link == ""){
         var html ='<div class="alert alert-danger">';
          html += '<strong>오류</strong>';
          html += '<p class="text-right">비어있는 칸이 있습니다.</p>';
          html += '</div>';
          document.getElementById("alert-box").innerHTML = html;
      } else{
         document.getElementById("frm").submit();
      }
   });
</script>
</html>