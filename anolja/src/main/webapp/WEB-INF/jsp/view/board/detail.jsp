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
		margin-left:10px;
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
	
	#commentArea {
		width:1100px;
		height: 100px;
		background-color:white;
	}
	
	
	
</style>
<div id="wrap">
${sessionSocpe.id}
	<div id="outer">
		<div id="title">
		<div style="width:1100px; height:5px; background-color:#2c3e50;margin-bottom:5px;"></div>
			<div id="title2" style="margin-left:20px;">
				<h1>${board.title}</h1>
			</div>


			<div id="bInfo" style="background-color:#2c3e50;">
				<span>${board.anonymousId}</span> <span>조회수 : ${board.viewCnt}</span> <span><fmt:formatDate
						value="${board.regDate}" pattern="yyyy-MM-dd" /></span>
			</div>
		</div>
		<div style="width:1100px; height:5px; background-color:#2c3e50; margin-top:5px;"></div>
<%-- 		 <c:if test="${!empty file}"> --%>
<!-- 			 <div id="fileList" style="width:1100px; height:35px; line-height:35px;"> -->
<!-- 			 	첨부파일 :  -->
<%-- 				<c:forEach var="file" items="${file}" > --%>
<%-- 					${file} , --%>
<%-- 				</c:forEach> --%>
<!-- 				<div style="width:1100px; height:5px; background-color:#2c3e50; margin-top:-5px;"></div> -->
<!-- 			 </div> -->
<%-- 		 </c:if>  --%>
		<div id="content_section">
			<p>
			 	<c:forEach var="result" items="${file}">
				 	<img src="${pageContext.request.contextPath}/board/fileOutPut?path=${result.path}&sysName=${result.sysName}" style="width:50%; height:50%; margin:0 auto;"/><br>
				 	<br>
			 	</c:forEach>
				${board.content}
			</p>	
		</div>
<!-- 		<div id="updateBtn"> -->
			<br>
<!-- 			<div> -->
<!-- 				<br> -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${sessionScope.id == board.anonymousId}"> --%>
<!-- 						<div class="write_box"> -->
<!-- 								<ul> -->
<%-- 									<li style="margin-left:735px;"><a style="background-color:#37cc25;"href="${pageContext.request.contextPath}/board/replyForm?bNo=${board.bNo}">답글</a></li> --%>
<%-- 									<li><a style="background:#f5db27;" href="updateForm?bNo=${board.bNo}">수정</a></li> --%>
<%-- 									<li onclick="confirm('삭제 하시겠습니까?');"><a style="background:#d82f2f;" href="delete?bNo=${board.bNo}">삭제</a></li> --%>
<!-- 									<li><a style="background:#0faeea;" href="list">목록</a></li> -->
<!-- 								</ul> -->
<!-- 						</div> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<div class="write_box"> -->
<!-- 								<ul> -->
<%-- 									<li style="margin-left:920px;"><a style="background-color:#37cc25;"href="${pageContext.request.contextPath}/board/replyForm?bNo=${board.bNo}">답글</a></li> --%>
<!-- 									<li style="float:right;"><a style="background:#0faeea;" href="list">목록</a></li> -->
<!-- 								</ul> -->
<!-- 						</div> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<br> <br> <br> <br> <br> <br> <br> -->
	</div>

	<!-- 댓글 시작 -->
	<section id="commentStart">
	<div style="width:1100px; height:5px; background-color:#2c3e50; margin-bottom:5px;"></div>
	<form action="commentUpdate" method="post">
		<input type="hidden" name="bNo" value="${board.bNo}}" />
		<input type="hidden" name="cNo" value="${comment.cNo}" />

		<!-- 댓글 목록 -->
		<div id="commentList"></div>
	</form>
		
		<!-- 댓글 관련 파트 시작 -->
		<c:if test="${!empty id}">
		<div id="commentArea">
			<form id="rForm" class="form-inline">
				<div id="comment">
					<div class="form-group" style="width:100px; height:50px; float:left; display:inline-block;">
						<input type="text" name="anonymousId" value="${sessionScope.id}" style="width:100px;height:50px; text-align:center; font-size:17px;" readonly/>
					</div>
					<div class="form-group" style="width:847px; height:50px; float:left;">
						<input type="text" id="content" name="content" class="form-control input-wo1" style="width:846px; height:50px; padding-left:23px; float:left" placeholder="내용을 입력하세요"  />
					</div>	
					<button style="margin-left:36px; font-color:white; width:100px; height:50px; background-color:#e65d5d" class="btnud" id="ps">등록</button>			
				</div>
			</form>	
		</div>
		</c:if>
		<div id="buttonsDiv">
		<div style="background-color:white;">
				<br>
				<c:choose>
					<c:when test="${sessionScope.id == board.anonymousId}">
						<div class="write_box">
								<ul>
									<li style="margin-left:773px;"><a style="background-color:#37cc25;"href="${pageContext.request.contextPath}/board/replyForm?bNo=${board.bNo}">답글</a></li>
									<li><a style="background:#f5db27;" href="updateForm?bNo=${board.bNo}">수정</a></li>
