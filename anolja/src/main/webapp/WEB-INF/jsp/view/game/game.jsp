<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
</head>

<body>
<section class="content_section" style="width:1200px">
	<div class="content_row_1">
    <div id="outer">
        <div id="canvasDiv">
            <div id="pencil"><img src="${pageContext.request.contextPath}/resources/images/game/pencil.png" width="200px" height="50px" id="pencilImg"><span id="question"></span></div>
            <div id="canvas">
                <canvas id="myCanvas" width="520" height="430"></canvas>
                <a id="funny" href="#t" class="btn yellow mini">추천 <span>0</span></a>
                <span id="time"></span>
            </div>
            <div id="colorArea">
                <a href='#t' class='color' data-color='#fa5a5a' id='red'><img src="${pageContext.request.contextPath}/resources/images/game/red.png"></a>
                <a href='#t' class='color' data-color='#f0d264' id='yellow'><img src="${pageContext.request.contextPath}/resources/images/game/yellow.png"></a>
                <a href='#t' class='color' data-color='#82c8a0' id='green'><img src="${pageContext.request.contextPath}/resources/images/game/green.png"></a>
                <a href='#t' class='color' data-color='#7fccde' id='blue'><img src="${pageContext.request.contextPath}/resources/images/game/blue.png"></a>
                <a href='#t' class='color' data-color='#cb99c5' id='purple'><img src="${pageContext.request.contextPath}/resources/images/game/purple.png"></a>
                <a href='#t' class='color' data-color='black' id='black'><img src="${pageContext.request.contextPath}/resources/images/game/black.png"></a>
                <a href='javascript:fill();' id='bucket'><img src="${pageContext.request.contextPath}/resources/images/game/bucket.png" width="50px" height="50px"></a>
                <a href="#t" id="clearBtn" class="btn cyan small">All Clear</a>
            </div>
        </div>
        <div id="chatDiv">
        	<div id="hiddenScroll">
            	<div id="chat"> </div>
        	</div>
            <div id="sendChat">
                <input type="text" id="chatInput" onkeyup="enterkey();" />
                <a href="javascript:sendMsg()" class="btn green small">send</a>
            </div>
        </div>
        <div id="connectedUser">
	        <div id="online">
               	접속자<br>
               	<c:forEach var="i" items="${chatList}">
               		<span><span id='${i}'>${i}</span> [ <span>0</span> ]</span><br>
               	</c:forEach>
            </div>
        </div>
    </div>
</div>
</section>
    <script>
    	// 문제출제영역 숨기기
    	$("#pencilImg").hide();
    
    	// 웹소켓을 이용한 채팅하기
    	var ws = null;
    	// 현재 문제 출제자
    	var current = false;
    	
    	$(function () {
    		// 서버의 웹소켓 객체 연결하기
    		ws = new WebSocket("ws://192.168.10.115/anolja/gameChat.do");
    		ws.onopen = function () {
    			console.log("웹소켓 서버 접속 성공");
    			console.log("${id}");
    		};
    		ws.onmessage = function (evt) {
    			onMessage(evt);
    		};
    		ws.onclose = function () {
    			console.log("웹소켓 서버 연결 종료");
    		};
    		ws.onerror = function (evt) {
    			console.log(evt);
    		};
    	});
    	
    	var rightAnswerCnt = 0;
    	
