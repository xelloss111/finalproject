<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoMain.js'></script>
<!-- video css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">


<section class="content_section">
	<div class="content_row_1">

		<!-- 검색 영역 -->
		<input type="text" id="videoSearch" name="videoSearch"
			placeholder="     YOUTUBE 영상 검색 GO!" />
		<button type="submit" value="Search" class="sc_btn">
			<i class="fas fa-search-plus"></i>
		</button>
		
		<div class="searchList">
			<ul class="list_ul">
				<li class="list_select">
					<form name="lForm" id="lForm" method="post">
						<select class="round" name="myTank_list" id="myTank_list" onchange="chageLangSelect()">

							
						</select>
					</form>
				</li>
				<!-- modal 2 영역 -->
				<li class="myTank"  data-toggle="modal" data-target="#myModal2">
					<span>내 VIDEO BOX 관리</span>
				</li>
			</ul>
			
		</div>

		<!-- 캐러셀 영역 시작 -->
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="carousel slide " id="myCarousel" data-interval="false">
						<div class="carousel-inner" id='carousel-inner'></div>
						<!-- carousel-innerEND -->
					</div>
					<!-- /#myCarousel -->


				</div>
				<!-- /.span12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
		<!-- 캐러셀 영역 끝 -->

		<div class="thumb_imgs">
			<ul class='clickList' id="clickList">

			</ul>
		</div>


	</div>
	<!-- content_row_1 END -->
	
	
	<!-- 모달 1 영역-->

	  <!-- 동영상 저장소 -->
	  <div class="modal fade" id="myModal1" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">VIDEO BOX</h4>
	        </div>
	        
	        
	        <div class="modal-body">
	        <p>VIDEO BOX를 생성 후 동영상을 저장하거나 가지고 있는 BOX에 동영상을 담아주세요!</p>
	        <p>BOX 이름은 열글자를 넘길 수 없습니다!</p>

					<form name="saveTank" id="saveTank">
						<div class="save_myTank">
							<ul>
								<li><span>새로운 VIDEO BOX 만들기 :</span> 
									<input type="text" placeholder="    새로운 VIDEO BOX 이름" name="tankName1" class="newTank" maxlength="10">
									<input type="button" value=" 생성 " onclick="addOption()" class="newTankBtn">
								</li>

								<li class="oldTank"><span>MY VIDEO BOX :</span> 
								<select class="round" name="tankName2" id="tank_list">
										<option value="tank0">VIDEO BOX LIST</option>
										
										<c:forEach var="tankList" items="${tankList}">
											<option value="${tankList.tankId}">${tankList.tankName}</option>
										</c:forEach>
								
								</select></li>

							</ul>
						</div>
						<!-- save_myTank END -->
						<hr>

						<div class="save_info">
							<h2>저장 VIDEO 정보</h2>

							<ul>
								<li class="save_thumb">
									<!-- 여기가 섬네일 위치 -->
								</li>
								<li class="save_titleaddr">
									
									<!-- 여기가 제목 위치 -->
								</li>
							</ul>
						</div>
						<!-- save_info END -->
						<div class="save_list_btn">
							<input type="button" class="btn btn-primary" value="저장하기"
							id="submit">
						</div>
					</form>

				</div>
	        <!-- modal-body END-->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>	
	<!-- 모달1 영역 끝 -->
	
	
	<!-- 모달 영역 2 -->
	<!-- 내 동영상 LIST -->
	  <div class="modal fade" id="myModal2" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">My VIDEO BOX</h4>
	        </div>
	        <div class="modal-body">
	        <p>VIDEO BOX 이름을 변경/삭제하거나 BOX에 모아둔 동영상을 삭제 하실 수 있어요!</p>
	        
	        	<div class="modal2_body">
									<div id="accordion">
	        					<c:forEach var="tankList" items="${tankList}">
									<!-- 내 동영상 box -->
										<div class="boxListDiv"><!-- 동영상 box 리스트 반복 만들어주기 -->
											<ul class='togui'> 
				        						<li class="folderTankImg">
				        							<i class="far fa-folder"></i>
				        							<i class="far fa-folder-open"></i>
				        						</li>
				        						<li class="folderTankTitle">
				        							<input type="text" value="${tankList.tankName}" class="folderInput" disabled="disabled" maxlength="10"> 
				        							<input type="hidden" value="${tankList.tankId}" class="hdnTankId"> 
				        						</li>
				        						<li	class="folderBtn">
				        							<input type="button" value="변경"  class="updtankBtn">
				        							<input type="button" value="삭제"  class="deltankBtn">
				        						</li>
		        							</ul>
										</div>
										<!-- 각 박스 안의 동영상들  -->
										<div id="videoListHide">
											<!-- 클릭한 저장소에 있는 동영상 리스트  -->
											<ul class="seldelvideo"> 
												<c:forEach var="delList" items="${delList}">
													<c:if test="${delList.tankId == tankList.tankId}">
							        					<li class="videoImg">
							        						<img src="${delList.videoImg}" class="hdnImg"/>
							        					</li>
							        					<li class="selVideoTitle">
							        						<input type="text" value="${delList.videoTitle}" class="folderInput" disabled="disabled"> 
							        						<input type="hidden" value="${delList.tankId}" class="hdnTankId"> 
							        						<input type="hidden" value="${delList.videoNo}" class="hdnVideoNo"> 
							        					</li>
							        					<li	class="selvideoBtnArea">
							        						<input type="button" value="삭제"  class="delVideoBtn">
							        					</li>
							        				</c:if>
					        					</c:forEach>
			        						</ul>
										</div><!-- videoListHide EDN -->
			        			</c:forEach>
									</div><!-- accordionEND -->
	        	</div><!-- modal2_body -->
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
</section>

