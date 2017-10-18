<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>JTimes :: 시민 제보</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="/commons/SmartEditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" ></script>
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
		document.getElementById("sabip").addEventListener('click',function(event){
			
			var form = $('form')[0];
	         var formData = new FormData(form);
	             $.ajax({
	                url: '/citizenrep/crimg.do',
	                processData: false,
	                    contentType: false,
	                data: formData,
	                type: 'POST',
	                success: function(result){
	                	var data = JSON.parse(result);
	                	var imgpath = data.filePath;
	                	var sHTML = "<div style='width:100%; text-align:left;' align='left'><img src='/citizenrep/ctrepimg/"+imgpath+"' style='width: 450px; height: 300px;' display='block'/></div>";
	                	oEditors.getById["ir1"].exec("PASTE_HTML", [sHTML]);
	                }
	           });
	         });
	});
</script>
<style type="text/css">
	.container {
		width: 1024px;
		margin: 0 auto;
	}
	#ir1{
		display: inline;
	}
</style>
</head>
<body>	
	<%@include file="/commons/clientNavi.jsp" %>
	<div class="container">
		<div class="row">
			<h2 class="well">참여마당<small> - 구독자가 만드는 기사</small></h2>
		</div>
		<div class="row well">
			<form method="post" action="javascript:submit(this)" enctype="multipart/form-data" id="form" name="form">
				<div class="form-group">
					<label>제목</label> 
					<input type="text" class="form-control"	id="title" name="title" />
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea rows="10" class="form-control" style="display: none; background-color: white" name="ir1" id="ir1"></textarea>
				</div>
				<div class="form-group">
					<div class="col-xs-9">
						<input type="file" name="file-upload" id="file-upload" />
						<a class="btn btn-default" id="sabip">이미지 본문 삽입</a>
					</div>
					<div class="col-xs-3 text-right">
						<a href="list.jsp" class="btn btn-warning btn-sm">취소</a>
						<button class="btn btn-primary btn-sm">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@include file="/commons/clientFooter.jsp" %>
</body>
<script type="text/javascript">
function submit(el) {
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	document.form.action = "/citizenrep/addctrep.html";
	document.form.submit();
}
</script>
</html>