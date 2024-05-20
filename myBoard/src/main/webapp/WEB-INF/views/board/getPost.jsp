<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%><!-- 함수 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%><!-- 파일업로드,년월일 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="../includes/header.jsp"%>

<div class="row">
  <div class="col-lg-12">
	<a class="page-header-link" 
		href="/board/getPost?
			currentPageNum=<c:out value='${cri.currentPageNum}'/>
			&itemsPerPage=<c:out value='${cri.itemsPerPage}'/>
			&type=<c:out value='${cri.type}'/>
			&keyword=<c:out value='${cri.keyword}'/>
			&bno=<c:out value='${getPostResult.bno}'/>"
	/>
		<h3 class="page-header">게시글 보기</h3>
	</a>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">게시글을 확인합니다.</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

        <div class="form-group">
          <label>No.</label> 
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
          <textarea class="form-control content" rows="3" name='content'
            readonly="readonly"><c:out value="${getPostResult.content}" /></textarea>
        </div>
        
<%-- 		<div class="form-group">
          <label>작성자</label> <input class="form-control" name='writer'
			value='<sec:authentication property="principal.username"/>' readonly="readonly">
		</div> --%>

        <div class="form-group">
          <label>작성자</label> <input class="form-control" name='writer'
            value='<c:out value="${getPostResult.writer}"/>' readonly="readonly">
        </div>
        
<%--         <div class="form-group">
          <label>작성일</label> <input class="form-control" name='createdDate'
            value='<c:out value="${getPostResult.createdDate}"/>' readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>수정일</label> <input class="form-control" name='updatedDate'
            value='<c:out value="${getPostResult.updatedDate}"/>' readonly="readonly">
        </div> --%>


				<button data-oper='list' class="btn common-btn">목록</button>
		<%-- <button data-oper='modify' class="btn common-btn" style="float:right;" onclick="modifyPost(${getPostResult.bno})">수정/삭제</button> --%>

				<sec:authentication property="principal" var="pinfo" />
					<sec:authorize access="isAuthenticated()"> <!-- pinfo.username: 로그인 한 유저와 작성자, 관리자만 수정 -->
						<c:if test="${pinfo.username eq getPostResult.writer || '[ROLE_ADMIN]' eq pinfo.authorities}">
							<button data-oper='modify' class="btn common-btn" style="float:right;" 
							onclick="modifyPost(${getPostResult.bno})">수정/삭제</button>
						</c:if>
				</sec:authorize>



		<form id='operForm' action="/board/modifyPost" method="get">
		  <input type='hidden' id='bno' name='bno' value='<c:out value="${getPostResult.bno}"/>'>
		  <input type='hidden' name='currentPageNum' value='<c:out value="${cri.currentPageNum}"/>'>
		  <input type='hidden' name='itemsPerPage' value='<c:out value="${cri.itemsPerPage}"/>'>
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


<div class='row reply'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
			<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> 댓글목록을 보여줍니다.
				<sec:authorize access="isAuthenticated()">
				<%-- <c:if test="${pinfo.username eq getPostResult.writer || '[ROLE_ADMIN]' eq pinfo.authorities}"> --%>
				<c:if test="${'[ROLE_MEMBER]' eq pinfo.authorities || '[ROLE_ADMIN]' eq pinfo.authorities}">
					<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right' >댓글작성</button>
				</c:if>	
				</sec:authorize>
				
			</div>
			<!-- /.panel-heading -->
			
			<!-- 댓글목록 -->
			<div class="panel-body">
				<ul class="chat">
				</ul>
				<!-- ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->
			<div class="panel-footer"></div>
		</div>
	</div>
	<!-- ./ end row -->
</div>

<!-- 댓글작성 Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" 
aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" 
				aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글</h4>
			</div>

			<!-- 댓글 작성 양식 -->
			<div class="modal-body">
				<div class="form-group">
					<label>댓글 내용</label> 
					<input class="form-control" name='reply' value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>작성자</label> 
					<input class="form-control" name='replyer' value='replyer' readonly>
				</div>
				<div class="form-group">
					<label>작성일</label> 
					<input class="form-control" name='replyDate' value='2018-01-01 13:13'>
				</div>
			</div>
			
			<!-- 댓글 수정/삭제/등록/닫기 버튼 -->
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->



<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
// $(document).ready // 제이쿼리 방식
// window.onload = function() {} // 기본 JS 방식

// HTML에는 생명주기(lifecycle)가 존재한다.
// DOMContentLoaded  : Browser에서 HTML이 완전히 로드되고 DOM tree가 만들어 질 때 발생하는 이벤트
// load  : 문서의 모든 콘텐츠(images,script,css, etc)가 로드된 후 발생하는 이벤트
// beforeunload / unload  : 사용자가 페이지를 벗어날 때 일어나는 이벤트

// window.onload 가 load 생명주기 때 실행되는 이벤트 함수이며
// $(document).ready는 jquery가 onload를 래핑한 함수이다.