<script>

// select영역 정보 json으로 뽑기
var resultselbox = new Array();

$(function() {
		<c:forEach var="tankList" items="${tankList}">
			var json = new Object();
			json.tankId = "${tankList.tankId}";
			json.tankName = "${tankList.tankName}";
			resultselbox.push(json);
		</c:forEach>
});

// 모든 동영상 정보
var resultdelbox = new Array();

$(function() {
		<c:forEach var="delList" items="${delList}">
			var json = new Object();
			json.tankId = "${delList.tankId}";
			json.tankName = "${delList.tankName}";
			json.videoNo = "${delList.videoNo}";
			json.videoTitle = `${delList.videoTitle}`;
			json.videoImg = "${delList.videoImg}";
			resultdelbox.push(json);
		</c:forEach>
});

//1. 모달에서 저장하기 눌렀을 때.

$("#submit").click(function () {
	var target = document.getElementById("tank_list");
	var option = target.options[target.selectedIndex];
	var visible_modal = jQuery('.modal.in').attr('id');
	var resultTankHtml='';
	var newTankOptionHtml = '';
	var selectBoxResultHtml='';
	var modal2FolderHtml ='';
	var videoDelHtml ='';

	
	saveTankId = option.value;
	saveTankName = option.innerText;

// 1-1. 저장소 선택되지 않은 경우
	if(saveTankId=='tank0') {
		swal({
			  text: "VIDEO BOX를 선택해주세요.",
			  icon: "error",
			  button: "닫기",
			})
				return;
	};

// 1-2. 서버로 데이터 보내기 ajax
		$.ajax({
			type: "POST",
			data: {"id":sessionId,
					"tankName":saveTankName,
					"tankId":saveTankId,
				   "videoImg": saveVideoImg,
				   "videoTitle":saveVideoTitle,
				   "videoUrl":saveVideoUrl
				   },
			url: "videoSave",
			dataType:"json",
			success: function (result) {

// 1-3.	저장완료 얼럿 후 모달창 닫기
				swal({
					  text: saveTankName + " VIDEO BOX에 저장 완료",
					  icon: "success",
					  button: "닫기",
					}).then((value)=> {
						jQuery('#' + visible_modal).modal('hide');
						return;
					});

				//main selectbox
				selectBoxResultHtml += '	<option value="tank0">  MY VIDEO BOX </option> ';
				// select 박스 추가해주기
				$("#myTank_list").html(selectBoxResultHtml);
				
				for (var t = 0; t < result.length; t++) {

						// select 박스 시작
						var tankList_tankId = result[t].tankId;
						var tankList_tankName = result[t].tankName;
						
        				// 내 VIDEO BOX
        				modal2FolderHtml += '	<div class="boxListDiv">';
        				modal2FolderHtml += '		<ul class="togui">'; 
        				modal2FolderHtml += '			<li class="folderTankImg">';
        				modal2FolderHtml += '				<i class="far fa-folder"></i>';
        				modal2FolderHtml += '				<i class="far fa-folder-open"></i>';
        				modal2FolderHtml += '			</li>';		
        				modal2FolderHtml += '			<li class="folderTankTitle">';		
        				modal2FolderHtml += '				<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled" maxlength="10"> ';	
        				modal2FolderHtml += '				<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId"> ';	
        				modal2FolderHtml += '			</li>';		
        				modal2FolderHtml += '			<li class="folderBtn">';		
        				modal2FolderHtml += '				<input type="button" value="변경"  class="updtankBtn">';		
        				modal2FolderHtml += '				<input type="button" value="삭제"  class="deltankBtn">';		
        				modal2FolderHtml += '			</li>';		
        				modal2FolderHtml += '		</ul>';						 
        				modal2FolderHtml += '	</div>';

        				modal2FolderHtml += '	<div id="videoListHide">';
        				
					for (var v = 0; v < resultdelbox.length; v++) {
						// BOX 안의 동영상 리스트 
							var deleteImgList = resultdelbox[v].videoImg;
							var deleteNoList = resultdelbox[v].videoNo;
							var deleteTitleList = resultdelbox[v].videoTitle;
							var deleteTankIdList = resultdelbox[v].tankId;
						
						if(deleteTankIdList == tankList_tankId) {
						
							modal2FolderHtml += '		<ul class="seldelvideo">';
							modal2FolderHtml += '			<li class="videoImg">';
							modal2FolderHtml += '				<img src="'+ deleteImgList +'" class="hdnImg"/>';
							modal2FolderHtml += '			</li>';
							modal2FolderHtml += '			<li class="selVideoTitle">';
							modal2FolderHtml += '				<input type="text" value="' + deleteTitleList +'" class="folderInput" disabled="disabled">';
							modal2FolderHtml += '				<input type="hidden" value="' + deleteTankIdList +'" class="hdnTankId">';
							modal2FolderHtml += '				<input type="hidden" value="' + deleteNoList + '" class="hdnVideoNo"> ';
							modal2FolderHtml += '			</li> ';
							modal2FolderHtml += '			<li class="selvideoBtnArea"> ';
							modal2FolderHtml += '				<input type="button" value="삭제"  class="delVideoBtn"> ';
							modal2FolderHtml += '			</li> ';
							modal2FolderHtml += '		</ul> ';
							}//if추가
							
						};//동영상 추가 for
						
						modal2FolderHtml += '	</div> ';
        				//select 추가
        				selectBoxResultHtml += '	<option value="' +tankList_tankId+ '">' +tankList_tankName+ '</option> ';

        				
				};//폴더 for
				
				//저장소의 동영상 리스트
				
				$("#myTank_list").html(selectBoxResultHtml);
				$("#accordion").html(modal2FolderHtml);
				
				//아코디언 리프레쉬
				$('#accordion').accordion("refresh");  
			}//success
		});
				   
});

