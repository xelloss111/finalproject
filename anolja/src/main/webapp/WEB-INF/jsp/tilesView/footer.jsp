<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<footer class="footer">
	<p>copyright&copy; 2018. ANOLJA all rights reserved.</p>
</footer>

</div>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/note.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/notesendUI.css">


<!-- 받은 편지함 모달 -->
<div class="modal fade" id="noteLogG" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content display-area">
			<div class="modal-header">
				<button type="button" class="closeFixed" data-dismiss="modal">×</button>
				<!-- <h4 class="modal-title"></h4> -->
			</div>
			<div class="modal-body">
				<nav class="navbarFixed navbar-inverseFixed">
					<div class="container-fluidFixed">
						<div class="navbar-headerFixed">
							<a class="navbar-brandFixed" href="#">쪽지함</a>
						</div>
						<ul class="navFixed navbar-navFixed">
							<li><a href="send">보낸 쪽지함</a></li>
							<li><a href="get">받은 쪽지함</a></li>

						</ul>
						<ul class="navFixed navbar-navFixed navbar-rightFixed">
						</ul>
					</div>
				</nav>
				<div class="w3-container">

					<table class="w3-table-all w3-hoverable">
						<thead>
							<tr class="w3-light-grey">
								<th>글 번호</th>
								<th>보낸이</th>
								<th>내용</th>
								<th>작성시간</th>
								<th>확인시간</th>
							</tr>
						</thead>


					</table>
				</div>

				<div class="modal-footerFixed btn-area" style="text-align: right">
					<div class="button-list btnFixed"
						style="float: left; margin-left: 20px;">
						<button type="button" class="btnFixed"
							style="text-shadow: 0 0 black;">글쓰기</button>
						<button type="button" class="btnFixed">삭제</button>
					</div>
					<div class="button-list btnFixed" style="margin-right: 40px;">
						<button type="button" class="btnFixed">이전</button>
						<button type="button" class="btnFixed">다음</button>
						<button type="button" class="btnFixed">처음으로</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
<!-- 받은 편지함 모델 끝 -->

