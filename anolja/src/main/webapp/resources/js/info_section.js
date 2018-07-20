/**
 *   session 값(로그인 여부)에 따른 header 영역 변경 처리 
 */
//	ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

	var infoList = $('#wrap > .info_section > ul');
	console.log("세션 ID 체크 중 : ", sessionId);

	var signuphtml = '';
	var loginhtml = '';
	var mypagehtml = '';
	var logouthtml = '';
	
	signuphtml = '<li id="signup">\
		<img class="signupicon" src="'+ctx+'/resources/images/user/signup.png"\
		alt="회원가입" title="회원가입"></li>';

	loginhtml = '<li id="login">\
		<img class="loginicon" src="'+ctx+'/resources/images/user/login.png"\
		alt="로그인" title="로그인"></li>';
	
	mypagehtml = '<li id="mypage"><span id="mSpan">' + sessionId + '님 접속중</span>\
		<img class="mypageicon" src="' + ctx + '/resources/images/user/mypage.png"\
		alt="내 정보" title="내 정보"></li>';

	logouthtml = '<li id="logout">\
		<img class="logouticon" src="' + ctx + '/resources/images/user/logout.png"\
		alt="로그아웃" title="로그아웃"></li>';
	
	if (sessionId == 'null') {
		makeLoginElement();
	} else {
		makeLogoutElement();
	};

	function makeLoginElement() {
		infoList.innerHTML = "";
		infoList.append(signuphtml);
		infoList.append(loginhtml);
	};

	function makeLogoutElement() {
		infoList.innerHTML = "";
		infoList.append(mypagehtml);
		infoList.append(logouthtml);
	};

