<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Board List Page
				<button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
			</div>

			<div class="panel-body">
				<table class="table table-striped table-borderded table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>

					<tbody>
						<!-- JSTL을 이용한 Board데이터 렌더링 -->
						<c:forEach items="${getPostListResult}" var="getPostList">
							<!-- controller에서 K,V값 확인 -->
							<!-- c:forEach는 list값을 순회함 model.addAttribute("getPostListResult", service.getPostList()); -->
							<tr>
								<td><c:out value="${getPostList.bno}" /></td>
								<%-- <td><a href='/board/getPost?bno=${getPostList.bno}'>${getPostList.title}</a></td> --%>
								<td><a class="toGetPost" href='<c:out value="${getPostList.bno}"/>'> 
								<c:out value="${getPostList.title}" /></a></td>
								<td><c:out value="${getPostList.writer}" /></td>
								<td><c:out value="${getPostList.createdDate}" /></td>
								<td><c:out value="${getPostList.updatedDate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class='row'>
		<div class="col-lg-12">

			<form id='searchForm' action="/board/getPostList" method='get'>
				<%-- 				<select name='type'>
					<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
					<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
					<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
					<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 내용 or 작성자</option>
				</select> <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
				 --%>
				<button class='btn btn-default'>Search</button>
			</form>
		</div>
	</div>
	
	<!-- 페이징/ 버튼생성 -->
	<div class='pull-right'>
		<ul class="pagination">
			<c:if test="${pageMaker.hasPrev}">
				<li class="paginate_button previous"><a href="${pageMaker.startPageNum -1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPageNum}" end="${pageMaker.endPageNum}">
				<li class="paginate_button ${pageMaker.cri.currentPageNum eq num ? "active":""} "><!-- 페이지 버튼의 숫자 num과 값currentPageNum이 같은가  -->
				<a href="${num}">${num}</a> <%-- 	<c:out value="${num}"/> --%></li>
			</c:forEach>

			<c:if test="${pageMaker.hasNext}">
				<li class="paginate_button next">
				<a href="${pageMaker.endPageNum +1}">Next</a></li>
			</c:if>
		</ul>
	</div>

	<!-- 페이징/ a태그(num)대신 form태그로 currentPageNum,itemsPerPage값 넘겨주기 -->
	<form id='paginate_button_actionForm' action="/board/getPostList" method='get'>
		<input type='hidden' name='currentPageNum' value='<c:out value="${pageMaker.cri.currentPageNum}"/>'> 
		<input type='hidden' name='itemsPerPage' value='<c:out value="${pageMaker.cri.itemsPerPage}"/>'>
<%-- 		<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
		<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'> --%>
	</form>
</div>
<!-- 페이징 끝 -->

<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
	/* Modal addAttribute로 bno 받음 */
	$(function() {
		var result = '<c:out value="${getCreatePostResult}"/>';
		checkModal(result);
		history.replaceState({}, null, null);
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}

			if (parseInt(result) > 0) {
				$(".modal-body").html(
						"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			$("#myModal").modal("show");

		}
		$("#regBtn").on("click", function() {
			self.location = "/board/getCreatePost";
		});

		$(".paginate_button a").on(
				"click",
				function(e) {
					e.preventDefault();
					console.log('paginate_button');
					actionForm.find("input[name='currentPageNum']").val(
							$(this).attr("href"));/* currentPageNum의 값을 href의 속성값으로 */
					actionForm.submit();
				});
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
</script>


<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="../includes/footer.jsp"%>