<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css">
<div id="wrap">
	<div id="outer">
		<div id="titleDiv">
			<br> <br>
			<button onclick="location.href='write'">글쓰기</button>
			<button>답글</button>
			<div id="ps">
				<a href="list">목록</a>
			</div>
		</div>
		<hr>
		<div id="title">
			<div id="title2">
				<h1>${board.title}</h1>
			</div>


			<div id="bInfo">
				<span>${board.anonymousId}</span> <span>조회수 : 184</span> <span><fmt:formatDate
						value="${board.regDate}" pattern="yyyy-MM-dd" /></span>
			</div>
		</div>
		<hr>
		<div id="content_section">${board.content}</div>
		<div id="comment">
			<hr>
			<br>
			<div id="commentList"></div>
			<div>
				<br>
				<form id="writeForm">
					<h5>댓글쓰기</h5>
					<br>
					<textarea name="commentText"></textarea>
					<button>등록</button>
				</form>
				<div class="write_box">
					<div style="text-align: right;">
							<a href="updateForm">수정</a>
							<a href="delete?bNo=${board.bNo}">삭제</a>
						<a href="list">목록</a>
					</div>
				</div>
			</div>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
	</div>

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
							<td>${list.bNo}</td>
							<td><a
								href="${pageContext.request.contextPath}/board/detail?bNo=${list.bNo}">${list.title}</a></td>
							<td>${list.anonymousId}</td>
							<td><fmt:formatDate value="${list.regDate}"
									pattern="yyyy-MM-dd" />
							<td>${list.viewCnt}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<div class="content_row_2">
			<div class="search_box">
				<form action="#" method="get">
					<input type="search" name="gallery_search_window"
						class="search_window" placeholder="검색어">
					<div class="search_select_box">
						<select name="검색 대상" value="검색대상">
							<option value="제목">제목</option>
							<option value="제목">제목+내용</option>
							<option value="제목">댓글</option>
						</select>
					</div>
				</form>
			</div>
			<div class="write_box">
				<a href="write">글 쓰기</a>
			</div>
		</div>
		<div class="content_row_3">
			<span class="list_prev_btn">문의사항 이전 버튼</span> <a href="#">1</a> <a
				href="#">2</a> <a href="#">3</a> <span class="list_next_btn">문의사항
				다음 버튼</span>
		</div>
	</section>
</div>