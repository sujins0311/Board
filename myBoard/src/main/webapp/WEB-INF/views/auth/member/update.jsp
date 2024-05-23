<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../../includes/header.jsp"%>
<title>회원정보수정</title>
<style>

@media (min-width: 768px) {


}

</style>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
				<h3 class="page-header text-center"><b>회원정보수정</b></h3>
		</div>
	</div>
	<div class="row">
	    <div class="col-md-4 col-md-offset-4">
	        <div class="register-panel panel panel-default">
	            <div class="panel-body"> 
	                <form id="updateForm" role="form" action="/auth/member/update" method="post">
	                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> <!-- CSRF 토큰 추가 -->
	                    <div class="form-group">
	                        <label for="userid">아이디</label> 
	                        <input type="text" class="form-control" id="userid" 
	                        value="${member.userid}" name="userid" readonly>
	                    </div>
	                    <div class="form-group">
	                        <label for="username">이름</label> 
	                        <input type="text" class="form-control" id="username" 
	                        value="${member.username}" name="username">
	                    </div>
	                    <div class="form-group">
	                        <label for="updatePWBtn">비밀번호</label> <!--label for는 id와 일치해야한다  -->
	                        <button type="button" id="updatePWBtn"
	                        class="btn btn btn-primary" name="userpw" >변경</button>
	                    </div>
	                    <div class="form-group">
	                        <label for="email">이메일</label> 
	                        <input type="email" class="form-control" id="email" 
	                        value="${member.email}" name="email">
	                    </div>
	                    <div class="text-center">
	                    <button id="updateSubmitBtn" type="submit" 
	                    class="btn btn-primary">회원정보수정</button>
	                    <button type="button" data-dismiss="modal" onclick="back()"
	                    class="btn btn-secondary" >취소</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</div>
	</div>
	
<%@include file="./memberModal.jsp"%>

</body>
</html>

<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	// 비밀번호수정버튼	    
 	$(function() {
			$("#updatePWBtn").on("click", function(e) {
				e.preventDefault();
				location.href = "/auth/member/updatePassword"
			});
		});

		// 회원정보수정 폼제출
		$(function() {
			$("#updateSubmitBtn").on("click", function(e) {
				e.preventDefault();
				debugger;
				$("#updateForm").submit();
			});
		});

		

	});
</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../../includes/footer.jsp"%>