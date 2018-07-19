/**
 * 	로그인 처리를 위한 js
 */

// contextPath 가져오기
var signupSection = $('.signup_section');
var loginSection = $('.login_section');

var login = document.querySelector('#login');
var logout = document.querySelector('#logout');

console.log(login, logout);

if (login != null) {
	$(document).on('click', '#login', function() {
		if (signupSection.attr("display") != 'none') signupSection.slideUp('slow');
		var html = "";
		html += '<img class="glass" src="'+ ctx +'/resources/images/user/mark_icon_login.png" alt=""\
			  style="float:left; margin-right: 100px; padding-left:17%; padding-top:50px;">\
			<form id="lForm">\
			<div id="writeArea" style="float:left; margin-top:80px; margin-right:20px;">\
			<table id="writeTable">\
			<tr>\
			<td style="width: 200px; vertical-align=middle;" >\
			<input class="userlib" type="text" name="id" placeholder="id 입력"/>\
			</td>\
			</tr>\
			<tr>\
			<td>\
			<input class="userlib" type="password" name="pass" placeholder="비밀번호 입력" />\
			</td>\
			</tr>\
			</table>\
			</div>\
			</form>\
			<div id="loginArea" style="float:left; margin-left: 40px; margin-top:100px;">\
			<button class="btn2" id="loginBtn"><span class="button__inner">로그인</span></button>\
			</div>\
			<div id="findArea" style="float:left; margin-left: 40px; margin-top:100px;">\
			<button class="btn" id="findIdBtn"><span class="button__inner">ID 찾기</span></button>\
			<button class="btn" id="findPassBtn"><span class="button__inner">PW 찾기</span></button>\
			</div>';
		
		
		loginSection.slideToggle('slow');
		loginSection.html(html);
		
		// form 태그의 엘리먼트 정보 가져오기
		var loginBtn = document.querySelector("#loginBtn");
		var findIdBtn = document.querySelector('#findIdBtn');
		var findPassBtn = document.querySelector('#findPassBtn');
		var loginid = document.querySelector("input[name='id']");
		var loginpass = document.querySelector("input[name='pass']");

		// 로그인 버튼 이벤트 처리
		$(document).on('click', '#loginBtn', function() {
			if (loginid.value === "") { 
				swal({
					  title: "로그인 실패",
					  text: "ID는 필수 입력 사항입니다.",
					  icon: "error",
					  button: "돌아가기",
					});
				return;
			};
			if (loginpass.value === "") {
				swal({
					  title: "로그인 실패",
					  text: "패스워드는 필수 입력 사항입니다.",
					  icon: "error",
					  button: "돌아가기",
					});
				return;
			};

			var lform = $('#lForm').serialize();
			$.ajax({
				url: ctx + "/user/login",
				type: 'post',
				data: lform,
				success: function(result) {
					if (result.startsWith('/')) {
						location.href = ctx + result;
					} else {
						swal({
							title: "로그인 실패",
							text: result,
							icon: "error",
							button: "돌아가기",
						});
					}
				}
			});
		});
		
		// 아이디 찾기 이벤트 처리
		$(findIdBtn).click(function() {
			swal({
				  title: 'ID 찾기',
				  text: '가입 시 작성한 email 주소를 입력해 주세요',
				  content: "input",
				  button: {
				    text: "검색",
				    closeModal: false,
				  },
				}).then(name => {
					$.ajax({
						url: ctx + "/user/findId",
						type: "post",
						data: {email: name},
					}).done(function(result) {
						if (result.search("email") != -1) {
							return swal({
										title: "ID 찾기 실패",
										icon: "error",
										text: result
									});
						}
						swal({
							title: "ID 찾기 성공",
							icon: "success",
							text: "회원님의 아이디는 : [ " + result + " ] 입니다.",
						});
					});
				});	
		});
		
		$(findPassBtn).click(function() {
			swal({
				  title: 'Password 찾기',
				  text: 'ID를 먼저 입력해 주세요',
				  content: {
					  element: "input",
					  attributes: {
						  placeholder: "ID 입력",
						  type: 'text',
					  }
				  },
				  button: {
				    text: "입력",
				    closeModal: false,
				  },
				}).then(id => {
					console.log(id);
					$.ajax({
						url: ctx + "/user/idCheck",
						type: "post",
						data: {id: id},
					}).done(function(resID) {
						if (!resID) {
							return swal({
										icon: "error",
										text: "ID가 맞지 않습니다."
									});
						}
						swal({
							  title: 'Password 찾기',
							  text: 'email을 입력해 주세요',
							  content: {
								  element: "input",
								  attributes: {
									  placeholder: "email 입력",
									  type: 'text',
								  }
							  },
							  button: {
							    text: "입력",
							    closeModal: false,
							  },
							}).then(email => {
								console.log(email);
								$.ajax({
									url: ctx + "/user/emailCheck",
									type: "post",
									data: {email: email},
								}).done(function(resEmail) {
									if (!resEmail) {
										return swal({
													icon: "error",
													text: "email 주소가 맞지 않습니다."
												});
									}
									var temp = JSON.parse(resEmail);
									$.ajax({
										url: ctx + "/user/findPass",
										type: "post",
										data: {email: temp.email},
										success: function(result) {
											swal({
												title: "완료",
												icon: "success",
												text: result,
												button: "닫기"
											});
										}
									});
								});
							
							});
			
						});
				});
		});
	});
}

if (logout != null) {
	$(document).on('click', '#logout', function() {
		swal({
			  title: "로그 아웃",
			  text: "정말 종료하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((accept) => {
			  if (accept) {
			    $.ajax({
			    	url: ctx + "/user/logout",
			    	type: 'post',
			    	data: sessionId
			    }).done(function(result) {
			    	swal("로그아웃 되었습니다.").then((acc) => {location.href = ctx + result;});
			    });
			  } else {
				  return;
			  }
			});
	});
}
