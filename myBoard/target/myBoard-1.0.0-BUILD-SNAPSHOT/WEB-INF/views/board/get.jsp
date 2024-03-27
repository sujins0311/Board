<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Board Details</title>
</head>
<body>
    <h1>Board Details</h1>
    <table border="1">
        <tr>
            <th>BNO</th>
            <th>Title</th>
            <th>Content</th>
            <th>Writer</th>
            <th>RegDate</th>
            <th>UpdateDate</th>
        </tr>
        <tr>
            <td>${board.bno}</td>
            <td>${board.title}</td>
            <td>${board.content}</td>
            <td>${board.writer}</td>
            <td>${board.regdate}</td>
            <td>${board.updateDate}</td>
        </tr>
    </table>
</body>
</html>