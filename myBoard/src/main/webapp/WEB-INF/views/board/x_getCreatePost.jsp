<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 등록</title>
</head>
<body>

<h1>게시글 등록</h1>

<form action="createPost" method="post">
    <label for="title">게시글 번호:</label><br>
    <input type="text" id="bno" name="bno"><br>

    <label for="content">내용:</label><br>
    <textarea id="content" name="content"></textarea><br>

    <label for="writer">작성자:</label><br>
    <input type="text" id="writer" name="writer"><br>

    <input type="submit" value="등록">
</form>


</body>
</html>