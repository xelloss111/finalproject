<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%> 
<!--  사용하지 않는 영역 시작 info_section-->
		<section class="info_section">
			<ul class="info_list">
				<li><a href=""><img src="" alt=""></a></li>
				<li><a href=""><img src="" alt=""></a></li>
				<li><a href=""><img src="" alt=""></a></li>
				<li><a href=""><img src="" alt=""></a></li>
			</ul>
		</section>
<!--  사용하지 않는 영역 끝 info_section-->

<div id="wrap">
		
		<section class="info_section">
			<ul class="info_list">
				<li id="signup">
					<img class="signupicon" src="${pageContext.request.contextPath}/resources/images/user/signup.png" alt="회원가입" title="회원가입">
				</li>
				<li id="login">
					<img class="loginicon" src="${pageContext.request.contextPath}/resources/images/user/login.png" alt="로그인" title="로그인">
				</li>
				<li id="mypage"><span id="mSpan">' + sessionId + '님 접속중</span>
					<img class="mypageicon" src="${pageContext.request.contextPath}/resources/images/user/mypage.png" alt="내 정보" title="내 정보">
				</li>
				<li id="logout">
					<img class="logouticon" src="${pageContext.request.contextPath}/resources/images/user/logout.png" alt="로그아웃" title="로그아웃">
				</li>
			</ul>
		</section>

<header class="header">

<!--  사용하지 않는 영역 시작 class="logo"-->
	<h1 class="logo">
		<a href="${pageContext.request.contextPath}/index.jsp">Aː</a>
	</h1>
<!--  사용하지 않는 영역 끝 class="logo"-->
	<nav class="nav">
		<ul class="gnb">
			<li><a href="${pageContext.request.contextPath}/board/list">아무말대잔치</a><span
				class="sub_menu_toggle_btn">하위 메뉴 토글 버튼</span></li>
			<li><a href="${pageContext.request.contextPath}/game">씽크빅 대전</a><span
				class="sub_menu_toggle_btn">하위 메뉴 토글 버튼</span></li>
			<li><a href="${pageContext.request.contextPath}/bgsearch">치키너</a><span class="sub_menu_toggle_btn">하위
					메뉴 토글 버튼</span></li>
			<li><a href="${pageContext.request.contextPath}/video">후방주의</a><span class="sub_menu_toggle_btn">하위
					메뉴 토글 버튼</span></li>
			<li><a href="${pageContext.request.contextPath}/gallery/list">명예의 전당</a><span class="sub_menu_toggle_btn">하위
					메뉴 토글 버튼</span></li>
		</ul>
	</nav>
	<!-- <span class="menu_toggle_btn">전체 메뉴 토글 버튼</span> -->
</header>