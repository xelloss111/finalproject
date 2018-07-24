/**
 * 	회원 가입 처리를 위한 js 파일
 */

var signupSection = $('.signup_section');
var loginSection = $('.login_section');
var signup = document.querySelector('#signup');

$(document).on('click', '#signup', function() {
	if(loginSection.attr('display') != 'none') loginSection.slideUp('slow');
//	var html = "";
//	html += '<img class="glass" src="'+ ctx +'/resources/images/user/mark_icon_title.png" alt=""\
//		  style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">\
//		<form id="sForm">\
//		<div id="writeArea" style="float:left; margin-top:40px; margin-right:20px;">\
//		<table id="writeTable">\
//		<tr>\
//		<td style="width: 200px; vertical-align=middle;" >\
//		<input class="userlib" type="text" name="id" placeholder="id 입력"/>\
//		</td>\
//		<td style="width: 100px;"><span id="chkId"></span></td>\
//		</tr>\
//		<tr>\
//		<td>\
//		<input class="userlib" type="password" name="pass" placeholder="비밀번호 입력" />\
//		</td>\
//		<td></td>\
//		</tr>\
//		<tr>\
//		<td>\
//		<input class="userlib" type="password" id="passCheck" placeholder="비밀번호 체크" />\
//		</td>\
//		<td><span id="chkPass"></span></td>\
//		</tr>\
//		<tr>\
//		<td>\
//		<input class="userlib" type="email" name="email" placeholder="Example@Example.com" />\
//		</td>\
//		<td><span id="chkEmail"></span></td>\
//		</tr>\
//		</table>\
//		</div>\
//		</form>\
//		<div id="btnArea" style="float:left; margin-left: 40px; margin-top:105px;">\
//	    <button class="btn" id="registBtn"><span class="button__inner">가입</span></button>\
//		</div>';
	
	signupSection.slideToggle('slow');
//	signupSection.html(html);
	
	// form 태그의 엘리먼트 정보 가져오기
	var registBtn = document.querySelector("#registBtn");
	var signid = document.querySelector("input[name='id']");
	var signpass = document.querySelector("input[name='pass']");
	var signpassAgain = document.querySelector("#passCheck");
	var signemail = document.querySelector("input[name='email']");
	var signidChk = document.querySelector("#chkId");
	var signpassChk = document.querySelector("#chkPass");
	var signemailChk = document.querySelector("#chkEmail");

	// id 존재 여부 체크
	$(document).on('keyup', 'input[name="id"]', function() {
		serverCall(ctx + "/user/idCheck", "POST", {"id":signid.value}, "id");
	});

	// email 존재 여부 체크
	$(document).on('keyup', 'input[name="email"]', function() {
//			e.preventDefault();
		var mail = signemail.value;
		var chk = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		console.log(mail.indexOf('.'));	
		console.log(mail.length);
		
		if (mail.length == 0) {
			signemailChk.innerHTML = '';
			return;
		}
		
		if (!chk.test(mail)){
			signemailChk.style.color = 'red';
			signemailChk.innerHTML = '&nbsp;&nbsp;잘못된 주소';
			return;
		}
		serverCall(ctx + "/user/emailCheck", "POST", {"email": signemail.value}, "email");
	});

	// 패스워드 재 확인 체크
	$(document).on('keyup', '#passCheck', function() {
		var color = "";
		var html = "";
		if (signpass.value === signpassAgain.value) {
			color = "green";
			html = "&nbsp;&nbsp;일치";
		} else {
			color = "red";
			html = "&nbsp;&nbsp;불일치";
		}
		signpassChk.innerHTML = "";
		signpassChk.style.color = color;
		signpassChk.innerHTML = html;
	});

	// 가입 버튼 이벤트 처리
	$(registBtn).click(function(e) {
		console.log(signidChk.innerText);
		console.log(signemailChk.innerText);
		
		if (signid.value == "") {
			swal({
				  title: "회원 가입 실패",
				  text: "ID는 필수 입력 사항입니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		} else if (signidChk.innerHTML == '&nbsp;&nbsp;사용 불가') {
			swal({
				  title: "회원 가입 실패",
				  text: "사용 중인 ID로 가입이 불가능 합니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		};
		
		if (signpass.value == "") { 
			swal({
				  title: "회원 가입 실패",
				  text: "패스워드는 필수 입력 사항입니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		} else if (signpass.value != signpassAgain.value) {
			swal({
				  title: "회원 가입 실패",
				  text: "입력하신 패스워드와 확인된 패스워드가 다릅니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		} else if (signpassAgain.innerHTML = '') {
			swal({
				  title: "회원 가입 실패",
				  text: "패스워드를 재 확인 해주세요",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		}
		
		if (signemail.value == "") {
			swal({
				  title: "회원 가입 실패",
				  text: "email은 필수 입력 사항입니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		};
			
		if (signemail.value.search("@") == -1) {
			swal({
				  title: "회원 가입 실패",
				  text: "email 주소에는 @이 포함되어야 합니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		} else if (signemailChk.innerHTML == '&nbsp;&nbsp;사용 불가') {
			swal({
				  title: "회원 가입 실패",
				  text: "사용 중인 email로 가입이 불가능합니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		};
		
		var signForm = $('#sForm').serialize();
		console.log(signForm);
		$.ajax({
			url: ctx + '/user/signup',
			data: signForm,
//				data: {id: signForm.id, pass : signForm.id, email : signForm.email},
			type: 'post',
			success: function(signResult) {
//					swal('가입 시 입력한 이메일 주소를 통해 인증을 완료해 주세요').then((acc) => {
//						location.href = ctx + signResult;
//					});
				swal('가입 시 입력한 이메일 주소를 통해 인증을 완료해 주세요');
			}
			,beforeSend:function(){
				$('.loading').attr('id', '');
			}
			,complete:function(){
				$('.loading').attr('id', 'display-none');
			}
			,error:function() {
				$('.loading').attr('id', 'display-none');
				swal({
					title: '[Anolja 회원 가입]',
					text: '서버 통신 오류로 회원 가입이 실패했습니다.\n다시 시도해 주세요',
					icon: 'error',
					button: '확인',
				});
			}
		});
		
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
	};


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
//						params = `${key}=${options.data[key]}`;
			}
		} 
		
		req.onreadystatechange = function () {
			if (req.readyState == 4 && req.status == 200) {
//		 				var result = JSON.parse(req.responseText);
					checkInfo(requestMsg, req);
			}
		}
		
		if (method == "POST") {
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		}
		
		req.send(method == "POST" ? params : null);
	};
});

