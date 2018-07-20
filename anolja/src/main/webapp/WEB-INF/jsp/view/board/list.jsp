<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board.css">
		<section class="content_section">
			<div class="content_row_1">
			<div class="content_row_2">
				<div class="search_box">
					<form action="#" method="get">
						<input type="search" name="gallery_search_window" class="search_window" placeholder="검색어">
						<div class="search_select_box">
							<select name="검색 대상">
								<option value="제목">제목</option>
								<option value="제목">제목+내용</option>
								<option value="제목">댓글</option>
							</select>
						</div>	
					</form>
				</div>
				<c:if test="${!empty sessionScope.id}">
					<div class="write_box">
						<a href="${pageContext.request.contextPath}/board/write">글 쓰기</a>
					</div>
				</c:if>
			</div>
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
							<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${re.bNo}&pageNo=${result.pageResult.pageNo}">${re.bNo}</a></td>
							<td>
								<a href="${pageContext.request.contextPath}/board/detail?bNo=${re.bNo}&pageNo=${result.pageResult.pageNo}">
									<c:if test="${re.groupBlist > 0}">
										<c:forEach begin="1" end="${re.depth}">
											RE : 
										</c:forEach>
									</c:if>							
								${re.title}
								</a>
							</td>
							<td>${re.anonymousId}</td>
							<td><fmt:formatDate value="${re.regDate}" pattern="yyyy-MM-dd" />
							<td>${re.viewCnt}</td>
						</tr>
					</c:forEach>
						
					</tbody>
				</table>
			</div>
			
			
			
			
			<c:if test="${result.pageResult.next eq true}">
					      <span onclick="javascript:goPage(${result.pageResult.endPage + 1});" class="list_prev_btn"></span>
			</c:if>
			
			<div class="content_row_2">
				<div class="search_box">
					<form action="#" method="get">
						<input type="search" name="gallery_search_window" class="search_window" placeholder="검색어">
						<div class="search_select_box">
							<select name="검색 대상">
								<option value="제목">제목</option>
								<option value="제목">제목+내용</option>
								<option value="제목">댓글</option>
							</select>
						</div>	
					</form>
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
					      <span onclick="javascript:goPage(${result.pageResult.beginPage - 1});" class="list_prev_btn"></span>
					      </c:if>
					<c:forEach var="i" begin="${result.pageResult.beginPage}" end="${result.pageResult.endPage}">
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
					      <span onclick="javascript:goPage(${result.pageResult.endPage + 1});" class="list_next_btn"></span>
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
	
	function goPage(pageNo) {
		location.href = "list?pageNo=" + pageNo;
	}
</script>