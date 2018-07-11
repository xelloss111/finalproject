/**
 *   session 값(로그인 여부)에 따른 header 영역 변경 처리 
 */
//	ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

	var infoList = $('#wrap > .info_section > ul');
	console.log("세션 ID 체크 중 : ", sessionId);
	if (sessionId == 'null') {
		makeLoginElement();
	} else {
		makeLogoutElement();
	};

	var html1 = '';
	var html2 = '';
	function makeLoginElement() {
		infoList.innerHTML = "";

		html1 = '<li id="signup">\
				<img class="signupicon" src="'+ctx+'/resources/images/user/signup.png"\
				alt="회원가입" title="회원가입"></li>';
		
		html2 = '<li id="login">\
				<img class="loginicon" src="'+ctx+'/resources/images/user/login.png"\
				alt="로그인" title="로그인"></li>';
		
		infoList.append(html1);
		infoList.append(html2);
	};

	function makeLogoutElement() {
		infoList.innerHTML = "";
		
		html1 = '';
		html1 = '<li id="mypage"><span id="mSpan">' + sessionId + '님 접속중</span>\
				<img class="mypageicon" src="' + ctx + '/resources/images/user/mypage.png"\
				alt="내 정보" title="내 정보"></li>';
		
		html2 = '';
		html2 = '<li id="logout">\
				<img class="logouticon" src="' + ctx + '/resources/images/user/logout.png"\
				alt="로그아웃" title="로그아웃"></li>';
		
		infoList.append(html1);
		infoList.append(html2);
	};

