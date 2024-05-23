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
				<a class="snb-btn" href="/auth/member/updatePassword">
					<button class="common-btn btn">비밀번호수정</button>
				</a>
				<a class="snb-btn">
					<button class="common-btn btn">나의활동:작성글모아보기(예정)</button>
				</a>
				<a class="snb-btn" href="/auth/member/delete">
					<button class="common-btn btn">탈퇴하기</button>
				</a>
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


</script>
<%@include file="../../includes/footer.jsp"%>