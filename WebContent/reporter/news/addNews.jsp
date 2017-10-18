<%@page import="kr.co.jtimes.common.dao.CommonsDao"%>
<%@page import="kr.co.jtimes.common.vo.NewsTypeVo"%>
<%@page import="kr.co.jtimes.common.vo.NewsCategoryVo"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jtimes.reporter.profile.common.dao.ReporterEmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/reporter/commons/loginCheck.jsp" %>
<% 
	pageContext.setAttribute("cp", "news");
	ReporterEmployeeVo reporter = (ReporterEmployeeVo)session.getAttribute("loginReporter");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Bootstrap Example</title>
	<meta charset="UTF-8">
	<META http-equiv="Expires" content="-1"> 
	<META http-equiv="Pragma" content="no-cache"> 
	<META http-equiv="Cache-Control" content="No-Cache"> 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <style type="text/css">
        .container { margin: 0 auto; width: 1024px;}
        .margintop {margin-top: 150px;}
        .picture-container {position: fixed; right:0; top:70px; width:500px; height:90%; z-index: 999;}
        .pic-item{height: 20%;}
        .pic-item a img{height: 100px;}
        .display-inline{display: inline;}
        a {cursor: pointer;}
    </style>
  <script type="text/javascript" src="/commons/SmartEditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
	var oEditors = [];
	
	var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR
	
	// 추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	$(document).ready(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "ir1",
			sSkinURI: "/commons/SmartEditor2/SmartEditor2Skin.html",	
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				fOnBeforeUnload : function(){
					//alert("완료!");
				},
				I18N_LOCALE : sLang
			}, //boolean
			fOnAppLoad : function(){
				//예제 코드
				//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
			},
			fCreator: "createSEditor2"
		});
		//----------------------------------------------------------------------------------------------------------------
		document.getElementById("btn-hide").addEventListener("click", function(event){
			event.stopImmediatePropagation();
			var btn = document.getElementById("btn-hide");
			var picCon = document.getElementById("picture-container");
			var con = document.getElementsByClassName("picture-container")[0];
			console.log(picCon.style.display);
			if(picCon.style.display == "block" || picCon.style.display == "") {
				picCon.style.display = "none";
				con.style.width = "100px";
				btn.innerHTML = "<span class='glyphicon glyphicon-menu-left'></span>";
			} else {
				picCon.style.display = "block";
				con.style.width = "500px";
				btn.innerHTML = "<span class='glyphicon glyphicon-menu-right'></span>";
			}
		});
		
	});
	var mainImgFilter = false;
	function appendContentImg(el){

		var img = el.firstElementChild;
		if(mainImgFilter == false){
			mainImgFilter = true;
			document.getElementById("main-img-path").value = img.src;
		}
		var sHTML = "<div style='width:100%; text-align:center;' align='center'><img src='"+img.src+"' style='width:70%;' display='block'/></div>";
		oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	}
	function submit(el) {
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		var newsType = document.getElementById("news-type").value;
		var newsCategory = document.getElementById("news-category").value;
		var newsLocation = document.getElementById("news-location").value;
		var title = document.getElementById("news-title").value;
		var contents = document.getElementById("ir1").value;
		var firstSigner = document.getElementById("first-sign").value;
		var secondSigner = document.getElementById("second-sign").value;
		
		
		if(newsType == "") {
			alert("종류를 선택하세요.");
			return;
		} else if(newsCategory == "") {
			alert("카테고리를 선택하세요.");
			return;
		} else if(newsLocation == "") {
			alert("지역을 선택하세요.");
			return;
		} else if(title == "") {
			alert("제목을 입력하세요.");
			return;
		} else if(contents == "") {
			alert("내용을 입력하세요.");
			return;
		} else if(firstSigner == "") {
			alert("1차 결재자를 선택하세요.");
			return;
		} else if(secondSigner == "") {
			alert("2차 결재자를 선택하세요.");
			return;
		} else {
			contents += '<p><%=reporter.getReporterName() %> 기자 [<%=reporter.getReporterEmail() %>] </p>';
			document.form.action = "addNewsProcess.jsp";
			document.form.submit();
		}
	}
	
	function temporarySave(event) {
		
		event.preventDefault();
		
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				alert("임시 저장 되었습니다.");
				temporaryNewsCheck("l", 0);
			}
		};
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var newsType = document.getElementById("news-type").value;
		var newsCategory = document.getElementById("news-category").value;
		var newsLocation = document.getElementById("news-location").value;
		var title = document.getElementById("news-title").value;
		var contents = document.getElementById("ir1").value;
		var firstSigner = document.getElementById("first-sign").value;
		var secondSigner = document.getElementById("second-sign").value;
		contents += '<p><%=reporter.getReporterName() %> 기자 [<%=reporter.getReporterEmail() %>] </p>';
		if(!(newsType || newsCategory || newsLocation || title || contents || firstSigner || secondSigner)){
			
			alert("입력된 값이 없어 임시저장이 불가능 합니다!");
			return;
		}
		
		xhr.open("POST", "/reporter/news/temporarySaveProcess.jsp");
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send("newsType="+document.getElementById("news-type").value + "&firstSigner=" + document.getElementById("first-sign").value + 
				 "&secondSigner=" + document.getElementById("second-sign").value + "&newsCategory=" + document.getElementById("news-category").value + 
				 "&newsLocation=" + document.getElementById("news-location").value + "&newsTitle=" + document.getElementById("news-title").value +
				 "&ir1=" + encodeURIComponent(document.getElementById("ir1").value) + "&mainPath=" + encodeURIComponent(document.getElementById("main-img-path").value));
	}
	
