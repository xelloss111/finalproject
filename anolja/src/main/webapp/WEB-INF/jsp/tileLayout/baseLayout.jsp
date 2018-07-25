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
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
	
	var sessionId = `<%= session.getAttribute("id")%>`;
	</script>
</head>
<body>
	<!-- 로딩 이미지 -->
	<div class="loading" id='display-none'><img class="loading-image" src="${pageContext.request.contextPath}/resources/images/user/working.gif" alt="Loading..." /></div>
	 
	<!-- MyPage 모달 오픈을 위한 버튼 트리거 -->
	<button type="button" id="captureBtn" data-toggle="modal" data-target="#mmm"></button>
	
	<!-- MyPage 영역 -->
	<div class="modal fade bs-example-modal-lg" id="mmm" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header" style="background:#ffc40f;">
	        <h4 class="modal-title" id="myModalLabel">웹캠 프로필 이미지 등록 / 합성</h4>
	      </div>
			<div id="mypageBody" class="modal-body">
			</div>
	      <div class="modal-footer">
	        <a href="javascript:" class="btn4" onclick="App.stop();" style="float:left;">영상 중지</a>
	        <button type="button" id="normalView" class="btn3" style="float:left;">화면만 나오게</button>
	        <button type="button" id="previewImg" class="btn1" style="float:left;">사진찍기</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
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
		<!-- 회원 영역 -->
		<section class="signup_section">
			<img class="glass" src="${pageContext.request.contextPath}/resources/images/user/mark_icon_title.png" alt="" style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">
			<form id="sForm">
				<div id="writeArea" style="float:left; margin-top:40px; margin-right:20px;">
					<table id="writeTable">
					<tr>
						<td style="width: 200px; vertical-align=middle;" >
							<input class="userlib" type="text" name="id" placeholder="id 입력"/>
						</td>
						<td style="width: 100px;"><span id="chkId"></span></td>
					</tr>
					<tr>
						<td>
							<input class="userlib" type="password" name="pass" placeholder="비밀번호 입력" />
						</td>
						<td></td>
					</tr>
					<tr>
						<td>
							<input class="userlib" type="password" id="passCheck" placeholder="비밀번호 체크" />
						</td>
						<td><span id="chkPass"></span></td>
					</tr>
					<tr>
						<td>
							<input class="userlib" type="email" name="email" placeholder="Example@Example.com" />
						</td>
						<td><span id="chkEmail"></span></td>
					</tr>
				</table>
			</div>
		</form>
		<div id="btnArea" style="float:left; margin-left: 40px; margin-top:105px;">
	    	<button class="btn" id="registBtn"><span class="button__inner">가입</span></button>
		</div>
		</section>
		<section class="login_section">
			<img class="glass" src="${pageContext.request.contextPath}/resources/images/user/mark_icon_login.png" alt="" style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">
			<form id="loginForm">
				<div id="writeArea" style="float:left; margin-top:80px; margin-right:20px;">
					<table id="writeTable">
						<tr>
							<td style="width: 200px; vertical-align=middle;" >
								<input class="userlib" type="text" name="id" placeholder="id 입력"/>
							</td>
						</tr>
						<tr>
							<td>
								<input class="userlib" type="password" name="pass" placeholder="비밀번호 입력" />
							</td>
						</tr>
					</table>
				</div>
			</form>
			<div id="loginArea" style="float:left; margin-left: 40px; margin-top:100px;">
				<button class="btn2" id="loginBtn"><span class="button__inner">로그인</span></button>
			</div>
			<div id="findArea" style="float:left; margin-left: 40px; margin-top:100px;">
				<button class="btn" id="findIdBtn"><span class="button__inner">ID 찾기</span></button>
				<button class="btn" id="findPassBtn"><span class="button__inner">PW 찾기</span></button>
			</div>
		</section>
		<section class="mypage_section"></section>
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
		$.getScript(ctx + "/resources/js/mypage.js", function() {});
	});
	


	var sessionId = `<%= session.getAttribute("id") %>`;
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

</body>
</html>