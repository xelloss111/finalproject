/**
 * 	회원 가입 처리를 위한 js 파일
 */

// contextPath 가져오기
var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

var userSection = $('.user_section');
var signup = document.querySelector('#signup');

signup.addEventListener('click', function() {
	var html = "";
	html += '<img class="glass" src="'+ ctx +'/resources/images/user/mark_icon_title.png" alt=""\
		  style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">\
		<form id="sForm">\
		<div id="writeArea" style="float:left; margin-top:40px; margin-right:20px;">\
		<table id="writeTable">\
		<tr>\
		<td style="width: 200px; vertical-align=middle;" >\
		<input type="text" name="id" placeholder="id 입력"/>\
		</td>\
		<td style="width: 100px;"><span id="chkId"></span></td>\
		</tr>\
		<tr>\
		<td>\
		<input type="password" name="pass" placeholder="비밀번호 입력" />\
		</td>\
		<td></td>\
		</tr>\
		<tr>\
		<td>\
		<input type="password" id="passCheck" placeholder="비밀번호 체크" />\
		</td>\
		<td><span id="chkPass"></span></td>\
		</tr>\
		<tr>\
		<td>\
		<input type="email" name="email" placeholder="Example@Example.com" />\
		</td>\
		<td><span id="chkEmail"></span></td>\
		</tr>\
		</table>\
		</div>\
		<div id="btnArea" style="float:left; margin-left: 40px; margin-top:105px;">\
		<button class="btn" id="registBtn"><span class="button__inner">가입</span></button>\
		</div>\
		</form>';
	
	userSection.slideToggle('slow');
	$(".user_section").html(html);
	
	// form 태그의 엘리먼트 정보 가져오기
	var registBtn = document.querySelector("#registBtn");
	var id = document.querySelector("input[name='id']");
	var pass = document.querySelector("input[name='pass']");
	var passAgain = document.querySelector("#passCheck");
	var email = document.querySelector("input[name='email']");
	var idChk = document.querySelector("#chkId");
	var passChk = document.querySelector("#chkPass");
	var emailChk = document.querySelector("#chkEmail");

	// id 존재 여부 체크
	id.addEventListener("keyup", function() {
		serverCall(ctx + "/user/idCheck", "POST", {"id":id.value}, "id");
	});

	// email 존재 여부 체크
	email.addEventListener("blur", function() {
		serverCall(ctx + "/user/emailCheck", "POST", {"email": email.value}, "email");
	});

	// 패스워드 재 확인 체크
	passAgain.addEventListener("keyup", function() {
		var color = "";
		var html = "";
		if (pass.value === passAgain.value) {
			color = "green";
			html = "&nbsp;&nbsp;일치";
		} else {
			color = "red";
			html = "&nbsp;&nbsp;불일치";
		}
		passChk.innerHTML = "";
		passChk.style.color = color;
		passChk.innerHTML = html;
	});

	// 가입 버튼 이벤트 처리
	registBtn.addEventListener("click", function(e) {
		e.preventDefault();
		
		console.log(idChk.innerText);
		console.log(emailChk.innerText);
		
		if (id.value == "") {
			alert("id는 필수 입력 사항입니다.");
			return;
		} else if (idChk.innerHTML == '&nbsp;&nbsp;사용 불가') {
			alert("사용 중인 ID로 가입이 불가능 합니다.");
			return;
		}
		
		if (pass.value == "") { alert("pass는 필수 입력 사항입니다."); return; }
		
		if (email.value == "") {
			alert("email은 필수 입력 사항입니다.");
			return;
		} else if (emailChk.innerHTML == '&nbsp;&nbsp;사용 불가') {
			alert("사용 중인 email로 가입이 불가능 합니다.");
			return;
		}
		
		var form = document.querySelector("#sForm");
		var elements = form.elements;
		
		console.log(elements);
		
		form.setAttribute("action", ctx + "/user/signup");
		form.setAttribute("method", "post");
		form.submit();
	});


	// 가입 정보 체크 결과 출력 함수
	function checkInfo(msg, data) {
		var color = "";
		var html = "";
		var element;
		switch(msg) {
			case "id":
				element = document.querySelector("#chkId");
				if (data.responseText != "") {
					color = "red";
					html = "&nbsp;&nbsp;사용 불가";
				} else {
					color = "green";
					html = "&nbsp;&nbsp;사용 가능";
				}
			break;
			case "email":
				element = document.querySelector("#chkEmail");
				if (data.responseText != "") {
					color = "red";
					html = "&nbsp;&nbsp;사용 불가";
				} else {
					color = "green";
					html = "&nbsp;&nbsp;사용 가능";
				}
			break;
		}
		element.innerHTML = "";
		element.style.color = color;
		element.innerHTML = html;
	}


	// 회원 가입 전 서버 통신을 통한 정보 체크 함수
	// ID 및 이메일 관련 모듈화 처리 완료
	function serverCall(url, method, data, requestMsg) {
		var req = new XMLHttpRequest();
		req.open(method, url, true);
		
		var params = "";
		// 파라미터 존재 여부 확인
		if (typeof (data) == "string") {
			params = data;
		}
		// 객체 형태로 넘어온 경우
		// {msg: "hi", id: "aaa", age: 22} => msg=hi&id=aaa&age=22
		else {
			for (var key in data) {
				if (params != "") {
					params += "&";					
				}
				params += key + "=" + data[key];
//					params = `${key}=${options.data[key]}`;
			}
		} 
		
		req.onreadystatechange = function () {
			if (req.readyState == 4 && req.status == 200) {
//	 				var result = JSON.parse(req.responseText);
					checkInfo(requestMsg, req);
			}
		}
		
		if (method == "POST") {
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		}
		
		req.send(method == "POST" ? params : null);
	};
});