// 2. 새로운 저장소 추가
function addOption(){
	saveTankName = $(".newTank").val();	
	var target = document.getElementById("tank_list");
	var test = target.options[target.selectedIndex].text;	

// 2-1. 지정한 저장소 이름이 중복일 때
	for(var k=0; k < target.length; k++) {
		if(target[k].innerText == saveTankName ) {
			swal({
				  title: "VIDEO BOX 이름 중복",
				  text: "이미 존재하는 VIDEO BOX 이름이 있습니다.",
				  icon: "warning",
				  button: "닫기",
				})
					return;
		}
	}
	
// 2-2. 저장소 이름을 지정하지 않았을 때
	if(saveTankName=='') {
		swal({
			  title: "VIDEO BOX 이름 필요",
			  text: "새로운 BOX의 이름을 지정해주세요.",
			  icon: "warning",
			  button: "닫기",
			})
				return;
	};

	
    var frm = document.saveTank;
    var op = new Option();

// 2-3. 저장소ID 생성해주기
    op.value = 'tank' + frm.tank_list.length;
// 2-4. 저장소 이름
    op.text = saveTankName;	  
// 2-5. select option 선택된 상태 설정 (기본값은 false이며 선택된 상태로 만들 경우에만 사용) 
    op.selected = true;
// 2-6. option 추가
    frm.tank_list.options.add(op); 
// 2-7. saveTankId 를 변수에 담아주기
	saveTankId = target.options[target.selectedIndex].value;
};	


