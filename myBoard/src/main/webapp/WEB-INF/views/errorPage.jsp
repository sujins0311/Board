<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" import="java.util.* "%> <!-- 세션을 사용하지 않는것을 명시해준다. -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> <!-- HTTP의 header = http-equiv -->
<title>ERORR</title>
</head>

<body>
	<h1>
		Error Message:
		<c:out value="${exception.getMessage()}"></c:out>
	</h1>
	<hr>
	<h4>Stack Trace:</h4>
	<ul>
		<c:forEach items="${exception.getStackTrace()}" var="stack">
			<li><c:out value="${stack}"></c:out></li>
		</c:forEach>
	</ul>
</body>
</html>
