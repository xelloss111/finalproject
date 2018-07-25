<%@ page contentType="text/html; charset=UTF-8"%>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
 <style type="text/css">
        form{
            width:527px;
        }
    	#board {width: 506px; margin: 50px auto;}
    	#btn {margin: 20px auto; width: 300px;}
    	.btnps {
    position: relative;
    background-color: #1488c1;
    border: none;
    font-size: 15px;
    color: #FFFFFF;
    text-align: center;
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
    text-decoration: none;
    overflow: hidden;
    cursor: pointer;
}

.btnps:after {
    content: "";
    background: #FFFFFF;
    display: block;
    position: absolute;
    padding-top: 300%;
    padding-left: 350%;
    margin-left: -20px!important;
    margin-top: -120%;
    opacity: 0;
    transition: all 0.8s
}

.btnps:active:after {
    padding: 0;
    margin: 0;
    opacity: 1;
    transition: 0s
}
.file_input label {
    position:relative;
    cursor:pointer;
    display:inline-block;
    vertical-align:middle;
    overflow:hidden;
    width:100px;
    height:30px;
    background:#777;
    color:#fff;
    text-align:center;
    line-height:30px;
}
.file_input label input {
    position:absolute;
    width:0;
    height:0;
    overflow:hidden;
}
.file_input input[type=text] {
    vertical-align:middle;
    display:inline-block;
    width:400px;
    height:28px;
    line-height:28px;
    font-size:11px;
    padding:0;
    border:0;
    border:1px solid #777;
}

#board {order : 2;}

    </style>
<div id="board">
    	<form action="insert" method="POST" enctype="multipart/form-data">
    		<input type="hidden" name="anonymousId" value="${sessionScope.id}">
	    	<input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요" style="width:523px; height:40px;"> <br><br>
            <div class="file_input" style="margin-bottom:30px;">
	            <label>
	                File Attach
	                <input type="file" accept="jpg" onchange="javascript:document.getElementById('file_route').value=this.value" multiple="multiple" name="files">
	            </label>
	            <input type="text" readonly="readonly" title="File Route" id="file_route"  style="width:420px;">
            </div>
	    	<textarea id="message" class="form-control" name="content" type="text" placeholder="내용을 입력해주세요" style="width:525px; height:300px;"></textarea> <br>
	    	<div id="btn">
                <div style="width:253px; margin:0 auto; margin-top:15px;">
	    		<button type="submit" id="writeBtn" class="btn btn-primary btnps" style="margin-right:20px;">등록</button>
	    		<button type="button" onclick="location.href='list'" class="btn btn-default btnps">취소</button>
                </div>
	    	</div>
    	</form>
    	
    	<script>
    	
    		출처: http://88240.tistory.com/52 [shaking blog]
    	$("#writeBtn").click(function () {
    		if($("#title").val() == "") {
    			swal("제목을 입력해주세요");
    			return false;
    		}
    	});
    	
    	$(document).ready(function(){
    		   $("#bContent").on("keyup", function(){
    		      if($(this).val().length > 30){
    		         swal("30자 이상은 쓸 수 없습니다");
    		         $(this).val($(this).val().substring(0,30));
    		      }
    	   })
    	})
    		function chk() {
    			var f = document.insert;
    			if (f.title.value.trim() == "") {
    				swal("제목을 입력해주세요")
    				f.title.focus();
    				return false;
    			}
    			
    			if(f.message.value.trim() == "") {
    				swal("내용을 입력해주세요")
    				f.message.focus();
    				return false;
    			}
    			
    			f.submit();
    		}
    		
    	</script>
    </div>