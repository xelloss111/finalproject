<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
        @import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
        @import url(//fonts.googleapis.com/earlyaccess/hanna.css);
    </style>
    <link rel = "stylesheet" type = "text/css" href = "${pageContext.request.contextPath}/resources/css/game.css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.notice.js"></script>
</head>

<body>
<section class="content_section" style="width:1200px">
	<div class="content_row_1">
    <div id="outer">
        <div id="canvasDiv">
            <div id="pencil"><img src="${pageContext.request.contextPath}/resources/images/game/pencil.png" width="200px" height="50px" id="pencilImg"><span id="question">바나나</span></div>
            <div id="canvas">
                <canvas id="myCanvas" width="520" height="430"></canvas>
                <a id="funny" href="#" class="btn yellow mini">추천 <span>0</span></a>
                <span id="time">02:00</span>
            </div>
            <div id="colorArea">
                <a href='#t' class='color' data-color='#fa5a5a' id='red'><img src="${pageContext.request.contextPath}/resources/images/game/red.png"></a>
                <a href='#t' class='color' data-color='#f0d264' id='yellow'><img src="${pageContext.request.contextPath}/resources/images/game/yellow.png"></a>
                <a href='#t' class='color' data-color='#82c8a0' id='green'><img src="${pageContext.request.contextPath}/resources/images/game/green.png"></a>
                <a href='#t' class='color' data-color='#7fccde' id='blue'><img src="${pageContext.request.contextPath}/resources/images/game/blue.png"></a>
                <a href='#t' class='color' data-color='#cb99c5' id='purple'><img src="${pageContext.request.contextPath}/resources/images/game/purple.png"></a>
                <a href='#t' class='color' data-color='black' id='black'><img src="${pageContext.request.contextPath}/resources/images/game/black.png"></a>
                <a href='#t' id='bucket'><img src="${pageContext.request.contextPath}/resources/images/game/bucket.png" width="50px" height="50px"></a>
                <a href="#t" id="clearBtn" class="btn cyan small">All Clear</a>
            </div>
        </div>
        <div id="chatDiv">
            <div id="online">
               	접속자<br>
                hrin<br>
                banana<br>
                apple<br>
                orange<br>
                tomato<br>
                skyblue<br>
            </div>
            <div id="chat">
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubbleMe">banana: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
                <div class="bubble">hrin: 안녕하세요</div>
            </div>
            <div id="sendChat">
                <input type="text" name="" id="chatInput">
                <a href="#" class="btn green small">send</a>
            </div>
        </div>
    </div>
</div>
</section>
    <script>
    	// 웹소켓을 이용한 채팅하기
    	var ws = null;
    	$(function () {
    		// 서버의 웹소켓 객체 연결하기
    		ws = new WebSocket("ws://192.168.10.115/anolja/gameChat.do");
    		ws.onopen = function () {
    			console.log("웹소켓 서버 접속 성공");
    		};
    		
    		// 서버에서 메세지가 왔을 때 호출
    		ws.onmessage = function (evt) {
    			$.noticeAdd({
    				text: evt.data,
    				stayTime: 8000
    			});
    		};
    		
    		ws.onclose = function () {
    			console.log("웹소켓 서버 연결 종료")
    		};
    		
    		ws.onerror = function (evt) {
    			console.log(evt.data);
    		};
    	});
    
    
    	// 그림그리기
        const canvas = document.querySelector("#myCanvas");
        const ctx = canvas.getContext("2d");
        
        var isPress = false;
        
        ctx.lineWidth = 3;
        ctx.lineCap = "round";
        
        $("canvas").on({
            mousedown: function (e) {
            	e.preventDefault();
                isPress = true;
                ctx.beginPath();
                ctx.moveTo(e.offsetX, e.offsetY);
            },
            mouseup: function (e) {
                isPress = false;
            },
            mousemove: function (e) {
                var x = e.offsetX;
                var y = e.offsetY;
                if (isPress == true) {
                    ctx.lineTo(x, y);
                    ctx.stroke();
                    if (x <= 10 || y <= 10 || x >= canvas.width-10 || y >= canvas.height-10) {
                        isPress = false;
                    }
                }
            }
        });
        
        // 캔버스 그리기 색상 바꾸기 및 지우기
        var color = "";
        $(".color").click(function () {
            var strokeStyle = $(this).data("color"); 
            ctx.strokeStyle = strokeStyle;
            color = strokeStyle;
        });
        $("#bucket").click(function () {
            ctx.fillStyle = color;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        });
        $("canvas").contextmenu(function (e) {
            e.preventDefault();
            ctx.fillStyle = color;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        });
        $("#clearBtn").click(function () {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        });
    </script>
</body>
</html>