<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<section class="content_section">
	<div class="content_row_1">
	<!-- 캐러셀 영역 시작 -->
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="carousel slide " id="myCarousel"  data-interval="false">
						<div class="carousel-inner">


						</div><!-- carousel-innerEND -->
					</div><!-- /#myCarousel -->
						

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
</section>



<script>

//Carousel Auto-Cycle



///////////////test
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
	 					html2 += '	<a href="" class = index'+ i +'>';
	 					html2 += '		<img src="' + vimg + '" />';
	 					html2 += '	<span>' + vtitle + '</span>';
	 					html2 += '	</a>';
	 					html2 += '</li>';
	 					
	 					$(".clickList").html(html2);
				};

			videoList();
			
			// List 클릭 시 캐러셀 이동
			$('.lini1-1').click(function(e){
				var indexSearch = $(this).children('a').attr('class');					
				var result = indexSearch.slice(-1);
 					$('.carousel').carousel(parseInt(result));
				});
			
			
// 				$.ajax({
// 					type:"POST",
// 					data: {videoId:vurl, title:vtitle, thumbnail:vimg},
// 					url:"videoList",
// 					dataType:"json",
// 					success : function(video) {
						
// 				});
				
			
        }
  }else {
      console.log("Error loading page\n");
  }
};

req.send(null);

</script>