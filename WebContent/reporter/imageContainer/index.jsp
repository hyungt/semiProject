<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.jtimes.reporter.imagecontainer.common.dao.TbImageDao"%>
<%@page import="kr.co.jtimes.reporter.profile.common.vo.ReporterEmployeeVo"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.jtimes.reporter.imagecontainer.common.vo.TbImageVo"%>
<%@page import="java.util.List"%>
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
      
      
      
      .ck-all input{
          display: none;
      }
      
      .form-blank {
           padding-right: 32px;
      }
      
      .text-center{
          margin-top: 30px;
          margin-bottom: 50px;
      }
      
      .caption{
           text-align: center;
      }
     
      
  </style>
</head>
<body>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% pageContext.setAttribute("cp", "img"); %>
<%@ include file="/reporter/commons/reporterNavi.jsp"%>
<div class="container">
    <div class="row"> 
         <ul class="nav nav-tabs navcontents">
            <li class="active originalrevision"><a href="#" id="N">원본</a></li>
            <li><a href="#" id="Y">수정본</a></li>
            <li class="dropdown">
                <a id="category" class="dropdown-toggle" data-toggle="dropdown" href="#">카테고리
                <span class="caret"></span></a>
                <ul class="dropdown-menu">
                	<li><a href="#" id="categoryAll">전체</a></li>
                    <li><a href="#" id="10">시사</a></li>
                    <li><a href="#" id="20">경제</a></li>
                    <li><a href="#" id="40">연예</a></li>
                    <li><a href="#" id="30">스포츠</a></li> 
                </ul>
            </li>
        </ul>      
    </div>
