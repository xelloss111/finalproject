/**
 * 
 */

var mypage = $('.mypage_section');

if (mypage) {
	$(document).on('click', '#mypage', function() {
		// show 되기 전 내부 html을 지우고 시작
		$(mypage).html('');
		
		// 프로필 이미지 영역 생성 및 클래스 적용
		var photoArea = document.createElement('div');
		var photo = document.createElement('img');
		$(photoArea).addClass('photoArea');
		$(photoArea).append(photo);
		
		// 서버 통신으로 사용자 프로필 이미지 경로가 존재하는지 체크 후 코드 추가
		$.ajax({
			url: ctx + '/user/getUserInfo',
			data: {id : sessionId},
			dataType: 'json',
			success: function(result) {
				if(result.filePath == null) {
					$(photoArea).children('img').attr('id', 'default');
					$(photoArea).children('img').attr('src', ctx + '/resources/images/user/default-profile.png');
				} else {
					$(photoArea).children('img').attr('id', 'user');
					$(photoArea).children('img').attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
				}
				
				if ($(photoArea).children('img').attr('id') == 'user') {
					$(mypage).append(removeIcon);
				}
			}
		});
		
		// id 영역 생성 및 클래스, id 값 적용
		var idArea = document.createElement('div');
		$(idArea).addClass('idArea');
		$(idArea).text(sessionId);
		
		// 버튼 영역 생성 및 클래스 적용
		var btnArea = document.createElement('div');
		var btnList = document.createElement('ul');
		btnArea = $(btnArea).addClass('mypageBtnArea');
		btnArea = $(btnArea).append(btnList);
		btnAreaUl = $(btnArea).children('ul');
		
		var mypagehtml = "";
		mypagehtml = '<li><button class="btn2 changeemailbtn">email 변경</button></li>\
						<li><button class="btn2 changepassbtn">PW 변경</button></li>\
						<li><button class="btn3 logoutbtn">로그아웃</button></li>\
						<li><button class="btn4 secessionbtn">회원탈퇴</button></li>';
		
		btnAreaUl.html(mypagehtml);
				
		// 프로필 이미지 파일 불러오기
		// input type 엘리먼트를 hide하고 버튼 트리거로 클릭 효과를 주기 위해 input 태그 생성
		var photoInput = document.createElement('input');
		var photoIcon = document.createElement('img');
		var addIcon = document.createElement('img');
		var removeIcon = document.createElement('img');
		var fileInfo;
		
		$(photoInput).addClass('photoInput');
		$(photoInput).attr('type', 'file');
		$(photoInput).attr('name', 'attachFile');
		$(photoInput).attr('id', 'attachFile');
		
		$(photoIcon).addClass('photoIcon');
		$(photoIcon).attr('src', ctx + '/resources/images/user/photo.png');
		$(photoIcon).attr('title', '프로필 사진 파일에서 추가');

		$(addIcon).addClass('addIcon');
		$(addIcon).attr('src', ctx + '/resources/images/user/add_icon.png');
		$(addIcon).attr('title', '현재 사진 프로필로 추가');

		$(removeIcon).addClass('removeIcon');
		$(removeIcon).attr('src', ctx + '/resources/images/user/remove_icon.png');
		$(removeIcon).attr('title', '프로필 사진 제거');
		
		// 마이페이지 영역에 엘리멘트 추가
		$(mypage).append(photoArea);
		$(mypage).append(idArea);
		$(mypage).append(btnArea);
		$(mypage).append(photoIcon);
		$(mypage).append(photoInput);
		
		// 프로필 영역 이미지 등록 처리
		$(document).on('dragover', '.photoArea > img', function(event) { 
			return false;
		});
		
		photoArea.ondrop = function (event) {
			$(photoArea).html('');
            var files = event.dataTransfer.files;
            event.preventDefault();
            fileInfo = files[0];
            console.log(fileInfo.name, fileInfo.size);
            $(this).html(`<img id="user" src="${URL.createObjectURL(fileInfo)}">`);
            $(mypage).append(addIcon);
            return false;
        };
		
		
		// 이미지를 파일에서 직접 불러와서 처리
		$(document).on('click', ".photoIcon", function() {
			// 만약 같은 파일 이름을 등록하는 경우 value 값을 공백으로 처리
			$(photoInput).val('');
			$(document).on('click', ".photoInput", function() {
				var file = document.querySelector("#attachFile");
				file.onchange = function () {
					var files = this.files;
					var f = files[0];
					
					// f 파일객체의 내용을 읽기
					var fr = new FileReader();
					
					fr.onload = function () {
						var img = document.createElement("img");
						img.width = 150;
						img.height = 150;
						img.src = fr.result;
						$(photoArea).html('');
						$(photoArea).append(img).attr('id', 'user');
						$(mypage).append(addIcon);
						console.log(f);
						fileInfo = f;
					};
					
					fr.readAsDataURL(f);
				};
			});
			$(".photoInput").trigger('click');
		});
		
		// 파일 업로드 ajax 처리 함수
		function sendFile(file) {
        	var fd = new FormData();
        	fd.append("id", sessionId);
        	fd.append("attach", file);
        	
        	$.ajax({
        		url: ctx + "/user/registProfileImage",
        		data: fd,
        		type: "POST",
        		contentType: false,
        		processData: false,
        		success: function (data) {
        			if (data.endsWith("완료")) {
        				swal({
        					title: '프로필 이미지 등록 성공',
        					text: data,
        					icon: 'success',
        				}).then((val) => {
        					$(photoArea).attr('id', 'user');
        					$(photoArea).attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
        					location.href = ctx + '/main';
        				});
        			} else {
        				swal({
        					title: '프로필 이미지 등록 실패',
        					text: data,
        					icon: 'error',
        				});
        			}
        		}
        	});
        };
		
		// addIcon 클릭 시 서버에 파일 저장
		$(document).on('click', '.addIcon', function() {
			swal({
				  title: '프로필 이미지 등록',
				  text: '해당 이미지로 정말 등록하시겠습니까?',
				  icon: "warning",
				  buttons: {
				    cancel: true,
				    confirm: true,
				  },
				}).then((val) => {
					if (val) {
						sendFile(fileInfo);
					} else {
						return;
					}
				});
		});
		
		// removeIcon 클릭 시 DB 및 서버 삭제
		$(document).on('click', '.removeIcon', function() {
			swal({
				  title: '프로필 이미지 삭제',
				  text: '프로필 이미지를 삭제하고 기본 이미지로 대체하시겠습니까?',
				  icon: "warning",
				  buttons: {
				    cancel: true,
				    confirm: true,
				  },
				}).then((val) => {
					if (val) {
						removeProfile();
					} else {
						return;
					}
				});
		});
		
		function removeProfile() {
			$.ajax({
				url: ctx + '/user/removeProfileImage',
				data: {id : sessionId},
				success: function(result) {
    				swal({
    					title: '프로필 이미지 삭제',
    					text: result,
    					icon: 'success',
    				}).then((val) => {
    					$(photoArea).attr('id', 'default');
    					$(photoArea).attr('src', ctx + '/resources/images/user/default-profile.png');
    					location.href = ctx + '/main';
    				});
				}
			});
		};
		
		// --------------------------------------------------------------------------------------------
		// email 변경 처리
		$('.changeemailbtn').on('click', function() {
			swal({
				  title: "[MyPage Email 변경]",
				  text: "기존 Email 주소를 입력해 주세요",
				  content: {
					  element: "input",
					  attributes: {
						  placeholder: "Email 입력",
						  type: 'text',
					  }
				  },
				  button: {
				    text: "입력",
				    closeModal: false,
				  },
			}).then((lastEmail) => {
				$.ajax({
					url: ctx + "/user/emailCheck",
					type: "post",
					data: {email: lastEmail},
				}).done(function(resEmail) {
					if (!resEmail) {
						return swal({
									icon: "error",
									text: "email 주소가 맞지 않습니다."
						});
					} else {
						swal({
							  title: "[MyPage Email 변경]",
							  text: "변경할 Email 주소를 입력해 주세요",
							  content: {
								  element: "input",
								  attributes: {
									  placeholder: "변경할 Email 입력",
									  type: 'text',
								  }
							  },
							  button: {
							    text: "입력",
							    closeModal: false,
							  },
						}).then((changeEmail) => {
							$.ajax({
								url: ctx + "/user/updateUserEmail",
								type: "post",
								data: {id: sessionId, email: changeEmail},
							}).done(function(result) {
								swal({
									title: '[MyPage Email 변경]',
									text: result,
									icon: 'success',
									button: '닫기',
								});
							}).fail(function() {
								swal({
									title: '[MyPage Email 변경]',
									text: '서버 통신 중 오류 발생으로 변경이 불가능합니다.\n다시 시도해 주세요',
									icon: 'error',
									button: '닫기',
								});
							});
						});
					}
				});
			});
		});
		
		// --------------------------------------------------------------------------------------------
		// 비밀번호 변경 처리
		$(document).on('click', '.changepassbtn', function() {
			swal({
				  title: '[MyPage Password 변경]',
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
				    closeModal: true,
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
									title: "[MyPage Password 변경]",
									icon: "success",
									text: result,
									button: "닫기"
								});
							},beforeSend:function(){
								$('.loading').attr('id', '');
							}
							,complete:function(){
								$('.loading').attr('id', 'display-none');
							}
							,error:function() {
								$('.loading').attr('id', 'display-none');
								swal({
									title: '[MyPage Password 변경]',
									text: '서버 통신 오류로 메일 발송에 실패했습니다.\n다시 시도해 주세요',
									icon: 'error',
									button: '확인',
								});
								location.href = ctx + '/main';
							}
						});
					});
				
				});
		});
		
		// -------------------------------------------------------------------------------------------
		// 로그아웃 처리
		$(document).on('click', '.logoutbtn', function() {
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
		
		// -------------------------------------------------------------------------------------------
		// 회원 탈퇴 처리
		$(document).on('click', '.secessionbtn', function() {
			swal({
				  title: "[Anolja 회원 탈퇴]",
				  text: "회원 탈퇴 시 더 이상 Anolja 서비스를 이용하실 수 없습니다.\n그래도 진행하시겠습니까?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((accept) => {
					if (accept) {
						swal({
							  title: '[Anolja 회원 탈퇴]',
							  text: '본인 확인을 위해 패스워드를 입력해 주세요',
							  content: {
								  element: "input",
								  attributes: {
									  placeholder: "패스워드 입력",
									  type: 'text',
								  }
							  },
							  button: {
							    text: "입력",
							    closeModal: false,
							  },
						}).then((password) => {
							$.ajax({
								url: ctx + '/user/passwordCheck',
								data: {id : sessionId, pass : password},
								type: 'post'
							}).done(function(info) {
								if (!info) {
									return swal('패스워드가 일치하지 않습니다. 다시 진행해 주세요');
								} else {
									swal({
										  title: "[Anolja 회원 탈퇴]",
										  text: "패스워드 확인 완료\n탈퇴를 진행하시겠습니까?",
										  icon: "warning",
										  buttons: true,
										  dangerMode: true,
										}).then((accept) => {
											if(!accept) {
												return swal('회원 탈퇴가 취소되었습니다.');
											} else {
												$.ajax({
													url: ctx + '/user/secessionUser',
													data: {id : sessionId},
													type: 'post'
												}).done(function(path) {
													swal({
														title: "[Anolja를 이용해 주셔서 감사합니다]",
														icon: "success",
														text: "다시 서비스를 이용하고 싶다면\n회원 가입 후 이용해 주세요",
														button: "닫기"
													}).then((end) => {
														location.href = ctx + path;
														return;
													});
												});
											}
										});
								}
							});
						})
					}
				});
		});
		
		
		// fade 토글로 display 처리
		$(mypage).fadeToggle('slow');
	});
}
