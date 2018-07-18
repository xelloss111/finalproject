<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/board.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/board.css">
<style>
	.write_box {
		    height: 33px;
		    text-align: right;
		    width: 1100px;
		    margin-bottom:20px;
		}
	.write_box ul {
		    width: 1100px;
		   height: 33px;
		   
	}
	.writhe_box ul li:first-child {
		margin-left:830px;
	}
	.write_box ul li {
		float:left;
		margin:0 10px;
		}
	#writeForm {clear:both;}
	
	#bInfo span, h1 {
		color :white;
		height: 50px;
    	line-height: 70px;
    	}
    	
	#commentlist{
		background-color:#2c3e50;
	}
	#commentList table tr td{
	 font-color : white;
	}
</style>
<div id="wrap">
	<div id="outer">
		<div id="titleDiv">
			<br> <br>
			<button onclick="location.href='write'">글쓰기</button>
			<button>답글</button>
		</div>
		<div id="title">
		<div style="width:1100px; height:5px; background-color:#2c3e50;margin-bottom:5px;"></div>
			<div id="title2" style="margin-left:20px;">
				<h1>${board.title}</h1>
			</div>


			<div id="bInfo" style="background-color:#2c3e50;">
				<span>${board.anonymousId}</span> <span>조회수 : 184</span> <span><fmt:formatDate
						value="${board.regDate}" pattern="yyyy-MM-dd" /></span>
			</div>
		</div>
		<div style="width:1100px; height:5px; background-color:#2c3e50; margin-top:5px;"></div>
		<div id="content_section" style="height:300px; margin-left:20px; ">${board.content}</div>
		<div id="updateBtn">
			<hr>
			<br>
			<div>
				<br>
				<c:choose>
					<c:when test="${sessionScope.id == board.anonymousId}">
						<div class="write_box">
								<ul>
									<li style="margin-left:830px;"><a href="updateForm?bNo=${board.bNo}">수정</a></li>
									<li><a href="delete?bNo=${board.bNo}">삭제</a></li>
									<li><a href="list">목록</a></li>
								</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="write_box">
								<ul>
									<li style="float:right;"><a href="list">목록</a></li>
								</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<br> <br> <br> <br> <br> <br> <br>
	</div>

	
	<!-- 댓글 시작 -->
	<section id="commentStart">
	<form action="commentUpdate" method="post">
		<input type="hidden" name="bNo" value="${board.bNo}}" />
		<input type="hidden" name="cNo" value="${comment.cNo}" />

		<!-- 댓글 목록 -->
		<div id="commentList"></div>
	</form>
		
		<!-- 댓글 관련 파트 시작 -->
		<form id="rForm" class="form-inline">
			<div id="comment">
				<div class="form-group">
					<input type="text" name="anonymousId" value="${sessionScope.id}" style="width:100px;height:50px; float:left;"/>
				</div>
				<div class="form-group">
					<input type="text" name="content" class="form-control input-wo1" style="width:789px; height:50px; padding-left:50px; float:left" placeholder="내용을 입력하세요"  />
				</div>	
				<button class="btn btn-primary">등록</button>			
			</div>
		</form>	
	</section>
	<section class="content_section">
			<div class="content_row_1">
			<div class="content_row_2">
				<div class="search_box">
					<form action="#" method="get" style="width:880px;">
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
							<td><a href="${pageContext.request.contextPath}/board/detail?bNo=${re.bNo}&pageNo=${result.pageResult.pageNo}">${re.title}</a></td>
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
					<form action="#" method="get" style="width:880px;">
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
	function commentDelete(commentNo) {
		$.ajax({
			url: "<c:url value='/board/commentDelete'/>",
			data: {
				bNo: "${board.bNo}", 
				cNo: commentNo
			},
			dataType: "json",
			success: makeCommentList
		});
	}
	
	function commentUpdateForm(commentNo) {
		
		$("#commentList tr[id^=row]").show();
		$("#commentList tr[id^=modRow]").remove();
		
		var modId = $("#row" + commentNo + " > td:eq(0)").text();
		var modContent = $("#row" + commentNo + " > td:eq(1)").text();
		
		var html = '';
		html += '<tr id="modRow' + commentNo + '">';
		html += '	<td>' + modId + '</td>';
		html += '	<td>';
		html += '		<div class="form-group">';
		html += '			<input type="text" name="content" value="' + modContent + '" class="form-control input-wp2" placeholder="내용을 입력하세요">';
		html += '		</div>';
		html += '	</td>';
		html += '	<td colspan="2">';
		html += '		<a href="javascript:commentUpdate(' + commentNo + ');" class="btn btn-success btn-sm" role="button">수정</a>';
		html += '		<a href="javascript:commentCancel(' + commentNo + ');" class="btn btn-warning btn-sm" role="button">취소</a>';
		html += '	</td>';
		html += '</tr>';
		$("#row" + commentNo).after(html);	
		$("#row" + commentNo).hide();
	}
	
	function commentUpdate(commentNo) {
		$.ajax({
			url: "<c:url value='/board/commentUpdate'/>",
			type: "POST",
			data: {
				bNo: "${board.bNo}", 
				content: $("#modRow" + commentNo + " input[name=content]").val(), 
				cNo: commentNo
			},
			dataType: "json",
			success: function (result) {
				makeCommentList(result);
			} 
		});
	}
	

	
	function commentCancel(commentNo) {
		$("#row" + commentNo).show();
		$("#modRow" + commentNo).remove();
	}
	
	// 댓글 등록 처리
	$("#rForm").submit(function (e) {
		e.preventDefault(); //submit 속성을없애고 이 함수를 실행하기위해서
		
		$.ajax({
			url: "<c:url value='/board/commentRegist'/>",
			type: "POST",
			data: {
				bNo: "${board.bNo}", 
				content: $("#rForm input[name='content']").val(), 
				anonymousId: $("#rForm input[name='anonymousId']").val()
			},
			dataType: "json"
		})
		.done(function (result) {
			alert("댓글등록이 완료되었습ㄷㅏ");
			if (!'${sessionScope.id}') {
				$("#rForm input[name='anonymousId']").val("");
			}
			$("#rForm input[name='content']").val("");
			
			makeCommentList(result);
		});
	});	
	
	// 댓글 목록 만드는 공통 함수
	function makeCommentList(result) {
		console.dir(result);
		var html = "";
		html += '<table class="table table-bordered">';
		html += '	<colgroup>'; 
		html += '		<col width="7%">'; 
		html += '		<col width="*">'; 
		html += '		<col width="14%">'; 
		html += '		<col width="10%">'; 
		html += '	</colgroup>'; 
		  
		for (var i = 0; i < result.length; i++) {
			var comment = result[i];
			html += '<tr id="row' + comment.cNo + '">';
			html += '	<td style="color:white;text-align:center">' + comment.anonymousId + '</td>';
			html += '	<td style="color:white; padding-left:50px;">' + comment.content + '</td>';
			var date = new Date(comment.regDate);
			var time = date.getFullYear() + "-" 
			         + (date.getMonth() + 1) + "-" 
			         + date.getDate() + " "
			         + date.getHours() + ":"
			         + date.getMinutes() + ":"
			         + date.getSeconds();
			html += '	<td style="color:white;">' + time + '</td>';
			html += '	<td>';    
			if('${sessionScope.id}' == comment.anonymousId) {
			html += '		<a href="javascript:commentUpdateForm(' + comment.cNo + ')" class="btn btn-success btn-sm" "role="button">수정</a>';    
			html += '		<a href="javascript:commentDelete(' + comment.cNo + ')" class="btn btn-danger btn-sm" role="button">삭제</a>';    
			}
			html += '	</td>';    
			html += '</tr>';
		}
		if (result.length == 0) {
			html += '<tr><td colspan="4" style="color:white; height:30px; padding-left:50px; text-align:center;">댓글이 존재하지 않습니다.</td></tr>';
		}
		html += "</title>";
		$("#commentList").html(html);
	}
	
	// 댓글 목록 조회
	function commentList() {
		$.ajax({
			url: "<c:url value='/board/commentList'/>",
			data: {bNo: "${board.bNo}"},
			dataType: "json", 
			success: makeCommentList
		});
	}
	
	
	
	
	
	// 상세 페이지 로딩시 댓글 목록 조회 ajax 호출
	commentList();	
	</script>
</div>





























