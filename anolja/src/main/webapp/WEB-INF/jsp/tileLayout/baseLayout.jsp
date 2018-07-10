<%@ page pageEncoding="utf-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<title>AːNOLJA</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/default.css">
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
	<!-- 회원 가입 등의 얼럿 처리를 위한 스크립트 -->
	<script>
	console.log("세션 ID : ", `${id}`);
	var msg = `${msg}`;
	if (msg) {
		swal({
			  text: msg,
			  button: "확인"
			});
	}
	</script>
	
	<div id="quick_wrap">
		<div id="quick_right_menu">
			<span></span>
			<ul>
				<li><a href="#" style="font-weight: bold;">Skyqe</a></li>

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

<script src="${pageContext.request.contextPath}/resources/js/signup.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/login.js"></script>
</body>
</html>