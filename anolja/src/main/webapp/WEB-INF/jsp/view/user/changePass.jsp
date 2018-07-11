<%@ page contentType="text/html; charset=UTF-8"%>
	<script type="text/javascript">
		var body = document.querySelector('body');
		var userEmail = '${email}';
		var ctx = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
		
		body.innerHTML = '';
		
		var passChk = "";
		
		swal({
			  title: "Password 변경 페이지",
			  text: "변경할 패스워드를 입력해 주세요",
			  content: {
				  element: "input",
				  attributes: {
					  placeholder: "패스워드 입력",
					  type: 'text',
				  }
			  },
			  button: {
			    text: "입력",
			    closeModal: false,
			  },
		})
		.then((pass) => {
			  passChk = pass;
			  swal({
				  title: "Password 변경 페이지",
				  text: "패스워드 재확인",
				  content: {
					  element: "input",
					  attributes: {
						  placeholder: "재확인 패스워드 입력",
						  type: 'text',
					  }
				  },
				  button: {
				    text: "입력",
				    closeModal: false,
				  },
			  }).then((againPass) => {
				 if (passChk !== againPass) {
						return swal({
							icon: "error",
							text: "패스워드가 서로 다릅니다. 다시 인증 후 시도해 주세요"
						});
			 			window.open('', '_self', ''); // 브라우저창 닫기
			 			/* window.close(); // 브라우저 창 닫기 */
			 			self.location = ctx + '/main';
				 }
				 $.ajax({
					url: ctx + "/user/changePass",
				 	data: {email : userEmail, pass : againPass},
				 	type: 'post',
				 }).done(function(result) {
					console.log(result);
					swal({
						title: "비밀번호 변경 완료!",
						text: "비밀번호가 성공적으로 변경되었습니다.\n홈페이지에서 다시 로그인 하세요",
						icon: "success",
						button: "메인으로 가기"
					}).then((acc) => {
			 			window.open('', '_self', ''); // 브라우저창 닫기
			 			/* window.close(); // 브라우저 창 닫기 */
			 			self.location = ctx + '/main';
					});
				 });
			  });
		});
	</script>