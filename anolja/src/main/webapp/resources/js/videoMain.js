/**
 *  video.jsp메인 
 *  메인에서 저장 아이콘 클릭 시 모달1 발생
 *  동영상 검색
 *  
 */

// 1. sessionID 구해오기 - 관련 코드 baseLayout.jsp 에 있음
//var ctx;
//$(document).ready(function() {
//	ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));	
//});

// 2. 동영상 저장을 위한 변수들
sessionId = `<%=session.getAttribute("id")%>`;
var tankName ='';
var saveVideoImg='';
var saveVideoTitle ='';
var saveVideoUrl ='';
var saveTankName ='';
var saveTankId ='';

// 3. 로그인 하지 않았을 때 첫 화면에서 저장소 정보 불러오지 않기
if(sessionId == 'null') {
	$(".searchList").hide();
};

// 4. 첫 화면에서 유튜브 리스트 불러오기
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
// 4-1. 캐러셀 영역
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
	 					
// 4-2. list 영역
	 					html2 += '<li class="lini1-1">';
	 					html2 += '	<span>';
	 					html2 += '		<img src="' + vimg + '" class="index' + i + '">';
	 					html2 += '		<span class="vidTitle">' + vtitle + '</span>';
	 					html2 += '		<span class="hide_url">' + vurl + '</span>';
	 					html2 += '	</span>';
	 					html2 += '  <button type="submit" value="save" class="sc_btn save_btn"  data-toggle="modal" data-target="#myModal1">';
	 					html2 += '		<i class="far fa-save"></i>';
	 					html2 += '  </button>';
	 					html2 += '</li>';
	 					
	 					$(".clickList").html(html2);
	 					
				};

			videoList();
			
// 5. List 클릭 시 캐러셀 이동
			$(document).on('click','.lini1-1 > span' ,function(){
				var indexSearch = $(this).children('img').attr('class');	
				
				var result = indexSearch.slice(-1);
 					$('.carousel').carousel(parseInt(result));
				});
			
// 6. 동영상 저장 클릭 시 modal1 뜨기
						
			$(document).on("click", ".save_btn", function(){
				var saveImg = '';
				var saveTitle ='';
				var saveUrl ='';
				var saveImgHtml = '';
				var saveTitleHtml ='';			
				
				saveImg = $(this).prev().children('img').attr('src');
				saveTitle = $(this).prev().children('.vidTitle').text();
				saveUrl = $(this).prev().children('.hide_url').text();
				
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

// 7. 돋보기 버튼 클릭 시 검색되도록 
$(".sc_btn").click(function(){
	searchEnter();
});


// 8. input 에서 검색어 쓰고 엔터하면 검색 가능하도록 */
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
					
// 8-1. 기존 캐러셀 삭제 
					html='';
					html2='';
					
// 8-2-1. 리스트 가져오기 
					var result = JSON.parse(searchReq.responseText); 
					var items = result.items;
					var i = 0;	

// 8-2-2. 검색된 영상이 없을 때 얼럿
					
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
// 8-3. 캐러셀 영역
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
			 					
// 8-4. list 영역
			 					html2 += '<li class="lini1-1">';
			 					html2 += '	<span>';
			 					html2 += '		<img src="' + vimg + '" class="index' + i + '">';
			 					html2 += '		<span class="vidTitle">' + vtitle + '</span>';
			 					html2 += '		<span class="hide_url">' + vurl + '</span>';
			 					html2 += '	</span>';
			 					html2 += '  <button type="submit" value="save" class="sc_btn save_btn"  data-toggle="modal" data-target="#myModal1">';
			 					html2 += '		<i class="far fa-save"></i>';
			 					html2 += '  </button>';
			 					html2 += '</li>';
			 					
			 					$(".clickList").html(html2);
						};
						searchVideoList();
					}
			} else {
		        console.log("Error loading page\n");
		      } 
		} 
		searchReq.send(null);
};

// 9. save 아이콘 클릭 시 로그인 요청 이벤트 동적 처리
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


// 10. video 첫 화면에서 내 저장소 select 박스 option 변경 시 리스트 가져오기
var tankInfoHtml = '';
var tankInfoHtml2 = '';	
function chageLangSelect(){

tankInfoHtml = '';
tankInfoHtml2 ='';

var target = document.getElementById("myTank_list");
var selectValue = target.options[target.selectedIndex].value;

if(selectValue!='tank0'){
	$.ajax({
		type: "POST",
		data: {"id":sessionId, 
				"tankId":selectValue},
		url: "viewTankList",
		dataType:"json",
		success: function (list) {
				
					for(var j = 0; j < list.length; j++) {
						var resultTankId= list[j].tankId;
						var resultTankName = list[j].tankName;
						var resulturl = list[j].videoUrl;
						var resultTitle = list[j].videoTitle;
						var resutImg = list[j].videoImg;

							if( j == 0 ) {
								tankInfoHtml += '	<div class="item active"> ';
							} else {							
								tankInfoHtml += '	<div class="item"> ';		
							}
						
// 10-1. 캐러셀 영역
								tankInfoHtml += '		<div class="bannerImage"> ';	
								tankInfoHtml += '			<embed src=' + resulturl + ' style="width:745px; height:419px; left:0px; top:0.46875px;" /> ';	
								tankInfoHtml += '				<div class="caption row-fluid">  ';	
			 					tankInfoHtml += '					<div class="span4">  ';	
			 					tankInfoHtml += '						<h3>' + resultTitle + '</h3>  ';	
			 					tankInfoHtml += '					</div>  ';	
			 					tankInfoHtml += '					<div class="span8">  ';	
			 					tankInfoHtml += '						<h3></h3>  ';	
			 					tankInfoHtml += '					</div>  ';	
			 					tankInfoHtml += '				</div>  ';	
			 					tankInfoHtml += '		</div>  ';	
			 					tankInfoHtml += '	</div>  ';	
								

			 					tankInfoHtml += '<div class="control-box">';
			 					tankInfoHtml += '	<a data-slide="prev" href="#myCarousel" class="carousel-control left">';
			 					tankInfoHtml += '		<i class="far fa-arrow-alt-circle-left fa-2x"></i>';
			 					tankInfoHtml += '	</a>';
			 					tankInfoHtml += '	<a data-slide="next" href="#myCarousel" class="carousel-control right">';
			 					tankInfoHtml += ' 		<i class="far fa-arrow-alt-circle-right fa-2x"></i>';
			 					tankInfoHtml += '	</a>';	 					
			 					tankInfoHtml += '</div>';
			 					
			 					$(".carousel-inner").html(tankInfoHtml);
			 					
//	10-2. list 영역
			 					tankInfoHtml2 += '<li class="lini1-1">';
			 					tankInfoHtml2 += '	<span>';
			 					tankInfoHtml2 += '		<img src="' + resutImg + '" class="index' + j + '">';
			 					tankInfoHtml2 += '		<span class="vidTitle">' + resultTitle + '</span>';
			 					tankInfoHtml2 += '		<span class="hide_url">' + resulturl + '</span>';
			 					tankInfoHtml2 += '	</span>';
			 					tankInfoHtml2 += '  <button type="submit" value="save" class="sc_btn save_btn"  data-toggle="modal" data-target="#myModal1">';
			 					tankInfoHtml2 += '		<i class="far fa-save"></i>';
			 					tankInfoHtml2 += '  </button>';
			 					tankInfoHtml2 += '</li>';
			 					
			 					$(".clickList").html(tankInfoHtml2);
					}
		}				   				   
	});
}
}