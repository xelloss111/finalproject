/**
 * 동영상 저장 아이콘 클릭 시 발생하는 모달1 
 */


// 1. 모달에서 저장하기 눌렀을 때.
$("#submit").click(function () {
	var target = document.getElementById("tank_list");
	var option = target.options[target.selectedIndex];
	saveTankId = option.value;
	saveTankName = option.innerText;
	var visible_modal = jQuery('.modal.in').attr('id');
	var resultTankHtml='';

// 1-1. 저장소 선택되지 않은 경우
	if(saveTankId=='tank0') {
		swal({
			  text: "저장소를 선택해주세요.",
			  icon: "error",
			  button: "닫기",
			})
				return;
	};

// 1-2. 서버로 데이터 보내기 ajax
		$.ajax({
			type: "POST",
			data: {"id":sessionId,
					"tankName":saveTankName,
					"tankId":saveTankId,
				   "videoImg": saveVideoImg,
				   "videoTitle":saveVideoTitle,
				   "videoUrl":saveVideoUrl},
			url: "videoSave",
			success: function (tankInfo) {
// 1-3.	저장완료 얼럿 후 모달창 닫기
				swal({
					  text: saveTankName+ " 저장소에 저장 완료",
					  icon: "success",
					  button: "닫기",
					}).then((value)=> {
						jQuery('#' + visible_modal).modal('hide');
						return;
					});
			}
				   
				   
		});
});

// 2. 새로운 저장소 추가
function addOption(){
	saveTankName = $(".newTank").val();	
	var target = document.getElementById("tank_list");
		
// 2-2. 저장소 이름을 지정하지 않았을 때
	if(saveTankName=='') {
		swal({
			  title: "저장소 이름 필요",
			  text: "새로운 저장소의 이름을 지정해주세요.",
			  icon: "warning",
			  button: "닫기",
			})
				return;
	};
	
    var frm = document.saveTank;
    var op = new Option();

// 2-3. 저장소ID 생성해주기
    op.value = 'tank' + frm.tank_list.length;
// 2-4. 저장소 이름
    op.text = saveTankName;	  
// 2-5. select option 선택된 상태 설정 (기본값은 false이며 선택된 상태로 만들 경우에만 사용) 
    op.selected = true;
// 2-6. option 추가
    frm.tank_list.options.add(op); 
// 2-7. saveTankId 를 변수에 담아주기
	saveTankId = target.options[target.selectedIndex].value;
};	