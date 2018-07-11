<%@ page contentType="text/html; charset=UTF-8" %>
<link rel = "stylesheet" type = "text/css" href = "${pageContext.request.contextPath}/resources/css/searchresult.css">

<section class="content_section">
	<div class="content_row_1">

<!-- 여기부터 -->
    <div id="search-nav">
        <img src="${pageContext.request.contextPath}/resources/images/battleground/Letter2.png" width="100px" height="40px" style="margin-left: 10px;">
        <img src="${pageContext.request.contextPath}/resources/images/battleground/google-web-search-256.png" width="35px" height="35px" style="float: right;margin-right: 40px;margin-top: 2.2px;">
        <input type="text" id="nav-input" placeholder="검색할 ID 입력">
    </div>
    
    <div class="main">
        <div class="left-side">

        </div>

        <div class="center">
            <div class="player-summary">
                <div class="player-name-space">
                    <span class="player-name">Place to put name</span>
                </div>

            </div>

            <div class="season-select-wrapper">
                <select id="season-selbox">
                    <option selected>시즌7</option>
                    <option>시즌6</option>
                    <option>시즌5</option>
                    <option>시즌4</option>
                </select>
            </div>

            <div class="rank-wrapper">
                <div class="rank-box">
                    <h4 class="rank-stats-title-solo" style="background-color: #ff1e3c">솔로</h4>
                    <div class="rank-stats-header">
                        <div class="rank-stats-grade">
                            <img class="rank-image" src="${pageContext.request.contextPath}/resources/images/battleground/Rank-Icon/bronze.png">
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
                                <div class="ranked-stats__key">
                                    K/D
                                </div>
                                <div class="ranked-stats__value">
                                    2.93
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div class="ranked-stats__key">
                                    경기 당 데미지
                                </div>
                                <div class="ranked-stats__value">
                                    343
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>승</div>
                                <div>10%</div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>Top10%</div>
                                <div>33.3%</div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>최대거리 킬</div>
                                <div>186.0m</div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>
                                    헤드샷
                                </div>
                                <div>
                                    25.0%
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>
                                    평균 등수
                                </div>
                                <div>
                                    39.7
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>
                                    평균 생존시간
                                </div>
                                <div>
                                    13:40
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>
                                    KDA
                                </div>
                                <div>
                                    2.65
                                </div>
                            </li>
                            <li class="ranked-stats__item">
                                <div>
                                    최다 킬
                                </div>
                                <div>
                                    4
                                </div>
                            </li>
                        </ul>
                    </div>



                </div>

                <div class="rank-box">
                    <h4 class="rank-stats-title-duo" style="background-color: #ffa035">듀오</h4>
                    <div class="rank-stats-header">
                        <div class="no-status">
                            <img src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png" width="70px" height="70px">
                            <p>표시할 전적이 없습니다.</p>
                        </div>

                    </div>

                </div>


                <div class="rank-box">
                    <h4 class="rank-stats-title-squad" style="background-color: #448cff">스쿼드</h4>
                    <div class="rank-stats-header">
                        <div class="no-status">
                            <img src="${pageContext.request.contextPath}/resources/images/battleground/exclamation-mark.png" width="70px" height="70px">
                            <p>표시할 전적이 없습니다.</p>
                        </div>

                    </div>
                </div>
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
                    <li id="matches-item ">
                        <div class="matches-item_summary">
                            <div class="matches-item-column-status matches-item__column">
                                <i></i>
                                <div>10일전</div>
                                <div>29:35</div>
                            </div>
                            <div class="matches-item-column-rank matches-item__column">
                                <div>3</div>
                                <div>/27</div>
                            </div>

                            <div class="matches-item-column-kill matches-item__column">
                                <div>3</div>
                                <div>킬</div>
                            </div>
                            <div class="matches-item-column-damage matches-item__column">
                                <div>441</div>
                                <div>데미지</div>
                            </div>
                            <div class="matches-item-column-distance matches-item__column">
                                <div>6.82km</div>
                                <div>총 이동 거리</div>
                            </div>
                            <div class="matches-item-column-team matches-item__column">
                                <div>팀원</div>
                                <div>김씨</div>
                                <div>이씨</div>
                            </div>

                        </div>
                    </li>


                </ul>
                <button data-selector="total-played-game-btn-more" class="total-played-game__btn total-played-game__btn--more">더 보기</button>
            </div>

        </div>

        <div class="right-side">


        </div>
        </div>
        </div>
        </section>
        


</html>