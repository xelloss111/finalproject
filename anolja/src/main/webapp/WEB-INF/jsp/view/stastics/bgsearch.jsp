<%@ page contentType="text/html; charset=UTF-8" %>

  <link rel = "stylesheet" type = "text/css" href = "${pageContext.request.contextPath}/resources/css/search.css">

<section class="content_section">
	<div class="content_row_1">


<!-- 여기부터 -->
		<div id="image-area">
			<img
				src="${pageContext.request.contextPath}/resources/images/battleground/MainImage.png"
				width="250px" height="250px">
		</div>
		<div id="#search--area">
			<div id="search-area">
				<form>
					<input type="text" id="search-input" placeholder="검색할 아이디를 입력하세요.">
					<div id="search-icon">
						<a href="${pageContext.request.contextPath}/bgsearchresult">
						<img src="${pageContext.request.contextPath}/resources/images/battleground/google-web-search-256.png" width="35px" height="35px"></a>
					</div>
					
				</form>
			</div>
		</div>
<!-- 여기까지 -->
	</div>
</section>

<script>

</script>
</html>