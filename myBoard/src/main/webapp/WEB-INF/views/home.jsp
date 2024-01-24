<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 파일업로드,년월일 -->
<!-- JSTL라이브러리 import -->
<!DOCTYPE html>
<!-- JSP(JSTL) + Vanilla JS -->
<html lang="en">
<p>헤더 자리입니다.</p>
<!--  JSP 페이지에서 다른 JSP 파일을 포함하고자 할 때 사용하는 지시자 -->
<%-- <%@include file="../includes/header.jsp"%> --%>
<!-- 정적인콘텐츠(해당 JSP파일은 컴파일시점에 포함) -->
<%-- <jsp:include page="../includes/header.jsp"/> --%>
<!-- 동적인콘텐츠(해당 JSP파일이 실행 될때 포함/header.jsp와 list.jsp가 각각 실행되고, header.jsp의 결과 HTML만 include) -->
<head>
<!-- 부트스트랩 CSS CDN 링크 -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HOME</title>

</head>
	<hr><!-- 헤더 -->
<body>
	<a href="/board/getCreatePost">게시글 작성</a>
	<a href="/board/getPostList">게시글 목록</a>
	<a href="/board/getPost?bno=1">1번 게시글 조회</a>
	<a href="/board/getModifyPost?bno=1">1번 게시글 수정</a>
	<a href="/">처음으로</a>
<h1>
	MyBoard의 home화면입니다.
</h1>


<P>  The time on the server is ${serverTime}. </P>
	<!-- Vanilla JavaScript 코드 -->
	<script type="text/javascript">
    </script>
</body>
	<hr><!-- 푸터 -->
	<footer>
		<%-- <%@include file="../includes/footer.jsp"%> --%>
		<p>푸터 자리입니다.</p>
	</footer>
</html>
