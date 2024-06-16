<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/logHeader.jsp"%>
<title>회원가입</title>
<style>

@media (min-width: 768px) {


}

</style>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="page-header text-center">
				<b>회원정보 입력</b>
			</h3>
			</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="register-panel panel panel-default">
				<!-- <div class="panel-heading">계정 만들기</div> -->
				<div class="panel-body">
					<form id="registerForm" role="form" action="/auth/register" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<!-- CSRF 토큰 추가 -->
						<div class="form-group">
							<label for="userid">아이디:</label> 
							<input type="text" class="form-control" id="userid" name="userid" placeholder="아이디를 입력하세요" required>
						</div>
						<div class="form-group">
							<label for="userpw">비밀번호:</label> 
							<input type="password" class="form-control" id="userpw" name="userpw" placeholder="비밀번호를 입력하세요" required>
						</div>
						<div class="form-group">
							<label for="username">이름:</label> 
							<input type="text" class="form-control" id="username" name="username" placeholder="이름을 입력하세요" required>
						</div>
						<div class="form-group">
							<label for="email">이메일:</label> 
							<input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required>
						</div>
						<!-- <button id="resetBtn" type="reset" class="btn btn-secondary">초기화</button> -->
						<button id="registerSubmitBtn" type="submit" class="btn btn-lg btn-custom-success btn-block">가입하기</button>
					</form>
				</div>
				<div class="text-center">
					<p>
						이미 계정이 있으신가요? <a href="/customLogin"> 로그인</a>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>
<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#registerSubmitBtn").on("click",function(e) {
		e.preventDefault();

		var useridValue = $("#userid").val();
		var userpwtValue = $("#userpw").val();
		var usernameValue = $("#username").val();
		var emailValue = $("#email").val();

		// 필드값 검증
		if (useridValue !== "" 
				&& userpwtValue !== ""
				&& usernameValue !== ""
				&& emailValue !== "") {
			// 값이 유효한 폼제출
			console.log("userid:", useridValue);
			console.log("userpw:", userpwtValue);
			console.log("username:", usernameValue);
			console.log("email:", emailValue);
			
			$("#registerForm").submit();
			//$("#successModal").modal("show"); //오류주의...!submit은 return과 같다고 생각하기
		} else {
			alert("비어있는 내용이 있습니다.");
		}
	});
	
	// 모바일 화면에서 푸터 숨김
	if ($(window).width() < 768) {
		$(".footer").hide();
	}
	
	// 윈도우 리사이즈 이벤트
	$(window).resize(function() {
		if ($(window).width() >= 768) {
			$(".footer").show();
		} else {
			$(".footer").hide();
		}
	});
});
</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/logFooter.jsp"%>