<%-- 									<li><a onclick='return del();' id="kkkk" style="background:#d82f2f;" href="delete?bNo=${board.bNo}" role="button">삭제</a></li> --%>
									<li><a id="kkkk" style="background:#d82f2f;" role="button">삭제</a></li>
									<li><a style="background:#0faeea;" href="list">목록</a></li>
								</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="write_box">
								<ul>
								<c:if test="${!empty id}">
									<li style="margin-left:950px;"><a style="background-color:#37cc25;"href="${pageContext.request.contextPath}/board/replyForm?bNo=${board.bNo}">답글</a></li>
								</c:if>
									<li style="float:right;"><a style="background:#0faeea;" href="list">목록</a></li>
								</ul>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			</div>
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
		html += '	<td style="text-align:center; color:white;" >' + modId + '</td>';
		html += '	<td>';
		html += '		<div class="form-group">';
		html += '			<input type="text" name="content" value="' + modContent +
		'" class="form-control input-wp2" placeholder="내용을 입력하세요" style="height:33px; width:616px; padding-left:30px;  line-height:50px;">';
		html += '		</div>';
		html += '	</td>';
		html += ' <td></td>'
		html += '	<td colspan="1">';
		html += '		<a href="javascript:commentUpdate(' + commentNo + ');" class="btnud" role="button">수정</a>';
		html += '		<a href="javascript:commentCancel(' + commentNo + ');" class="btnud" role="button">취소</a>';
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
		html += '		<col width="10%">'; 
		html += '		<col width="*">';
		html += '		<col width="18%">'; 
		html += '		<col width="10%">'; 
		html += '	</colgroup>'; 
		  
		for (var i = 0; i < result.length; i++) {
			var comment = result[i];
			html += '<tr id="row' + comment.cNo + '">';
			html += '	<td style="color:white;text-align:center">' + comment.anonymousId + '</td>';
			html += '	<td style="color:white; padding-left:50px; ">' + comment.content + '</td>';
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
			html += '		<a href="javascript:commentUpdateForm(' + comment.cNo + ')" class="btnud" "role="button">수정</a>  &nbsp;';    
			html += '		<a style="width:100px;" href="javascript:commentDelete(' + comment.cNo + ')" class="btnud" role="button">삭제</a>';    
			}
			html += '	</td>';    
			html += '</tr>';
		}
		if (result.length == 0) {
			html += '<tr><td colspan="1" style="color:white; height:50px;  line-height:50px; text-align:center;">댓글이 존재하지 않습니다.</td></tr>';
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
	
	function del() {
// 		var result = confirm("삭제 하시겠습니까?");
// 		var result = swal("삭제 하시겠습니까?");
// 		swal({
// 		  title: "삭제 하시겠습니까?",
// 		  icon: "warning",
// 		  buttons: true,
// 		  dangerMode: true,
// 		})
// 		.then(willDelete => {
// 		  if (willDelete) {
// 		    swal('삭제 되었습니다.', {
// 		      icon: "success",
// 		    });
// 		  } else {
// 			return 'false';
// 		  }
// 		});
		
		
// 		if(result == false) {
// 			return false;
// 		} else {
// 			swal({
// 				  icon: 'success',
// 				  title: '삭제 되었습니다.',
// 				  showConfirmButton: false,
// 				  timer: 2500
// 				})
// 		}
	}

$("#kkkk").click(function () {
	swal({
		  title: "삭제 하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then(willDelete => {
		  if (willDelete) {
		    swal('삭제 되었습니다.', {
		      icon: "success",
		    }).then((suc) => {
		    	location.href = `delete?bNo=${board.bNo}`;
		    });
		  } else {
			return false;
		  }
		});
	});
	</script>
</div>





























