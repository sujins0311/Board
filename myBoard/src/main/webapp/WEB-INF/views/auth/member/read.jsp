<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../../includes/header.jsp"%>
<title>마이페이지</title>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<div style="display: flex; justify-content: center;">
				<a class="snb-btn" href="/auth/member/update">
					<button class="common-btn btn">개인정보수정</button>
				</a>
				<button class="common-btn btn" id="updatePWBtn">비밀번호 변경(예정)</button>
				<button class="common-btn btn" id="deleteAccountBtn">탈퇴하기(예정)</button>
				<button class="common-btn btn">내글모아보기동(예정)</button>
			</div>
		</div>
	</div>
</div>

<sec:authorize access="isAuthenticated()">
        <div class="row">
            <div class="col-md-6">
                <h2>사용자정보</h2>
                <p><strong>ID:</strong> ${member.userid}</p>
                <p><strong>이름:</strong> ${member.username}</p>
                <p><strong>이메일:</strong> ${member.email}</p>
                <p><strong>가입일:</strong> <fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}"/></p>
                <p><strong>회원등급:</strong> (예정)</p>
                <!-- 추가적인 사용자 정보 출력 -->
            </div>
        </div>
	</sec:authorize>
<%@include file="./memberModal.jsp"%>
</body>
</html>
<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	// 회원탈퇴
	$("#deleteAccountBtn").click(function() {
	    $("#deleteAccountModal").modal("show");
	});
	
	// 비밀번호수정
	$("#updatePWBtn").click(function() {
	    $("#updatePWModal").modal("show");
	});


	$("#confirmSubmitBtn").on("click", function(event) {
		event.preventDefault();
        var currentPassword = $("#currentPassword").val();
        var newPassword = $("#newPassword").val();
        var confirmNewPassword = $("#confirmNewPassword").val();
        
        if(newPassword !== confirmNewPassword){
        	aler("새 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.")
        	return;
        }
            // 비밀번호 변경 성공시 모달 닫기
            $("#updatePWModal").modal("hide");
	});
	
	$('#confirmSubmitBtn').on("click", function(event) {
		$("#updateForm").submit();
		$("#updateForm")[0].reset();
	});
});

</script>
<%@include file="../../includes/footer.jsp"%>