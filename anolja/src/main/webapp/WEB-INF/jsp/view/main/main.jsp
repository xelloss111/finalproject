<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="slider_section">
	
	<!-- 명예의 전당 영역 -->
	<div class="img_con">
		<h2 class="sec_h2">명예의 전당</h2>
		<div id="main_img">
			<ul class="catchImgUl">
				<c:forEach var="i" items="${list}" end='2' varStatus="status">
					<li class="visual_${status.index}"><a
						href="${pageContext.request.contextPath}/gallery/list"> <img
							src='<c:url value="/gallery/listView?gno=${i.gno}"/>'>
					</a></li>
				</c:forEach>
			</ul>


			<!-- 화살표 영역 -->
			<div id="prev">

				<i class="fas fa-arrow-alt-circle-left fa-2x"></i>
			</div>
			<!-- prev -->

			<div id="next">
				<i class="fas fa-arrow-alt-circle-right fa-2x"></i>
			</div>
			<!-- next -->
			<!-- 화살표 영역 끝 -->


		</div>
		<!-- main_img -->

		<!-- 블릿 기호 영역  -->
		<ul id="list_btn">
			<li class="on"><a href="#">최근 게시물1</a></li>
			<li><a href="#">최근 게시물2</a></li>
			<li><a href="#">최근 게시물3</a></li>
		</ul>

	</div>
	<!-- img_con -->

</section>

<!-- 치키너 영역 -->
<section class="popular_post_section bgarea">
	<figure class="snip1200">
		<img
			src="${pageContext.request.contextPath}/resources/images/s_images/bg_1.jpg"
			alt="" />
		<figcaption>
			<p>
				오늘도 치킨? <br> 내 전적을 검색해봅시닭!
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

<!-- 후방주의 영역 -->
<section class="popular_post_section sec_you">
	<figure class="snip1200">
		<img
			src="${pageContext.request.contextPath}/resources/images/s_images/bg_3.png"
			alt="" />
		<figcaption>
			<p>
				격하게 아무것도 하기 싫다면 <br> 동영상이나 보도록 하자
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

<!-- 아무말 대단치 영역 -->
<section class="latest_post_section bdarea">
	<h2 class="title">최근 아무말대잔치</h2>
	<ul class="latest_post_list">
		<c:forEach var="boardList" items="${boardList}" end="5">
			<li class="latest_post_list_li"><a
				href="${pageContext.request.contextPath}/board/detail?bNo=${boardList.bNo}">${boardList.title}</a></li>
		</c:forEach>
	</ul>
</section>

<!-- 씽크빅 대전 영역 -->
<section class="gallery_section thinkbig">
	<figure class="snip1200">
		<img
			src="${pageContext.request.contextPath}/resources/images/p_images/bg-1.png"
			alt="" />
		<figcaption>
			<p>
				창의력 장인이라면 <br> 도전!!
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

<!-- 씽크빅 마스터 (Rank) 영역 -->
<section class="rankup_section">
	<h2 class="title">씽크빅 마스터</h2>
	<ul class="rankup_list">
		<c:forEach var="ranklist" items="${ranklist}" end="9"
			varStatus="status2">
			<c:if test="${status2.index == 0}">
				<li><i class="fas fa-crown" style="color: gold"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 1}">
				<li><i class="fas fa-crown" style="color: silver"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 2}">
				<li><i class="fas fa-crown" style="color: #cd7f32"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 3}">
				<li><i class="fas fa-trophy" style="color: gold"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 4}">
				<li><i class="fas fa-trophy" style="color: silver"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 5}">
				<li><i class="fas fa-trophy" style="color: #cd7f32"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 6}">
				<li><i class="fas fa-medal" style="color: gold"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 7}">
				<li><i class="fas fa-medal" style="color: silver"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 8}">
				<li><i class="fas fa-medal" style="color: #cd7f32"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
			<c:if test="${status2.index == 9}">
				<li><i class="fas fa-medal" style="color: #fff"></i>
					&nbsp;${ranklist.id}</li>
			</c:if>
		</c:forEach>
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