//     	var sec = 5;
//         function gameSet(msg) {
//         	$("#chat").append('<div class="bubbleNotice">'+ sec +""+ msg +'</div>');
// 			$("#chat").scrollTop($("#chat")[0].scrollHeight);
//         	if (sec > 0) sec--;
//         	else {
//         		clearInterval(gameSetId);
//         	}
//         }
    	
    	function onMessage(evt) {
    		if (evt.data.startsWith('notice:')) {
    			var msg = evt.data.substring('notice:'.length);
    			// 게임 중 인원이 1명남았을 경우 게임 끝내고 메인으로 보내기
    			if (msg.includes('부족')) {
    				alert(msg);
    				clearInterval(timerId);
    				location.href = "${pageContext.request.contextPath}/main";
    				return;
    			}
    			// 모든 게임이 끝나면 메인으로 보내기
    			if (msg.includes('메인')) {
    				alert(msg);
    				clearInterval(timerId);
    				location.href = "${pageContext.request.contextPath}/main";
    				return;
    			}
    			// 소켓연결이 되면 참여자 목록에 더하기
    			if (msg.includes('참여')) {
					var id = msg.substring(0, msg.indexOf('님'));
					$("#online").append("<span><span id='"+id+"'>"+ id +"</span> [ <span>0</span> ]</span><br>");
    			}
    			// 소켓연결 종료되면 참여자 목록에서 빼기
    			if (msg.includes('접속종료')) {
					var id = msg.substring(0, msg.indexOf('님'));
					if ($("#"+id).text() == id) {
    					$("#"+id).parent().remove();
    				}
    			}
    			// 정답맞출 시 새로게임 시작하기
    			if (msg.includes('정답')) {
    				clearInterval(timerId);
    				gameRestart();
    			}
    			else if (msg == '게임을 시작합니다.') {
    				startTime();
    			}
    			
    			$("#chat").append('<div class="bubbleNotice">'+ msg +'</div>');
    			$("#chat").scrollTop($("#chat")[0].scrollHeight);
    			
//     			if (msg.includes('초')) {
//     				for (let i = 5; i >= 1; i--) {
// 	    				setInterval(() => {
// 			    			$("#chat").append('<div class="bubbleNotice">'+ msg +'</div>');
// 			    			$("#chat").scrollTop($("#chat")[0].scrollHeight);
// 						}, 1000);
// 	   				}
// 	    			var gameSetId = setInterval("gameSet("+msg+");", 1000);
//     			}
    			
    		}
    		else if (evt.data.startsWith('question:')) {
    			var msg = evt.data.substring('question:'.length);
    			current = true;
    			console.log("출제자: ", "${id}");
    			$("#pencilImg").show();
				$("#question").text(msg);
    		}
			// 화면에 정답 맞춘 갯수 뿌려주기
			else if (evt.data.startsWith('rightAnswerCnt:')) {
    			var msg = evt.data.substring('rightAnswerCnt:'.length);
    			var msgArr = msg.split(':');
    			var id = msgArr[0];
    			var cnt = msgArr[1];
    			$("#"+id).next().text(cnt);
    		}
    		// 추천 뿌려주기
			else if (evt.data.includes('rcmndCnt:')) {
				console.log(evt.data);
				rcmndCnt = evt.data.substring('rcmndCnt:'.length);
				$("#funny > span").text(rcmndCnt);
			}
			else if (evt.data.includes('room full')) {
				alert('방 인원이 모두 찼습니다.');
				location.href = "${pageContext.request.contextPath}/main";
				return;
			}
    		else {
	    		$("#chat").append('<div class="bubble">'+ evt.data +'</div>');
				$("#chat").scrollTop($("#chat")[0].scrollHeight);
    		}
			if (!current) {
    			$("#pencilImg").hide();
			}
    	}

    	function enterkey() {
    		if (window.event.keyCode == 13) {
    			sendMsg();
    		}
    	}
    	
    	function sendMsg() {
    		var $msg = $("#chatInput");
    		if ($msg.val() == "") {
    			alert("내용을 입력하세요");
    		}
    		else {
    			if (current) {
    				ws.send("문제를 출제하는동안 채팅할 수 없습니다.");
    	    		$("#chat").append('<div class="bubbleNotice">문제를 출제하는동안 채팅할 수 없습니다.</div>');
    			}
    			else {
		    		ws.send($msg.val());
		    		$("#chat").append('<div class="bubbleMe">'+ $msg.val() +'</div>');
    			}
				$("#chat").scrollTop($("#chat")[0].scrollHeight);
	    		$msg.val("");
	    		$msg.focus();
    		}
    	}
    
    	
    	
    	
    	/* 그림그리기 */
    	var paintWs = null;
    	var isEditable = false;
    	
        var canvas = document.querySelector("#myCanvas");
        var paintCtx = canvas.getContext("2d");
        
        var isPress = false;
        var prevX = 0;
        var prevY = 0;
        var point = {};
        
        paintCtx.lineWidth = 3;
        paintCtx.lineCap = "round";
        
        $(document).ready(function () {
        	paintWs = new WebSocket("ws://192.168.10.115/anolja/gamePaint.do");
	        $("canvas").on({
	            mousedown: function (e) {
	            	if (!isEditable) {return;}
	            	
	            	e.preventDefault();
			        isPress = true;
	                paintCtx.beginPath();
					prevX = e.offsetX;
					prevY = e.offsetY;
	            },
	            mouseup: function (e) {
	            	if (!isEditable) {return;}
	                isPress = false;
	                paintCtx.closePath();
	            },
	            mousemove: function (e) {
	            	if (!isEditable) {return;}
	            	
	                var x = e.offsetX;
	                var y = e.offsetY;
	                if (isPress) {
	                	point.prevX = prevX;
	                	point.prevY = prevY;
	                	point.nowX = x;
	                	point.nowY = y;
	                	point.color = color;
	                	
	                	paintWs.send(JSON.stringify(point));
	                	
	                	paintCtx.moveTo(prevX, prevY);
	                    paintCtx.lineTo(x, y);
	                    paintCtx.stroke();
	                    
	                    prevX = e.offestX;
	                    prevY = e.offestY;
	                    
	                    if (x <= 10 || y <= 10 || x >= canvas.width-10 || y >= canvas.height-10) {
	                        isPress = false;
	                    }
	                }
	            }
	        });
	        
	        paintWs.onmessage = function (evt) {
	        	console.log(evt.data);
	        	if (evt.data == "OK" || evt.data == "NO") {
	        		if (evt.data == "OK") {
	        			isEditable = true;
	        		}
	        		else {
	        			isEditable = false;
	        		}
	        		return;
	        	}
	        	
	        	var c = document.querySelector("#myCanvas");
	            var otherCtx = c.getContext("2d");
	        	var drawData;
	        	
	        	if (evt.data == "clear") {
	            	paintCtx.clearRect(0, 0, canvas.width, canvas.height);
	                paintCtx.closePath();
	                return;
	            }
	        	if (evt.data.startsWith('{"')) {
	        		drawData = JSON.parse(evt.data);
		            console.log(drawData.mode);
		            if(drawData.mode != undefined && drawData.mode == "fill") {
		            	otherCtx.fillStyle = drawData.color;
		            	otherCtx.fillRect(0, 0, canvas.width, canvas.height);
		            	otherCtx.closePath();
		            	if (drawData.color == '#f4f5ed') {
			            	$("#time").css("color", "black");
		            	}
		            	else {
			            	$("#time").css("color", "white");
		            	}
		            	return;
		            }
		            
		            otherCtx.strokeStyle = drawData.color;
		            otherCtx.beginPath();
		            otherCtx.moveTo(drawData.prevX, drawData.prevY);
		            otherCtx.lineTo(drawData.nowX, drawData.nowY);
		            otherCtx.stroke();
		            otherCtx.closePath();
	        	}
	        }
	        
        });
        
        
        
        
        
        // 캔버스 그리기 색상 바꾸기 및 지우기
        var color = "black";
        $(".color").click(function () {
            var strokeStyle = $(this).data("color"); 
            paintCtx.strokeStyle = strokeStyle;
            color = strokeStyle;
        });
        
        function fill() {
        	if (!isEditable) {return;}
            fillColor(color, 'white');
        };
        $("canvas").contextmenu(function (e) {
            e.preventDefault();
            if (!isEditable) {return;}
            fillColor('#f4f5ed', 'black');
        });
        $("#clearBtn").click(function () {
        	if (!isEditable) {return;}
            paintCtx.clearRect(0, 0, canvas.width, canvas.height);
            paintCtx.closePath();
            
            paintWs.send("clear");
        });
        
        // 채우기 색상
        function fillColor(fillColor, timeColor) {
        	paintCtx.fillStyle = fillColor;
            paintCtx.fillRect(0, 0, canvas.width, canvas.height);
            paintCtx.closePath();
            
            $("#time").css("color", timeColor);
            
	        var fill = {};
	        
            fill.mode = "fill";
            fill.color = fillColor;
            
            paintWs.send(JSON.stringify(fill));
        }
        
        /* 타이머 */
        var timerId; // 타이머를 핸들링하기 위한 전역 변수
        var time = 90; // 타이머의 시작 시간
        
        function startTime() {
        	timerId = setInterval("decrementTime()", 1000);
        }
        
        function decrementTime() {
        	$("#time").text(toMinSec(time));
        	if (time > 0) time--;
        	else {
        		clearInterval(timerId);
        		ws.send("Time Over");
        		gameRestart();
        	}
        }
        
        // 게임 한세트 끝난 후 다시 시작하기
        function gameRestart() {
			$("#question").text("");
			paintCtx.clearRect(0, 0, canvas.width, canvas.height);
    		time = 90;
    		rcmndCnt = 0;
    		
    		if (current) {
        		paintWs.send("next");
        		ws.send('rcmndCnt:'+rcmndCnt);
        		current = false;
        		
				setTimeout(() => {
	        		paintWs.send("gameRestart");
				}, 100);
	    		setTimeout(() => {
		    		ws.send("gameEnd");
	    			ws.send("next");
				}, 100);
    		}
        }
        
        /* 정수형 숫자(초 단위)를 "시:분:초" 형태로 표현하는 함수 */
    	function toMinSec(t) { 
    		var min;
    		var sec;

    		// 정수로부터 남은 시, 분, 초 단위 계산
    		min = Math.floor(time / 60);
    		sec = (time % 60);

    		// hh:mm:ss 형태를 유지하기 위해 한자리 수일 때 0 추가
    		if(min < 10) min = "0" + min;
    		if(sec < 10) sec = "0" + sec;

    		return(min + ":" + sec);
    	}
		
    	// 스크롤바 마우스오버시 보이고, 마우스리브시 없애기
    	$("#chat").mouseover(function () {
    		$("#hiddenScroll").css("width", "240px");
    	});
    	$("#chat").mouseleave(function () {
    		$("#hiddenScroll").css("width", "215px");
    	});
    	
    	
    	/* 추천버튼 */
    	var rcmndCnt = 0;
    	$("#funny").click(function () {
    		if (current) {
    			$(this).unbind('click');
    			return;
    		}
    		$("#funny > span").text(++rcmndCnt);
    		$(this).unbind('click');
    		ws.send("rcmndCnt:"+rcmndCnt);
   		}); 
    </script>
</body>
</html>