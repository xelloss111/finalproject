<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
    @import url(//fonts.googleapis.com/earlyaccess/hanna.css);
</style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gallery.css">
</head>
<body>
		<section class="content_section">
			<div class="content_row_1">
				<ul class="gallery_list">
					<c:forEach var="i" items="${list}">
						<li><a href="#t"><img src='<c:url value="/gallery/listView?gno=${i.gno}"/>' class="scroll" data-gno="${i.gno}" data-id="${i.id}" data-answer="${i.answer}"></a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="content_row_2">
				<div class="search_box">
					<form action="#" method="get">
						<div class="search_select_box">
						</div>	
					</form>
				</div>
				<div class="write_box">
				</div>
			</div>
		</section>
		
		<script>
			var isEnd = false;
		
			$(window).scroll(function myScroll() {
				// 마지막 게시물의 다음 게시물을 불러오기 위해
				// 현재 보여지는 게시글의 마지막번호를 변수에 담는다.
				var lastGno = $(".scroll:last").attr("data-gno");
				
				if ($(window).scrollTop() + window.innerHeight + 30 > $(document).height()) {
					// 에이작스를 한번만 부르기 위해 이프문안에 들어오면 스크롤 이벤트 없애기
					$(window).off("scroll");
					if (isEnd == true) {return;}
					$.ajax({
						url: "<c:url value='/gallery/listAjax'/>",
						data: {gno: lastGno},
						dataType: "JSON",
						success: function (list) {
// 							console.log("list.length: "+list.length);
// 							console.log("list: "+list[0].id, list[0].answer);
							// 불러올 데이터가 1개 미만이면 에이작스 끝내기
							if( list.length <= 1 ){
                                isEnd = true;
                                return;
                       		}
							for (let i = 0; i < list.length; i++) {
								var html = "<li>"+
										   '	<a href="#t">'+
										   '		<img src=\'<c:url value="/gallery/listView?gno='+list[i].gno+'"/>\''+
										   '	   		 class="scroll" data-gno="'+list[i].gno+'" '+
										   '	   		 data-id="'+list[i].id+'" data-answer="'+list[i].answer+'">'+
										   '	</a>'+
										   '</li>';
								$(".gallery_list").append(html);
							}
							// 에이작스 한 번 실행 후 스크롤이벤트 on
							$(window).on("scroll", myScroll);
						},
						// 데이터 불러오는 시간이 길어질 때 보여주는 로딩화면
						beforeSend:function(){
							$('.loading').attr('id', '');
						},
						complete:function(){
							$('.loading').attr('id', 'display-none');
						}
					});
				}
			});
			
			$(document)
			.on("mouseover", ".gallery_list img", function () {
				var id = $(this).attr("data-id");
				var answer = $(this).attr("data-answer");
				$(this).parent().append(
						'<span class="canvasInfo">'+
						'	문제 : '+answer+'<br>'+
						'	출제자 : '+id+'<br>'+
						'</span>'
				);
			})
			.on("mouseleave", ".gallery_list img", function () {
				$(this).next().remove();
			});
			
		</script>
</body>
</html>