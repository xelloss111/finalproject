<%@ page contentType="text/html; charset=UTF-8"%>


	<script>
	
	
	var mypageHtml = '';
	mypageHtml += '<section class="profile_section">';
	mypageHtml += '<a id="deleteProfile" role="button">';
	mypageHtml += '<i class="fas fa-minus-square fa-2x"></i></a>';
	mypageHtml += '<a id="returnProfile" role="button">';
	mypageHtml += '<i class="fas fa-undo fa-2x"></i></a>';
	mypageHtml += '<a id="uploadProfile" role="button">';
	mypageHtml += '<i class="fas fa-plus-square fa-2x"></i></a>';
	mypageHtml += '<div class="photoArea">';
	mypageHtml += '<img id="user" src="/anolja/user/viewProfileImage?id=rama">';
	mypageHtml += '</div>';
	mypageHtml += '<input name="attachFile" class="photoInput" id="attachFile" ';
	mypageHtml += 'style="display: none;" type="file">';
	mypageHtml += '</section>';
	mypageHtml += '<div class="mypage-sidebar">';
	mypageHtml += '<ul class="mypage-sidebar-nav">';
	mypageHtml += '<li><a id="mypage-navbar-toggle">돌아가기';
	mypageHtml += '<i class="fa fa-bars menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	mypageHtml += '<li><a id="openFile" role="button">파일 불러오기';
	mypageHtml += '<i class="fa fa-file-alt menu-icon fa-2x" aria-hidden="true"></i></a></li>';
	mypageHtml += '<li><a id="openCam" role="button">캠 사진찍기';
	mypageHtml += '<i class="fa fa-camera menu-icon fa-2x" aria-hidden="true"></i></a></li></ul></div>';
	mypageHtml += '<section class="cam_section">';
	mypageHtml += '<video height="426" width="570" controls autoplay style="width: 99px; height: 75px;'
		       +  ' display: none;"></video>';
	mypageHtml += `<a href="javascript:" class="btn" onclick="App.start('glasses');">Glasses!</a>`;
	mypageHtml += `<a href="javascript:" class="btn" onclick="App.start('hipster');">Hipster!</a>`;
	mypageHtml += `<a href="javascript:" class="btn" onclick="App.start('blur');">Blurr!</a>`;
	mypageHtml += `<a href="javascript:" class="btn" onclick="App.start('greenscreen');">Color Me!</a>`;
	mypageHtml += '<canvas id="output" height="426" width="515"></canvas>';
	mypageHtml += '<div class="colours" style="display:none;">';
	mypageHtml += '<div id="red">';
	mypageHtml += '<input type="range" min=0 max=255 value=190 class="min">';
	mypageHtml += '<input type="range" min=0 max=255 value=240 class="max">';
	mypageHtml += '</div>';
	mypageHtml += '<div id="green">';
	mypageHtml += '<input type="range" min=0 max=255 value=0 class="min">';
	mypageHtml += '<input type="range" min=0 max=255 value=120 class="max">';
	mypageHtml += '</div>';
	mypageHtml += '<div id="blue">';
	mypageHtml += '<input type="range" min=0 max=255 value=90 class="min">';
	mypageHtml += '<input type="range" min=0 max=255 value=190 class="max"></div></div></section>';
	
	var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	var sessionId = "${id}";	
	var popupX = ((window.screen.width /2) / 4) * 3.5;
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= ((window.screen.height /2) / 4) * 1.5;
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	
	// 최초 팝업 오픈 시 사이즈 및 크기 고정
	firstPosition();
	
	var body = document.querySelector('body');
	var head = document.querySelector('head');
	
	$(head).eq(15).remove();
	body.innerHTML = '';
	$(body).html(mypageHtml);
	
    var localMediaStream = null;

	
	// 돌아가기 버튼 클릭 시 윈도우 창 닫음
	$('#mypage-navbar-toggle').click(function() {
		window.close();
	})
	
	var fileInfo = '';
	// 서버 통신으로 사용자 프로필 이미지 경로가 존재하는지 체크 후 코드 추가
	function getProfile(){
		$.ajax({
			url: ctx + '/user/getUserInfo',
			data: {id : sessionId},
			dataType: 'json',
			success: function(result) {
				if(result.filePath == null) {
					$('.photoArea').children('img').attr('id', 'default');
					$('.photoArea').children('img').attr('src', ctx + '/resources/images/user/default-profile.png');
				} else {
					$('.photoArea').children('img').attr('id', 'user');
					$('.photoArea').children('img').attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
					$('#deleteProfile').show();
				}
			}
		});
	};
	
	// 파일 불러오기 버튼 클릭 시 이벤트 발생
	$(document).on('click','#openFile', function() {
		$('.photoInput').val('');
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
					$('.photoArea').html('');
					$('.photoArea').append(img).attr('id', 'user');
					console.log(f);
					fileInfo = f;
				};
				fr.readAsDataURL(f);
				$('#uploadProfile').show();
				$('#returnProfile').show();
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
		$('#uploadProfile').hide();
		$('#returnProfile').hide();
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
	    					$('.photoArea').attr('id', 'user');
	    					$('.photoArea').attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
	
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
	    					$('.photoArea').attr('id', 'user');
	    					$('.photoArea').attr('src', ctx + '/user/viewProfileImage?id='+sessionId);
	
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
//  		  captureBtn.addEventListener('click', snapshot, false);
	});
	
	
	// 최초 윈도우 위치 설정 함수
	function firstPosition() {
		window.resizeTo(620, 700);
		window.moveTo(popupX, popupY);
	}
	</script>