</div>
<div class="container">
    <div class="row">
            <div class="row text-center well">
              <form class="form-inline" name="frm" action="index.do" enctype="application/x-www-form-urlencoded">
                 <div class="form-group form-blank">
                      <div class="form-group">
                          <select name="titleAuthorCategory" id="titleAuthorCategory" class="form-control">
                          	  <option value="optAll">전체</option>
                              <option value="optTitle">제목</option>
                              <option value="optWriter">작성자</option>
                          </select>
                       </div>

                       <div class="form-group">
                           <input type="text" class="form-control" id="searchWord" name="searchWord">
                       </div>

                 </div>
                    
                    <div class="form-group form-blank">
                         <input type="date" class="form-control" name="beginDate" id="beginDate"> ~ <input type="date" class="form-control" name="endDate" id="endDate">
                   </div>
               
                    <div class="form-group ck-all form-blank">
                       <label for="ck-png" class="btn btn-default">png</label>
                       <input type="checkbox" id="ck-png" name="png">
                       
                       <label for="ck-jpg" class="btn btn-default">jpg</label>
                       <input type="checkbox" id="ck-jpg" name="jpg">
                       
                       <label for="ck-bmp" class="btn btn-default">bmp</label>
                       <input type="checkbox" id="ck-bmp" name="bmp">
                       
                       <label for="ck-gif" class="btn btn-default">gif</label>
                       <input type="checkbox" id="ck-gif" name="gif">
                   </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" name="formBtn" id="searchBtn" onclick="search(event)">검색</button>
                    </div>

                   <div class="form-group">
                        <a href="addPicture.jsp"><label for="" class="btn btn-default">이미지등록</label></a>
                   </div>
               </form>
            </div>
       
       
        <div class="row ">
        	<div class="panel panel-default panel-body" id="img-box">
		        <%
		        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					TbImageDao tbImageDao = new TbImageDao();
		            List<TbImageVo> tbImageList = tbImageDao.getImageSelectAlterStateMain();            		
		        	for(TbImageVo voList : tbImageList) {
		        		String path = voList.getImgPath();
		        		String title = voList.getImgTitle();
		        		String regDate = sdf.format(voList.getImgRegdate());
		        		String reporterNo = voList.getReporter().getReporterName();
		        		String category = voList.getCategory().getCategoryName();
		        		String explanation = voList.getImgAlt();
		        		String location = voList.getImgLocation();
		        		String type = voList.getImgType();
		        %>
		        		<div class="col-xs-3">
		                    <div class="thumbnail" style="width: 250px; height: 300px;">
		                        <a href="pictureContainer.jsp?path=<%=path %>&title=<%=title %>&regDate=<%=regDate %>&reporterNo=<%=reporterNo %>&category=<%=category %>&explanation=<%=explanation %>&location=<%=location %>&type=<%=type %>">
		                            <img src="/imgdata/<%=path %>" width="50%" id="img-path"/>
		                            <div class="caption" >
		                                <h4 id="img-title"><%=title %></h4>
		                                <p id="img-regdate"><%=regDate %></p>
		                                <p id="img-reproterno"><%=reporterNo %></p>
		                            </div>
		                        </a>
		                    </div>
		                </div>
		        <% 
		        	}
		        %>   
            </div>
        </div>
        
        <div class="row" style="text-align: center">
            <div class="label label-primary" >
                <label id="expend" style="width: 500px; cursor: pointer;" class="glyphicon glyphicon-chevron-down">  펼치기</label>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">

    // 원본 수정본을 선택시 선택한 곳의 버튼 모양 변경
    var navContentsList = document.querySelectorAll(".nav-tabs > li:nth-child(1)>a, .nav-tabs > li:nth-child(2)>a");
    for(var index=0; index < navContentsList.length; index++) {
        var navContentsListItem = navContentsList.item(index);
        
        navContentsListItem.addEventListener("click", function(event) {
            var liNodeList = document.querySelectorAll(".nav-tabs > li:nth-child(1), .nav-tabs > li:nth-child(2)");
            for(var index2=0; index2 < liNodeList.length; index2++) {
                liNodeList.item(index2).setAttribute("class", "");
            }
            event.target.parentNode.setAttribute("class", "active originalrevision");
        });
    }
    
    // 체크박스형식으로 이미지 변경
    var navExtensionList = document.querySelectorAll(".ck-all > label:nth-child(n+1)");
    for(var navExtensionListIncrease=0; navExtensionListIncrease < navExtensionList.length; navExtensionListIncrease++) {
        var navExtensionListItem = navExtensionList.item(navExtensionListIncrease);
            navExtensionListItem.addEventListener('click', function(event){
                this.classList.toggle("btn-success");
            });
    }   
    
 // 원본 -> 수정본, 수정본 -> 원본이미지 보이게 만들기
    var liBtnList = document.querySelectorAll(".nav-tabs > li:nth-child(1)>a, .nav-tabs > li:nth-child(2)>a");
    
    for(index=0; index < liBtnList.length; index++) {
		var liBtn = liBtnList.item(index);
		
		liBtn.addEventListener("click", function(event) {
            
			// 초기화 함수
			tapId = event.target.id;
            beginIndex = 1;
       	 	endIndex = 8;

       	 	
       		// 원본,수정본 클릭시 검색값 초기화 코드
       	 	document.getElementById("titleAuthorCategory").value = "optAll";
       		document.getElementById("searchWord").value = "";
       		document.getElementById("beginDate").value = "";
       		document.getElementById("endDate").value = "";
       	 	
        	// 원본,수정본을 누를시 jpg, png, bmp, gif파일선택이미지를 초기화 시키는 코드
       	    var navExtensionList = document.querySelectorAll(".ck-all > label:nth-child(n+1)");
       	    for(var navExtensionListIncrease=0; navExtensionListIncrease < navExtensionList.length; navExtensionListIncrease++) {
       	        var item = navExtensionList.item(navExtensionListIncrease);
       	        var classValues = item.getAttribute('class');
       	        if (classValues.indexOf('btn-success') >= 0) {
       	        	item.setAttribute('class', classValues.replace('btn-success', ''));
       	        }     
       	    }    
       	 	
       		// 원본,수정본 클릭시 검색값 초기화 코드
       	 	document.getElementById("titleAuthorCategory").value = "optAll";
       		document.getElementById("searchWord").value = "";
       		document.getElementById("beginDate").value = "";
       		document.getElementById("endDate").value = "";
       	 	
        	// 원본,수정본을 누를시 jpg, png, bmp, gif파일선택이미지를 초기화 시키는 코드
       	    var navExtensionList = document.querySelectorAll(".ck-all > label:nth-child(n+1)");
       	    for(var navExtensionListIncrease=0; navExtensionListIncrease < navExtensionList.length; navExtensionListIncrease++) {
       	        var item = navExtensionList.item(navExtensionListIncrease);
       	        var classValues = item.getAttribute('class');
       	        if (classValues.indexOf('btn-success') >= 0) {
       	        	item.setAttribute('class', classValues.replace('btn-success', ''));
       	        }     
       	    }    
       	 	
       	    // 원본, 수정본을 누를 시 jpg, png, bmp, gif버튼의 값을 초기화 시켜주는 코드
       		document.getElementById("ck-png").checked = false;
            document.getElementById("ck-jpg").checked = false;
            document.getElementById("ck-bmp").checked = false;
            document.getElementById("ck-gif").checked = false;
       	 	
            
       	 	var xhr = new XMLHttpRequest();
            
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    var jsonText = xhr.responseText;
                    var arr = JSON.parse(jsonText);
                    console.log(arr);
                    var html = "";
                    for(var i=0; i < arr.length; i++) {
                    	var img = arr[i];
                    	console.log(img.Alt + " " + img.category.categoryName);
                    	html += '<div class="col-xs-3">';
	                    html += '<div class="thumbnail" style="width: 250px; height: 300px;">';
	                    html += '<a href="pictureContainer.jsp?path='+img.imgPath+'&title='+img.imgTitle+'&regDate='+img.imgRegdate+'&reporterNo='+img.reporter.reporterName+'&category='+img.category.categoryName+'&explanation='+img.imgAlt+'&location='+img.imgLocation+'&type='+img.imgType+'">';
	                    html += '<img src="/imgdata/'+img.imgPath+'" width="50%" height="50%" id="img-path"/>';
	                    html += '<div class="caption" >';
	                    html += '<h4 id="img-title">'+img.imgTitle+'</h4>';
	                    html += '<p id="img-regdate">'+img.imgRegdate+'</p>';
	                    html += '<p id="img-reproterno">'+img.reporter.reporterName+'</p>';
	                    html += '</div>';
	                    html += '</a>';
	                    html += '</div>';
	                    html += '</div>';

                    };
                    
                    document.getElementById("img-box").innerHTML = html;
                    
            	}
            }
            xhr.open("GET", "/index.do?bino="+beginIndex+"&eino="+endIndex+"&tapid="+tapId+"&categoryId="+categoryId);
            
            xhr.send(null);
        });
    }
    
    // 펼치기 클릭 시 8개씩 나오게 만듬
    // 초기화 함수
	var beginIndex = 1;
    var endIndex = 8;
	var tapId = "";
	
    document.getElementById("expend").addEventListener("click", function(event){
    		
    	var expendId = document.getElementById("expend").id
    	tapId = document.querySelector(".originalrevision > a").id;
    	
    	var xhr = new XMLHttpRequest();
        
        xhr.onreadystatechange = function() {
            if(xhr.readyState == 4 && xhr.status == 200) {
                var jsonTextTap = xhr.responseText;
                var arrTap = JSON.parse(jsonTextTap);
                
                var htmlTap = "";
                for(var a=0; a < arrTap.length; a++) {
                	var imgTap = arrTap[a];
                	htmlTap += '<div class="col-xs-3">';
                	htmlTap += '<div class="thumbnail" style="width: 250px; height: 300px;">';
                	htmlTap += '<a href="pictureContainer.jsp?path='+imgTap.imgPath+'&title='+imgTap.imgTitle+'&regDate='+imgTap.imgRegdate+'&reporterNo='+imgTap.reporter.reporterName+'&category='+imgTap.category.categoryName+'&explanation='+imgTap.imgAlt+'&location='+imgTap.imgLocation+'&type='+imgTap.imgType+'">';
                	htmlTap += '<img src="/imgdata/'+imgTap.imgPath+'" width="50%" height="50%" id="img-path"/>';
                	htmlTap += '<div class="caption" >';
                	htmlTap += '<h4 id="img-title">'+imgTap.imgTitle+'</h4>';
                	htmlTap += '<p id="img-regdate">'+imgTap.imgRegdate+'</p>';
                	htmlTap += '<p id="img-reproterno">'+imgTap.reporter.reporterName+'</p>';
                    htmlTap += '</div>';
                    htmlTap += '</a>';
                    htmlTap += '</div>';
                    htmlTap += '</div>';
                }
                document.getElementById("img-box").innerHTML += htmlTap;
        	}
        }
        
        // 펼치기 버튼 누를시 8씩 증가하는 함수
        beginIndex += 8;
        endIndex += 8;
        xhr.open("GET", "/index.do?bino="+beginIndex+"&eino="+endIndex+"&tapid="+tapId+"&expendId="+expendId+"&categoryId="+categoryId);
        
        xhr.send(null);
    });
    
    // 카테고리를 변경 할 때마다 이름값을 메인 카테고리 라인에 넣기
    // 초기화 함수
    // categoryId: 시사의id값, 경제의id값, 스포츠의id값, 연예의id값
    // categoryName: a테그 안에 있는 html화면에 보이는 text값
     var categoryId = "";
     var categoryList = document.querySelectorAll(".dropdown-menu li a");
     for(index=0; index < categoryList.length; index++) {
         var categoryItem = categoryList.item(index);
         
         // 원본/수정본의 id값을 가져옴
         tapId = document.querySelector(".originalrevision > a").id;
         
         categoryItem.addEventListener("click", function(event) {
        	
        	 // 초기화 함수
        	 beginIndex = 1;
        	 endIndex = 8;
        	 
        	 // 카테고리클릭시 검색값 초기화 코드
        	 document.getElementById("titleAuthorCategory").value = "optAll";
        	 document.getElementById("searchWord").value = "";
        	 document.getElementById("beginDate").value = "";
        	 document.getElementById("endDate").value = "";
        	 
        	// 원본,수정본을 누를시 jpg, png, bmp, gif파일선택이미지를 초기화 시키는 코드
        	    var navExtensionList = document.querySelectorAll(".ck-all > label:nth-child(n+1)");
        	    for(var navExtensionListIncrease=0; navExtensionListIncrease < navExtensionList.length; navExtensionListIncrease++) {
        	        var item = navExtensionList.item(navExtensionListIncrease);
        	        var classValues = item.getAttribute('class');
        	        if (classValues.indexOf('btn-success') >= 0) {
        	        	item.setAttribute('class', classValues.replace('btn-success', ''));
        	        }     
        	    }    
        	 	
        	 // 원본, 수정본을 누를 시 jpg, png, bmp, gif버튼의 값을 초기화 시켜주는 코드
        	 document.getElementById("ck-png").checked = false;
             document.getElementById("ck-jpg").checked = false;
             document.getElementById("ck-bmp").checked = false;
             document.getElementById("ck-gif").checked = false;

        	 
        	 // a태그 안에 있는 html화면에 보이는 text값과 카테고리별 id값을 가져옴
        	 var categoryName = event.target.innerText;
             categoryId = event.target.id;
             
             document.getElementById("category").innerHTML = categoryName;
             
             var xhr = new XMLHttpRequest();
             
             xhr.onreadystatechange = function() {
                 if(xhr.readyState == 4 && xhr.status == 200) {
                     var jsonTextCategory = xhr.responseText;
                     var arrCategory = JSON.parse(jsonTextCategory);
                     
                     var htmlCategory = "";
                     for(i=0; i < arrCategory.length; i++) {
                     	var imgCategory = arrCategory[i];
	                     	htmlCategory += '<div class="col-xs-3">';
	                     	htmlCategory += '<div class="thumbnail" style="width: 250px; height: 300px;">';
	                     	htmlCategory += '<a href="pictureContainer.jsp?path='+imgCategory.imgPath+'&title='+imgCategory.imgTitle+'&regDate='+imgCategory.imgRegdate+'&reporterNo='+imgCategory.reporter.reporterName+'&category='+imgCategory.category.categoryName+'&explanation='+imgCategory.imgAlt+'&location='+imgCategory.imgLocation+'&type='+imgCategory.imgType+'">';
	                     	htmlCategory += '<img src="/imgdata/'+imgCategory.imgPath+'" width="50%" height="50%" id="img-path"/>';
	                     	htmlCategory += '<div class="caption" >';
	                     	htmlCategory += '<h4 id="img-title">'+imgCategory.imgTitle+'</h4>';
	                     	htmlCategory += '<p id="img-regdate">'+imgCategory.imgRegdate+'</p>';
	                     	htmlCategory += '<p id="img-reproterno">'+imgCategory.reporter.reporterName+'</p>';
	 	                    htmlCategory += '</div>';
	 	                    htmlCategory += '</a>';
	 	                    htmlCategory += '</div>';
	 	                    htmlCategory += '</div>';
						
 	                   
                     };
                     
                     document.getElementById("img-box").innerHTML = htmlCategory;
                    
                     
             	}
             }
             xhr.open("GET", "/index.do?bino="+beginIndex+"&eino="+endIndex+"&tapid="+tapId+"&categoryId="+categoryId);
             
             xhr.send(null);

         }); 
     }
     
     // 제목 작성자 검색기능
      function search(event){
    	 event.preventDefault();
	    	
    	 	 // 초기화 함수
	     	 beginIndex = 1;
	     	 endIndex = 8;
        	 tapId = document.querySelector(".originalrevision > a").id;	
  
             var xhr = new XMLHttpRequest();
             
             xhr.onreadystatechange = function() {
                 if(xhr.readyState == 4 && xhr.status == 200) {
                     var jsonTextSearch = xhr.responseText;
                     var arrSearch = JSON.parse(jsonTextSearch);
                     
                     var htmlSearch = "";
                     for(i=0; i < arrSearch.length; i++) {
                     	var imgSearch = arrSearch[i];
                     	//Console.log(imgSearch.imgPath);
                     	//Console.log(imgSearch.imgTitle);
                     	//Console.log(imgSearch.imgRegdate);
                     	//Console.log(imgSearch.reporter.reporterNo);
	                     	htmlSearch += '<div class="col-xs-3">';
	                     	htmlSearch += '<div class="thumbnail" style="width: 250px; height: 300px;">';
	                     	htmlSearch += '<a href="pictureContainer.jsp?path='+imgSearch.imgPath+'&title='+imgSearch.imgTitle+'&regDate='+imgSearch.imgRegdate+'&reporterNo='+imgSearch.reporter.reporterName+'&category='+imgSearch.category.categoryName+'&explanation='+imgSearch.imgAlt+'&location='+imgSearch.imgLocation+'&type='+imgSearch.imgType+'">';
	                     	htmlSearch += '<img src="/imgdata/'+imgSearch.imgPath+'" width="50%" height="50%" id="img-path"/>';
	                     	htmlSearch += '<div class="caption" >';
	                     	htmlSearch += '<h4 id="img-title">'+imgSearch.imgTitle+'</h4>';
	                     	htmlSearch += '<p id="img-regdate">'+imgSearch.imgRegdate+'</p>';
	                     	htmlSearch += '<p id="img-reproterno">'+imgSearch.reporter.reporterName+'</p>';
	                     	htmlSearch += '</div>';
	                     	htmlSearch += '</a>';
		 	                htmlSearch += '</div>';
		 	                htmlSearch += '</div>';
						
 	                   
                     };
                     
                     document.getElementById("img-box").innerHTML = htmlSearch;
                    
                     
             	}
             }
             xhr.open("POST", "/index.do");
             var obj = {
            	 bino: beginIndex,
            	 eino: endIndex,
            	 tapid: tapId,
            	 categoryId: categoryId,
            	 opt: document.getElementById("titleAuthorCategory").value,
            	 keyword: document.getElementById("searchWord").value,
            	 beginDate: document.getElementById("beginDate").value,
            	 endDate: document.getElementById("endDate").value,
            	 png: document.getElementById("ck-png").checked?"png":"nopng",
            	 jpg: document.getElementById("ck-jpg").checked?"jpg":"nojpg",
            	 bmp: document.getElementById("ck-bmp").checked?"bmp":"nobmp",
            	 gif: document.getElementById("ck-gif").checked?"gif":"nogif"
             };
            var data = makeQueryString(obj);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send(data);
    	}   
    
     	function makeQueryString(obj) {
     		var param = Object.keys(obj).map(function(key) {
     			return [key, obj[key]].join("=")
     		}).join("&");
     		
     		return param;
     	}
     
</script>
</html>