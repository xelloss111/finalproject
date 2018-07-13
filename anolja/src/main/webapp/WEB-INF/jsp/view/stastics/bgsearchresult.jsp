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
						<span class="player-name">Place to put name</span>
					</div>

				</div>

				<div class="season-select-wrapper">
					<select id="season-selbox">
						<!-- <option selected>시즌7</option> -->
						<option>시즌6</option>
						<option>시즌5</option>
						<option>시즌4</option>
					</select>
				</div>

				<div class="rank-wrapper">
				
					<div class="rank-box">
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
										<div class="rank-score">1700</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">5231위</div>
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
											<div>
												<fmt:formatNumber value="${solo.wins/solo.roundsPlayed*100}"
													pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>Top10%</div>
											<div>
												<fmt:formatNumber
													value="${solo.top10s/solo.roundsPlayed*100}" pattern=".0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최대거리 킬</div>
											<div>
												<fmt:formatNumber value="${solo.longestKill}" pattern=".0" />
												m
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>헤드샷</div>
											<div>
												<fmt:formatNumber value="${solo.headshotKills/solo.kills*100}" pattern=".0" /> %
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
													value="${(solo.timeSurvived/solo.roundsPlayed)/60}"
													pattern="0" />
												minutes
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>KDA</div>
											<div>
												<fmt:formatNumber
													value="${(solo.kills+solo.assists)/solo.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최다 킬</div>
											<div>${solo.roundMostKills}</div>
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

					<div class="rank-box">
						<h4 class="rank-stats-title-duo" style="background-color: #ffa035">듀오</h4>
						<c:choose>
							<c:when test="${duo.roundsPlayed ne 0}">
								<div class="rank-stats-header">
									<div class="rank-stats-grade">
										<img class="rank-image"
											src="${pageContext.request.contextPath}/resources/images/battleground/Rank-Icon/bronze.png">
									</div>
									<div class="rank-stats-data">
										<div class="rank-score">1700</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">5231위</div>
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
												<fmt:formatNumber
													value="${duo.top10s/duo.roundsPlayed*100}" pattern=".0" />
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
												<fmt:formatNumber value="${duo.headshotKills/duo.kills*100}" pattern=".0" />%
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
													value="${(duo.kills+duo.assists)/duo.losses}"
													pattern=".00" />
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


					<div class="rank-box">
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
										<div class="rank-score">1700</div>
										<div class="rank-grade">Silver 4</div>
										<div class="rank-ranking">5231위</div>
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
											<div>
												<fmt:formatNumber value="${squad.wins/squad.roundsPlayed*100}"
													pattern=".0" />
												%
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>Top10%</div>
											<div>
												<fmt:formatNumber
													value="${squad.top10s/squad.roundsPlayed*100}" pattern=".0" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최대거리 킬</div>
											<div>
												<fmt:formatNumber value="${squad.longestKill}" pattern=".0" />
												m
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>헤드샷</div>
											<div>
												<fmt:formatNumber value="${squad.headshotKills/squad.kills*100}" pattern=".0" />%
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
													value="${(squad.timeSurvived/squad.roundsPlayed)/60}"
													pattern="0" />
												minutes
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>KDA</div>
											<div>
												<fmt:formatNumber
													value="${(squad.kills+squad.assists)/squad.losses}"
													pattern=".00" />
											</div>
										</li>
										<li class="ranked-stats__item">
											<div>최다 킬</div>
											<div>${squad.roundMostKills}</div>
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
							<button type="button" class="matches-filter-btn">전체</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn">솔로</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn">듀오</button>
						</li>
						<li class="matches-filter-item">
							<button type="button" class="matches-filter-btn">스쿼드</button>
						</li>
					</ul>
				</div>

				<div class="matches-list-layer">
					<ul class="matches__list">
					<c:forEach var="mlog" items="${ulist}">
						<li id="matches-item ">
							<div class="matches-item_summary">
								<div class="matches-item-column-status matches-item__column">
									<i></i>
									<div>게임 일시</div>
									<div>${mlog.createdAt}</div>
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
									<div>${mlog.damageDealt}</div>
									<div>데미지</div>
								</div>
								<div class="matches-item-column-distance matches-item__column">
									<div>${mlog.walkDistance+mlog.rideDistance+mlog.swimDistance}</div>
									<div>총 이동 거리</div>
								</div>
								<div class="matches-item-column-team matches-item__column">
									
								</div>

							</div>
						</li>

                    </c:forEach>
					</ul>
					<button data-selector="total-played-game-btn-more"
						class="total-played-game__btn total-played-game__btn--more">더
						보기</button>
				</div>

			</div>

			<div class="right-side"></div>
		</div>
	</div>
</section>



</html>