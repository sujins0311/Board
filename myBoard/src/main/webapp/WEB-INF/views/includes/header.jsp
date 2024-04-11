<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

/* 반응형 웹사이트를 만드는 @media query */
@media (max-width: 768px) {
	.navbar-toggle {
		float: left;
		margin-left: 10px;
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
            	<div class="navbar-info">로그인 정보... 로그아웃</div>
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
                            <a class="snb-btn" href="/">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/home.ico" width=24px; height=24px;/>
                            	<span>Home</span>
                            </a>
                        </li>
                        <li>
                            <a class="snb-btn" href="/board/getCreatePost">
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
                            <a class="snb-btn" href="/getCreatePost">
                            	<!-- 아이콘 -->
                            	<img src="/resources/images/icons/link.ico" width=24px; height=24px;/>
                            	<span>관련 사이트</span>
                            	<span class="fa arrow" style="padding-top:4px; font-size:15px;"></span>
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
            </div>
            <!-- /.navbar-static-side -->
        </nav>
	</div>
 	<div id="page-wrapper">
 </body>
<!-- 공통 스크립트 -->
<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>