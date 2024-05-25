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

@media (min-width: 768px) {
	
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
		<a class="page-header-link" href="/board/createPost">
			<h3 class="page-header">게시글 등록</h3>
		</a>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글을 등록합니다.</div>
			<div class="panel-body">
				<form id="createPostForm" role="form" action=createPost method="post" 
				enctype="multipart/form-data"><!-- 파일업로드 -->
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="form-group">
						<label for="title">제목:</label> 
						<input type="text" class="form-control title" placeholder="제목을 입력하세요" id="title" name="title">
					</div>
					<div class="form-group">
						<label for="content">내용:</label>
						<textarea class="form-control content" placeholder="내용을 입력하세요" rows="3" id="content" name="content"></textarea>
					</div>
					<div class="form-group">
						<label for="writer">작성자:</label> 
						<input type="text" class="form-control writer" id="writer" name="writer"
						value='<sec:authentication property="principal.username"/>' readonly="readonly">
						<%-- <input type="text" class="form-control" id="writer" name="writer" value="${createPostResult.writer}" readonly="readonly"> --%>
					</div>
					<div class="form-group">
						<label for="files">파일첨부</label> 
						<input type="file" class="form-control files" id="files" name="files" multiple="multiple"> <!-- multiple="multiple" 첨부파일 여러개 선택할수있는 속성 -->
					</div>
					<button id="resetBtn" type="reset" class="btn common-btn">초기화</button>
					<button id="submitBtn" type="submit" class="btn common-btn submitBtn" style="float:right;">등록</button>
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
 const formObj = document.querySelector("#createPostForm")

	// button type="submit"
	// e.stopPropagation() 현재 이벤트가 상위 요소로 전파되지 않도록 막음
	// e.preventDefault() 페이지가 새로 고침되는 것을 막고, 대신 자바스크립트로 폼 제출을 처리
	document.querySelector(".submitBtn").addEventListener("click", e => {
	    e.stopPropagation();
	    e.preventDefault();
	
	    const fileReg = /(.*?)\.(gif|png|jpg|jpeg|bmp)$/;
	
	    // file suffix check(파일 확장자로 외부 공격을 막음)
	    // 파일 확장자를 검사하여 허용된 이미지 파일만 업로드할 수 있게 합니다.
	   	// 이는 악성 스크립트나 다른 공격을 포함할 수 있는 허용되지 않은 파일의 업로드를 방지하여 보안성을 높입니다.
	    const fileInput = document.querySelector("input[name='files']");
	
	    // dir 속성> files > file의 list를 볼 수 있음
	    const fileArr = fileInput.files;
	    

	
	    if(fileArr && fileArr.length > 0){ // 0보다 크다는 건 첨부 파일이 있다.
	        for (const file of fileArr) {
	            if(!file.name.match(fileReg)) { // 첨부파일에 올린 파일과 fileRegExp내가 허용한 파일 확장자(이미지)를 match를 한다.
	                alert("해당 종류의 확장자는 업로드 할 수 없습니다.")
	                return;
	            }
	        }
	    }
	
	    formObj.submit();
	
	},false)

		
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
					 
					}else{
					alert("제목 또는 내용이 비어 있습니다.");
				}
				
				$('#confirmModal').modal('show');
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



<%@include file="../includes/footer.jsp"%>