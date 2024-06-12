<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../../includes/header.jsp"%>
<title>회원탈퇴</title>
<style>

@media (min-width: 768px) {


}

</style>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="page-header text-center">
				<b>회원탈퇴</b>
			</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="register-panel panel panel-default">
				<div class="panel-body">
					<p>회원 탈퇴를 위해 비밀번호를 확인합니다. 비밀번호를 입력해 주세요.
					<p>
					<form id="deleteForm" role="form" action="/auth/member/delete" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<!-- CSRF 토큰 추가 -->
						<!-- <div class="form-group">
							<input type="hidden" class="form-control" id="userid" name="userid">
						</div> -->
						<div class="form-group">
							<label for="userid">아이디</label> <input type="text" class="form-control" id="userid" value="${member.userid}" name="userid" readonly>
						</div>
						<div class="form-group">
							<label for="userpw">비밀번호</label> <input type="password" class="form-control" id="userpw" name="userpw">
						</div>
						<div class="text-center">
							<button type="button" class="btn btn-secondary" onclick="back()">취소</button>
							<button type="submit" class="btn btn-primary" id="deleteSubmitBtn">탈퇴</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 회원탈퇴 -->
<div class="modal fade" id="deleteMemberModal" tabindex="-1" role="dialog" aria-labelledby="deleteMemberModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="deleteMemberModalLabel">회원 탈퇴</h4>
			</div>
			<div class="modal-body">정말로 회원 탈퇴를 하시겠습니까? 이 작업은 되돌릴 수 없습니다.</div>
			<div class="modal-footer">
				<button id="confirmDeleteMemberBtn" type="button" class="btn btn-danger">탈퇴</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- 에러 메시지를 표시하는 모달 -->
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="errorModalLabel">에러 메시지</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="errorMessage"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
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

	// 회원탈퇴 폼 제출
	$("#deleteSubmitBtn").on("click", function(event) {
		event.preventDefault();
		var userid = $("#userid").val();
		var userpw = $("#userpw").val();
		
		console.log(userid);
		console.log(userpw);

		if (userpw == null || userpw.trim() === "") {
			alert("비밀번호를 입력해주세요.");
			return;
		} else{
			$("#deleteMemberModal").modal("show");
		}
	});

	$("#confirmDeleteMemberBtn").on("click", function(e) {
		event.preventDefault();
		$("#deleteForm").submit();
	});

	});
</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../../includes/footer.jsp"%>