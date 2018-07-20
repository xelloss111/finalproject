<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gallery.css">

		<section class="content_section">
			<div class="content_row_1">
				<ul class="gallery_list">
<%-- 					<c:forEach var="i" items="${list}"> --%>
<%-- 						<li><a href=""><img src='<c:url value="/gallery/listView?gno=${i.gno}"/>'></a></li> --%>
<%-- 					</c:forEach> --%>
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
			$(function () {
				$.ajax({
					url: "<c:url value='/gallery/listAjax'/>",
					dataType: "JSON",
					success: function (list) {
						console.log(list[0].gno)
						for (let i = 0; i < list.length; i++) {
// 							var src = ctx + '/gallery/listView?gno=' + list[i].gno;
// 							var gli = document.createElement('li');
// 							var ga = document.createElement('a');
// 							var gimg = document.createElement('img');
							
// 							$(gimg).attr('src', src);
// 							$(ga).append(gimg)
// 							$(gli).append(ga);
// 							$(".gallery_list").append(gli);
// 							console.log($(".gallery_list"))
							$(".gallery_list").append('<li><a href=""><img src=\'<c:url value="/gallery/listView?gno=' + list[i].gno + '"/>\'></a></li>');
						}
					}
				});
			});
			
// 			var page = 1;

// 			$(window).scroll(function() {
// 			    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
// 			      console.log(++page);
// 			      $("#enters").append("<h1>Page " + page + "</h1><BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~<BR/>So<BR/>MANY<BR/>BRS<BR/>YEAHHH~");
			      
// 			    }
// 			});
		</script>