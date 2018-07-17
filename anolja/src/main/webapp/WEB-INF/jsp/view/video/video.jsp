<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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
						<select class="round" name="myTank_list" id="myTank_list">
							<option value="tank0"> 내 저장 리스트 불러오기</option>
						</select>
					</form>
				</li>
				<li class="myTank"  data-toggle="modal" data-target="#myModal2">
					<span>내 저장소</span>
				</li>
			</ul>
			
		</div>

		<!-- 캐러셀 영역 시작 -->
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="carousel slide " id="myCarousel" data-interval="false">
						<div class="carousel-inner"></div>
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
			<ul class='clickList'>

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
									<input type="button" value=" 추가 " onclick="addOption()">
								</li>

								<li class="oldTank"><span>기존 저장소에 저장 :</span> <select
									class="round" name="tankName2" id="tank_list">
										<option value="tank0">저장 리스트 불러오기</option>
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
	          <p>Some text in the modal.</p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
</section>



<script>

/////////////////sessionID 구해오기
var ctx;
$(document).ready(function() {
	ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));	
});

///////////////////저장을 위한 변수들

var sessionId = `<%=session.getAttribute("id")%>`;
var tankName ='';
var saveVideoImg='';
var saveVideoTitle ='';
var saveVideoUrl ='';
var saveTankName ='';
var saveTankId ='';

//로그인 하지 않았을 때 첫 화면에서 저장소 정보 불러오지 않기
if(sessionId == 'null') {
	$(".searchList").hide();
};


/////////////// 첫 화면에서 유튜브 리스트 불러오기
var url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=10&playlistId=PLSB4jUMSVNnaGj5Auw93KId3MoYxvrfNQ&key=AIzaSyCiq53GDPhGkdCHDXCHb_LTN9cDj2mMBHQ";
var req = new XMLHttpRequest();
var html = '';
var html2 ='';

req.open('GET', url , true);
req.onreadystatechange = function (aEvt) {
  if (req.readyState == 4) {
     if(req.status == 200)
		var result = JSON.parse(req.responseText); 
		var items = result.items;
		var i = 0;
		
        for ( i = 0; i < items.length; i++){
					
				var vId = items[i].snippet.resourceId.videoId;
				var vurl = "http://www.youtube.com/embed/" + vId;
				var vtitle = items[i].snippet.title;
				var vimg = items[i].snippet.thumbnails.default.url;
				
				function videoList() {	
					if( i == 0 ) {
						html += '	<div class="item active"> ';
					} else {							
						html += '	<div class="item"> ';		
					}
					//캐러셀 영역
						html += '		<div class="bannerImage"> ';	
	 					html += '			<embed src=' + vurl + ' style="width:745px; height:419px; left:0px; top:0.46875px;" /> ';	
	 					html += '				<div class="caption row-fluid">  ';	
	 					html += '					<div class="span4">  ';	
	 					html += '						<h3>' + vtitle + '</h3>  ';	
	 					html += '					</div>  ';	
	 					html += '					<div class="span8">  ';	
	 					html += '						<h3></h3>  ';	
	 					html += '					</div>  ';	
	 					html += '				</div>  ';	
	 					html += '		</div>  ';	
	 					html += '	</div>  ';	
						

	 					html += '<div class="control-box">';
	 					html += '	<a data-slide="prev" href="#myCarousel" class="carousel-control left">';
	 					html += '		<i class="far fa-arrow-alt-circle-left fa-2x"></i>';
	 					html += '	</a>';
	 					html += '	<a data-slide="next" href="#myCarousel" class="carousel-control right">';
	 					html += ' 		<i class="far fa-arrow-alt-circle-right fa-2x"></i>';
	 					html += '	</a>';	 					
	 					html += '</div>';
	 					
	 					$(".carousel-inner").html(html);
	 					
	 					// list 영역
	 					html2 += '<li class="lini1-1">';
	 					html2 += '	<span>';
	 					html2 += '		<img src="' + vimg + '" class="index' + i + '">';
	 					html2 += '		<span>' + vtitle + '</span>';
	 					html2 += '		<span class="hide_url">' + vurl + '</span>';
	 					html2 += '	</span>';
	 					html2 += '  <button type="submit" value="save" class="sc_btn save_btn"  data-toggle="modal" data-target="#myModal1">';
	 					html2 += '		<i class="far fa-save"></i>';
	 					html2 += '  </button>';
	 					html2 += '</li>';
	 					
	 					$(".clickList").html(html2);
	 					
				};

			videoList();
			
			
			
			// List 클릭 시 캐러셀 이동
			$(document).on('click','.lini1-1 > span' ,function(){
				var indexSearch = $(this).children('img').attr('class');	
				
				var result = indexSearch.slice(-1);
 					$('.carousel').carousel(parseInt(result));
				});
			
			///////////////////////// 동영상 저장 클릭 시 모달창
						
			$(document).on("click", ".save_btn", function(){
				var saveImg = '';
				var saveTitle ='';
				var saveUrl ='';
				var saveImgHtml = '';
				var saveTitleHtml ='';			
				
				saveImg = $(this).prev().children('img').attr('src');
				saveTitle = $(this).prev().children('span').text();
				saveUrl = $(this).prev().children('.hide_url').text();
				
				console.log(saveUrl);
				
				saveImgHtml += '<img src="'+ saveImg +'" name="videoImg">';
				
				$(".save_thumb").html(saveImgHtml);
				
				saveTitleHtml += '<h2>동영상 제목 </h2>';
				saveTitleHtml += '<span>'+ saveTitle +'</span>';
				saveTitleHtml += '<h2>동영상 주소 </h2>';
				saveTitleHtml += '<span>'+ saveUrl +'</span>';
				
				$(".save_titleaddr").html(saveTitleHtml);
				 saveVideoImg = saveImg;
				 saveVideoTitle = saveTitle;
				 saveVideoUrl = saveUrl;
				
			});


        }
  }else {
      console.log("Error loading page\n");
  }
};

