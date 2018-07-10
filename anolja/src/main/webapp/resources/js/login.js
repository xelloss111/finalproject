/**
 * 	로그인 처리를 위한 js
 */

// contextPath 가져오기
var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

var signupSection = $('.signup_section');
var loginSection = $('.login_section');

var login = document.querySelector('#login');

login.addEventListener('click', function() {
	if (signupSection.attr("display") != 'none') signupSection.slideUp('slow');
	var html = "";
	html += '<img class="glass" src="'+ ctx +'/resources/images/user/mark_icon_login.png" alt=""\
		  style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">\
		<form id="lForm">\
		<div id="writeArea" style="float:left; margin-top:80px; margin-right:20px;">\
		<table id="writeTable">\
		<tr>\
		<td style="width: 200px; vertical-align=middle;" >\
		<input type="text" name="id" placeholder="id 입력"/>\
		</td>\
		</tr>\
		<tr>\
		<td>\
		<input type="password" name="pass" placeholder="비밀번호 입력" />\
		</td>\
		</tr>\
		</table>\
		</div>\
		<div id="loginArea" style="float:left; margin-left: 40px; margin-top:100px;">\
		<button class="btn2" id="loginBtn"><span class="button__inner">로그인</span></button>\
		</div>\
		<div id="findArea" style="float:left; margin-left: 40px; margin-top:100px;">\
		<button class="btn" id="findIdBtn"><span class="button__inner">ID 찾기</span></button>\
		<button class="btn" id="findPassBtn"><span class="button__inner">PW 찾기</span></button>\
		</div>\
		</form>';
	
	
	loginSection.slideToggle('slow');
	loginSection.html(html);
	
	// form 태그의 엘리먼트 정보 가져오기
	var loginBtn = document.querySelector("#loginBtn");
	var id = document.querySelector("input[name='id']");
	var pass = document.querySelector("input[name='pass']");

	// 로그인 버튼 이벤트 처리
	loginBtn.addEventListener("click", function(e) {
		e.preventDefault();
		
		if (id.value === "") { 
			swal({
				  title: "로그인 실패",
				  text: "ID는 필수 입력 사항입니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		};
		if (pass.value === "") {
			swal({
				  title: "로그인 실패",
				  text: "패스워드는 필수 입력 사항입니다.",
				  icon: "error",
				  button: "돌아가기",
				});
			return;
		};

//		var form = document.querySelector("#lForm");
//		form.setAttribute("action", ctx + "/user/login");
//		form.setAttribute("method", "post");
//		form.submit();
		
		var form = $('#lForm').serialize();
		$.ajax({
			url: ctx + "/user/login",
			type: 'POST',
			data: form,
			success: function(result) {
				if (result.startsWith("/")) {
					location.href = ctx + result;
					return;
				}
				swal({
					  title: "로그인 실패",
					  text: result,
					  icon: "error",
					  button: "돌아가기",
				});
			}
		});
	});
});
