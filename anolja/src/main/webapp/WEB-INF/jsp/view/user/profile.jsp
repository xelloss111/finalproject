<%@ page contentType="text/html; charset=UTF-8"%>
	
	<script>
	var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	var sessionId = "${id}";	
	var popupX = ((window.screen.width / 2) / 4) * 3.5;
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= ((window.screen.height / 2) / 4) * 1.5;
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
	// 최초 팝업 오픈 시 사이즈 및 크기 고정
	firstPosition();
	
	var body = document.querySelector('body');
	body.innerHTML = '';
	
	var profile = document.createElement('section')
	$(profile).addClass('profile_section');
	var sidebar = document.createElement('div');
	$(sidebar).addClass("mypage-sidebar");
	var sidebarnav = document.createElement('ul');
	$(sidebarnav).addClass("mypage-sidebar-nav");
	var profileInput = document.createElement('input');
	$(profileInput).addClass('photoInput');
	$(profileInput).attr('type', 'file');
	$(profileInput).attr('name', 'attachFile');
	$(profileInput).attr('id', 'attachFile');
	profileInput.style.display = 'none';
	
	// 등록 버튼
	var upBtn = document.createElement('a');
	$(upBtn).attr('role', 'button');
	$(upBtn).attr('id', 'uploadProfile');
	var bType = document.createElement('i');
	bType.setAttribute('class', 'fas fa-plus-square fa-2x');
	upBtn.appendChild(bType);
	
	// 삭제 버튼
	var delBtn = document.createElement('a');
	$(delBtn).attr('role', 'button');
	$(delBtn).attr('id', 'deleteProfile');
	var bType2 = document.createElement('i');
	bType2.setAttribute('class', 'fas fa-minus-square fa-2x');
	delBtn.appendChild(bType2);
	
	
	// 되돌리기
	var reBtn = document.createElement('a');
	$(reBtn).attr('role', 'button');
	$(reBtn).attr('id', 'returnProfile');
	var bType3 = document.createElement('i');
	bType3.setAttribute('class', 'fas fa-undo fa-2x');
	reBtn.appendChild(bType3);
	
	// 비디오 객체 및 스트림 얻기
	var video = document.createElement('video');
	$(video).addClass('profileVideo');
	$(video).attr('autoplay', 'autoplay');
	var canvasprofile = document.createElement('canvas');
	$(canvasprofile).addClass('profileCanvas');
    var ctxcanvas = canvasprofile.getContext('2d');
    var localMediaStream = null;
	
	
	var html = ''; 
	html += '<li><a id="mypage-navbar-toggle">돌아가기<i class="fa fa-bars menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<li><a role="button" id="openFile">파일 불러오기<i class="fa fa-file-alt menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<li><a role="button" id="openCam">캠 사진찍기<i class="fa fa-camera menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	
	$(sidebarnav).html(html);
	$(sidebar).append(sidebarnav);
	
	$(body).append(profile);
	$(body).append(sidebar);
	
	$('#mypage-navbar-toggle').click(function() {
		window.close();
	})
	
	// 프로필 이미지 영역 생성 및 클래스 적용
	var photoArea = document.createElement('div');
	var photo = document.createElement('img');
	$(photoArea).addClass('photoArea');
	$(photoArea).append(photo);
	$(profile).append(photoArea);
	$(profile).append(profileInput);
	$(profile).prepend(upBtn);
	$(profile).prepend(reBtn);
	$(profile).prepend(delBtn);
	getProfile();
	
	var fileInfo = '';
	// 서버 통신으로 사용자 프로필 이미지 경로가 존재하는지 체크 후 코드 추가
	function getProfile(){
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
					$(delBtn).show();
				}
			}
		});
	};
	
	// 파일 불러오기 버튼 클릭 시 이벤트 발생
	$(document).on('click','#openFile', function() {
		if (document.querySelector('video')) {
			video.pause();
		  	video.src = "";
		  	localMediaStream.getTracks()[0].stop();
		  	$(video).remove();
		  	$(canvasprofile).remove();
		}
		firstPosition();
		$(profileInput).val('');
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
					console.log(f);
					fileInfo = f;
				};
				fr.readAsDataURL(f);
				$(upBtn).show();
				$(reBtn).show();
			};
		});
		$(".photoInput").trigger('click');
	});
	
	$(document).on('click', '#uploadProfile', function() {
		swal({
			  text: '해당 이미지로 정말 등록하시겠습니까?',
			  buttons: {
			    cancel: true,
			    confirm: true,
			  }
			}).then((val) => {
				if (val) {
					uploadFile(fileInfo);
				} else {
					return;
				}
			});
	});
	
	$(document).on('click', '#returnProfile', function() {
		getProfile();
		$(upBtn).hide();
		$(reBtn).hide();
	});
	
	$(document).on('click', '#deleteProfile', function() {
		swal({
			  text: '프로필 이미지를 삭제하고 기본 이미지로 대체하시겠습니까?',
			  buttons: {
			    cancel: true,
			    confirm: true,
			  }
			}).then((val) => {
				if (val) {
					deleteProfile();
				} else {
					return;
				}
			});
	});
	
	
	// 파일 업로드 ajax 처리 함수
	function uploadFile(file) {
		var sendUrl = '';
		var fd = new FormData();
    	if (typeof file !== 'object') {
			sendUrl = ctx + "/user/registProfileBase64Image";
	    	$.ajax({
	    		url: sendUrl,
	    		data: {id : sessionId, fileInfo : file},
	    		type: "POST",
	    		success: function (data) {
	    			if (data.endsWith("완료")) {
	    				swal({
	    					text: data
	    				}).then((val) => {
	    					$(photoArea).attr('id', 'user');
	    					$(photoArea).attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
	
	    				});
	    			} else {
	    				swal({
	    					text: data,
	    					icon: 'error'
	    				});
	    			}
	    		}
	    	});
    	} else {
		    fd.append("id", sessionId);
	    	fd.append("attach", file);
			sendUrl = ctx + "/user/registProfileImage";
	    	$.ajax({
	    		url: sendUrl,
	    		data: fd,
	    		type: "POST",
	    		contentType: false,
	    		processData: false,
	    		success: function (data) {
	    			if (data.endsWith("완료")) {
	    				swal({
	    					text: data
	    				}).then((val) => {
	    					$(photoArea).attr('id', 'user');
	    					$(photoArea).attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
	
	    				});
	    			} else {
	    				swal({
	    					text: data,
	    					icon: 'error'
	    				});
	    			}
	    		}
	    	});    		
    	}
    	
    };
	
	function deleteProfile() {
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
					$(delBtn).hide();
				});
			}
		});
	};
	
	// 웹캠 등록 버튼 이벤트 처리
	$("#openCam").click(function() {
		window.resizeTo(620, 700);

		$(body).append(video);
		$(body).append(canvasprofile);
		
		// 에러 발생 시 콜백 함수
	    var errorCallback = function(e) {
	        console.log('Reeeejected!', e);
	    };
	    
		function snapshot() {
		    if (localMediaStream) {
		      ctxcanvas.drawImage(video, 0, 0, 300, 150);
		      // "image/webp" works in Chrome.
		      // Other browsers will fall back to image/png.
		      fileInfo = canvasprofile.toDataURL('image/jpeg');
		      photo.src = fileInfo;
// 		      var decodeUrl = window.atob(photo.src);
		      console.log(fileInfo);
			  $(upBtn).show();
			  $(reBtn).show();
		    }
		  }
		
		  video.addEventListener('click', snapshot, false);
		
		  // Not showing vendor prefixes or code that works cross-browser.
		  navigator.getUserMedia({video: true}, function(stream) {
		    video.src = window.URL.createObjectURL(stream);
		    localMediaStream = stream;
		  }, errorCallback);
	});
	
	
	// 최초 윈도우 위치
	function firstPosition() {
		window.resizeTo(620, 290);
		window.moveTo(popupX, popupY);
	}
	</script>