</script>
</head>
<body>
<%@ include file="/reporter/commons/reporterNavi.jsp" %>
<div class="container">
<%
	ReporterEmployeeDao empDao = new ReporterEmployeeDao();
	CommonsDao commonsDao = new CommonsDao();

	/*수정해야할 부분.. 나중에 세션에서 가져올것*/

	
	List<ReporterEmployeeVo> firstSigner = empDao.getBossReportersByNo(reporter.getDeptNo().getDeptNo());
	List<ReporterEmployeeVo> secondSigner = empDao.getChiefs();
	
	List<NewsCategoryVo> categoryList = commonsDao.getAllCategory();
	List<NewsTypeVo> typeList = commonsDao.getAllNewsType();
%>
	<div class="col-xs-12">
		<h2 class="display-inline col-xs-10">기사 등록</h2>
		<div class="col-xs-2" id="temporary-div"></div>
	</div>
		<form id="form" name="form" class="form-horizontal" action="javascript:submit(this)" method="post">
			<input type="hidden" id="main-img-path" name="mainimgpath" value=""/> 
			<div class="form-group row">
				<label class="col-xs-1 control-label">결재자</label>
				<div class="col-xs-2">
					<select id="first-sign" name="firstsign">
						<option selected value="">--- 1차결재자 ---</option>
					<%for(ReporterEmployeeVo signer : firstSigner){ %>
						<option value="<%=signer.getReporterNo() %>"><%=signer.getReporterName() %></option>
					<%} %>
					</select>
				</div>
				<div class="col-xs-2">
					<select id="second-sign" name="secondsign">
						<option selected value="">--- 2차결재자 ---</option>
					<%for(ReporterEmployeeVo signer : secondSigner){ %>
						<option value="<%=signer.getReporterNo() %>"><%=signer.getReporterName() %></option>
					<%} %>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-xs-1 control-label">분류</label>
				<div class="col-xs-2">
					<select id="news-type" name="newstype">
						<option selected value="">--- 종 류 ---</option>
					<%for(NewsTypeVo type : typeList){
					%>
						<option value="<%=type.getNewsTypeNo() %>"><%=type.getNewsTypeName()%></option>
					<%} %>
					</select>
				</div>
				<div class="col-xs-2">
					<select id="news-category" name="newscategory">
						<option selected value="">---카테고리---</option>
					<%for(NewsCategoryVo category : categoryList){
					%>
						<option value="<%=category.getCategoryNo() %>"><%=category.getCategoryName()%></option>
					<%} %>
					</select>
				</div>
				<div class="col-xs-2">
					<select id="news-location" name="newslocation">
						<option selected  value="">--- 지 역 ---</option>
						<option value="국내">국내</option>
						<option value="해외">해외</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
					<label class="col-xs-1 control-label">제목</label>
					<div class="col-xs-10">
						<input type="text" id="news-title" name="title" class="form-control"/>
					</div>
			</div>
			<div class="form-group row">
				<label class="col-xs-1 control-label">내용</label>
				<div class="col-xs-10">
					<textarea name="ir1" id="ir1" rows="10" cols="100" style="width:100%; height:412px; display:none;"></textarea>
				</div>      
			</div>
			<div class="form-group row">
				<div class="col-xs-1"></div>
				<div class="col-xs-10 text-right">
					<button id="temp-save" class="btn btn-info" onclick="temporarySave(event)">임시저장</button>
					<button type="submit" id="btn-submit" class="btn btn-success">작성완료</button>
				</div>
			</div>
		</form>
		<div class="well picture-container">
				<div class="col-xs-1">
					<button class="btn" id="btn-hide"><span class="glyphicon glyphicon-menu-right"></span></button>
				</div>
				<div class="col-xs-10" id="picture-container">
					<fieldset>
						<legend>PictureContainer</legend>
						<div class="row">
							<div class="col-xs-2">
								<select id="img-category" onchange="categoryChange()" class="text-right">
									<option value="0">---전체보기---</option>
									<%for(NewsCategoryVo category : categoryList){
									%>
										<option value="<%=category.getCategoryNo() %>"><%=category.getCategoryName()%></option>
									<%} %>
								</select>
							</div>
							<div class="pull-right">
								<ul class="nav nav-tabs">
									<li id="tab-N" class="active"><a onclick="javascript:tabClick('N')">원본</a></li>
									<li id="tab-Y"><a onclick="javascript:tabClick('Y')">수정본</a></li>
								</ul>
							</div>
						</div>
					</fieldset>
				
					<div id="img-space" class="row">
					
					</div>
					<div class="text-center row col-xs-10">
	                	<ul id="img-page" class="pagination pagination-sm">
	                    
                		</ul>
            		</div>
				</div>
			</div>
		</div>
	<%@include file="/reporter/commons/reporterFooter.jsp" %>
	
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">임시 저장 목록</h4>
				</div>
				<div id="modal-body" class="modal-body">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	function categoryChange() {
		
		var category = document.getElementById("img-category").value;
		var state = '';
		if(document.getElementById("tab-N").getAttribute("class") == "active") {
			state = "N";
		} else {
			state = "Y";
		}
		
		requestImage(category, state, 1);
	}

	function tabClick(state){
		if(state == 'Y') {
			document.getElementById("tab-N").setAttribute("class", "");
			document.getElementById("tab-Y").setAttribute("class", "active");
		} else {
			document.getElementById("tab-N").setAttribute("class", "active");
			document.getElementById("tab-Y").setAttribute("class", "");
		}
		var category = document.getElementById("img-category").value;
		console.log(category);
		requestImage(category, state, 1);
	}

	function requestImage(categoryNo, tabId, pageNo){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var jsonText = xhr.responseText;
				var imgs = JSON.parse(jsonText);
				var beginPage = imgs.beginPage;
				var endPage = imgs.endPage;
				var currentNaviBlock = imgs.currentNaviBlock;
				var totalNaviBlock = imgs.totalNaviBlock;
				var imgList = imgs.imgList;
				var totalPages = imgs.totalPages;
				
				var htmlContents = "";
				imgList.forEach(function (imgItem, index) {
					if(index%2 == 0) {
						htmlContents += '<div class="row">';
					}
					htmlContents += '<div class="col-xs-6 text-center pic-item">'
					htmlContents += 	'<a onclick="javascript:appendContentImg(this)">'
					htmlContents += 		'<img src="/imgdata/'+imgItem.imgPath+'" class="img-thumbnail">'
					htmlContents += 	'</a>'
					htmlContents += 	'<h4>'+imgItem.imgTitle+'</h4>'
					htmlContents += 	'<h4>'+imgItem.reporter.reporterName+'</h4>'
					htmlContents += '</div>'
					if(index%2 == 1) {
						htmlContents += '</div>';
					}
				});
				document.getElementById("img-space").innerHTML = htmlContents;
				
				var pageHTML = "";
	            if(pageNo != 1) {
	            	pageHTML +='<li><a onclick="javascript:requestImage('+categoryNo+',\''+ tabId +'\','+(pageNo-1)+')">&lt;</a></li>';
	            }
				for(var i = beginPage; i <= endPage; ++i) {
					pageHTML += '<li class="'+((i == pageNo)?'active':'')+'"><a onclick="javascript:requestImage('+categoryNo+',\''+ tabId +'\','+ i +')">' + i + '</a></li>'
				}
				if(!(pageNo >= totalPages)){
					pageHTML += '<li><a onclick="javascript:requestImage('+categoryNo+',\''+ tabId +'\','+(pageNo+1)+')">&gt;</a></li>';
				}
				document.getElementById("img-page").innerHTML = pageHTML;
			}
		}
		xhr.open("GET", "/reporter/news/getImageProcess.jsp?tabId="+tabId+"&pageNo="+pageNo+"&category="+categoryNo);
		xhr.send(null);
	};
	
	requestImage(0, "N", 1);
	
	function temporaryNewsCheck(type, no) {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				var data = JSON.parse(xhr.responseText);
				
				if(data.processType=="l") {
					var tempList = data.tempList;
					if(tempList.length){
						var btn = '<button id="temp-btn" type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">임시저장('+tempList.length+')</button>';
						document.getElementById("temporary-div").innerHTML = btn;
						
						var htmlContents = "";
						tempList.forEach(function(temp, index) {
							htmlContents += '<div class="row">'
							htmlContents += '<div class="col-xs-8"><p>'+temp.title+'</p></div>'
							htmlContents += '<div class="col-xs-2"><button class="btn btn-success" data-dismiss="modal" onclick="javascript:temporaryNewsCheck(\'g\', '+temp.no+')">선택</button></div>'
							htmlContents += '<div class="col-xs-2"><button class="btn btn-danger" onclick="deleteTemp('+temp.no+')">삭제</button></div>'
							htmlContents += '</div>'
							htmlContents += '<hr/>'
						});
						document.getElementById("modal-body").innerHTML = htmlContents;
					} else {
						document.getElementById("temporary-div").innerHTML = "";
					}
				} else {
					var temp = data.temp;
					console.log(temp);
					document.getElementById("news-title").value = temp.title;
					var typeOption = document.getElementById("news-type");
					for(var i = 0; i < typeOption.options.length; ++ i) {
						if(typeOption.options[i].value == temp.type.newsTypeNo) {
							typeOption.options[i].selected = true;
						}
					}
					var categoryOption = document.getElementById("news-category");
					for(var j = 0; j < categoryOption.options.length; ++ j) {
						if(categoryOption.options[j].value == temp.category.categoryNo) {
							categoryOption.options[j].selected = true;
						}
					}
					var locationOption = document.getElementById("news-location");
					if(temp.location){
						for(var k = 0; k < locationOption.options.length; ++ k) {
							if(locationOption.options[k].value == temp.location) {
								locationOption.options[k].selected = true;
							}
						}
					}
					oEditors.getById["ir1"].exec("PASTE_HTML", [temp.contents]);
					document.getElementById("modal-body").innerHTML = "";
					document.getElementById("main-img-path").value = temp.imgPath;
					temporaryNewsCheck("l", 0);
				}
				
			}
		};
		xhr.open("GET", "/reporter/news/temporaryGetProcess.jsp?processType="+type+"&tempNo="+no);
		xhr.send(null);
	}
	
	function deleteTemp(no){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200) {
				document.getElementById("modal-body").innerHTML = "";
				temporaryNewsCheck("l", 0);
			}
		}
		xhr.open("GET", "/reporter/news/deleteTemporary.jsp?no="+no);
		xhr.send(null);
	}
	temporaryNewsCheck("l", 0);
</script>
</html>