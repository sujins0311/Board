<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<!-- 각 jsp에 아래와 같이 header.jsp 추가하기 -->
<!--  JSP 페이지에서 다른 JSP 파일을 포함하고자 할 때 사용하는 지시자 -->
<%-- <%@include file="../includes/header.jsp"%> --%>
<!-- 정적인콘텐츠(해당 JSP파일은 컴파일시점에 포함) -->
<%-- <jsp:include page="../includes/header.jsp"/> --%>
<!-- 동적인콘텐츠(해당 JSP파일이 실행 될때 포함/header.jsp와 list.jsp가 각각 실행되고, header.jsp의 결과 HTML만 include) -->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- 공통 스타일 -->
<title>안녕하세요!</title>

<!-- BootStrap -->
<!-- 부트스트랩은 재사용가능한 완성된 UI 컴포넌트를 제공 -->

<!-- 부트스트랩 CSS CDN 링크 -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd" crossorigin="anonymous">

<!-- MetisMenu CSS(반응형 사이드바 메뉴를 생성하는데 도움을 주는 jQuery 플러그인) -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables의 Responsive 확장 플러그인의 스타일(표 형태의 데이터를 동적으로 정렬, 검색, 페이지네이션할 수 있는 플러그인) -->
<link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

<!-- DataTables Responsive CSS( DataTables와 함께 사용하여 테이블이 작은 화면에서도 응답할 수 있게 도와주는 플러그인) -->
<link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

<!-- Custom CSS -->
<!-- 사용자 정의 CSS 파일을 로컬 경로에서 호출 -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts (FontAwesome 아이콘) -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- 파비콘(탭 로고이미지)-->
<link rel="shortcut icon" href="/resources/images/icons/favicon.ico" type="image/x-icon"/>

<!-- 아이콘 소스 -->
<!-- 검색: https://www.freepik.com/search?format=search&last_filter=query&last_value=list&query=list&type=icon -->
<!-- 클립보드 다운로드: https://www.paste.photos/ -->
<!-- 변환: https://favicon.io/ -->

<style type="text/css">
/* 부트스트랩 기본값을 커스텀합니다.*/

html {
	overflow-y: scroll;
}

#wrapper, #page-wrapper {
	height: 100%;
}

body {
	height: 100%;
	background-color: rgba(94,66,161,0.1);
	border-color: rgba(94,66,161,0.5); 
}


/*GNB(General Navigation Bar), LNB(Local), SNB(Side), FNB(Foot)*/
.snb-btn {
	display: flex !important;
	color: black;
	font-weight: bold;
	font-size: 12px;
}

.snb-btn > span {
	padding-left: 10px;
	padding-top: 5px;
}

.lnb-btn {
	color: black;
	font-weight: bold;
	font-size: 12px;
}

.lnb-btn > span {
	padding-left: 5px;
}

.navbar-default {
	background-color: rgba(94,66,161,0); 
}

.navbar-header {
	width: 100%;
}

.nav>li>a:focus, .nav>li>a:hover {
	background-color: rgba(94,66,161,0.5); 
}

.sidebar ul li a.active {
	background-color: rgba(94,66,161,0.5);
}

.navbar-info {
	float: right;
	padding: 15px 15px;
}

.common-btn {
	border: solid 1px lightgray;
	background-color: white;
	box-shadow: 1px 1px 0px 0 rgb(0 0 0 / 10%);
	font-weight: bold;
}

.btn:focus,
.btn:active:focus,
.btn.active:focus,
.btn.focus,
.btn:active.focus,
.btn.active.focus {
	outline: 0;
}

.page-contents {
	text-align: center;
}

.page-header-link,
.page-header-link:hover {
	display: block;
	width: 128px;
	color: black;
	text-decoration: none;
}

.pagination>.active>a, 
.pagination>.active>a:focus, 
.pagination>.active>a:hover, 
.pagination>.active>span, 
.pagination>.active>span:focus, 
.pagination>.active>span:hover {
    z-index: 3;
    color: black;
    cursor: pointer;
    background-color: blanchedalmond;
    border-color: lightgray;
}

.pagination>li>a, .pagination>li>span {
    position: relative;
    float: left;
    padding: 1px 6px;
    margin-left: -1px;
    line-height: 1.42857143;
    color: black;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #ddd;
}

.content {
	height: 200px !important;
}

.reply .panel-footer {
	display: flex;
	justify-content: center;
	padding: 5px 15px;
}

.reply .pagination {
	margin: 0;
}

 textarea {
    resize: none;
    width: 300px;  /* 원하는 너비 설정 */
    height: 150px; /* 원하는 높이 설정 */
}

/* 반응형 웹사이트를 만드는 @media query */
@media (max-width: 768px) {

	.sidebar-widget {
		display: none;
	}
	
	.navbar-toggle {
		float: left;
		margin-left: 10px;
	}
	
	.navbar-toggle:focus {
		background-color: transparent !important;
	}
	
	.navbar-brand {
		margin-left: -15px;
	}
	
	.btn-search {
		width: 100%;
	}
}
</style>

</head>

