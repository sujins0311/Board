<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ERROR - 예기치 않은 오류가 발생했습니다.</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
            padding-top: 50px;
        }
        h1 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #dc3545;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
            line-height: 1.6;
            color: #6c757d;
        }
        ul {
            list-style-type: none;
            padding-left: 0;
            text-align: left;
        }
        li {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>ERROR</h1>
    <h2>예기치 않은 오류가 발생했습니다.</h2>
    <p>오류가 계속되면 시스템 관리자에게 문의하세요.</p>
    <a href="/" class="button">홈으로 돌아가기</a>

    <h3>Error Message:</h3>
    <h4><c:out value="${exception.getMessage()}"/></h4>
    <hr>
    <h3>Stack Trace:</h3>
    <ul>
        <c:forEach items="${exception.getStackTrace()}" var="stack">
            <li><c:out value="${stack}"/></li>
        </c:forEach>
    </ul>
</body>
</html>