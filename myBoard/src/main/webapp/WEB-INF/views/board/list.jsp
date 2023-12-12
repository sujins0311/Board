<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Board List</title>
</head>
<body>
    <h1>Board List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>BNO</th>
                <th>Title</th>
                <th>Content</th>
                <th>Writer</th>
                <th>Reg Date</th>
                <th>Update Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${list}">
                <tr>
                    <td>${board.bno}</td>
                    <td>${board.title}</td>
                    <td>${board.content}</td>
                    <td>${board.writer}</td>
                    <td>${board.regdate}</td>
                    <td>${board.updateDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>