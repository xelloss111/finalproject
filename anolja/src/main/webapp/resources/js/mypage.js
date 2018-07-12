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
//		$(photoIcon).attr('role', 'file');

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
//			console.log("이미지 오버");
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
		}
		
		// fade 토글로 display 처리
		$(mypage).fadeToggle('slow');
	});
}

