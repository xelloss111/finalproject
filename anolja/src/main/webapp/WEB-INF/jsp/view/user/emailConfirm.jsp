<%@ page contentType="text/html; charset=UTF-8"%>
	<script type="text/javascript">
		var body = document.querySelector('body');
		var userEmail = '${email}';
		var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
		
		body.innerHTML = '';
		
		swal({
			  title: "회원 가입 성공",
			  text: userEmail + "님 회원가입을 축하합니다.\n이제 로그인이 가능 합니다.",
			  icon: "success"			  
		})
		.then((value) => {
			window.open('', '_self', ''); // 브라우저창 닫기
			/* window.close(); // 브라우저 창 닫기 */
			self.location = ctx + '/main';
		});
		
// 		swal({
// 			  title: "회원 가입 성공",
// 			  text: userEmail + "님 회원가입을 축하합니다.\n이제 로그인이 가능 합니다.",
// 			  icon: "success",
// 			  button: "확인",
// 		});


	</script>