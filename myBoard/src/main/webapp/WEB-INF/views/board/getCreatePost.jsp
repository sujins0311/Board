<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!-- 헤더 + 바디 -------------------------------------------------------------------------------->
<%@include file="../includes/header.jsp"%>

	<!-- role: 시멘틱하지않은 요소에 추가설명을 위한 태그 -->
	<!-- action: controller의 메서드 경로 -->
	<!-- name: 서버로 전송할때 사용자입력한 내용과 같이 전송됨 -->
	<!-- value: 초기입력값, placeholder: hint text -->
	<!-- id: 고유식별자, class: CSS등 을 위한 식별자 우선순위: id>class -->
	<!-- type: 필드타입정의(text, password, submit, checkbox, radio, number 등) -->
	<!-- 부트스트랩클래스
"form-group":폼요소를 감싸는 컨테이너, 
"form-control":입력필트에 적용되어 부트스트랩 폼스타일 적용 -->

<style>
.reg-body {
	width: 100%;
}

.context {
	height: 200px;
}

@media (min-width: 768px) {
	.reg-body {
	}
	.context {
		height: 200px;
	}
	
	.title {
		width: 100%;
	}
	
	.writer {
		width: 100%;
	}
}
</style>

<div class="row">
	<div class="col-lg-12">
		<a class="page-header-link" href="/board/getCreatePost">
			<h3 class="page-header">게시글 등록</h3>
		</a>
	</div>
</div>

<div class="row reg-body">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글을 등록합니다.</div>
			<div class="panel-body">
				<form id="createPostForm" role="form" action=getCreatePost method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<label for="title">제목:</label> <input type="text" class="form-control title" placeholder="제목을 입력하세요" id="title" name="title">
					</div>
					<div class="form-group">
						<label for="content">내용:</label>
						<textarea class="form-control context" placeholder="내용을 입력하세요" rows="3" id="content" name="content"></textarea>
					</div>
					<div class="form-group">
						<label for="writer">작성자:</label> 
						<input type="text" class="form-control writer" id="writer" name="writer"
						value='<sec:authentication property="principal.username"/>' readonly"readonly">
						<%-- <input type="text" class="form-control" id="writer" name="writer" value="${createPostResult.writer}" readonly="readonly"> --%>
					</div>
					<button id="resetBtn" type="reset" class="btn common-btn">초기화</button>
					<button id="submitBtn" type="button" class="btn common-btn" style="float:right;">등록</button>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="confirmModalLabel">알림</h4>
				</div>
				<div class="modal-body">게시글을 등록하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button id="confirmSubmitBtn" type="button" class="btn btn-primary">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

<script type="text/javascript">
	// 값이 전달이되는 지 확인하기위해 log 추가
	$(function() {
		// = $(document).ready(function() {
		// `document`는 웹 페이지의 전체 문서를 나타내는 객체로, DOM (Document Object Model)의 최상위 객체

		// 등록버튼 누르면 모달창열기
		$("#submitBtn").on("click", function(event) {
			var titleValue = $("#title").val();
			var contentValue = $("#content").val();
			
			if (titleValue !== "" && contentValue !== "") {
		        // 값이 유효한 경우 모달 열기
		        console.log("제목:", titleValue);
		        console.log("내용:", contentValue);
				 $('#confirmModal').modal('show');
				}else{
				alert("제목 또는 내용이 비어 있습니다.");
			}
		});

		// 모달창에서 확인 버튼을 누르면 클릭이벤트
		$("#confirmSubmitBtn").on("click", function() {
	        //모달 숨김 
	        $('#confirmModal').hide();
	        $('.modal-backdrop').hide();
	        //$('#confirmModal').modal('hide');
			// 폼 전송
			$("#createPostForm").submit();
	        // 전송 후 폼 초기화
	        $("#createPostForm")[0].reset();

	        // 모달제거
			//$('#confirmModal').remove();
			
			
			//$('.modal-backdrop').remove();
		});

		// Reset 버튼 클릭 이벤트
		$("#resetBtn").on("click", function() {
			console.log("필드가 리셋되었습니다.");
		});

	});
</script>


<!-- 푸터------------------------------------------------------------------------------ -->
	<%@include file="../includes/footer.jsp"%>