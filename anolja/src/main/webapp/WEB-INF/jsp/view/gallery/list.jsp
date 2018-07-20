<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gallery.css">
</head>
<body>
		<section class="content_section">
			<div class="content_row_1">
				<ul class="gallery_list">
					<c:forEach var="i" items="${list}">
						<li><a href=""><img src='<c:url value="/gallery/listView?gno=${i.gno}"/>' class="scroll" data-gno="${i.gno}"></a></li>
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
<!-- 					<a href="#">글 쓰기</a> -->
				</div>
			</div>
			<div class="content_row_3">
				<span class="list_prev_btn">갤러리 이전 버튼</span>
				<a href="#">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<span class="list_next_btn">갤러리 다음 버튼</span>
			</div>
		</section>
		
		<script>
			var isEnd = false;
		
			$(window).scroll(function myScroll() {
				var lastGno = $(".scroll:last").attr("data-gno");
				
				if ($(window).scrollTop() + window.innerHeight + 30 > $(document).height()) {
					$(window).off("scroll");
					if (isEnd == true) {return;}
					$.ajax({
						url: "<c:url value='/gallery/listAjax'/>",
						data: {gno: lastGno},
						dataType: "JSON",
						success: function (list) {
							console.log("list.length: "+list.length);
							if( list.length <= 1 ){
                                isEnd = true;
                                return;
                       		}
							for (let i = 0; i < list.length; i++) {
								var html = "<li>"+
										   '	<a href="">'+
										   '		<img src=\'<c:url value="/gallery/listView?gno='+list[i].gno+'"/>\' class="scroll" data-gno="'+list[i].gno+'">'+
										   '	</a>'+
										   '</li>';
								$(".gallery_list").append(html);
							}
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
		</script>
</body>
</html>