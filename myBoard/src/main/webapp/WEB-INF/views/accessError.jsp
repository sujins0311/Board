<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>죄송합니다 - 접근 거부</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-rxYHS0B5Z0qfgPbo8G4+eAr/IUv6x6e/Oo8wUjN+3ALZK6SzqY+ymNMd5cFxoKlt" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            max-width: 600px;
            margin: 50px auto;
            text-align: center;
        }
        h1 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #343a40;
        }
        p {
            font-size: 18px;
            margin-bottom: 20px;
            line-height: 1.6;
            color: #6c757d;
        }
        .icon {
            font-size: 64px;
            margin-bottom: 20px;
            color: #dc3545;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <i class="fas fa-exclamation-circle icon"></i>
        <h1>죄송합니다</h1>
        <p>요청하신 페이지를 보실 권한이 없습니다.</p>
        <p>방문하시려는 페이지는 권한이 있는 회원만 보실 수 있습니다.</p>
        <p>권한이 있는 회원이 아니시라면 먼저 운영자에게 문의하여 사용권한을 얻으신 후 요청하신 페이지를 보실 수 있습니다.</p>
        <p>감사합니다.</p>

        <!-- Spring Security 403 에러 메시지 출력 -->
        <c:if test="${not empty SPRING_SECURITY_403_EXCEPTION.getMessage()}">
            <h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
        </c:if>

        <!-- 결과 출력 -->
        <c:if test="${not empty result}">
            <h2><c:out value="${result}"/></h2>
        </c:if>
        <a href="/" class="button">홈으로 돌아가기</a>
    </div>
</body>
</html>