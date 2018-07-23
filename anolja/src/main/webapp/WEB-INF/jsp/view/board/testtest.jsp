<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board.css">
<link rel="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" />
<style>
	#a {
		width:100px; height:100px; border:1px solid red;
	}
</style>
		<section class="content_section">
		<div id="pilseong">여기 들어와야하는거 ㅇ냐 1111이??컨트롤러는뭐야????????함해바바????</div>
	<input type="text" id="test"/>
	<button id="btn">전송</button>
	</section>
	<script>
	$("#btn").click(function () {
		
		$.ajax({
			url: "<c:url value='/board/search'/>",
			data: {title: $("#test").val()},
// 			dataType:"json",다시 ㄱㄱ 봐봐 왜냐면
			success:function(result) {
				
				alert("안녕");
				
				var html="111";
				$("#pilseong").html(html);
				
			},
			error: function (e) {
				console.log(e)
				}
		});
	});
	</script>
