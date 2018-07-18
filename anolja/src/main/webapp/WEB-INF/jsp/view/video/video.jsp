<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- video js -->
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoMain.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoModal1.js'></script>
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
							<option value="tank0"> 내 저장 리스트 불러오기</option>
							
							
								<c:forEach var="tankList" items="${tankList}">
									<option value="${tankList.tankId}">${tankList.tankName}</option>
								</c:forEach>
							
						</select>
					</form>
				</li>
				<li class="myTank"  data-toggle="modal" data-target="#myModal2">
					<span>내 저장소 관리</span>
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
	
	
	<!-- 모달 영역 1 -->

	  <!-- 동영상 저장소 -->
	  <div class="modal fade" id="myModal1" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">동영상 저장소</h4>
	        </div>
	        
	        
	        <div class="modal-body">
	        

					<form name="saveTank" id="saveTank">
						<div class="save_myTank">
							<ul>
								<li><span>새로운 저장소 만들기 :</span> 
									<input type="text" placeholder="    새로운 저장소 이름" name="tankName1" class="newTank">
									<input type="button" value=" 추가 " onclick="addOption()" class="newTankBtn">
								</li>

								<li class="oldTank"><span>기존 저장소에 저장 :</span> 
								<select class="round" name="tankName2" id="tank_list">
										<option value="tank0">저장 리스트 불러오기</option>
										
										<c:forEach var="tankList" items="${tankList}">
											<option value="${tankList.tankId}">${tankList.tankName}</option>
										</c:forEach>
								
								</select></li>

							</ul>
						</div>
						<!-- save_myTank END -->
						<hr>

						<div class="save_info">
							<h2>저장 동영상 정보</h2>

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
	          <h4 class="modal-title">My YOUTUBE 저장소</h4>
	        </div>
	        <div class="modal-body">
	          <p>내 저장소 수정, 삭제 기능 추가 예정</p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
</section>

<script>
//1. 모달에서 저장하기 눌렀을 때.

$("#submit").click(function () {
	var target = document.getElementById("tank_list");
	var option = target.options[target.selectedIndex];
	var visible_modal = jQuery('.modal.in').attr('id');
	var resultTankHtml='';

	saveTankId = option.value;
	saveTankName = option.innerText;

// 1-1. 저장소 선택되지 않은 경우
	if(saveTankId=='tank0') {
		swal({
			  text: "저장소를 선택해주세요.",
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
				   "videoUrl":saveVideoUrl},
			url: "videoSave",
			success: function (tankInfo) {
// 1-3.	저장완료 얼럿 후 모달창 닫기
				swal({
					  text: saveTankName+ " 저장소에 저장 완료",
					  icon: "success",
					  button: "닫기",
					}).then((value)=> {
						jQuery('#' + visible_modal).modal('hide');
						return;
					});
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
				  title: "저장소 이름 중복",
				  text: "이미 존재하는 저장소 이름이 있습니다.",
				  icon: "warning",
				  button: "닫기",
				})
					return;
		}
	}
	
// 2-2. 저장소 이름을 지정하지 않았을 때
	if(saveTankName=='') {
		swal({
			  title: "저장소 이름 필요",
			  text: "새로운 저장소의 이름을 지정해주세요.",
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

</script>