var inputVal = '';
$(document).on('click', '.updtankBtn', function(){
	//버튼 토글을 위한 노드 찾기
	inputVal = $($(this).parent().prev().children()).val();
	console.log("inputVal : " + inputVal);
	
	//버튼 토글
	var targetBtn = $(this);
	console.log("targetBtn : " + targetBtn);
	
	//input disabled 풀어주기
	$($(this).parent().prev().children()).attr('disabled', false);
	$($(this).parent().prev().children()).focus();
	
});			
	
	$('body').on('keydown','.folderInput', function(){
		$(this).parent().next().children(".updtankBtn").attr("class","secBtn").val("완료");
		$(this).parent().next().children(".deltankBtn").attr("class","backBtn").val("취소");
	});
		// BOX 이름 저장 취소 클릭
		$(document).on('click','.backBtn', function(){
			$('.secBtn').attr("class","updtankBtn").val("변경");
			$('.backBtn').attr("class","deltankBtn").val("삭제");
			$('.folderInput').attr('disabled', true);
		});
		
		// BOX 이름 변경 시도
		$(document).on('click','.secBtn', function(){
			var selectBoxResultHtml2 = '';
			var modal2FolderHtml2 ='';
			
			var newTankName = $($(this).parent().prev().children('.folderInput')).val();
			var targetTankid = $($(this).parent().prev().children('.hdnTankId')).val();
			
			//이름을 안쓰고 완료했을 때 경고.
			if(newTankName=='') {
				swal({
					  title: "VIDEO BOX 이름 필요",
					  text: "새로운 BOX의 이름을 지정해주세요.",
					  icon: "warning",
					  button: "닫기",
					})
						return;
			};
			
			
				// 저장소 이름 변경을 위해 서버로 보내기
				$.ajax({
					type: "POST",
					data: {"id":sessionId,
							"tankName":newTankName,
							"tankId":targetTankid
						   },
					url: "changeNewTankName",
					dataType:"json",
					success: function (result) {
						swal({
								text: "BOX 이름 변경 완료!",
								icon: "success",
								button: "닫기",
							});
						
						$('.secBtn').attr("class","updtankBtn").val("변경");
						$('.folderInput').attr('disabled', true);
						
						// main 화면에 바뀐 저장소 이름으로 재로딩
						selectBoxResultHtml2 += '	<option value="tank0"> MY VIDEO BOX </option> ';

						
						for (var t = 0; t < result.length; t++) {

								// select 박스 시작
								var tankList_tankId = result[t].tankId;
								var tankList_tankName = result[t].tankName;
								
								selectBoxResultHtml2 += '	<option value="' +tankList_tankId+ '">' +tankList_tankName+ '</option> ';
								// select 박스 끝
								
								// modal2 folder
		        				// 내 VIDEO BOX
		        				modal2FolderHtml2 += '<div class="boxListDiv">';
		        				modal2FolderHtml2 += '	<ul class="togui">'; 
		        				modal2FolderHtml2 += '		<li class="folderTankImg">';
		        				modal2FolderHtml2 += '			<i class="far fa-folder"></i>';
		        				modal2FolderHtml2 += '			<i class="far fa-folder-open"></i>';
		        				modal2FolderHtml2 += '		</li>';		
		        				modal2FolderHtml2 += '		<li class="folderTankTitle">';		
		        				modal2FolderHtml2 += '			<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled" maxlength="10"> ';	
		        				modal2FolderHtml2 += '			<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId"> ';	
		        				modal2FolderHtml2 += '		</li>';		
		        				modal2FolderHtml2 += '		<li class="folderBtn">';		
		        				modal2FolderHtml2 += '			<input type="button" value="변경"  class="updtankBtn">';		
		        				modal2FolderHtml2 += '			<input type="button" value="삭제"  class="deltankBtn">';		
		        				modal2FolderHtml2 += '		</li>';		
		        				modal2FolderHtml2 += '	</ul>';						 
		        				modal2FolderHtml2 += '</div>';	
						};
								
						// select 박스 추가해주기
						$("#myTank_list").html(selectBoxResultHtml2);
						$("#accordion").html(modal2FolderHtml2);
						
						//재로딩 끝
						return;
					}
				});
		});
		
		$(document).on('click','.deltankBtn', function(){
			var targetTankid = $($(this).parent().prev().children('.hdnTankId')).val();
			var selectBoxResultHtml3 = '';
			var modal2FolderHtml3 ='';
			var selectModal1Box ='';
			
			swal({
				  title: "정말로 BOX를 삭제할까요?",
				  text: "BOX를 삭제하면 저장된 동영상이 모두 삭제됩니다.",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					  
					  /* 유저 삭제 요청 */
					$.ajax({
						type: "POST",
						data: {"id":sessionId,
								"tankId":targetTankid
							   },
						url: "delTank",
						dataType:"json",
						success: function (result) {
							swal("BOX를 삭제했습니다.", {
							      icon: "success",
							    });
							
							// 삭제 후 재로딩
							// main 화면에 바뀐 저장소 이름으로 재로딩
						selectBoxResultHtml3 += '	<option value="tank0"> MY VIDEO BOX </option> ';
						//modal1 selectbox
		 				selectModal1Box = '<option value="tank0">VIDEO BOX LIST</option>';
						
						for (var t = 0; t < result.length; t++) {

								// select 박스 시작
								var tankList_tankId = result[t].tankId;
								var tankList_tankName = result[t].tankName;
								
								selectBoxResultHtml3 += '	<option value="' + tankList_tankId+ '">' +tankList_tankName+ '</option> ';
								// select 박스 끝
								
								//modal1에 있는 my video list select box
								selectModal1Box += '	<option value="' +tankList_tankId+ '">' +tankList_tankName+ '</option> ';
								
								// modal2 folder
		        				modal2FolderHtml3 += '<div class="boxListDiv">';
		        				modal2FolderHtml3 += '	<ul class="togui">'; 
		        				modal2FolderHtml3 += '		<li class="folderTankImg">';
		        				modal2FolderHtml3 += '			<i class="far fa-folder"></i>';
		        				modal2FolderHtml3 += '			<i class="far fa-folder-open"></i>';
		        				modal2FolderHtml3 += '		</li>';		
		        				modal2FolderHtml3 += '		<li class="folderTankTitle">';		
		        				modal2FolderHtml3 += '			<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled" maxlength="10"> ';	
		        				modal2FolderHtml3 += '			<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId"> ';	
		        				modal2FolderHtml3 += '		</li>';		
		        				modal2FolderHtml3 += '		<li class="folderBtn">';		
		        				modal2FolderHtml3 += '			<input type="button" value="변경"  class="updtankBtn">';		
		        				modal2FolderHtml3 += '			<input type="button" value="삭제"  class="deltankBtn">';		
		        				modal2FolderHtml3 += '		</li>';		
		        				modal2FolderHtml3 += '	</ul>';						 
		        				modal2FolderHtml3 += '</div>';	
						};
								
						// select 박스 추가해주기
						$("#myTank_list").html(selectBoxResultHtml3);
						$("#accordion").html(modal2FolderHtml3);
		 				$("#tank_list").html(selectModal1Box);
						
						//재로딩 끝
						}
					});  
				  } else {
				    swal("BOX 삭제 취소!");
				  }
				});
			
		});
