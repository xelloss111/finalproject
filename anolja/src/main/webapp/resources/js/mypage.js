/**
 * 
 */

var mypage = $('.mypage_section');

if (mypage) {
	$('#mypage').click(function() {
		// show 되기 전 내부 html을 지우고 시작
		$(mypage).html('');
		
		// 프로필 이미지 영역 생성 및 클래스 적용
		var photoArea = document.createElement('div');
		var photo = document.createElement('img');
		$(photoArea).addClass('photoArea');
		$(photoArea).append(photo);
		
		// 서버 통신으로 사용자 프로필 이미지 경로가 존재하는지 체크 후 코드 추가
//		$(photoArea).children('img').attr('id', 'default');
		$(photoArea).children('img').attr('src', ctx + '/resources/images/user/default-profile.png');
		
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
            for (var i = 0; i < files.length; i++) {
                console.log(files[i].name, files[i].size);
                $(this).html(`<img id="user" src="${URL.createObjectURL(files[i])}">`);
                // 서버에 파일 저장하기
//                sendFile(files[i]);
            }
            $(mypage).append(addIcon);
            return false;
        }
		
		
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
					};
					
					fr.readAsDataURL(f);
				};
			});
			$(".photoInput").trigger('click');
		});
			
		// fade 토글로 display 처리
		$(mypage).fadeToggle('slow');
	});
}

