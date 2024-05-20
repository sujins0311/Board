<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>

<h1>/auth/member page</h1>
<h1>manager</h1>
<sec:authorize access="isAnonymous()">
	<a href="/customLogin">로그인</a>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<a href="/customLogout">로그아웃</a>
</sec:authorize>

<p>principal : <sec:authentication property="principal"/></p>
<p>MemberVO : <sec:authentication property="principal.member"/></p>
<p>사용자이름 : <sec:authentication property="principal.member.username"/></p>
<p>사용자아이디 : <sec:authentication property="principal.username"/></p>
<p>사용자이메일 : <sec:authentication property="principal.member.email"/></p>
<p>사용자 권한 리스트  : <sec:authentication property="principal.member.authList"/></p>
<p>사용자 권한  : <sec:authentication property="principal.authorities"/></p>
<hr>


<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/footer.jsp"%>