$(document).ready(function () {
	  
	  var bnoValue = '<c:out value="${getPostResult.bno}"/>';
	  var replyUL = $(".chat");
	  
		// 댓글목록 표시 함수 호출
	    showList(1);
	    
	 	// 댓글목록을 표시하는 함수
	    function showList(page){
	    	console.log("show list " + page);
	        
	        replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {
	          
	        console.log("replyCnt: "+ replyCnt );
	        console.log("list: " + list);
	        console.log(list);

	        
	        if(page == -1){
	          pageNum = Math.ceil(replyCnt/10.0);
	          showList(pageNum);
	          return;
	        }
	          
	         var str="";
	         
	         if(list == null || list.length == 0){
	           return;
	         }
	         
	         for (var i = 0, len = list.length || 0; i < len; i++) {
	           str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
	           str +="  <div><div class='header'><strong class='primary-font'>["
	        	   +list[i].rno+"] "+list[i].replyer+"</strong>";
	        	   
	        	// 권한검사(로그인유저 == 댓글작성자) 
				console.log("REPLYER: ", list[i].replyer);
				console.log("LOGINER:", loginer);  
	        	   if(list[i].replyer == loginer){
	           str +="	<button class='common-btn btn' style='padding:1px 5px; font-size:12px; font-weight:normal;'>수정</button>"; 
	           str +="	<button class='common-btn btn' style='padding:1px 5px; font-size:12px; font-weight:normal;'>삭제</button>"; 
	        	   }
	           str +="    <small class='pull-right text-muted'>"
	               +replyService.displayTime(list[i].replyDate)+"</small></div>";
	           str +="    <p>"+list[i].reply+"</p></div></li>";
	         }
	         
	         replyUL.html(str);	         
	         showReplyPage(replyCnt);
	       });//end function         
	     }//end showList
	    
	    var pageNum = 1;
	    var replyPageFooter = $(".panel-footer");
	    
	 	// 댓글페이지를 표시하는 함수
	    function showReplyPage(replyCnt){
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>이전</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        var active = pageNum == i? "active":"";
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>다음</a></li>";
	      }
	      
	      str += "</ul></div>";  
	      console.log(str);  
	      replyPageFooter.html(str);
	    }
	    
	 	// 페이지 버튼 클릭 이벤트
	    replyPageFooter.on("click","li a", function(e){
	        e.preventDefault();
	        console.log("page click");	        
	        var targetPageNum = $(this).attr("href");	        
	        console.log("targetPageNum: " + targetPageNum);
	        pageNum = targetPageNum;	        
	        showList(pageNum);
	      });     

	    var modal = $("#replyModal");
	    var modalInputReply = modal.find("input[name='reply']");
	    var modalInputReplyer = modal.find("input[name='replyer']");
	    var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	    var modalModBtn = $("#modalModBtn");
	    var modalRemoveBtn = $("#modalRemoveBtn");
	    var modalRegisterBtn = $("#modalRegisterBtn");
	    
	    var replyer = null;
	    
	    <sec:authorize access="isAuthenticated()">	    
	    	replyer = '<sec:authentication property="principal.username"/>';   	    
		</sec:authorize>
	 
	    var csrfHeaderName ="${_csrf.headerName}"; 
	    var csrfTokenValue="${_csrf.token}";
	    
	 	// 모달 닫기 버튼
	    $("#modalCloseBtn").on("click", function(e){	    	
	    	modal.modal('hide');
	    });
	    
	 	// 댓글 작성 버튼
	    $("#addReplyBtn").on("click", function(e){
	      console.log(replyer);
	      
	      modal.find("input").val("");
	      modalInputReplyDate.closest("div").hide();
	      modal.find("button[id !='modalCloseBtn']").hide();
	      modal.find("input[name='replyer']").val(replyer); // 댓글 작성자 필드에 replyer 변수 값 적용
	      modal.find("input[name='replyer']").attr("readonly", "readonly"); // 댓글 작성자 필드를 읽기 전용으로 설정합니다.
	      modalRegisterBtn.show();
	      
	      $("#replyModal").modal("show");
	      
	    });
	 	
	 	// AJAX 요청이 전송되기 전에 실행될 함수(AJAX 요청 헤더에 CSRF 토큰을 설정)
	 	// 시큐리티 사용할때 POST방식은 CSRF 토큰을 꼭 추가해야함
	    $(document).ajaxSend(function(e, xhr, options) { 
	        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
	      }); 
	    
		// 댓글등록버튼
	    modalRegisterBtn.on("click",function(e){
		 	  //*********디버그
		      //debugger;
	      var reply = {
	            reply: modalInputReply.val(),
	            replyer:modalInputReplyer.val(),
	            bno:bnoValue
	          };
	      replyService.add(reply, function(result){	        
	        alert(result);     
	        modal.find("input").val("");
	        modal.modal("hide");        
	        showList(1); //등록 후 다시 페이지를 불러옴
	        //showList(-1);   
	      });   
	    });
		
		
	    
		// 댓글목록
	    $(".chat").on("click", "button", function(e){	      
	    	var rno = $(this).closest("li").data("rno"); //button에서 rno를 가져와 저장
	    	console.log("rno: ", rno);
	    	
	      replyService.get(rno, function(reply){    
	        modalInputReply.val(reply.reply);
	        modalInputReplyer.val(reply.replyer);
	        modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
	        .attr("readonly","readonly");
	        modal.data("rno", reply.rno);      
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();    
	        $("#replyModal").modal("show");      
	      });
	    });
		
	    $(".chat").on("click", "button", function(e){	      
		    var rno = $(this).closest("li").data("rno"); // 클릭된 버튼의 부모인 <li> 요소에서 rno를 가져와 변수에 저장
		    console.log("rno: ", rno); // 확인을 위해 콘솔에 출력
		    replyService.get(rno, function(reply){    
		        modalInputReply.val(reply.reply);
		        modalInputReplyer.val(reply.replyer);
		        modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
		        .attr("readonly","readonly");
		        modal.data("rno", reply.rno);      
		        modal.find("button[id !='modalCloseBtn']").hide();
		        modalModBtn.show();
		        modalRemoveBtn.show();    
		        $("#replyModal").modal("show");      
		      });
		    });
	    
	  	// 댓글수정버튼
		modalModBtn.on("click", function(e){
			
		 var originalReplyer = modalInputReplyer.val();
			
		 var reply = {
				      rno:modal.data("rno"), 
				      reply: modalInputReply.val(),
				      replyer: originalReplyer};
  
  	// 로그인유저검증 후 > 댓글수정모달
/* 	if(!replyer){
		 alert("로그인후 수정이 가능합니다.");
		 modal.modal("hide");
		 return;
	} */

	console.log("Original Replyer: " + originalReplyer);
	
	if(replyer  != originalReplyer){
	 
		 alert("자신이 작성한 댓글만 수정이 가능합니다.");
		 modal.modal("hide");
		 return;
	 
	}
	  
	replyService.update(reply, function(result){
	      
	  alert(result);
	  modal.modal("hide");
	  showList(pageNum);
	  
	});
  
});
	  	
	// 댓글삭제버튼
	modalRemoveBtn.on("click", function (e){
	   	  
	   	  var rno = modal.data("rno");

	   	  console.log("RNO: " + rno);
	   	  console.log("REPLYER: " + replyer);
	   	  
	   	  if(!replyer){
	   		  alert("로그인후 삭제가 가능합니다.");
	   		  modal.modal("hide");
	   		  return;
	   	  }
	   	  
	   	  var originalReplyer = modalInputReplyer.val();
	   	  
	   	  console.log("Original Replyer: " + originalReplyer);
	   	  
	   	  if(replyer  != originalReplyer){
	   		  
	   		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
	   		  modal.modal("hide");
	   		  return;
	   		  
	   	  }
	   	  
	   	  
	   	  replyService.remove(rno, originalReplyer, function(result){
	   	        
	   	      alert(result);
	   	      modal.modal("hide");
	   	      showList(pageNum);
	   	      
	   	  });
	   	  
	   	});

	 
	});
	


	</script>
