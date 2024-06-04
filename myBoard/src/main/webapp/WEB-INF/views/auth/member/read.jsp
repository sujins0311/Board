<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../../includes/header.jsp"%>
<title>마이페이지</title>
<style>
<style>
/* 커스텀 프로필 리스트 아이템 스타일 */
.customProfileList li {
    padding: 10px;
    position: relative;
    color: #333;
    text-align: left;
    display: flex;
    align-items: center; /* 아이콘과 텍스트 수직 정렬 */
    margin-bottom: 15px;
}

/* 아이콘 스타일 */
.customProfileList li svg {
    margin-right: 10px; /* 아이콘과 텍스트 사이 간격 조정 */
}

/* 버튼 컨테이너 스타일 */
.button-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}



@media (min-width: 768px) {


}

</style>
<hr>
<div class="container" id="profileContainer">
	<div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-body">
					<h3 class="mt-2">
						<b>기본정보</b>
					</h3>
					<sec:authorize access="isAuthenticated()">
						<ul class="list-group customProfileList mt-4">
							<li class="list-group-item"><i class="fas fa-id-card fa-fw"></i> ID: ${member.userid}</li>
							<li class="list-group-item"><i class="fas fa-user fa-fw"></i> 이름: ${member.username}</li>
							<li class="list-group-item"><i class="fas fa-envelope fa-fw"></i> 이메일: ${member.email}</li>
							<li class="list-group-item"><i class="fas fa-calendar-alt fa-fw"></i> 가입일: <fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}" /></li>
							<li class="list-group-item"><i class="fas fa-graduation-cap fa-fw"></i> 회원등급: (예정)</li>
						</ul>
					</sec:authorize>
					<div class="button-container">
						<a class="snb-btn" href="/auth/member/update">
							<button class="common-btn btn mr-2">개인정보수정</button>
						</a> <a class="snb-btn" href="/auth/member/updatePassword">
							<button class="common-btn btn mr-2">비밀번호수정</button>
						</a> <a class="snb-btn" href="#">
							<button class="common-btn btn mr-2">나의활동:작성글모아보기(예정)</button>
						</a> <a class="snb-btn" href="/auth/member/delete">
							<button class="common-btn btn">탈퇴하기</button>
						</a>
					</div>
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


</script>
		<%@include file="../../includes/footer.jsp"%>