/* 동영상 관리 */
$(document).on("click",".delVideoBtn", function(){
	//삭제 후 처리를 위한 this 기억해놓기
	var targetBtn = $(this); 
	
    // 저장소 정보 가져오기
    var videoNo = $(this).parent().prev().children('.hdnVideoNo').val();
    
    // 부모 저장소의 tankId
    var selectTankID = $(this).parent().parent().parent().prev().children().children('.folderTankTitle').children('.hdnTankId').val();
    
    console.log("클릭한 videoNo :"+  videoNo);
    console.log("클릭한 tankID :"+  selectTankID);
    
    // 담아서 뿌려줄 HTML

    //video영역
    var videoDelHtml ='';
	
    $.ajax({
    	type: "POST",
		data: {"id":sessionId,
				"videoNo":videoNo
			   },
		url: "selectDalVideo",
		dataType:"json",
		success: function (resultdelbox) {
			swal({
				text: "동영상 삭제 완료!",
				icon: "success",
				button: "닫기",
			});//swal 끝
			
			//삭제 처리 후 html 
			
			
			// BOX 안의 동영상 리스트
			for (var v = 0; v < resultdelbox.length; v++) {
				var deleteImgList = resultdelbox[v].videoImg;
				var deleteNoList = resultdelbox[v].videoNo;
				var deleteTitleList = resultdelbox[v].videoTitle;
				var deleteTankIdList = resultdelbox[v].tankId;
				
		
				//저장소의 동영상 리스트
				if(deleteTankIdList == selectTankID) {
					
					videoDelHtml += '<li class="videoImg">';
					videoDelHtml += '	<img src="'+ deleteImgList +'" class="hdnImg"/>';
					videoDelHtml += '</li>';
					videoDelHtml += '<li class="selVideoTitle">';
					videoDelHtml += '	<input type="text" value="' + deleteTitleList +'" class="folderInput" disabled="disabled">';
					videoDelHtml += '	<input type="hidden" value="' + deleteTankIdList +'" class="hdnTankId">';
					videoDelHtml += '	<input type="hidden" value="' + deleteNoList + '" class="hdnVideoNo"> ';
					videoDelHtml += '</li> ';
					videoDelHtml += '<li class="selvideoBtnArea"> ';
					videoDelHtml += '<input type="button" value="삭제"  class="delVideoBtn"> ';
					videoDelHtml += '</li> ';
				}
			}
					targetBtn.parent().parent().html(videoDelHtml);
			}//success
    	
    });
});

////////////////

  $( function() {
    $( "#accordion" ).accordion({
      collapsible: true
    });
  });


</script>