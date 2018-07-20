<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<section class="slider_section">

	<div class="img_con">
		<h2 class="sec_h2">명예의 전당</h2>
		<div id="main_img">
			<ul>
				<li class="visual_0">
					<a href="#">
						<img src="${pageContext.request.contextPath}/resources/images/catchmind/game_img.png">
					</a>
				</li>
	
				<li class="visual_1">
					<a href="#">
						<img src="${pageContext.request.contextPath}/resources/images/catchmind/game_img2.png">
					</a>
				</li>
	
				<li class="visual_2">
					<a href="#">
						<img src="${pageContext.request.contextPath}/resources/images/catchmind/game_img3.png">
					</a>
				</li>
	
			</ul>
	
	
	<!-- 화살표 영역 -->
			<div id="prev">
				<i class="far fa-arrow-alt-circle-left fa-2x"></i>
			</div><!-- prev -->
	
			<div id="next">
				<i class="far fa-arrow-alt-circle-right fa-2x"></i>
			</div><!-- next -->
<!-- 화살표 영역 끝 -->


	</div><!-- main_img -->
	
	<!-- 블릿 기호 영역  -->
		<ul id="list_btn">
			<li class="on"><a href="#">최근 게시물1</a></li>
			<li><a href="#">최근 게시물2</a></li>
			<li><a href="#">최근 게시물3</a></li>
		</ul>
		
	</div><!-- img_con -->

</section>


<section class="latest_post_section bdarea" >
			<h2 class="title">최근 글</h2>
			<ul class="latest_post_list">
				<li><a href="">안녕하세요 홈페이지가 오픈...</a></li>
				<li><a href="">홈페이지 리뉴얼...</a></li>
				<li><a href="">flat design은...</a></li>
				<li><a href="">blog에서 다양한 정보를...</a></li>
				<li><a href="">저는 누굴까요?...</a></li>
			</ul>
		</section>
		<section class="popular_post_section bgarea">
			<figure class="snip1200">
				<img src="${pageContext.request.contextPath}/resources/images/s_images/bg_1.jpg" alt="" />
				<figcaption>
					<p>오늘도 치킨? <br>
						내 전적을 검색해봅시닭!
					</p>
					<div class="heading">
						<h2>
							<span>전적 검색실</span>
						</h2>
					</div>
				</figcaption>
				<a href="${pageContext.request.contextPath}/bgsearch"></a>
			</figure>
		</section>
		
		
		<section class="popular_post_section sec_sky">
			<figure class="snip1200">
				<img src="${pageContext.request.contextPath}/resources/images/s_images/bg_2.png" alt="" />
				<figcaption>
					<p>얼굴보고 얘기하자! <br>
						화상 채팅하러 가기
					</p>
					<div class="heading">
						<h2>
							<span>SKYQE</span>
						</h2>
					</div>
				</figcaption>
				<a href="#"></a>
			</figure>
		</section>
		
		<section class="popular_post_section sec_you">
			<figure class="snip1200">
				<img src="${pageContext.request.contextPath}/resources/images/s_images/bg_3.png" alt="" />
				<figcaption>
					<p> 격하게 아무것도 하기 싫다면 <br>
						동영상이나 보도록 하자
					</p>
					<div class="heading">
						<h2>
							<span>YouTube</span>
						</h2>
					</div>
				</figcaption>
				<a href="${pageContext.request.contextPath}/video"></a>
			</figure>
		</section>
		
				
		<section class="gallery_section thinkbig">
			<figure class="snip1200">
				<img src="${pageContext.request.contextPath}/resources/images/p_images/bg-1.png" alt="" />
				<figcaption>
					<p> 창의력 장인이라면  <br>
						도전!!
					</p>
					<div class="heading">
						<h2>
							<span>TINGKBIG</span>
						</h2>
					</div>
				</figcaption>
				<a href="${pageContext.request.contextPath}/game"></a>
			</figure>
		</section>
		
		<section class="rankup_section">
			<h2 class="title">씽크빅 마스터</h2>
			<ul class="rankup_list">
				<li><a href=""><i class="fas fa-crown" style="color: gold"></i> &nbsp; 펭귄 </a></li>
				<li><a href=""><i class="fas fa-crown" style="color: silver"></i> &nbsp; 늑대 </a></li>
				<li><a href=""><i class="fas fa-crown" style="color: #cd7f32"></i> &nbsp; 카멜레온 </a></li>
				<li><a href=""><i class="fas fa-trophy" style="color: gold"></i> &nbsp; 돌고래</a></li>
				<li><a href=""><i class="fas fa-trophy" style="color: silver"></i> &nbsp; 기린</a></li>
				<li><a href=""><i class="fas fa-trophy" style="color: #cd7f32"></i> &nbsp; 팬더</a></li>
				<li><a href=""><i class="fas fa-medal" style="color: gold"></i> &nbsp; 블롭피쉬 </a></li>
				<li><a href=""><i class="fas fa-medal" style="color: silver"></i> &nbsp; 키위새</a></li>
				<li><a href=""><i class="fas fa-medal" style="color: #cd7f32"></i> &nbsp; 고양이</a></li>
				<li><a href=""><i class="fas fa-medal" style="color :#fff"></i> &nbsp; 해파리</a></li>
			</ul>
		</section>
		
		
<script>
// 슬라이더
$(function(){ 
	var visual = $("#main_img > ul > li");
	var visualImg =visual.find("a img");
	var button=$("#list_btn > li");
	var cnt = 0;
	var setIntervalId;
	var dir = "next";

	setTimeout(win_init, 10);
	$(window).resize(function(){
		win_init();
	});
	
	function win_init(){
		$("#main_img").css("height", visualImg.height());
		$("#prev").css("top",(visualImg.height() - $("#prev").height())/2);
		$("#next").css("top",(visualImg.height() - $("#next").height())/2);
	}

	button.click(function(){
		var tg=$(this);
		var i= tg.index();

		button.removeClass("on");
		tg.addClass("on");
		
		move(i);
	});

	$("#next").click(function(){
		dir="next";
		var n = cnt+1;
		if(n == visual.length){
			n=0;
		}
		button.eq(n).trigger("click");
	});

	$("#prev").click(function(){
		dir="prev";
		var n = cnt-1;
		if(n < 0 ){
			n= visual.length - 1;
		}
		button.eq(n).trigger("click");
	});

	timer();

	function timer(){
		setIntervalId = setInterval(function(){
			var n = cnt + 1;
			if(n == visual.length){
				n=0;
			}
			button.eq(n).trigger("click");
		},5000);
	};

	function move(i){
		if(cnt == i) return;
		
		var cnt_img = visual.eq(cnt); // 현재 이미지
		var next_img = visual.eq(i); // 바뀔 이미지

		if(dir == "prev"){
		 cnt_img.css({left:0}).stop().animate({left:"-100%"});
		 next_img.css({left:"100%"}).stop().animate({left:0});
		}else{
		 cnt_img.css({left:0}).stop().animate({left:"100%"});
		 next_img.css({left:"-100%"}).stop().animate({left:0});
		}
		cnt=i;
	};// move()함수 종결

	$("#main_wrap").mouseover(function(){
		clearInterval(setIntervalId);
	}).mouseout(function(){
		timer();
	});

});
</script>		
		