req.send(null);


/* youtube search */
/* 돋보기 버튼 클릭 */
$(".sc_btn").click(function(){
	searchEnter();
});


/* input 에서 검색어 쓰고 엔터하면 검색 가능하도록 */

$(document).ready(function(){
       $("#videoSearch").keypress(function (e) {
        if (e.which == 13){
        	searchEnter(); 
        }
    });
});



function searchEnter() {
		var value = $('#videoSearch').val();
		var searchUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=viewCount&q="+ value +"&type=video&videoDefinition=high&key=AIzaSyCiq53GDPhGkdCHDXCHb_LTN9cDj2mMBHQ";
		var searchReq = new XMLHttpRequest();
			
		searchReq.open('GET', searchUrl , true);
		searchReq.onreadystatechange = function (aEvt) {
			if (searchReq.readyState == 4) {
				if(searchReq.status == 200)
					
					/* 기존 캐러셀 삭제 */
					html='';
					html2='';
					
					/* 리스트 가져오기 */
					var result = JSON.parse(searchReq.responseText); 
					var items = result.items;
					var i = 0;	
					
					if(result.pageInfo.totalResults == 0){
						swal({
							  title: "검색 실패",
							  text: "검색된 영상이 없습니다.",
							  icon: "error",
							  button: "돌아가기",
							}).then((value)=> {
								$("#videoSearch").focus();
								return;
							});
					};
					
					for ( i = 0; i < items.length; i++){
						
						var vId = items[i].id.videoId;
						var vurl = "http://www.youtube.com/embed/" + vId;
						var vtitle = items[i].snippet.title;
						var vimg = items[i].snippet.thumbnails.default.url;
						
						function searchVideoList() {	
															
							if( i == 0 ) {
								html += '	<div class="item active"> ';
							} else {							
								html += '	<div class="item"> ';		
							}
							//캐러셀 영역
								html += '		<div class="bannerImage"> ';	
			 					html += '			<embed src=' + vurl + ' style="width:745px; height:419px; left:0px; top:0.46875px;" /> ';	
			 					html += '				<div class="caption row-fluid">  ';	
			 					html += '					<div class="span4">  ';	
			 					html += '						<h3>' + vtitle + '</h3>  ';	
			 					html += '					</div>  ';	
			 					html += '					<div class="span8">  ';	
			 					html += '						<h3></h3>  ';	
			 					html += '					</div>  ';	
			 					html += '				</div>  ';	
			 					html += '		</div>  ';	
			 					html += '	</div>  ';	
								

			 					html += '<div class="control-box">';
			 					html += '	<a data-slide="prev" href="#myCarousel" class="carousel-control left">';
			 					html += '		<i class="far fa-arrow-alt-circle-left fa-2x"></i>';
			 					html += '	</a>';
			 					html += '	<a data-slide="next" href="#myCarousel" class="carousel-control right">';
			 					html += ' 		<i class="far fa-arrow-alt-circle-right fa-2x"></i>';
			 					html += '	</a>';	 					
			 					html += '</div>';
			 					
			 					$(".carousel-inner").html(html);
			 					
			 					// list 영역
			 					html2 += '<li class="lini1-1">';
			 					html2 += '	<span>';
			 					html2 += '		<img src="' + vimg + '" class="index' + i + '">';
			 					html2 += '		<span>' + vtitle + '</span>';
			 					html2 += '		<span class="hide_url">' + vurl + '</span>';
			 					html2 += '	</span>';
			 					html2 += '  <button type="submit" value="save" class="sc_btn save_btn"  data-toggle="modal" data-target="#myModal1">';
			 					html2 += '		<i class="far fa-save"></i>';
			 					html2 += '  </button>';
			 					html2 += '</li>';
			 					
			 					$(".clickList").html(html2);
						};

						searchVideoList();
						
					
					}/* for문 끝 */
						
			} else {
		        console.log("Error loading page\n");
		      } /* if문 끝 */
		} /* onreadystatechange 끝  */
		searchReq.send(null);
};


