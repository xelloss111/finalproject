<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/youtube.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoMain.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/videoModal1.js'></script>

<section class="content_section">
	<div class="content_row_1">

		<!-- 검색 영역 -->
		<input type="text" id="videoSearch" name="videoSearch"
			placeholder="     YOUTUBE 영상 검색 GO!" />
		<button type="submit" value="Search" class="sc_btn">
			<i class="fas fa-search-plus"></i>
		</button>
		
		<div class="searchList">
			<ul class="list_ul">
				<li class="list_select">
					<form name="lForm" id="lForm" method="post">
						<select class="round" name="myTank_list" id="myTank_list" onchange="chageLangSelect()">
							<option value="tank0"> 내 저장 리스트 불러오기</option>
							
							
								<c:forEach var="tankList" items="${tankList}">
									<option value="${tankList.tankId}">${tankList.tankName}</option>
								</c:forEach>
							
						</select>
					</form>
				</li>
				<li class="myTank"  data-toggle="modal" data-target="#myModal2">
					<span>내 저장소 관리</span>
				</li>
			</ul>
			
		</div>

		<!-- 캐러셀 영역 시작 -->
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span12">
					<div class="carousel slide " id="myCarousel" data-interval="false">
						<div class="carousel-inner" id='carousel-inner'></div>
						<!-- carousel-innerEND -->
					</div>
					<!-- /#myCarousel -->


				</div>
				<!-- /.span12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container -->
		<!-- 캐러셀 영역 끝 -->

		<div class="thumb_imgs">
			<ul class='clickList' id="clickList">

			</ul>
		</div>


	</div>
	<!-- content_row_1 END -->
	
	
	<!-- 모달 영역 1 -->

	  <!-- 동영상 저장소 -->
	  <div class="modal fade" id="myModal1" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">동영상 저장소</h4>
	        </div>
	        
	        
	        <div class="modal-body">
	        

					<form name="saveTank" id="saveTank">
						<div class="save_myTank">
							<ul>
								<li><span>새로운 저장소 만들기 :</span> 
									<input type="text" placeholder="    새로운 저장소 이름" name="tankName1" class="newTank">
									<input type="button" value=" 추가 " onclick="addOption()">
								</li>

								<li class="oldTank"><span>기존 저장소에 저장 :</span> <select
									class="round" name="tankName2" id="tank_list">
										<option value="tank0">저장 리스트 불러오기</option>
										
										<c:forEach var="tankList" items="${tankList}">
											<option value="${tankList.tankId}">${tankList.tankName}</option>
										</c:forEach>
								
								</select></li>

							</ul>
						</div>
						<!-- save_myTank END -->
						<hr>

						<div class="save_info">
							<h2>저장 동영상 정보</h2>

							<ul>
								<li class="save_thumb">
									<!-- 여기가 섬네일 위치 -->
								</li>
								<li class="save_titleaddr">
									
									<!-- 여기가 제목 위치 -->
								</li>
							</ul>
						</div>
						<!-- save_info END -->
						<div class="save_list_btn">
							<input type="button" class="btn btn-primary" value="저장하기"
							id="submit">
						</div>
					</form>

				</div>
	        <!-- modal-body END-->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>	
	<!-- 모달1 영역 끝 -->
	
	
	<!-- 모달 영역 2 -->
	<!-- 내 동영상 LIST -->
	  <div class="modal fade" id="myModal2" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h4 class="modal-title">My YOUTUBE 저장소</h4>
	        </div>
	        <div class="modal-body">
	          <p>Some text in the modal.</p>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
</section>
