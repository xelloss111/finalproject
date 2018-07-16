<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/searchresult.css">

<section class="content_section">
	<div class="content_row_1">

		<!-- 여기부터 -->
		<div id="search-nav">
			<img
				src="${pageContext.request.contextPath}/resources/images/battleground/Letter2.png"
				width="100px" height="40px" style="margin-left: 10px;"> <img
				src="${pageContext.request.contextPath}/resources/images/battleground/google-web-search-256.png"
				width="35px" height="35px"
				style="float: right; margin-right: 40px; margin-top: 2.2px;">
			<input type="text" id="nav-input" placeholder="검색할 ID 입력">
		</div>

		<div class="main">
			<div class="left-side"></div>

			<div class="center">
				<div class="player-summary">
					<div class="player-name-space">
						<span class="player-name">${characterName}의 전적정보</span>
					</div>
				</div>

				<div class="season-select-wrapper">
					<select id="season-selbox" name="season">
						<!-- <option selected>시즌7</option> -->
						<option value="division.bro.official.2018-06" selected="selected">시즌6</option>
						<option value="division.bro.official.2018-05">시즌5</option>
						<option value="division.bro.official.2018-04">시즌4</option>
					</select>
				</div>

				<div class="rank-wrapper">

					<div class="rank-box solobox">
						<h4 class="rank-stats-title-solo"
							style="background-color: #ff1e3c">솔로</h4>
						<!--  -->
						<c:choose>
							<c:when test="${solo.roundsPlayed ne 0}">
								<div class="rank-stats-header">
									<div class="rank-stats-grade">
										<img class="rank-image"
											src="${pageContext.request.contextPath}/resources/images/battleground/Rank-Icon/bronze.png">
									</div>
									<div class="rank-stats-data">
										<div class="rank-score">
											<fmt:formatNumber
												value="${((solo.winPoints*100.36)+(solo.killPoints*19.61))/100}"
												pattern="0" />
										</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">
											KillPoints
											<fmt:formatNumber value="${solo.killPoints}" pattern="0" />
										</div>
										<div class="rank-ranking">
											WinPoints
											<fmt:formatNumber value="${solo.winPoints}" pattern="0" />
										</div>
									</div>
								</div>

								<div class="ranked-stats__detailed">
									<ul class="ranked-stats__list">
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">K/D</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${solo.kills/solo.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">경기 당 데미지</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${solo.damageDealt/solo.roundsPlayed}" pattern="0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>승률</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${solo.wins/solo.roundsPlayed*100}"
													pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div >Top10%</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${solo.top10s/solo.roundsPlayed*100}" pattern=".0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최대거리 킬</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${solo.longestKill}" pattern=".0" />
												m
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>헤드샷</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${solo.headshotKills/solo.kills*100}" pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>팀킬</div>
											<div class="ranked-stats__value">${solo.teamKills}</div>
										</li>
										<li class="ranked-stats__item">
											<div>평균 생존시간</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${(solo.timeSurvived/solo.roundsPlayed)/60}"
													pattern="0" />
												minutes
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>KDA</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${(solo.kills+solo.assists)/solo.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최다 킬</div>
											<div class="ranked-stats__value">${solo.roundMostKills}</div>
										</li>
									</ul>

								</div>
							</c:when>
							<c:when test="${solo.roundsPlayed eq 0}">
								<div class="rank-stats-header">
									<div class="no-status">
										<img
											src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png"
											width="70px" height="70px">
										<p>표시할 전적이 없습니다.</p>
									</div>

								</div>
							</c:when>
						</c:choose>


					</div>

					<div class="rank-box duobox">
						<h4 class="rank-stats-title-duo" style="background-color: #ffa035">듀오</h4>
						<c:choose>
							<c:when test="${duo.roundsPlayed ne 0}">
								<div class="rank-stats-header">
									<div class="rank-stats-grade">
										<img class="rank-image"
											src="${pageContext.request.contextPath}/resources/images/battleground/Rank-Icon/bronze.png">
									</div>
									<div class="rank-stats-data">
										<div class="rank-score">
											<fmt:formatNumber
												value="${((duo.winPoints*100.36)+(duo.killPoints*19.61))/100}"
												pattern="0" />
										</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">
											KillPoints
											<fmt:formatNumber value="${duo.killPoints}" pattern="0" />
										</div>
										<div class="rank-ranking">
											WinPoints
											<fmt:formatNumber value="${duo.winPoints}" pattern="0" />
										</div>
									</div>
								</div>

								<div class="ranked-stats__detailed">
									<ul class="ranked-stats__list">
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">K/D</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${duo.kills/duo.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">경기 당 데미지</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${duo.damageDealt/duo.roundsPlayed}" pattern="0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>승률</div>
											<div>
												<fmt:formatNumber value="${duo.wins/duo.roundsPlayed*100}"
													pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>Top10%</div>
											<div>
												<fmt:formatNumber value="${duo.top10s/duo.roundsPlayed*100}"
													pattern=".0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최대거리 킬</div>
											<div>
												<fmt:formatNumber value="${duo.longestKill}" pattern=".0" />
												m
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>헤드샷</div>
											<div>
												<fmt:formatNumber value="${duo.headshotKills/duo.kills*100}"
													pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>팀킬</div>
											<div>${solo.teamKills}</div>
										</li>
										<li class="ranked-stats__item">
											<div>평균 생존시간</div>
											<div>
												<fmt:formatNumber
													value="${(duo.timeSurvived/duo.roundsPlayed)/60}"
													pattern="0" />
												minutes
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>KDA</div>
											<div>
												<fmt:formatNumber
													value="${(duo.kills+duo.assists)/duo.losses}" pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최다 킬</div>
											<div>${duo.roundMostKills}</div>
										</li>
									</ul>

								</div>
							</c:when>
							<c:when test="${duo.roundsPlayed eq 0}">
								<div class="rank-stats-header">
									<div class="no-status">
										<img
											src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png"
											width="70px" height="70px">
										<p>표시할 전적이 없습니다.</p>
									</div>
								</div>
							</c:when>
						</c:choose>

					</div>
					<!-- 전적 없을 시에 표시할 화면 					
					<div class="rank-box">
						<h4 class="rank-stats-title-duo" style="background-color: #ffa035">듀오</h4>
						<div class="rank-stats-header">
							<div class="no-status">
								<img
									src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png"
									width="70px" height="70px">
								<p>표시할 전적이 없습니다.</p>
							</div>

						</div>

					</div>
					 -->


					<div class="rank-box squadbox">
						<h4 class="rank-stats-title-squad"
							style="background-color: #448cff">스쿼드</h4>
						<c:choose>
							<c:when test="${squad.roundsPlayed ne 0}">
								<div class="rank-stats-header">
									<div class="rank-stats-grade">
										<img class="rank-image"
											src="${pageContext.request.contextPath}/resources/images/battleground/Rank-Icon/bronze.png">
									</div>
									<div class="rank-stats-data">
										<div class="rank-score">
											<fmt:formatNumber
												value="${((squad.winPoints*100.36)+(squad.killPoints*19.61))/100}"
												pattern="0" />
										</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">
											KillPoints
											<fmt:formatNumber value="${squad.winPoints}" pattern="0" />
										</div>
										<div class="rank-ranking">
											WinPoints
											<fmt:formatNumber value="${squad.winPoints}" pattern="0" />
										</div>
									</div>
								</div>

								<div class="ranked-stats__detailed">
									<ul class="ranked-stats__list">
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">K/D</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${squad.kills/squad.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div class="ranked-stats__key">경기 당 데미지</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${squad.damageDealt/squad.roundsPlayed}" pattern="0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>승률</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${squad.wins/squad.roundsPlayed*100}" pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>Top10%</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${squad.top10s/squad.roundsPlayed*100}" pattern=".0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최대거리 킬</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber value="${squad.longestKill}" pattern=".0" />
												m
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>헤드샷</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${squad.headshotKills/squad.kills*100}" pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>팀킬</div>
											<div class="ranked-stats__value">${solo.teamKills}</div>
										</li>
										<li class="ranked-stats__item">
											<div>평균 생존시간</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${(squad.timeSurvived/squad.roundsPlayed)/60}"
													pattern="0" />
												minutes
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>KDA</div>
											<div class="ranked-stats__value">
												<fmt:formatNumber
													value="${(squad.kills+squad.assists)/squad.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최다 킬</div>
											<div class="ranked-stats__value">${squad.roundMostKills}</div>
										</li>
									</ul>

								</div>
							</c:when>
							<c:when test="${squad.roundsPlayed eq 0}">
								<div class="rank-stats-header">
									<div class="no-status">
										<img
											src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png"
											width="70px" height="70px">
										<p>표시할 전적이 없습니다.</p>
									</div>

								</div>
							</c:when>
						</c:choose>
					</div>

					<!-- rank-wrapper/div 끝 부분 -->
				</div>

				<!--Rank-Wrapper 블럭박스 끝-->

				<div class="matches-filter">
					<ul style="list-style: none; float: right;">
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn allbtn">전체</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn solobtn">솔로</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn duobtn">듀오</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn squadbtn">스쿼드</button>
						</li>
					</ul>
				</div>

				<div class="matches-list-layer">
					<ul class="matches__list">
						<c:forEach var="mlog" items="${ulist}">
							<li class="matches-item ${mlog.gameMode}">
								<div class="matches-item_summary">
									<div class="matches-item-column-status matches-item__column">
										<i></i>
										<div>게임 일시</div>
										<div>${mlog.createdAt}</div>
									</div>
									<div class="matches-item-column-status matches-item__column">
										<div>게임 모드</div>
										<div class="matches-game-mode">${mlog.gameMode}</div>
									</div>
									<div class="matches-item-column-rank matches-item__column">
										<div>${mlog.winPlace}</div>
										<div>등</div>
									</div>

									<div class="matches-item-column-kill matches-item__column">
										<div>${mlog.kills}</div>
										<div>킬</div>
									</div>
									<div class="matches-item-column-damage matches-item__column">
										<div>
											<fmt:formatNumber value="${mlog.damageDealt}" pattern="0" />
										</div>
										<div>데미지</div>
									</div>
									<div class="matches-item-column-distance matches-item__column">
										<div>
											<fmt:formatNumber
												value="${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}"
												pattern="0" />
											M
										</div>
										<div>총 이동 거리</div>
									</div>

									<div class="matches-item-column-distance matches-item__column">
										<div>${mlog.mapName}</div>
										<div>맵</div>
									</div>
									<div class="matches-item-column-team matches-item__column">

									</div>

								</div>
							</li>

						</c:forEach>
					</ul>
					<button data-selector="total-played-game-btn-more"
						class="total-played-game__btn total-played-game__btn--more loadLog">더
						보기</button>
				</div>

			</div>

			<div class="right-side"></div>
		</div>
	</div>
</section>

<script>
	var displayCnt = 4; //화면 첫 로딩시 보여줄 리스트 개수 지정 관련 변수

	$(document).ready(
			function() {
				$("ul.matches__list li").eq(displayCnt).nextAll().css(
						"display", "none");
			})

	$(function() {
		$("#season-selbox")
				.change(
						function() {
							var selected = $(this).val();
							$.ajax({
										url : "${pageContext.request.contextPath}/getseasoninfo",
										headers : {
											"Content-Type" : "text/html"
										},
										type : "GET",
										data : "season=" + selected
												+ "&characterName="
												+ '${characterName}',
										dataType : "JSON",
										success : function(data) {
											console.log(data[0].roundsPlayed);
											
											var solo = data[0];
											var duo = data[1];
											var squad = data[2];
											
											alert(((solo.winPoints*100.36)+(solo.killPoints*19.61))/100);
											
											var $soloBox = ".rank-box.solobox";
											var $duoBox = ".rank-box.duobox";
											var $squadBox = ".rank-box.squadbox";
																						
											$($soloBox).find(".rank-score").text((((solo.winPoints*100.36)+(solo.killPoints*19.61))/100).toFixed(0));
											$($soloBox).find(".rank-ranking").eq(0).text("KillPoints"+solo.killPoints.toFixed(0));
											$($soloBox).find(".rank-ranking").eq(1).text("WinPoints"+solo.winPoints.toFixed(0));
											$($soloBox).find(".ranked-stats__value").eq(0).text((solo.kills/solo.losses).toFixed(2));
											$($soloBox).find(".ranked-stats__value").eq(1).text((solo.damageDealt/solo.roundsPlayed).toFixed(0));
											$($soloBox).find(".ranked-stats__value").eq(2).text((solo.wins/solo.roundsPlayed*100).toFixed(1)+"%");
											$($soloBox).find(".ranked-stats__value").eq(3).text((solo.top10s/solo.roundsPlayed*100).toFixed(1));
											$($soloBox).find(".ranked-stats__value").eq(4).text(solo.longestKill.toFixed(0)+" m");
											$($soloBox).find(".ranked-stats__value").eq(5).text((solo.headshotKills/solo.kills*100).toFixed(1)+"%");
											$($soloBox).find(".ranked-stats__value").eq(6).text(solo.teamKills.toFixed(0));
											$($soloBox).find(".ranked-stats__value").eq(7).text(((solo.timeSurvived/solo.roundsPlayed)/60).toFixed(0)+" minutes");
											$($soloBox).find(".ranked-stats__value").eq(8).text(((solo.kills+solo.assists)/solo.losses).toFixed(2));
											$($soloBox).find(".ranked-stats__value").eq(9).text(solo.roundMostKills.toFixed(0));
											
											$($duoBox).find(".rank-score").text((((duo.winPoints*100.36)+(duo.killPoints*19.61))/100).toFixed(0));
											$($duoBox).find(".rank-ranking").eq(0).text("KillPoints"+duo.killPoints.toFixed(0));
											$($duoBox).find(".rank-ranking").eq(1).text("WinPoints"+duo.winPoints.toFixed(0));
											$($duoBox).find(".ranked-stats__value").eq(0).text((duo.kills/duo.losses).toFixed(2));
											$($duoBox).find(".ranked-stats__value").eq(1).text((duo.damageDealt/duo.roundsPlayed).toFixed(0));
											$($duoBox).find(".ranked-stats__value").eq(2).text((duo.wins/duo.roundsPlayed*100).toFixed(1)+"%");
											$($duoBox).find(".ranked-stats__value").eq(3).text((duo.top10s/duo.roundsPlayed*100).toFixed(1));
											$($duoBox).find(".ranked-stats__value").eq(4).text(duo.longestKill.toFixed(0)+" m");
											$($duoBox).find(".ranked-stats__value").eq(5).text((duo.headshotKills/duo.kills*100).toFixed(1)+"%");
											$($duoBox).find(".ranked-stats__value").eq(6).text(duo.teamKills.toFixed(0));
											$($duoBox).find(".ranked-stats__value").eq(7).text(((duo.timeSurvived/duo.roundsPlayed)/60).toFixed(0)+" minutes");
											$($duoBox).find(".ranked-stats__value").eq(8).text(((duo.kills+duo.assists)/duo.losses).toFixed(2));
											$($duoBox).find(".ranked-stats__value").eq(9).text(duo.roundMostKills.toFixed(0));
											
											$($squadBox).find(".rank-score").text((((squad.winPoints*100.36)+(squad.killPoints*19.61))/100).toFixed(0));
											$($squadBox).find(".rank-ranking").eq(0).text("KillPoints"+squad.killPoints.toFixed(0));
											$($squadBox).find(".rank-ranking").eq(1).text("WinPoints"+squad.winPoints.toFixed(0));
											$($squadBox).find(".ranked-stats__value").eq(0).text((squad.kills/squad.losses).toFixed(2));
											$($squadBox).find(".ranked-stats__value").eq(1).text((squad.damageDealt/squad.roundsPlayed).toFixed(0));
											$($squadBox).find(".ranked-stats__value").eq(2).text((squad.wins/squad.roundsPlayed*100).toFixed(1)+"%");
											$($squadBox).find(".ranked-stats__value").eq(3).text((squad.top10s/squad.roundsPlayed*100).toFixed(1));
											$($squadBox).find(".ranked-stats__value").eq(4).text(squad.longestKill.toFixed(0)+" m");
											$($squadBox).find(".ranked-stats__value").eq(5).text((squad.headshotKills/squad.kills*100).toFixed(1)+"%");
											$($squadBox).find(".ranked-stats__value").eq(6).text(squad.teamKills.toFixed(0));
											$($squadBox).find(".ranked-stats__value").eq(7).text(((squad.timeSurvived/squad.roundsPlayed)/60).toFixed(0) +" minutes");
											$($squadBox).find(".ranked-stats__value").eq(8).text(((squad.kills+squad.assists)/squad.losses).toFixed(2));
											$($squadBox).find(".ranked-stats__value").eq(9).text(squad.roundMostKills.toFixed(0));
											
											
											
											
										}
									})
						})
	});

	$(document).ready(
			function() {
				$(".loadLog").on(
						"click",
						function() {
							var plusCnt = displayCnt + 4;

							for (; displayCnt < plusCnt; displayCnt++) {
								$("ul.matches__list li").eq(displayCnt).next()
										.css("display", "block");
							}
						})
			});

	
	$(document).ready(function() {
		var all = "<c:forEach var='mlog' items='${ulist}'>" + 
		"							<li class='matches-item ${mlog.gameMode}'>" + 
		"								<div class='matches-item_summary'>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<i></i>\r\n" + 
		"										<div>게임 일시</div>\r\n" + 
		'										<div>"${mlog.createdAt}"</div>' + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<div>게임 모드</div>\r\n" + 
		"										<div class='matches-game-mode'>${mlog.gameMode}</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-rank matches-item__column'>\r\n" + 
		"										<div>${mlog.winPlace}</div>\r\n" + 
		"										<div>등</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-kill matches-item__column'>\r\n" + 
		"										<div>${mlog.kills}</div>\r\n" + 
		"										<div>킬</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-damage matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.damageDealt}' pattern='0' />\r\n" + 
		"										</div>\r\n" + 
		"										<div>데미지</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}' pattern='0' />\r\n" + 
		"											M\r\n" + 
		"										</div>\r\n" + 
		"										<div>총 이동 거리</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		'										<div>"${mlog.mapName}"</div>' + 
		"										<div>맵</div>" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-team matches-item__column'>\r\n" + 
		"									</div>\r\n" + 
		"								</div>\r\n" + 
		"							</li>\r\n" + 
		"						</c:forEach>";
		
		var solo = "<c:forEach var='mlog' items='${soloMatchInfo}'>" + 
		"							<li class='matches-item ${mlog.gameMode}'>" + 
		"								<div class='matches-item_summary'>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<i></i>\r\n" + 
		"										<div>게임 일시</div>\r\n" + 
		'										<div>"${mlog.createdAt}"</div>' + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<div>게임 모드</div>\r\n" + 
		"										<div class='matches-game-mode'>${mlog.gameMode}</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-rank matches-item__column'>\r\n" + 
		"										<div>${mlog.winPlace}</div>\r\n" + 
		"										<div>등</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-kill matches-item__column'>\r\n" + 
		"										<div>${mlog.kills}</div>\r\n" + 
		"										<div>킬</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-damage matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.damageDealt}' pattern='0' />\r\n" + 
		"										</div>\r\n" + 
		"										<div>데미지</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}' pattern='0' />\r\n" + 
		"											M\r\n" + 
		"										</div>\r\n" + 
		"										<div>총 이동 거리</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		'										<div>"${mlog.mapName}"</div>' + 
		"										<div>맵</div>" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-team matches-item__column'>\r\n" + 
		"									</div>\r\n" + 
		"								</div>\r\n" + 
		"							</li>\r\n" + 
		"						</c:forEach>";
		
		var duo = "<c:forEach var='mlog' items='${duoMatchInfo}'>" + 
		"							<li class='matches-item ${mlog.gameMode}'>" + 
		"								<div class='matches-item_summary'>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<i></i>\r\n" + 
		"										<div>게임 일시</div>\r\n" + 
		'										<div>"${mlog.createdAt}"</div>' + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<div>게임 모드</div>\r\n" + 
		"										<div class='matches-game-mode'>${mlog.gameMode}</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-rank matches-item__column'>\r\n" + 
		"										<div>${mlog.winPlace}</div>\r\n" + 
		"										<div>등</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-kill matches-item__column'>\r\n" + 
		"										<div>${mlog.kills}</div>\r\n" + 
		"										<div>킬</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-damage matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.damageDealt}' pattern='0' />\r\n" + 
		"										</div>\r\n" + 
		"										<div>데미지</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}' pattern='0' />\r\n" + 
		"											M\r\n" + 
		"										</div>\r\n" + 
		"										<div>총 이동 거리</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		'										<div>"${mlog.mapName}"</div>' + 
		"										<div>맵</div>" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-team matches-item__column'>\r\n" + 
		"									</div>\r\n" + 
		"								</div>\r\n" + 
		"							</li>\r\n" + 
		"						</c:forEach>";
		
		var squad = "<c:forEach var='mlog' items='${squadMatchInfo}'>" + 
		"							<li class='matches-item ${mlog.gameMode}'>" + 
		"								<div class='matches-item_summary'>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<i></i>\r\n" + 
		"										<div>게임 일시</div>\r\n" + 
		'										<div>"${mlog.createdAt}"</div>' + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-status matches-item__column'>\r\n" + 
		"										<div>게임 모드</div>\r\n" + 
		"										<div class='matches-game-mode'>${mlog.gameMode}</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-rank matches-item__column'>\r\n" + 
		"										<div>${mlog.winPlace}</div>\r\n" + 
		"										<div>등</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-kill matches-item__column'>\r\n" + 
		"										<div>${mlog.kills}</div>\r\n" + 
		"										<div>킬</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-damage matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.damageDealt}' pattern='0' />\r\n" + 
		"										</div>\r\n" + 
		"										<div>데미지</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		"										<div>\r\n" + 
		"											<fmt:formatNumber value='${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}' pattern='0' />\r\n" + 
		"											M\r\n" + 
		"										</div>\r\n" + 
		"										<div>총 이동 거리</div>\r\n" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-distance matches-item__column'>\r\n" + 
		'										<div>"${mlog.mapName}"</div>' + 
		"										<div>맵</div>" + 
		"									</div>\r\n" + 
		"									<div class='matches-item-column-team matches-item__column'>\r\n" + 
		"									</div>\r\n" + 
		"								</div>\r\n" + 
		"							</li>\r\n" + 
		"						</c:forEach>";
		
		$(".allbtn").on("click", function() {
			displayCnt = 4;
			$("ul.matches__list").html(all);
			$("ul.matches__list li").eq(displayCnt).nextAll().css(
					"display", "none");
		});
		
		$(".solobtn").on("click", function() {
			displayCnt = 4;
			$("ul.matches__list").html(solo);
			$("ul.matches__list li").eq(displayCnt).nextAll().css(
					"display", "none");
		});
		
		$(".duobtn").on("click", function() {
			displayCnt = 4;
			$("ul.matches__list").html(duo);
			$("ul.matches__list li").eq(displayCnt).nextAll().css(
					"display", "none");
		});
		
		$(".squadbtn").on("click", function() {
			displayCnt = 4;
			$("ul.matches__list").html(squad);
			$("ul.matches__list li").eq(displayCnt).nextAll().css(
					"display", "none");
		});

	})
</script>
