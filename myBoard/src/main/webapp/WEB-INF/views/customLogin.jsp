<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="./includes/logHeader.jsp"%>
<title>로그인</title>

<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="page-header text-center">
				<a href="/"><b>HOME(이미지삽입예정)</a></b>
			</h3>
			</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-4 ">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title text-center"><b>로그인이 필요합니다.</b></h3>
				</div>
				<div class="panel-body">
					<form role="form" method='post' action="/login">
						<fieldset>
							<div class="form-group">
								<input class="form-control" placeholder="아이디를 입력해 주세요." name="username" type="text" autofocus>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="비밀번호를 입력해 주세요." name="password" type="password" value="">
							</div>
							<div class="checkbox">
								<label> <input name="remember-me" type="checkbox">아이디 저장
								</label>
							</div>
							<!-- Change this to a button or input when using this as a form -->
							<a href="index.html" class="btn btn-lg btn-custom-success btn-block">로그인</a>
						</fieldset>
						<!-- CSRF(Cross-Site Request Forgery)토큰은 서버가 브라우저에 전송한 토큰값과 비교해 처리하는 방식 > 세션 보관 -->
						<!-- <input type="hidden" name="_csrf"
						    value="c58c9d7a-a81e-4231-96dd-168c6662428a" /> -->
						<!-- 스프링 시큐리티 > CSRF토큰 비활성화  -->
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			</div>
			<div style="display: flex; justify-content: center;">
				<a class="snb-btn" href="/"> <!-- 아이콘 --> <!-- <img src="/resources/images/icons/home.ico" width=24px; height=24px; />  -->
					<button class="common-btn btn">HOME</button>
				</a> <a class="snb-btn" href="/board/getPostList" style="margin: 0px 15px 0px 15px"> <!-- 아이콘 --> <!-- <img src="/resources/images/icons/list.ico" width=24px; height=24px;/> -->
					<button class="common-btn btn">게시글 목록</button>
				</a> <a class="snb-btn" href="/auth/register"> <!-- 아이콘 --> <!-- <img src="/resources/images/icons/list.ico" width=24px; height=24px;/> --> <span></span>
					<button class="common-btn btn">회원가입</button>
				</a>
			</div>
		</div>
	</div>
</div>

<!-- 회원가입성공모달 -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">성공 메시지</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="successModalBody"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="successModalBtnToLogIn" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!--  jQuery 라이브러리의 3.6.4 버전 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// 회원가입 모달
	$(function() {
		var registerMember = '${registerMember}';
		
		console.log(registerMember);
		checkModal(registerMember);
		
		// parseInt() 함수는 문자열을 정수로 변환하는 JavaScript의 내장 함수
		// $(".modal-body").html("<p>모달에 추가할 HTML 형식의 텍스트</p>");
		// $(".modal-body").text("모달에 추가할 텍스트");
		function checkModal(registerMember) {
		    if (!registerMember || registerMember === '' 
		    		|| registerMember === null) { // 공백이거나 null이면 모달종료 
		        return;
		    }else{
				$("#successModalBody").html(
						"[ID :" + registerMember + "] 회원가입에 성공하셨습니다.");
				}
			$("#successModal").modal("show");
		}
	});
	
	// 비밀번호수정 성공모달, 회원탈퇴 성공모달
	$(function() {
	    var successMessage = "${success}";
	    
	    checkResult(successMessage);

	    function checkResult(successMessage) {
	        if (!successMessage || successMessage.trim() === '') {// 공백이거나 null이면 모달종료 
	            return;
	        }else{
	        	$("#successModalBody").html(successMessage);
	        }
	        $("#successModal").modal("show");
	    }
	});
	
	// 로그인버튼
	$(".btn-custom-success").on("click", function(e) {
		e.preventDefault();
		// 아이디, 패스워드 입력 검증
		$("form").submit();
	});
	
	// 패스워드 입력창에서 엔터키 입력시 로그인 버튼 클릭
	$("form input[name='password']").keydown(function(e) {
		// 키 번호 13 == enter 키
		if(e.keyCode == 13) {
			$(".btn-custom-success").click();
		}
	});
	
	// 모바일 화면에서 키보드 사용시 푸터 숨김 및 해제
	$("form input").focus(function() {
		if($(window).width() < 768) {
			$(".footer").hide();	
		}
	});
	
	$("form input").blur(function() {
		if($(window).width() < 768) {
			$(".footer").show();	
		}
	});
});
</script>

</body>
</html>

<!-- 푸터--------------------------------------------------------------------------------->
<%@include file="./includes/logFooter.jsp"%>