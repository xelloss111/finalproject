<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<section class="content_section">
	<div class="content_row_1">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="carousel slide" id="myCarousel">
						<div class="carousel-inner">



<!-- 							<div class="control-box"> -->
<!-- 								<a data-slide="prev" href="#myCarousel" -->
<!-- 									class="carousel-control left">‹</a> <a data-slide="next" -->
<!-- 									href="#myCarousel" class="carousel-control right">›</a> -->
<!-- 							</div> -->
							<!-- /.control-box -->
						</div>
					</div>
						<!-- /#myCarousel -->

				</div>
					<!-- /.span12 -->
			</div>
				<!-- /.row -->
		</div>
			<!-- /.container -->


	</div>
		<!-- content_row_1 END -->
</section>



<script>
//Carousel Auto-Cycle
$(document).ready(function() {
  $('.carousel').carousel({
    interval: 6000
  })
});


///////////////test
var url = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLSB4jUMSVNnaGj5Auw93KId3MoYxvrfNQ&key=AIzaSyCAlK-6EnlJZ3seSOGsvS7X8Yq_GzFlT9I";
var req = new XMLHttpRequest();
var html = '';

req.open('GET', url , true);
req.onreadystatechange = function (aEvt) {
  if (req.readyState == 4) {
     if(req.status == 200)
		var result = JSON.parse(req.responseText); 
		var items = result.items;
		var i = 0;
		
        for ( i = 0; i < items.length; i++){
					
				var vId = items[i].snippet.resourceId.videoId;
				var vurl = "https://www.youtube.com/embed/" + vId;
				var vtitle = items[i].snippet.title;
				var vimg = items[i].snippet.thumbnails.default.url;
				
				function videoList() {	
					if( i == 0 ) {
						html += '	<div class="item active"> ';
					} else {							
						html += '	<div class="item"> ';		
					};
					
						html += '		<div class="bannerImage"> ';	
	 					html += '			<embed src=' + vurl + ' /> ';	
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
	
	 					$(".carousel-inner").html(html);
				};
			videoList();
			
// 				$.ajax({
// 					type:"POST",
// 					data: {videoId:vurl, title:vtitle, thumbnail:vimg},
// 					url:"videoList",
// 					dataType:"json",
// 					success : function(video) {
						
// 	 					html += '		<div class="bannerImage"> ';	
// 	 					html += '			<embed src=' + video.videoId + ' /> ';	
// 	 					html += '				<div class="caption row-fluid">  ';	
// 	 					html += '					<div class="span4">  ';	
// 	 					html += '						<h3>' + video.title + '</h3>  ';	
// 	 					html += '					</div>  ';	
// 	 					html += '					<div class="span8">  ';	
// 	 					html += '						<h3></h3>  ';	
// 	 					html += '					</div>  ';	
// 	 					html += '				</div>  ';	
// 	 					html += '		</div>  ';	
// 	 					html += '	</div>  ';	

// 	 					$(".carousel-inner").html(html);
// 					}
// 				});
				
			
        }
  }else {
      console.log("Error loading page\n");
  }
};

req.send(null);

</script>