<body>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
            	<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            	<a class="navbar-brand" href="/">MyBoard</a>
            	
				<div class="navbar-info">
				        
				    <sec:authorize access="isAnonymous()">
				    <a href="/auth/register"><button class="common-btn btn">회원가입</button></a>
				    <a href="/customLogin"><button class="common-btn btn">로그인</button></a>
				    
				      
				    </sec:authorize>
				    <sec:authorize access="isAuthenticated()">
				       <sec:authentication property="principal.username"/> 님
				       <a href="/auth/member/read">마이페이지</a> |
				       <!-- <a href="/auth/all">회원정보</a> | -->
				        <!-- <a href="/customLogout">로그아웃</a> -->
				        <!-- Spring Security와 같은 보안 프레임워크를 사용하는 경우 /logout URL로 접근하면 Spring Security가 해당 요청을 인터셉트하여 로그아웃 -->
				        <!-- JSP 페이지로 이동하는 것이 아니라, Spring Security가 로그아웃을 처리 -->
				        <!-- <a href="#" onclick="document.getElementById('logoutForm').submit();">로그아웃</a> -->
				        <a href="#" onclick="confirmLogout()">로그아웃</a>
				    </sec:authorize>

					<form id="logoutForm" action="/customlogout" method="post">
						<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}" />
					</form>
				</div><!-- 로그인 정보... 로그아웃 -->
			</div>
            <!-- /.navbar-header -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="게시글 검색">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        <li>
                        <!-- 
	                        id(#) : 엘리먼트를 식별
	                        class(.) : css style을 적용하기 위한 엘리먼트를 식별 (여러개가 같은 값을 가지는 경우가 많음)
	                        둘 다 식별자로서의 기능은 동일하기에
	                        프로젝트에서 둘 중 어느 방식을 주 식별자로 할 건지 일관되게 정하는 것이 보통
	                        단일 개체에 이벤트를 주려면 id로 식별자를 선택하거나 태그 내 이벤트 속성을 사용할 것
                        -->
                            <a class="snb-btn" href="/">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/home.ico" width=24px; height=24px;/>
                            	<span>Home</span>
                            </a>
                        </li>
                        

                        <li>
                            <a class="snb-btn" href="#" onclick="isWritingAllowed()">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/write.ico" width=24px; height=24px;/>
                            	<span>게시글 작성</span>
                            </a>
                        </li>

                        
                        
                        <li>
                            <a class="snb-btn" href="/board/getPostList">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/list.ico" width=24px; height=24px;/>
                            	<span>게시글 목록</span>
                            </a>
                        </li>
                        <li>
                            <a class="snb-btn" style="cursor:pointer;">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/link.ico" width=24px; height=24px;/>
                            	<span>관련 사이트</span>
                            	<span class="fa arrow" style="padding-top:5px; font-size:15px;"></span>
                            </a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a class="lnb-btn" href="https://github.com/sujins0311/sujins0311" target="_blank">
                                    	<img src="/resources/images/icons/page.ico" width=24px; height=24px;/> 
                                    	<span>Github</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="lnb-btn" href="https://sujinpad.tistory.com/" target="_blank">
                                    	<img src="/resources/images/icons/page.ico" width=24px; height=24px;/> 
                                    	<span>Tistory</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
              	<div class="sidebar-widget" style="margin-top:500px;">
              		<p><b>최근 댓글 보기(작업중)</b></p>
              		<p><a>최근 댓글 및 링크 1</a></p>
              		<p><a>최근 댓글 및 링크 2</a></p>
              		<p><a>최근 댓글 및 링크 3</a></p>
              		<p><a>최근 댓글 및 링크 4</a></p>
              		<p style=''><a>최근 댓글 및 링크 5</a></p>
              		<!-- <![CDATA[ 문자열 ]]> 표현식 : XML 에서 문자열을 escape 할 수 있다. 
              		태그나 특수기호 등 언어나 예약어로 파싱되는게 아닌 일반 문자로 인식되어야 할 때 사용 ex) mybatis sql에서 사용가능 -->
              		<!-- &nbsp; &lt; &gt; 등의 표현식 : HTML에서 문자열 escape를 하는 방법.
              		각각이 의미하는 문자가 존재하며 특히 HTML에서 띄어쓰기는 여러번들어가도 한칸밖에 인식이 안되는데 이 떄 &nbsp;를 사용  -->
              		<a>&lt;</a>&nbsp;&nbsp;<a>&gt;</a>
              	</div>
            </div>
            <!-- /.navbar-static-side -->
        </nav>

		<!-- Modal -->
		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" 
		aria-labelledby="loginModalLabel" aria-hidden="true" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" 
						aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="loginModalLabel">알림</h4>
					</div>
					<div class="modal-body">로그인이 필요합니다. 로그인을 하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<a href="/customLogin" class="btn btn-primary">로그인</a>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
		

	</div>
 	<div id="page-wrapper">
 	
 	
 </body>
<!-- 공통 스크립트 -->
<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

	// jsp 및 servlet 의 scope 종류
	// page : default scope
	// request
	// session
	// application
	// page < request < session < application
	
	// jsp 의 기본 오브젝트
	// page, request, response pageContext, session, application, out, config, exception
	
	// empty 인지 여부
	// 따라서 객체가 null이거나 '' 이면 true
/* 	function isAuthenticated(e) {
		if (${empty pageContext.request.userPrincipal.name}) {
	        if (confirm('로그인이 필요합니다. 로그인하시겠습니까?')) {
	            location.href="/customLogin";
	        }
		} else {
			location.href="/board/createPost"	
		}
	}//header:게시글작성, getpost:작성하기 */
    var loginer = "${pageContext.request.userPrincipal.name}";
    console.log("loginer:" + loginer);
	
	function isWritingAllowed(e) {
		if (${empty pageContext.request.userPrincipal.name}) {
			$('#loginModal').modal('show');	
		} else {
			location.href="/board/createPost"	
		}
	}//header:게시글작성
	
	
	// 로그아웃 확인
	function confirmLogout() {
		if(confirm("로그아웃 하시겠습니까?")){
			document.getElementById('logoutForm').submit();
		}	
	}
	
	// 뒤로가기
	// location: 현재페이지조작
	// history: 모든 페이지 기록조작
	function back() {
		history.back();
	}
</script>
