<%@ page pageEncoding="utf-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta http-equiv="X-UA-Compatible" content="IE=11">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>AːNOLJA</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/favicon/favicon.ico">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/resources/images/icon/flat-design-touch.png">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"
	type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/flat.min.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/demo.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/jquery.particleground.js'></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
	integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt"
	crossorigin="anonymous">

<!-- sweetAlert 적용 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



<script type="text/javascript">
	$(function(){// jQuery 시작
		
		var quickID = $("#quick_right_menu");
		var offset = quickID.offset();
		//.offset 선택한 요소의 좌표를 가져온다.
		//.offset().top, .offset().left
		//.offset ({left:100, top:50}); 왼쪽 100px, 위쪽 50px로 위치 변경

		
		$(window).scroll(function(){
					if($(window).scrollTop() > offset.top){
					quickID.stop().animate({marginTop:$(window).scrollTop()},1000);
				}else{quickID.stop().animate({marginTop:0},200);
				};
		});

	}); //jQuery 종결 
	</script>
</head>
<body>
	<!-- 로딩 이미지 -->
	<div class="loading" id='display-none'><img class="loading-image" src="${pageContext.request.contextPath}/resources/images/user/working.gif" alt="Loading..." /></div>
	 
	<!-- Large modal -->
	<!-- Button trigger modal -->
	<button type="button" id="captureBtn" data-toggle="modal" data-target="#mmm"></button>
	
	<!-- Modal -->
	<div class="modal fade" id="mmm" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
	      </div>
	      <div class="modal-body">
<!-- 	        <video height="426" width="640" controls autoplay style="width:99px; height:75px; display:none;"></video> -->
<!-- 			<a href="javascript:" class="btn" onclick="App.start('glasses');">Glasses!</a> -->
<!-- 			<a href="javascript:" class="btn" onclick="App.start('hipster');">Hipster!</a> -->
<!-- 			<a href="javascript:" class="btn" onclick="App.start('blur');">Blurr!</a> -->
<!-- 			<a href="javascript:" class="btn" onclick="App.start('greenscreen');">Color Me!</a> -->
<!-- 			<br /><br /><br /> -->
<!-- 			<!-- Out Canvas Element for output --> -->
<%-- 			<canvas id="output"  height="426" width="515" ></canvas> --%>
		
<!-- 			<div class="colours" style="display:none;"> -->
<!-- 				<div id="red"> -->
<!-- 					<input type="range" min=0 max=255 value=190 class="min"> -->
<!-- 					<input type="range" min=0 max=255 value=240 class="max"> -->
<!-- 				</div> -->
<!-- 				<div id="green"> -->
<!-- 					<input type="range" min=0 max=255 value=0 class="min"> -->
<!-- 					<input type="range" min=0 max=255 value=120 class="max"> -->
<!-- 				</div> -->
<!-- 				<div id="blue"> -->
<!-- 					<input type="range" min=0 max=255 value=90 class="min"> -->
<!-- 					<input type="range" min=0 max=255 value=190 class="max"> -->
<!-- 				</div>				 -->
<!-- 			</div> -->
		  </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
 
	 
	 
	<div id="quick_wrap">
		<div id="quick_right_menu">
			<span></span>
			<ul>
				<li><a href="#" style="font-weight: bold;">쪽지함</a></li>

			</ul>
		</div>
	</div>
	<!-- quick_wrap -->

	<div class="container">
		<div id="particles"></div>
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="content" />
		<tiles:insertAttribute name="footer" />
	</div>
	
	<!-- 회원 가입 등의 얼럿 처리를 위한 스크립트 -->
	<script>
	var ctx;
	$(document).ready(function() {
		ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
		$.getScript(ctx + "/resources/js/info_section.js", function() {});
		$.getScript(ctx + "/resources/js/signup.js", function() {});
		$.getScript(ctx + "/resources/js/loginout.js", function() {});
		$.getScript(ctx + "/resources/js/capture/ccv.js", function() {});
		$.getScript(ctx + "/resources/js/capture/face.js", function() {});
		$.getScript(ctx + "/resources/js/capture/scripts.js", function() {});
		$.getScript(ctx + "/resources/js/capture/stackblur.js", function() {});
		$.getScript(ctx + "/resources/js/mypage.js", function() {});
	});
	

	var sessionId = `<%= session.getAttribute("id")%>`;
	console.log("세션 ID : ", sessionId);
	var msg = `${msg}`;
	if (msg) {
		swal({
			  text: msg,
			  button: "확인"
			});
	}

	</script>

<script async="" src="//www.google-analytics.com/analytics.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capture/ccv.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capture/face.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capture/scripts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/capture/stackblur.js"></script>

<%-- <script src="${pageContext.request.contextPath}/resources/js/info_section.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/signup.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/loginout.js"></script> --%>
</body>
</html>