<script>

	/* console.log("===============");
	console.log("JS TEST");

	var bnoValue = '<c:out value="${board.bno}"/>'; */

	//for replyService add test
	/* replyService.add(
	    
	    {reply:"JS Test", replyer:"tester", bno:bnoValue}
	    ,
	    function(result){ 
	      alert("RESULT: " + result);
	    }
	); */


	//reply List Test
	/* replyService.getList({bno:bnoValue, page:1}, function(list){
	    
		  for(var i = 0,  len = list.length||0; i < len; i++ ){
		    console.log(list[i]);
		  }
	});
	 */

	 
	/*  //17번 댓글 삭제 테스트 
	 replyService.remove(17, function(count) {

	   console.log(count);

	   if (count === "success") {
	     alert("REMOVED");
	   }
	 }, function(err) {
	   alert('ERROR...');
	 });
	 */
	 

	//12번 댓글 수정 
	/* replyService.update({
	  rno : 12,
	  bno : bnoValue,
	  reply : "Modified Reply...."
	}, function(result) {

	  alert("수정 완료...");

	});  
	 */


// 조회=============================================================
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
		    operForm.attr("action","/board/modifyPost")
		    operForm.submit(); 
		  });

		    
		  $("button[data-oper='list']").on("click", function(e){ 
		    operForm.find("#bno").remove();
		    operForm.attr("action","/board/getPostList")
		    operForm.submit();
		  });  
		});

</script>
<!-- 푸터--------------------------------------------------------------------------------->
<%@include file="../includes/footer.jsp"%>