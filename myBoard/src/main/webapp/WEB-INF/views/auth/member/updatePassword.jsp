<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../../includes/header.jsp"%>
<title>비밀번호수정</title>
<style>

@media (min-width: 768px) {


}

</style>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <h3 class="page-header text-center"><b>비밀번호수정</b></h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="register-panel panel panel-default">
                <div class="panel-body">
                    <form id="updatePWForm" role="form" action="/auth/member/updatePassword" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /><!-- CSRF 토큰 추가 -->
	                    <div class="form-group">
	                        <label for="userid">아이디</label> 
	                        <input type="text" class="form-control" id="userid" 
	                        value="${member.userid}" name="userid" readonly>
	                    </div>
                        <div class="form-group">
                            <label for="currentPassword">현재 비밀번호</label>
                            <input type="password" class="form-control" id="currentPassword">
                        </div>
                        <div class="form-group">
                            <label for="userpw">새 비밀번호</label>
                            <input type="password" class="form-control" id="userpw" name="userpw">
                        </div>
                        <div class="form-group">
                            <label for="confirmNewPassword">새 비밀번호 확인</label>
                            <input type="password" class="form-control" id="confirmNewPassword">
                        </div>
                        <div class="text-center">
                            <button type="button" class="btn btn-secondary" onclick="back()">취소</button>
                            <button type="submit" class="btn btn-primary" id="updatePWSubmitBtn">변경</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 변경 버튼을 누르면 뜨는 모달 -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">변경하시겠습니까?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" >확인</button>
            </div>
        </div>
    </div>
</div>

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
            <div class="modal-body" id="errorModalBoady"></div>
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

    // 비밀번호변경 유효성검사 및 폼 제출
    $("#updatePWSubmitBtn").on("click", function(event) {
        event.preventDefault();
        var currentPassword = $("#currentPassword").val();
        var userpw = $("#userpw").val();
        var confirmNewPassword = $("#confirmNewPassword").val();
        debugger;
        console.log(currentPassword);
        console.log(userpw);
        console.log(confirmNewPassword);

        var errorMessage = "${error}";

        checkResult(errorMessage);

        function checkResult(errorMessage) {
            if (userpw !== confirmNewPassword) { // 새비번 !== 새비번확인
                $("#errorModalBoady").text("새 비밀번호를 다시 확인해주세요.");
                $("#errorModal").modal("show");
                return;
            }

            if (!errorMessage || errorMessage.trim() === '') { // 공백이거나 null이면 모달종료
                return;
            } else {
                $("#errorModalBoady").html(errorMessage);
            }
            $("#errorModal").modal("show");
        }

        if (confirm("비밀번호를 변경하시겠습니까?")) {
            // 확인버튼 > 로그아웃(=세션종료)
            document.getElementById('logoutForm').submit();
            $("#updatePWForm").submit();
        }
    });

});
</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../../includes/footer.jsp"%>