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
<style>
* {
	box-sizing: border-box;
}

html {
	overflow-y: scroll;
}

.flex-col-center {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}
</style>
</head>
<body>
<script>
window.onload = function() {
	var interval = setInterval(function() {
		var countElement = document.getElementById("count");
		var count = parseInt(countElement.innerHTML);
		if(count == 1) {
			clearInterval(interval);
			location.href="/board/getPostList"
			return;
		}
		countElement.innerHTML = --count;
	}, 1000);
}
</script>

<div class="flex-col-center" style="margin-top: 100px;">
	<h1>
		Sujin's Hello World!
	</h1>
	<h3>제 사이트에 오신것을 환영합니다.</h3>
	<h3><span id="count">5</span>초 후 게시판으로 진입합니다.</h3>
	<p>서버시간: ${serverTime}</p>
</div>
</body>
	<hr>
	<footer class="flex-col-center">
		<p>업데이트 이력</p>
		<p>2024-04-09 CSS 업데이트</p>
	</footer>
</html>
