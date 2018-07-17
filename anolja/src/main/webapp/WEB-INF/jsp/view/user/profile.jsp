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
	
	// 프로필 이미지 영역 생성 및 클래스 추가
	var profile = document.createElement('section')
	$(profile).addClass('profile_section');
	// 사이드바 영역 생성 및 클래스 추가
	var sidebar = document.createElement('div');
	$(sidebar).addClass("mypage-sidebar");
	// 사이드 바 내부 목록 영역 생성 및 클래스 추가
	var sidebarnav = document.createElement('ul');
	$(sidebarnav).addClass("mypage-sidebar-nav");
	// file 타입의 input 태그 생성 (영역에서는 숨김 처리)
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
	
	// 되돌리기 버튼
	var reBtn = document.createElement('a');
	$(reBtn).attr('role', 'button');
	$(reBtn).attr('id', 'returnProfile');
	var bType3 = document.createElement('i');
	bType3.setAttribute('class', 'fas fa-undo fa-2x');
	reBtn.appendChild(bType3);
	
	// 비디오 객체 및 스트림 얻기, 캡쳐 버튼 추가
	var video = document.createElement('video');
	$(video).addClass('profileVideo');
	$(video).attr('autoplay', 'autoplay');
	
	var canvasprofile = document.createElement('canvas');
	$(canvasprofile).addClass('profileCanvas');
    var ctxcanvas = canvasprofile.getContext('2d');
    
    var localMediaStream = null;
    
    var captureBtn = document.createElement('button');
    captureBtn.setAttribute('id', 'captureBtn');
    captureBtn.setAttribute('class', 'btn2');
    captureBtn.innerText = "사진찍기";
	
	// 사이드바 메뉴에 들어갈 엘리먼트 작성
	var html = ''; 
	html += '<li><a id="mypage-navbar-toggle">돌아가기<i class="fa fa-bars menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<li><a role="button" id="openFile">파일 불러오기<i class="fa fa-file-alt menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	html += '<li><a role="button" id="openCam">캠 사진찍기<i class="fa fa-camera menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	
	$(sidebarnav).html(html);
	$(sidebar).append(sidebarnav);
	
	$(body).append(profile);
	$(body).append(sidebar);
	
	// 돌아가기 버튼 클릭 시 윈도우 창 닫음
	$('#mypage-navbar-toggle').click(function() {
		window.close();
	})
	
	// 프로필 이미지 영역 생성 및 클래스 적용, 엘리먼트의 자식 객체로 추가
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
	
	// 추가 버튼 클릭 이벤트 및 파일 업로드 처리
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
	
	// 되돌리기 버튼 클릭 이벤트 처리
	$(document).on('click', '#returnProfile', function() {
		getProfile();
		$(upBtn).hide();
		$(reBtn).hide();
	});
	
	// 삭제 버튼 클릭 이벤트 처리 및 삭제 처리
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
	
    // 삭제 처리용 함수
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
	  	// 웹캠 정보 가져오기
	 
		navigator.getUserMedia({video: true}, function(stream) {
		    video.src = window.URL.createObjectURL(stream);
		    localMediaStream = stream;

		    // 미디어 정보가 존재하는 경우에만 브라우저 사이즈를 늘림
		    // 사이즈 확장 후 video, canvas 객체, 버튼 적용
		    window.resizeTo(620, 700);
			$(body).append(video);
			$(body).append(canvasprofile);
			$(body).append(captureBtn);
		  }, function(err) {
// 			  swal("웹캠 정보가 없어 해당 기능은 이용하실 수 없습니다.");
// 			  return false;
		  });
		
		// 에러 발생 시 콜백 함수
	    var errorCallback = function(e) {
	    	 swal("웹캠 정보가 없어 해당 기능은 이용하실 수 없습니다.");
	    };
	    
	    // 스트림객체를 통해 캔버스에 이미지를 그린후
	    // 캔버스의 이미지 정보를 img 태그에 삽입
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
		
// 		  video.addEventListener('click', snapshot, false);
 		  captureBtn.addEventListener('click', snapshot, false);
	});
	
	
	// 최초 윈도우 위치 설정 함수
	function firstPosition() {
		window.resizeTo(620, 290);
		window.moveTo(popupX, popupY);
	}
	</script>