<script>
	$(document).ready(function() {
		/*페이징 현재 페이지 나타내는 변수*/
		var notePageNo = 0;
		
		var html="";
		
		/*로그인한 사람만 사용할 수 있도록 하기위한 세션 아이디*/
		var sessionId = `<%=session.getAttribute("id")%>`;
		
		/*받은 쪽지함 내용물(태그) 출력 메소드<매개변수로 getnote의 출력결과가 와야한다>*/
		function resultList(result){
			html="<table class=\"w3-table-all w3-hoverable\">" + 
			"<thead>" + 
			"<tr class='w3-light-grey'>" + 
			"<th></th>"+
			"<th>보낸이</th>" + 
			"<th>제목</th>" + 
			"<th>작성시간</th>" + 
			"<th>읽음</th>" + 
			"</tr>" + 
			"</thead>";
    	for(let j=0; j < result.length; j++){
    		console.log(result[j].title);
    		let dateTime = new Date(result[j].sendDate);
    		html +=	'<tr>'+ 
    		'<td>'+'<input type="checkbox" name=\"ch'+j+'\" value='+result[j].id+'></td>'+
    		'<td>'+result[j].sendId+ "</td>" + 
    		'<td>'+result[j].title+'</td>' + 
    		'<td>'+dateTime.toLocaleDateString().slice(0,-1)+'</td>' + 
    		'<td>'+result[j].status+'</td>'+
    		'</tr>'; 
    	}
    	html+="</table>";
      
    	$("#noteLogG > div > div > div.modal-body > div.w3-container").html(html);
    	
    	/* 받은 쪽지함 디테일 페이지로 이동 이벤트 걸기*/
    	for(let j=0; j < result.length; j++){
    	$("#noteLogG > div > div > div.modal-body > div.w3-container > table > tbody > tr:nth-child("+(j+1)+") > td:nth-child(3)").click(function(){
    	
        let dateTime = new Date(result[j].sendDate);
    		
        html="<div class=\"title-areaFixed\">" + 
    		"<h4>"+result[j].title+"</h4>" + 
    		"</div>" + 
    		"<div class=\"writer-areaFixed\"><span class=\"writername-areaFixed\">"+result[j].sendId+"</span><span class=\"send-date\">"+dateTime.toLocaleDateString().slice(0,-1)+"</span>" + 
    		"<div class=\"write-date-areaFixed\"><span>2018-09-04</span></div>" + 
    		"</div>" + 
    		"<div class=\"content-area\">"+result[j].content+"</div>";
    		
         $("#noteLogG > div > div > div.modal-body > div.w3-container").html(html);
         });
         };
    	
      /*삭제 기능 이벤트 걸기*/
      $("#noteLogG > div > div > div.modal-body > div.modal-footerFixed.btn-area > div:nth-child(1) > button:nth-child(2)").click(function(){
    	  var checkedList = []; 
    	  $("#noteLogG > div > div > div.modal-body > div.w3-container > table > tbody input[type='checkbox']").each(function(){
    		if($(this).prop("checked")){
    			checkedList.push($(this).val());
    		}
    	  });
    	  
    	  if(checkedList.length == 0){
    		  alert("삭제할 대상을 체크해주세요.")
    		  return;
    	  }
    		$.ajax({
    				url : "${pageContext.request.contextPath}/deletenote",
    				data : JSON.stringify(checkedList),
    				contentType:'application/json',
    				type : "POST",
    				dataType : "JSON"
    			})
    			.done(function (result) {
    					alert(result);
    			});
    		
    		
    	  });
    		}
		
		/* 쪽지 받기 모달 시작 부분 */
		/* 받은 쪽지함 함수*/
		function getRevList(getObject){
			$(getObject).click(function(e) {
				/*로그인 여부 확인 얼럿*/
 				if(sessionId == 'null'){
 					alert("로그인을  해주세요.");
 					return;
 				}
				
				//페이징 값 초기화
				notePageNo = 0;
				
				e.preventDefault();
				
				var html = "";
				
				$.ajax({
					url : "${pageContext.request.contextPath}/getnotelist",
					type : "GET",
					dataType : "JSON"
				})
				.done(function (result) {
					for(let i = 0; i < result.length; i++) {
						console.log(result[i].title);
					}
					resultList(result);
			   /*ajax끝나는 괄호 */		
				});
				
				$("#noteLogG").modal({
					backdrop : false
				});
	         });
			
		}
		
		/*버튼에 리스트 출력 이벤트 거는 함수 실행문*/
		getRevList("#quick_right_menu > ul > li > a");
		getRevList("#noteLogG > div > div > div.modal-body > nav > div > ul:nth-child(2) > li:nth-child(2) > a");
        
		/*페이지 전환 코딩 시작*/
		
		/* 다음 버튼 클릭시 */
		$("#noteLogG > div > div > div.modal-body > div.modal-footerFixed.btn-area > div:nth-child(2) > button:nth-child(2)").click(function(){
			
			notePageNo = notePageNo+10;
			
			$.ajax({
				url : "${pageContext.request.contextPath}/getnotelist",
				type : "GET",
				data : "notePageNo="+notePageNo,
				dataType : "JSON"
			}).done(function (result) {
				for(let i = 0; i < result.length; i++) {
					console.log(result[i].title);
				}
				alert(notePageNo);
				
				if(result.length == 0){
					alert("다음 페이지가 존재하지 않습니다.");
					notePageNo = notePageNo-10;
					return;
				}
				resultList(result);
			/*ajax 끝나는 부분*/
		});
		});
		
		
		/* 이전 버튼 클릭시 */
		
		$("#noteLogG > div > div > div.modal-body > div.modal-footerFixed.btn-area > div:nth-child(2) > button:nth-child(1)").click(function(){

			notePageNo = notePageNo-10;
			
			if(notePageNo == -10){
				alert("이전 페이지가 존재하지 않습니다.");
				notePageNo = notePageNo+10;
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/getnotelist",
				type : "GET",
				data : "notePageNo="+notePageNo,
				dataType : "JSON"
			}).done(function (result) {
				for(let i = 0; i < result.length; i++) {
					console.log(result[i].title);
				}
				alert(notePageNo);
				/*
				if(result.length == 0){
					alert("더 이상 보여줄 쪽지가 없습니다.");
					notePageNo = notePageNo+10;
					return;
				}
				*/
				resultList(result);
			/*ajax 끝나는 부분*/
		});
		});
		
		/*처음으로 버튼 클릭시 */
		$("#noteLogG > div > div > div.modal-body > div.modal-footerFixed.btn-area > div:nth-child(2) > button:nth-child(3)").click(function(){
            notePageNo = 0;
			
			if(notePageNo == -10){
				alert("이전 페이지가 존재하지 않습니다.");
				notePageNo = notePageNo+10;
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath}/getnotelist",
				type : "GET",
				data : "notePageNo="+notePageNo,
				dataType : "JSON"
			}).done(function (result) {
				for(let i = 0; i < result.length; i++) {
					console.log(result[i].title);
				}
				alert(notePageNo);
				/*
				if(result.length == 0){
					alert("더 이상 보여줄 쪽지가 없습니다.");
					notePageNo = notePageNo+10;
					return;
				}
				*/
				resultList(result);
			/*ajax 끝나는 부분*/
		});
		});
		
		/*처음으로 버튼 취소 시*/
		
		/*이전버튼 클릭시 종료 */
		/*페이지 전환 코딩 끝*/
		
		
		/*게시글 받기 모달 끝 */
		
		/*게시글 쓰기 모달 */
        $("#noteLogG > div > div > div.modal-body > div.modal-footerFixed.btn-area > div:nth-child(1) > button:nth-child(1)").click(function(){
         			
         	 html = "<div id=\"form-main\">" + 
         			"<div id=\"form-div\">" + 
         			"<form class=\"form\" id=\"form1\">" + 
         			"<p class=\"getId\">" + 
         			"<input name=\"getId\" type=\"text\"" + 
         			"class=\"validate[required,custom[onlyLetter],length[0,100]] feedback-input\"" + 
         			"placeholder=\"Name\" id=\"name\" />" + 
         			"</p>" + 
         			"<p class=\"title\">" + 
         			"<input name=\"title\" type=\"text\"" + 
         			"class=\"validate[required,custom[email]] feedback-input\"" + 
         			"placeholder=\"Title\" />" + 
         			"</p>" + 
         			"<p class=\"content\">" + 
         			"<textarea name=\"content\"" + 
         			"class=\"validate[required,length[6,300]] feedback-input\"" + 
         			"placeholder=\"Comment\"></textarea>" + 
         			"</p>" + 
         			"<div class=\"submit\">" + 
         			"<input type=\"submit\" value=\"보내기\" id=\"button-blue\" />" + 
         			"<div class=\"ease\"></div>" + 
         			"</div>" + 
         			"</form>" + 
         			"</div>" + 
         			"</div>" + 
         			"<div class=\"modal-footer\">";
         			
         			$("#noteLogG > div > div > div.modal-body > div.w3-container").html(html);
         			
         			$("#form1").submit(function(event){
         				if(event.preventDefault){event.preventDefault()};
         				
         				var note = $('#form1').serialize();
         				
         				alert(note);
         
         				$.ajax({
         					url : "${pageContext.request.contextPath}/sendnote",
         					data : note,
         					type : "POST",
         					dataType : "JSON"
         				})
         				.done(function (result) {
         					alert("쪽지 보내기 완료")
         				}); /*ajax 마침표*/
         		});	
         		});
         	/*쓰기 모듈 끝부분 */
		
        /*보낸편지함 모달 시작 */
        $("#noteLogG > div > div > div.modal-body > nav > div > ul:nth-child(2) > li:nth-child(1) > a").click(function(e) {
	 	 	e.preventDefault();
	 	 	
	 	 	var html = "";
	 	 	
	 	 	$.ajax({
	 	 		url : "${pageContext.request.contextPath}/sendnotelist",
	 	 		type : "POST",
	 	 		dataType : "JSON"
	 	 	})
	 	 	.done(function (result) {
	 	 		html+="<table class=\"w3-table-all w3-hoverable\">" + 
	 	 				"<thead>" + 
	 	 				"<tr class='w3-light-grey'>" + 
	 	 				"<th></th>"+
	 	 				"<th>받은이</th>" + 
	 	 				"<th>제목</th>" + 
	 	 				"<th>작성시간</th>" + 
	 	 				"<th>읽음</th>" + 
	 	 				"</tr>" + 
	 	 				"</thead>";
	 	 		for(let j=0; j < result.length; j++){
	 	 			console.log(result[j].title);
	 	 			
	 	 			let dateTime = new Date(result[j].sendDate);
	 	 			
	 	 			html +=	'<tr>'+ 
	 	 			'<td>'+'<input type="checkbox" name=\"ch'+j+'\" value='+result[j].id+'></td>'+
	 	 			'<td>'+result[j].getId+ "</td>" + 
	 	 			'<td>'+result[j].title+'</td>' + 
	 	 			'<td>'+dateTime.toLocaleDateString().slice(0,-1)+'</td>' + 
	 	 			'<td>'+result[j].status+'</td>'+
	 	 			'</tr>'; 
	 	 			/*최근 보낸 편지 10개만 보여준다.*/
	 	 			if(j == 9){
	 	 				break;
	 	 			}
	 	 		}
	 	 		html+="</table>";
	 	 	  
	 	 		$("#noteLogG > div > div > div.modal-body > div.w3-container").html(html);
	 	 		
	 	 		/* 받은 쪽지함 디테일 페이지로 이동 이벤트 걸기*/
	 	 		/*
	 	 		for(let j=0; j < result.length; j++){
	 	 		$("#noteLogG > div > div > div.modal-body > div.w3-container > table > tbody > tr:nth-child("+(j+1)+") > td:nth-child(3) > a").click(function(){
	 	 			
	 	 	  html="<div class=\"title-areaFixed\">" + 
	 	 			"<h4>"+result[j].title+"</h4>" + 
	 	 			"</div>" + 
	 	 			"<div class=\"writer-areaFixed\"><span class=\"writername-areaFixed\">"+result[j].sendId+"</span><span class=\"send-date\">"+result[j].sendDate+"</span>" + 
	 	 			"<div class=\"write-date-areaFixed\"><span>2018-09-04</span></div>" + 
	 	 			"</div>" + 
	 	 			"<div class=\"content-area\">"+result[j].content+"</div>";
	 	 			
	 	 	  $("#noteLogG > div > div > div.modal-body > div.w3-container").html(html);
	 	 		});
	 	 		};
	 	 		*/
	 	 		
	 	    /*ajax끝나는 괄호 */		
	 	 	});
	 	 	
	 	 	$("#noteLogG").modal({
	 	 		backdrop : false
	 	 	});
           });
          /*보낸 편지 모달 끝*/
         
          });
</script>