<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>

<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">게시글 조회</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

          <div class="form-group">
          <label>#번호</label> 
          <input class="form-control" name='bno'
            value='<c:out value="${getPostResult.bno}"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>제목</label> 
          <input class="form-control" name='title'
            value='<c:out value="${getPostResult.title}"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>내용</label>
          <textarea class="form-control" rows="3" name='content'
            readonly="readonly"><c:out value="${getPostResult.content}" /></textarea>
        </div>

        <div class="form-group">
          <label>작성자</label> <input class="form-control" name='writer'
            value='<c:out value="${getPostResult.writer}"/>' readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>작성일</label> <input class="form-control" name='createdDate'
            value='<c:out value="${getPostResult.createdDate}"/>' readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>수정일</label> <input class="form-control" name='updatedDate'
            value='<c:out value="${getPostResult.updatedDate}"/>' readonly="readonly">
        </div>

		<button data-oper='modify' class="btn btn-default" onclick="modifyPost(${getPostResult.bno})">수정/삭제</button>
		<%-- <button class="btn btn-default" onclick="deletePost(${getPostResult.bno})">${getPostResult.bno} 번 게시글 삭제</button> --%>
		<button data-oper='list' class="btn btn-info">게시글 목록</button>


		<form id='operForm' action="/board/getModifyPost" method="get">
		  <input type='hidden' id='bno' name='bno' value='<c:out value="${getPostResult.bno}"/>'>
		  <input type='hidden' name='pageNum' value='<c:out value="${cri.currentPageNum}"/>'>
		  <input type='hidden' name='amount' value='<c:out value="${cri.itemsPerPage}"/>'>
		  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
		  <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>  
		</form>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
/* 	  function deletePost(bno) {
		  var payload = {
        	  'bno': bno,
          };
		  console.log(typeof(payload)); // 현재 object타입으로 json객체임
		  console.log(typeof(JSON.stringify(payload))); // 문자열객체로 변환
		  console.log(typeof(JSON.parse(JSON.stringify(payload)))); // JSON포맷의 문자열을 JSON객체로 변환 
		  
		  
		    if (confirm("정말로 삭제하시겠습니까?")) {
		    	//debugger;
		        $.ajax({
		          url: `/board/deletePost`,

		          // contentType: 'application/json', // 요청타입지정 
		          contentType: 'application/x-www-form-urlencoded', // 요청타입지정(내 메서드 타입에 맞춰서)
		          // dataType: 'text', // 응답타입지정 (Content-Type), 사실 응답타입은 굳이 지정 할 필요없다 
		          data : payload, // 전송타입에 맞는 payload
		          type: 'POST', // POST는 URL 파라메터가 아닌 HTTP bodypart로 데이터를 전송 
		          success: function(bno) {
		            alert('삭제가 완료되었습니다.');
		            window.location.href = '/board/getPostList';
		            //window.location.reload(); // 삭제 후 페이지 리로드
		          },
		          error: function(xhr, status, error) {
		            console.error('오류 발생:', error);
		          }
		        });
		      }
		    } */


		$(document).ready(function() {
		  var operForm = $("#operForm"); 
		  
		  $("button[data-oper='modify']").on("click", function(e){
		    operForm.attr("action","/board/getModifyPost")
		    operForm.submit(); 
		  });

		    
		  $("button[data-oper='list']").on("click", function(e){ 
		    operForm.find("#bno").remove();
		    operForm.attr("action","/board/getPostList")
		    operForm.submit();
		  });  
		});

</script>
<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/footer.jsp"%>