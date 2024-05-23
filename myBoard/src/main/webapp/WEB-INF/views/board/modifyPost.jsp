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

				<form role="form" action="modifyPost" method="post" style="display: inline;">
				
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>  
			
					<input type='hidden' name='currentPageNum' value='<c:out value="${cri.currentPageNum }"/>'> 
					<input type='hidden' name='itemPerPage' value='<c:out value="${cri.itemsPerPage }"/>'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>


					<div class="form-group">
						<label>#번호</label> <input class="form-control" name='bno' value='<c:out value="${modifyPostResult.bno}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label for="title">제목</label> <input class="form-control" id="title" name='title' value='<c:out value="${modifyPostResult.title}"/>'>
					</div>

					<div class="form-group">
						<label for="content">내용</label>
						<textarea class="form-control" rows="3" id="content" name='content'><c:out value="${modifyPostResult.content}" /></textarea>
					</div>

					<div class="form-group">
						<label>작성자</label> 
						<input class="form-control" name='writer' value='<c:out value="${modifyPostResult.writer}"/>' readonly="readonly">
					</div>

					<!-- 게시물작성자만 수정/삭제버튼 확인 -->
					<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq modifyPostResult.writer || '[ROLE_ADMIN]' eq pinfo.authorities}">
							<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
							<button type="submit" data-oper='delete' class="btn btn-danger">삭제</button>
						</c:if>
					</sec:authorize>
					<!-- <button type="submit" data-oper='list' class="btn btn-info">목록</button> -->

					<!-- <button type="submit" data-oper='modify' class="btn btn-default">수정</button>
					<button type="submit" data-oper='delete' class="btn btn-danger">삭제</button>
					<button type="submit" data-oper='list' class="btn btn-info">목록</button> -->
				</form>
				<button class="btn btn-info" onclick="back()" style="display: inline;" >취소</button>
			</div>
			<!--  end panel-body -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
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
		    if(operation === 'delete'){
		      formObj.attr("action", "/board/deletePost");
		    }else if(operation === 'list'){
		      formObj.attr("action", "/board/getPostList").attr("method","get");	      
		      var pageNumTag = $("input[name='currentPageNum']").clone();
		      var amountTag = $("input[name='itemsPerPage']").clone();
		      var keywordTag = $("input[name='keyword']").clone();
		      var typeTag = $("input[name='type']").clone();
		      
		      formObj.empty();
		      formObj.append(pageNumTag);
		      formObj.append(amountTag);
			      formObj.append(keywordTag);
		      formObj.append(typeTag); 
		    }
		    formObj.submit();
	  });

});

</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/footer.jsp"%>