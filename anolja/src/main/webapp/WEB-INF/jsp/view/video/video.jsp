<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoMain.js'></script>
<!-- video css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->

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

					<form name="saveTank" id="saveTank">
						<div class="save_myTank">
							<ul>
								<li><span>새로운 VIDEO BOX 만들기 :</span> 
									<input type="text" placeholder="    새로운 VIDEO BOX 이름" name="tankName1" class="newTank">
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
	        <p>VIDEO BOX 이름을 변경하거나 삭제하실 수 있어요!</p>
	        
	        	<div class="modal2_body">
	        		<ul class="modal2FolderStart">
	        			<c:forEach var="tankList" items="${tankList}">
		        			<li class="folderNoUi"> 
		        				<ul>
		        					<li class="folderTankImg">
		        						<i class="far fa-folder-open"></i>
		        					</li>
		        					<li class="folderTankTitle">
		        						<input type="text" value="${tankList.tankName}" class="folderInput" disabled="disabled"> 
		        						<input type="hidden" value="${tankList.tankId}" class="hdnTankId"> 
		        					</li>
		        					<li	class="folderBtn">
		        						<input type="button" value="변경"  class="updtankBtn">
		        						<input type="button" value="삭제"  class="deltankBtn">
		        					</li>
		        				</ul>
		        			</li>
	        			</c:forEach>
	        		</ul>
	        	</div>
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

//1. 모달에서 저장하기 눌렀을 때.

$("#submit").click(function () {
	var target = document.getElementById("tank_list");
	var option = target.options[target.selectedIndex];
	var visible_modal = jQuery('.modal.in').attr('id');
	var resultTankHtml='';
	var newTankOptionHtml = '';
	var selectBoxResultHtml='';
	var modal2FolderHtml ='';
	
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
// 				console.dir(result);
// 				console.dir(result.length);
// 1-3.	저장완료 얼럿 후 모달창 닫기
				swal({
					  text: saveTankName + " VIDEO BOX에 저장 완료",
					  icon: "success",
					  button: "닫기",
					}).then((value)=> {
						jQuery('#' + visible_modal).modal('hide');
						return;
					});
					
				selectBoxResultHtml += '	<option value="tank0">  MY VIDEO BOX </option> ';

				
				for (var t = 0; t < result.length; t++) {

						// select 박스 시작
						var tankList_tankId = result[t].tankId;
						var tankList_tankName = result[t].tankName;
						
						selectBoxResultHtml += '	<option value="' +tankList_tankId+ '">' +tankList_tankName+ '</option> ';
						// select 박스 끝
						
						// modal2 folder
	        			modal2FolderHtml += '<li class="folderNoUi">';
	        			modal2FolderHtml += '	<ul>';
	        			modal2FolderHtml +=	'		<li class="folderTankImg">';
	        			modal2FolderHtml +=	'			<i class="far fa-folder-open"></i>';
	        			modal2FolderHtml +=	'		</li>';
	        			modal2FolderHtml +=	'		<li class="folderTankTitle">';
	        			modal2FolderHtml +=	'			<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled">';
	        			modal2FolderHtml +=	'			<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId">';
        				modal2FolderHtml +=	'		</li>';
        				modal2FolderHtml +=	'		<li	class="folderBtn">';
        				modal2FolderHtml +=	'			<input type="button" value="변경" class="updtankBtn">';
        				modal2FolderHtml +=	'			<input type="button" value="삭제" class="deltankBtn">';
        				modal2FolderHtml +=	'		</li>';
        				modal2FolderHtml += '	</ul>';
        				modal2FolderHtml += '</li>';
				};
						
				// select 박스 추가해주기
				$("#myTank_list").html(selectBoxResultHtml);
				$(".modal2FolderStart").html(modal2FolderHtml);
			
			}
				   
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
	});

	
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
			
			
// 			var targetTankid = 
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
			        			modal2FolderHtml2 += '<li class="folderNoUi">';
			        			modal2FolderHtml2 += '	<ul>';
			        			modal2FolderHtml2 +=	'		<li class="folderTankImg">';
			        			modal2FolderHtml2 +=	'			<i class="far fa-folder-open"></i>';
			        			modal2FolderHtml2 +=	'		</li>';
			        			modal2FolderHtml2 +=	'		<li class="folderTankTitle">';
			        			modal2FolderHtml2 +=	'			<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled">';
			        			modal2FolderHtml2 +=	'			<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId">';
		        				modal2FolderHtml2 +=	'		</li>';
		        				modal2FolderHtml2 +=	'		<li	class="folderBtn">';
		        				modal2FolderHtml2 +=	'			<input type="button" value="변경" class="updtankBtn">';
		        				modal2FolderHtml2 +=	'			<input type="button" value="삭제" class="deltankBtn">';
		        				modal2FolderHtml2 +=	'		</li>';
		        				modal2FolderHtml2 += '	</ul>';
		        				modal2FolderHtml2 += '</li>';
						};
								
						// select 박스 추가해주기
						$("#myTank_list").html(selectBoxResultHtml2);
						$(".modal2FolderStart").html(modal2FolderHtml2);
						
						//재로딩 끝
						return;
					}
				});
		});
		
		$(document).on('click','.deltankBtn', function(){
			var targetTankid = $($(this).parent().prev().children('.hdnTankId')).val();
			var selectBoxResultHtml3 = '';
			var modal2FolderHtml3 ='';
			
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

						
						for (var t = 0; t < result.length; t++) {

								// select 박스 시작
								var tankList_tankId = result[t].tankId;
								var tankList_tankName = result[t].tankName;
								
								selectBoxResultHtml3 += '	<option value="' +tankList_tankId+ '">' +tankList_tankName+ '</option> ';
								// select 박스 끝
								
								// modal2 folder
			        			modal2FolderHtml3 += '<li class="folderNoUi">';
			        			modal2FolderHtml3 += '	<ul>';
			        			modal2FolderHtml3 +=	'		<li class="folderTankImg">';
			        			modal2FolderHtml3 +=	'			<i class="far fa-folder-open"></i>';
			        			modal2FolderHtml3 +=	'		</li>';
			        			modal2FolderHtml3 +=	'		<li class="folderTankTitle">';
			        			modal2FolderHtml3 +=	'			<input type="text" value="'+tankList_tankName+'" class="folderInput" disabled="disabled">';
			        			modal2FolderHtml3 +=	'			<input type="hidden" value="'+tankList_tankId+'" class="hdnTankId">';
		        				modal2FolderHtml3 +=	'		</li>';
		        				modal2FolderHtml3 +=	'		<li	class="folderBtn">';
		        				modal2FolderHtml3 +=	'			<input type="button" value="변경" class="updtankBtn">';
		        				modal2FolderHtml3 +=	'			<input type="button" value="삭제" class="deltankBtn">';
		        				modal2FolderHtml3 +=	'		</li>';
		        				modal2FolderHtml3 += '	</ul>';
		        				modal2FolderHtml3 += '</li>';
						};
								
						// select 박스 추가해주기
						$("#myTank_list").html(selectBoxResultHtml3);
						$(".modal2FolderStart").html(modal2FolderHtml3);
						
						//재로딩 끝
						}
					});  
				  } else {
				    swal("BOX 삭제 취소!");
				  }
				});
			
		});
		
</script>