///////////////////////////////////동영상 저장 기능

// var saveListHtml ='';

// $(documnet).on("click","#myModal1", function(){
	

// 	});




////////////////////////////////// save 아이콘 클릭 시 로그인 요청 이벤트 동적 처리
var modalHtml = '';

$(document).on('click','.save_btn' ,function(){
	
	if(sessionId == 'null') {
		$(".modal").remove();
	
		swal({
			  title: "로그인 필요",
			  text: "로그인 후 저장 가능합니다.",
			  icon: "warning",
			  button: "닫기",
			})
				return;
	}
});



/////////// 동영상 저장 모달에서 저장하기 눌렀을 때.

$("#submit").click(function () {
	saveTankName = $(".newTank").val();		
	var target = document.getElementById("tank_list");
	var saveTankSelect = target.options[target.selectedIndex].value;
	
	if(saveTankName=='' & saveTankSelect=='tank0') {
		swal({
			  text: "저장소를 선택해주세요.",
			  icon: "error",
			  button: "닫기",
			})
				return;
	};

	//////////// 서버로 데이터 보내기 ajax
		$.ajax({
			type: "POST",
			data: {"id":sessionId,
					"tankName":saveTankName,
					"tankId":saveTankId,
				   "videoImg": saveVideoImg,
				   "videoTitle":saveVideoTitle,
				   "videoUrl":saveVideoUrl},
			url: "videoSave",
			success: function () {
				swal({
					  text: saveTankName+ " 저장소에 저장 완료",
					  icon: "success",
					  button: "닫기",
					}).then((value)=> {
						$("#myModal1").removeClass('in');
						return;
					});
	
			}
		});
});


////////////// 새로운 저장소 추가
function addOption(){
	saveTankName = $(".newTank").val();	
	var target = document.getElementById("tank_list");
		
    ///// 저장소 이름을 지정하지 않았을 때
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
    
    op.value = 'tank' + frm.tank_list.length; // value
    op.text = saveTankName; // title	  
    
    
    op.selected = true; // 선택된 상태 설정 (기본값은 false이며 선택된 상태로 만들 경우에만 사용)

    frm.tank_list.options.add(op); // 옵션 추가
    //saveTankId 추가
	saveTankId = target.options[target.selectedIndex].value;
	console.log("saveTankId : " + saveTankId);
};	



</script>