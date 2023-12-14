<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> <!-- 파일업로드?? -->
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
<meta charset="UTF-8">
<title>Board List Page</title>
</head>
<body>
		
	<a href="/board/register">게시글 작성</a>
	<a href="/">처음으로</a>
	
	<!-- 게시글 목록을 나타내는 테이블 HTML -->
	<h1>Board List</h1>
	<table id="BoardList" border="1">
		<thead>
            <tr>
                <th>BNO</th>
                <th>Title</th>
                <th>Content</th>
                <th>Writer</th>
                <th>RegDate</th>
                <th>UpdateDate</th>
            </tr>
		</thead>
		<tbody>
			<!-- JSTL을 이용한 Board데이터 렌더링 -->
			<c:forEach items="${list}" var="boardList"> <!-- controller에서 K,V값 확인 --> <!-- c:forEach는 list값을 순회함 model.addAttribute("list", service.getList());	 -->
				<tr>
					<td><c:out value="${boardList.bno}" /></td>
					<td><c:out value="${boardList.title}" /></td>
					<td><c:out value="${boardList.content}" /></td>
					<td><c:out value="${boardList.writer}" /></td>
					<td><c:out value="${boardList.regdate}" /></td>
					<td><c:out value="${boardList.updateDate}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- Vanilla JavaScript 코드 -->
	<script type="text/javascript">
    </script>

	<!-- 푸터 -->
	<footer>
		<%-- <%@include file="../includes/footer.jsp"%> --%>
		<p>푸터 자리입니다.</p>
	</footer>
</body>
</html>


