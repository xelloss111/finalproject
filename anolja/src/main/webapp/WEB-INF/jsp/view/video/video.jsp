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
						<select class="round" name="tank_list" id="tank_list">
							<option>  저장 리스트 불러오기</option>
							<option value="thank1">  저장소 리스트1 </option>
							<option value="thank2">  저장소 리스트2 </option>
							<option value="thank3">  저장소 리스트3 </option>
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
					<form name="saveTank">
						<div class="save_myTank">
							<ul>
								<li><span>새로운 저장소에 저장 :</span> <input type="text"
									placeholder="    새로운 저장소 이름" name="tankTitle" class="newTank">
								</li>

								<li class="oldTank"><span>기존 저장소에 저장 :</span> <select
									class="round" name="tank_list" id="tank_list">
										<option>저장 리스트 불러오기</option>
										<option value="thank1">저장소 리스트1</option>
										<option value="thank2">저장소 리스트2</option>
										<option value="thank3">저장소 리스트3</option>
								</select></li>

							</ul>
						</div>
						<!-- save_myTank END -->
						<hr>

						<div class="save_info">
							<h2>저장 동영상 정보</h2>
							<!-- script 영역 -->
							<script>
								
								$(document).on("click", ".save_btn", function(){
									var saveImg = '';
									var saveTitle ='';
									var saveImgHtml = '';
									var saveTitleHtml ='';
								
									saveImg = $(this).prev().children('img').attr('src');
									saveTitle = $(this).prev().children('span').text();
									console.log("img : " + saveImg);
									console.log("title : " + saveTitle);
									
									saveImgHtml += '<img src="'+ saveImg +' ">';
									
									$(".save_thumb").html(saveImgHtml);
									
									saveTitleHtml += '<h2>동영상 제목 </h2>';
									saveTitleHtml += '<span>'+ saveTitle +'</span>';
									
									$(".save_titleaddr").html(saveTitleHtml);
								});
							</script>
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

//sessionID 구해오기
var ctx;
$(document).ready(function() {
	ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));	
});
var sessionId = `<%=session.getAttribute("id")%>`;



/////////////// list
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
				
		
// 			$('.lini1-1').click(function(e){
						
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




////////////////////////////////// save 클릭 시 이벤트 동적 처리
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




</script>