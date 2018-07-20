<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gallery.css">

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
		
			$(window).scroll(function () {
				var lastGno = $(".scroll:last").attr("data-gno");
// 				console.log("lastGno: "+lastGno);
				let $window = $(window);
				console.log("$window.scrollTop()",$(window).scrollTop())
				console.log("$window.height()",$window.height())
				console.log("$(document).height()",$(document).height())
				
				if ($window.scrollTop() + $window.height() + 30 > $(document).height()) {
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
						}
					});
				}
			});
			

// 			$(window).scroll(function() {
// 			    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
// 			      console.log(++page);
// 			      $(".gallery_list").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~");
// 			    }
// 			});
		</script>