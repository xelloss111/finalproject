<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/gallery.css">

		<section class="content_section">
			<div class="content_row_1">
				<ul class="gallery_list">
					<c:forEach var="i" items="${list}">
						<li><a href=""><img src='<c:url value="/gallery/listView"/>'></a></li>
					</c:forEach>
<!-- 					<li><a href=""><img src="C:/java-lec/upload/2018/07/19/17/pp.jpg" alt=""></a></li> -->
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_01.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_02.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_03.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_04.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_05.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_06.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_07.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_08.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_09.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_10.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_11.jpg" alt=""></a></li> --%>
<%-- 					<li><a href=""><img src="${pageContext.request.contextPath}/resources/images/p_images/sub_gallery_12.jpg" alt=""></a></li> --%>
				</ul>
			</div>
			<div class="content_row_2">
				<div class="search_box">
					<form action="#" method="get">
<!-- 						<input type="search" name="gallery_search_window" class="search_window" placeholder="검색어"> -->
						<div class="search_select_box">
<!-- 							<span>검색 대상</span> -->
<!-- 							<ul class="search_select_list"> -->
<!-- 								<li>제목</li> -->
<!-- 								<li>내용</li> -->
<!-- 								<li>제목+내용</li> -->
<!-- 								<li>댓글</li> -->
<!-- 								<li>이름</li> -->
<!-- 								<li>닉네임</li> -->
<!-- 								<li>아이디</li> -->
<!-- 								<li>태그</li> -->
<!-- 							</ul> -->
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
		