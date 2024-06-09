<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 수정</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">게시글 수정</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="modifyPost" method="post" style="display: inline;" 
				enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>  		
					<input type='hidden' name='currentPageNum' value='<c:out value="${cri.currentPageNum }"/>'> 
					<input type='hidden' name='itemPerPage' value='<c:out value="${cri.itemsPerPage }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<div class="form-group">
						<label>#번호</label> 
						<input class="form-control" name='bno' value='<c:out value="${modifyPostResult.bno}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label for="title">제목</label> 
						<input class="form-control" id="title" name='title' value='<c:out value="${modifyPostResult.title}"/>'>
					</div>
					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control" rows="3" id="content" name='content'><c:out value="${modifyPostResult.content}" /></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label> 
						<input class="form-control" name='writer' value='<c:out value="${modifyPostResult.writer}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label for="files">파일첨부</label> 
						<input type="file" class="form-control files" id="files" name="files" multiple="multiple"> <!-- multiple="multiple" 첨부파일 여러개 선택할수있는 속성 -->
					</div>

					<!-- 게시물작성자만 수정/삭제버튼 확인 -->
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq modifyPostResult.writer || '[ROLE_ADMIN]' eq pinfo.authorities}">
							<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
							<button type="submit" data-oper='delete' class="btn btn-danger removeBtn">삭제</button>
						</c:if>
					</sec:authorize>
					<!-- <button type="submit" data-oper='list' class="btn btn-info">목록</button> -->

					<!-- <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
					<button type="submit" data-oper='delete' class="btn btn-danger">삭제</button>
					<button type="submit" data-oper='list' class="btn btn-info">목록</button> -->
					<div class="btn btn-info" onclick="back()" style="float: right;" >취소</div>
					<!-- 파일수정/삭제 폼 -->
					<div class="deleteImages"></div> <!-- form태그에 히든태그를 붙이면 인풋태그가 사라짐 그래서 새 태그를 생성 -->
				</form>
				
			</div>
			<!--  end panel-body -->
		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->

        <!-- 첨부파일(이미지) -->
        <div class="col-lg-12">
	        <div class="panel">
		        <label>첨부파일</label>
				<div class="attachList d-flex flex-row"> <!-- flex-row: 가로로 나열 -->
				    <c:if test="${not empty modifyPostResult.attachVOList}">
					    <c:forEach items="${modifyPostResult.attachVOList}" var="attach">
					    	<c:if test="${attach.ano != null}" >
				    			 <div class="attachList d-flex flex-column"> <!-- target.closest("div").remove() -->
					        		<img src="/files/s_${attach.fileName}" alt="첨부 이미지"> <!-- 섬네일이미지 보여주기 -->
			                        <button class="btn btn-danger removeImgBtn"
			                                data-ano="${attach.ano}"
			                                data-fullname="${attach.fileName}"
			                        >X</button><!-- attach.fileName = uuid + fileName -->
				        		</div>
					        </c:if>
					    </c:forEach>
				    </c:if>
				</div>
			</div>
		</div>
		<!-- end 첨부파일(이미지) -->
</div>
<!-- /.row -->

<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form");
	// button > 'button[type="submit"]'으로 수정
	// 이벤트는 엘리먼트랑 되도록 1:1 로 걸어야 한다.
	// 공통으로 걸면 수정시 영향도가 너무 높아서 유지보수가 힘들어진다.
	// 원인을 찾기가 힘들어질 수 있다.
	$('button[type="submit"]').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper"); //data-oper를 사용해 수정 , 목록으로 이동   
		console.log(operation);
		
		// 삭제할 파일을 hidden 태그를 이용
		const fileArr = $(".attachList button");
		console.log(fileArr); // dataset:DOMStringMap , ano: "9" ,fullname: "16e5d92b-df5c-46d3-989f-8345112c5d11_토끼2.jpg"
		
		if(fileArr.length > 0){
			let str = '';
		    
		    fileArr.each(function() {
		        const ano = $(this).data("ano"); // 버튼의 data-ano 속성값을 가져옴
		        const fullName = $(this).data("fullname"); // 버튼의 data-fullname 속성값을 가져옴
		        
		        str += `<input type='hidden' name='anos' value='${ano}'> `;
		        str += `<input type='hidden' name='fullNames' value='${fullName}'> `;
		    });
		    
		    $(".deleteImages").append(str);
		}

		if(operation === 'delete'){
			debugger;
			if(!confirm("정말로 삭제 하시겠습니까?")) {
				return;
			}
			formObj.attr("action", "/board/deletePost");
		}else if(operation === 'list'){ // 목록(목록이동버튼 주석처리함)
			formObj.attr("action", "/board/getPostList").attr("method","get");	      
			var pageNumTag = $("input[name='currentPageNum']").clone();
			var amountTag = $("input[name='itemsPerPage']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			// 폼 내용을 비우고 복제된 입력 필드를 폼에 추가(Criteria 필드 전송)
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit(); //<form role="form" action="modifyPost" method="post"
	});
	  
	// 수정
	// 바닐라JS
	// 첨부파일 버튼을 눌렀을때 이벤트
    document.querySelector(".attachList").addEventListener("click", (e) => {
        const target = e.target

        if(target.tagName !=='BUTTON'){ // DOM 속성에서 tagName이 BUTTON이 아닐경우 종료
            return
        }

        const ano = target.getAttribute("data-ano")
        const fullName = target.getAttribute("data-fullname")

        if(ano && fullName){
            let str = ''
            str += `<input type='hidden' name='anos' value='\${ano}'> `
            str += `<input type='hidden' name='fullNames' value='\${fullName}'> `

            console.log("ano :", ano, "fullName :" , fullName);
            
            target.closest("div").remove() /* closest("div") 버튼이벤트의 상위 div */

            document.querySelector(".deleteImages").innerHTML += str // 삭제할 이미지의 정보를 담은 input태그 > 폼제출시, 같이 제출
        }
    }, false);

});// end $(document).ready()

</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/footer.jsp"%>