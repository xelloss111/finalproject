<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board.css">
		<section class="content_section">
			<div class="content_row_1">
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
					<c:forEach var="list" items="${list}">
						<tr>
							<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${list.bNo}">${list.bNo}</a></td>
							<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${list.bNo}">${list.title}</a></td>
							<td>${list.anonymousId}</td>
							<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
							<td>${list.viewCnt}</td>
						</tr>
					</c:forEach>
						
					</tbody>
				</table>
			</div>
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
			<div class="content_row_3">
				<span class="list_prev_btn">문의사항 이전 버튼</span>
				<a href="#">1</a>
				<a href="#">2</a>
				<a href="#">3</a>
				<span class="list_next_btn">문의사항 다음 버튼</span>
			</div>
		</section>
