<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css">
<link rel="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" />
<style>
	#sContent {
	height:auto%;
	}
	#sContent table tbody {
		height:100%;
	}
	
	.searchBox {
		display:inline-block;
		position:relative;
	}
	
	.searchBox select{
		display:inline-block; 
		width:80px;
		width:5.000rem;
		height:30px;
		height:1.875rem;
		font-size:0.813em;
		font-size:0.813rem;
		line-height:28px;
		line-height:1.750rem;
		text-align:center;
		color:#fff;
		background:#e65d5d;
		cursor:pointer;
	}
	

</style>
<section class="content_section">
	<div class="content_row_1">
<!-- 		<div class="content_row_2"> -->
<!-- 			<div class="search_box"> -->
<!-- 				<input type="text" id="searchBar" name="title" class="search_window" -->
<!-- 					style="width:150px;" placeholder="제목으로 검색하기"> -->
<!-- 				<button type="button" id="ps">검색</button> -->
<!-- 			</div> -->
<%-- 			<c:if test="${!empty sessionScope.id}"> --%>
<!-- 				<div class="write_box"> -->
<%-- 					<a href="${pageContext.request.contextPath}/board/write">글 쓰기</a> --%>
<!-- 				</div> -->
<%-- 			</c:if> --%>
<!-- 		</div> -->
		<div id="sContent">
			<table class="board_table">
				<caption>문의사항 게시판</caption>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="re" items="${result.list}">
						<tr>
							<td><a
								href="${pageContext.request.contextPath}/board/detail?bNo=${re.bNo}&pageNo=${result.pageResult.pageNo}">${re.bNo}</a></td>
							<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${re.bNo}&pageNo=${result.pageResult.pageNo}">
									<c:if test="${re.groupBlist > 0}">
										<c:forEach begin="1" end="${re.depth}">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
										<c:forEach begin="1" end="${re.depth}">
												RE : 
											</c:forEach>
									</c:if> ${re.title} [${re.comCnt}]
							</a></td>
							<td>${re.anonymousId}</td>
							<td><fmt:formatDate value="${re.regDate}" pattern="yyyy-MM-dd" />
							<td>${re.viewCnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>



	<c:if test="${result.pageResult.next eq true}">
		<span onclick="javascript:goPage(${result.pageResult.endPage + 1});"
			class="list_prev_btn"></span>
	</c:if>

	<div class="content_row_2">
			<div class="search_box">
				<input type="text" id="searchBar" name="title" class="search_window"
					style="width:150px;" placeholder="제목으로 검색하기" onkeydown="javascript:if(event.keyCode==13){test_key();}">
				<button type="button" id="ps">검색</button>
			</div>
			<c:if test="${!empty sessionScope.id}">
				<div class="write_box">
					<a href="${pageContext.request.contextPath}/board/write">글 쓰기</a>
				</div>
			</c:if>
		</div>

	<c:if test="${result.pageResult.count != 0}">
		<nav>
			<div class="content_row_3">
				<c:if test="${result.pageResult.prev eq true}">
					<span
						onclick="javascript:goPage(${result.pageResult.beginPage - 1});"
						class="list_prev_btn"></span>
				</c:if>
				<c:forEach var="i" begin="${result.pageResult.beginPage}"
					end="${result.pageResult.endPage}">
					<c:choose>
						<c:when test="${i eq result.pageResult.pageNo}">
							<a href="#1">${i}</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:goPage(${i});">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${result.pageResult.next eq true}">
					<span
						onclick="javascript:goPage(${result.pageResult.endPage + 1});"
						class="list_next_btn"></span>
				</c:if>
			</div>

		</nav>
	</c:if>
	<!-- 			<div class="content_row_3"> -->
	<!-- 				<span class="list_prev_btn">문의사항 이전 버튼</span> -->
	<!-- 				<a href="#">1</a> -->
	<!-- 				<a href="#">2</a> -->
	<!-- 				<a href="#">3</a> -->
	<!-- 				<span class="list_next_btn">문의사항 다음 버튼</span> -->
	<!-- 			</div> -->
</section>
<script>

	$("#ps").click(function () {
		if($("#searchBar").val() == "") {
			swal("검색어를 입력해주세요");
			return false;
		}
		
		$(".board_table").hide();
		$.ajax({
			url: "<c:url value='/board/search'/>",
			data: {title: $("#searchBar").val()},
			dataType: "json",
			success:function(result) {
				console.log(result);
				var html ="";
					html += '<table class="board_table">';
					html += '	<thead>';
					html += ' 		<tr>';
					html += ' 			<th>번호</th>';					
					html += ' 			<th>제목</th>';					
					html += ' 			<th>글쓴이</th>';					
					html += ' 			<th>작성일</th>';					
					html += ' 			<th>조회수</th>';					
					html += ' 		</tr>';
					html += '	</thead>';
					html += '   <tbody>';
				for(var i = 0; i < result.length; i++) {
					var search = result[i];
					html += '		<tr>'
					html += '			<td>' + search.bNo + '</td>';
					html += '			<td><a href="${pageContext.request.contextPath}/board/detail?bNo=' + search.bNo + '">' + search.title + '</a></td>';
					html += '			<td>' + search.anonymousId + '</td>';
					var date = new Date(search.regDate);
					var time = date.getFullYear() + "-"
							 + (date.getMonth() + 1) + "-"
							 + date.getDate();
					html += '			<td>' + time + '</td>';
					html += '			<td>' + search.viewCnt + '</td>';
					html += '		</tr>';
				}
					html += '	</tbody>';
					html += '</table>';
			$("#sContent").html(html);
			}
		});
	});
	
	function goPage(pageNo) {
		location.href = "list?pageNo=" + pageNo;
	}
</script>