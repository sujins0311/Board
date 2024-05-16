<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-10">
		<a class="page-header-link" href="/board/getPostList">
			<h3 class="page-header">게시글 목록</h3>
		</a>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				게시글 목록을 보여줍니다.
				<button class="btn common-btn btn-xs pull-right" type="button" onclick="isWritingAllowed()">작성하기</button>
				<!-- onclick="isAuthenticated() header.jsp 전역으로 선언 -->
				<!-- <button id='regBtn' type="button" class="btn common-btn btn-xs pull-right">작성하기</button> -->
			</div>

			<div class="panel-body">
				<table class="table table-striped table-borderded table-hover">
					<thead>
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>

					<tbody>
						<!-- JSTL을 이용한 Board데이터 렌더링 -->
						<c:forEach items="${list}" var="post">
							<!-- controller에서 K,V값 확인 -->
							<!-- c:forEach는 list값을 순회함 model.addAttribute("list", service.getPostList()); -->
							<tr>
								<td><c:out value="${post.bno}" /></td>
								<%-- <td><a href='/board/getPost?bno=${post.bno}'>${post.title}</a></td> --%>
								<td><a class="toGetPost" href='<c:out value="${post.bno}"/>'> 
								<c:out value="${post.title}" /></a></td>
								<td><c:out value="${post.writer}" /></td>
								<td><c:out value="${post.createdDate}" /></td>
								<td><c:out value="${post.updatedDate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 검색 -->
	<div class="col-lg-12">
	        <form id='searchForm' action="/board/getPostList" method='get' class="form-inline" style="text-align: center;">
	            <div class="form-group mr-2">
	                <select class="form-control" name='type' style="padding-right: 0px; appearance: none;"> <!-- type이 null일떄(주소에 type이 없을때 type을 추가함)  -->
	                    <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> >검색조건 선택 &nbsp; ▼</option>
	                    <option value="T" <c:out value="${pageMaker.cri.type == 'T'?'selected':''}"/>>제목만</option>
	                    <option value="C" <c:out value="${pageMaker.cri.type == 'C'?'selected':''}"/>>내용만</option>
	                    <option value="W" <c:out value="${pageMaker.cri.type == 'W'?'selected':''}"/>>글작성자</option>
	                    <option value="TC" <c:out value="${pageMaker.cri.type == 'TC'?'selected':''}"/>>제목 + 내용</option>
	                    <option value="TW" <c:out value="${pageMaker.cri.type == 'TW'?'selected':''}"/>>제목 + 작성자</option>
	                    <option value="TWC" <c:out value="${pageMaker.cri.type == 'TWC'?'selected':''}"/>>제목 + 내용 + 작성자</option>
	                </select>
	            </div>
				<div class="form-group mr-2">
					<input class="form-control" type="text" name='keyword'
					value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="검색어를 입력해주세요"> 
					<input type='hidden' name='currentPageNum' value='<c:out value="${pageMaker.cri.currentPageNum}"/> '>
					<input type='hidden' name='itemsPerPage' value='<c:out value="${pageMaker.cri.itemsPerPage}"/> '> 
				</div>
				<button type="submit" class='btn common-btn btn-search'>검색</button>
	        </form>
	</div>
	<!-- /.검색 -->

	<%-- 	<div class='row'>
		<div class="col-lg-12">
			<!-- 드롭다운 -->
			<div class="dropdown">
				<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" >상세검색</button>
				<div class="dropdown-menu" >
					<form id="searchForm2" action="/board/getPostList" method="get" class="form-inline">
						<div>
							<label>제목</label> 
							<input type="hidden" name="type" value="T"> 
							<input type="text" name="titleKeyword" class="form-control" placeholder="검색어를 입력해주세요.">
						</div>
						<br>
						<div>
							<label>내용</label> 
							<input type="hidden" name="type" value="C"> 
							<input type="text" name="contentKeyword" class="form-control" placeholder="검색어를 입력해주세요.">
						</div>
						<br>
						<div>
							<label>작성자</label> 
							<input type="hidden" name="type" value="W"> 
							<input type="text" name="writerKeyword" class="form-control" placeholder="검색어를 입력해주세요.">
						</div>
						<div>
							<label>작성일</label> 
							<input type="hidden" name="type" value="D"> 
							<input type="text" name="dateKeyword" class="form-control" placeholder="검색어를 입력해주세요.">
						</div>
						<br>
						<input type="hidden" name="pageNum" value="${pageMaker.cri.currentPageNum}"> 
						<input type="hidden" name="amount" value="${pageMaker.cri.itemsPerPage}">
						<button type="submit" class="btn btn-default">검색</button>
					</form>
				</div>
			</div>
			<!-- /.드롭다운 -->
		</div>
	</div> --%>
	
	<!-- 페이징, 버튼생성 -->
	<div class="page-contents">
		<ul class="pagination">
			<c:if test="${pageMaker.hasPrev}">
				<li class="paginate_button previous"><a href="${pageMaker.startPageNum -1}">이전</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPageNum}" end="${pageMaker.endPageNum}">
				<li class="paginate_button ${pageMaker.cri.currentPageNum eq num ? "active":""} "><!-- 페이지 버튼의 숫자 num과 값currentPageNum이 같은가  -->
				<a href="${num}">${num}</a> <%-- 	<c:out value="${num}"/> --%></li>
			</c:forEach>

			<c:if test="${pageMaker.hasNext}">
				<li class="paginate_button next">
				<a href="${pageMaker.endPageNum +1}">다음</a></li>
			</c:if>
		</ul>
	</div>
	<!-- /.페이징, 버튼생성 -->

	<!-- 페이징/ a태그(num)대신 form태그로 currentPageNum,itemsPerPage값 넘겨주기 -->
	<form id='paginate_button_actionForm' action="/board/getPostList" method='get'>
		<input type='hidden' name='currentPageNum' value='<c:out value="${pageMaker.cri.currentPageNum}"/>'> 
		<input type='hidden' name='itemsPerPage' value='<c:out value="${pageMaker.cri.itemsPerPage}"/>'>
		<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
