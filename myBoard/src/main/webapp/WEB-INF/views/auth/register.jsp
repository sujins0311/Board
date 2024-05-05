<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/logHeader.jsp"%>


<h2>회원 가입</h2>
<form id="registerForm">
	<label for="userid">아이디:</label> 
	<input type="text" id="userid" name="userid" ><br><br>
	
	<label for="userpw">비밀번호:</label> 
	<input type="password" id="userpw" name="userpw" ><br><br>
	
	<label for="username">이름:</label> 
	<input type="text" id="username" name="username" ><br><br>
	
	<label for="email">이메일:</label> 
	<input type="email" id="email" name="email" ><br><br>
	
	<button type="submit">가입하기</button>
</form>

<!-- 여기에 필요한 JavaScript 코드를 포함할 수 있습니다. -->

</body>
</html>
<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

/*  jQuery를 사용하여 AJAX 요청을 보내는 방법 */

	$(document).ready(function() {
		$("#registerForm").submit(function(event) { // 폼이 제출되면
			event.preventDefault(); // 기본 제출 동작 방지
			/*         
			 var memberData = {
			 username: "사용자명",
			 email: "이메일",
			 password: "비밀번호"
			 }; */

			// 회원가입 정보를 JSON 형식으로 생성
			var formData = { // 회원 정보를 폼 데이터로 가져옴
				userid : $("#userid").val(),
				userpw : $("#userpw").val(),
				username : $("#username").val(),
				email : $("#email").val()
			};
			
			// AJAX를 사용하여 서버에 POST 요청 보내기
			$.ajax({
				type : "POST",
				url : "/auth/register", // 서버 엔드포인트
				contentType : "application/json", // 요청 데이터 타입(consumes)
				data : JSON.stringify(formData), // JSON 문자열로 변환하여 데이터 전송
				dataType : 'text', // 서버 응답 데이터 타입(produces)
				success : function(response) { // 성공적으로 요청이 완료된 경우
					if (response === 'success') {
						alert("회원가입이 성공적으로 완료되었습니다.");
						window.location.href = '/board/getPostList';
						//window.location.reload(); // 생성 후 페이지 리로드
						// 원하는 동작 수행
					} else {
						alert("회원가입에 실패하였습니다.");
					}
				},
				error : function(xhr, status, error) { // 요청이 실패한 경우
					alert("서버 오류로 회원가입에 실패하였습니다.");
					console.error('오류 발생:', error);
					//console.error(xhr.responseText);
				}
			});
		});
	});

	/* function register(userid) {
	 if (confirm("회원가입을 완료하시겠습니까?")) {

	 $.ajax({
	 type : 'POST', // POST는 URL 파라메터가 아닌 HTTP bodypart로 데이터를 전송 
	 url : '/auth/register',
	 data : JSON.stringify(userid), // 전송타입에 맞는 payload
	 contentType : "application/json; charset=utf-8",
	 success : function(userid) {
	 alert('가입이 완료되었습니다.');
	 window.location.href = '/board/getPostList';
	 //window.location.reload(); // 삭제 후 페이지 리로드
	 },
	 error : function(xhr, status, er) {
	 console.error('오류 발생:', error);
	 }
	 })
	 } */
</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/logFooter.jsp"%>
