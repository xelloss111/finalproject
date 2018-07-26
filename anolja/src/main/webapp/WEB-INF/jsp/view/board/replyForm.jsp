<%@ page contentType="text/html; charset=UTF-8"%>
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



    </style>
<div id="board" style="order:4">
    	<form action="boardReply" method="POST" enctype="multipart/form-data">
<%--     		<input type="hidden" name="bNo" value="${board.bNo}" /> --%>
    		<input type="hidden" name="groupBno" value="${board.groupBno}" />
    		<input type="hidden" name="anonymousId" value="${sessionScope.id}" />
    		<input type="hidden" name="groupBlist" value="${board.groupBlist}" />
    		<input type="hidden" name="depth" value="${board.depth}" />
    		
	    	<input type="text" class="form-control" id="exampleInputEmail1" name="title" 
	    	placeholder="제목을 입력해주세요" style="width:523px; height:40px;""> <br><br>
            <div class="file_input" style="margin-bottom:30px;">
            <label>
                File Attach
                <input type="file" onchange="javascript:document.getElementById('file_route').value=this.value" multiple="multiple" name="files">
            </label>

            <input type="text" readonly="readonly" title="File Route" id="file_route"  style="width:420px;">
            </div>
	    	<textarea id="message" class="form-control" name="content" id="exampleInputEmail1" type="text" 
	    	 style="width:525px; height:300px;">${board.content}</textarea> <br>
	    	<div id="btn">
                <div style="width:253px; margin:0 auto; margin-top:15px;">
	    		<button type="submit" class="btn btn-primary btnps" style="margin-right:20px;">등록</button>
	    		<button type="button" onclick="location.href='list'" class="btn btn-default btnps">취소</button>
                </div>
	    	</div>
    	</form>
    </div>