<%-- 		<input type='hidden' name='titleKeyword' value='<c:out value="${ pageMaker.cri.titleKeyword }"/>'>
		<input type='hidden' name='contentKeyword' value='<c:out value="${ pageMaker.cri.contentKeyword }"/>'>
		<input type='hidden' name='writerKeyword' value='<c:out value="${ pageMaker.cri.writerKeyword }"/>'> --%>
	</form>
	<!-- /.페이징/ a태그(num)대신 form태그로 currentPageNum,itemsPerPage값 넘겨주기 -->
</div>
	<!-- /.페이징 -->



	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 1050;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">알림</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->



<script type="text/javascript">
	var actionForm = $("#paginate_button_actionForm"); //#는 jQuery에서 id를 선택하는 선택자
	
	/* 게시글작성 성공 > 게시글 목록 Modal */
	// Modal addAttribute로 bno 받음
	$(function() {
		var result = '<c:out value="${createPostResult}"/>';
		checkModal(result);
		history.replaceState({}, null, null); // windows.history속 데이터 지우기
		function checkModal(result) {
			if (result === '' || history.state) { // 공백이면 종료
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html(
						"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			$("#myModal").modal("show");

		}
		/*/.게시글작성 성공 > 게시글 목록 Modal */
		
		/* 게시글작성으로 이동 > 시큐리티 추가로 onclick="isAuthenticated() 으로수정 */
/* 		$("#regBtn").on("click", function() {
			self.location = "/board/createPost";
		}); */
		/*/.게시글작성으로 이동 */

		/* 페이징 */
		$(".paginate_button a").on(
				"click",
				function(e) {
					e.preventDefault();
					console.log('paginate_button');
					actionForm.find("input[name='currentPageNum']").val(
							$(this).attr("href"));/* currentPageNum의 값을 href의 속성값으로 */
					actionForm.submit();
				});
		/*/.페이징 */
	});

	/* 제목 누르면 게시글조회로 이동 */
	$(".toGetPost").on(
			"click",
			function(e) {
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"
						+ $(this).attr("href") + "'>");
				actionForm.attr("action", "/board/getPost");
				actionForm.submit();
			});
	/* /.제목 누르면 게시글조회로 이동 */
	
	
	/* 검색 */
	$("#searchForm button").on("click", function(e) {
	    var searchForm = $('#searchForm');
	    var type = searchForm.find("select[name='type']").val();
	    var keyword = searchForm.find("input[name='keyword']").val();
	    
	    if (!type || !keyword) {
	        alert(!type ? "검색조건을 선택하세요" : "키워드를 입력하세요");
	        return false;
	    }
	});
	/*/.검색 */
	
	/* 수정 및 삭제 성공 시 모달창 */
	// 게시글 수정 및 삭제 성공 > 서버에서 addFlashAttribute에 "service.getPost(bno)"를 담아 전송 > 모달로 띄움
	function showModal(message) {
	    $(".modal-body").html(message); // 모달 창에 메시지 설정
	    $("#myModal").modal("show"); // 모달 창 표시
	}
	
	$(function() {
	    // 수정 결과 확인
	    var modifyResult = '<c:out value="${modifyPostResult}"/>';
	    checkResult(modifyResult, "게시글 수정에 성공했습니다.", "게시글 수정에 실패했습니다.");
	
	    function checkResult(result, successMessage, failureMessage) {
	        if (result === '') {
	            return; // 결과가 없으면 종료
	        }
	        
	        // 게시글 수정 성공 시 모달에 메시지 표시
	        showModal(successMessage + " (게시글 번호: " + result + ")");
	    }
	});
	
	$(function() {
	    // 삭제 결과 확인
	    var deleteResult = '<c:out value="${deletePostResult}"/>';
	    checkResult(deleteResult, "게시글 삭제를 성공했습니다.", "게시글 삭제를 실패했습니다.");
	
	    function checkResult(result, successMessage, failureMessage) {
	        if (result === '') {
	            return; // 결과가 없으면 종료
	        }
	        
	        // 게시글 삭제 성공 시 모달에 메시지 표시
	        showModal(successMessage + " (게시글 번호: " + result + ")");
	    }
	});
	/*/.수정 및 삭제 성공 시 모달창 */
    
</script>


<!-- 푸터------------------------------------------------------------------------------ -->
<div>
	<%@include file="../includes/footer.jsp"%>
</div>