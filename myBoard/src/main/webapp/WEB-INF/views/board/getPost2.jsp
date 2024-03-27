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
        
<%--         <div class="form-group">
          <label>작성일</label> <input class="form-control" name='createdDate'
            value='<c:out value="${getPostResult.createdDate}"/>' readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>수정일</label> <input class="form-control" name='updatedDate'
            value='<c:out value="${getPostResult.updatedDate}"/>' readonly="readonly">
        </div> --%>

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


<div class='row'>
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
			<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> reply List Page
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글작성</button>
			</div>
			<!-- /.panel-heading -->
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

<!-- 댓글 작성 Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 작성</h4>
			</div>

			<!-- 댓글 작성 양식 -->
			<div class="modal-body">
				<div class="form-group">
					<label>댓글 내용</label> <input class="form-control" name='reply' value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='replyer' value='replyer'>
				</div>
				<div class="form-group">
					<label>작성일</label> <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
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
$(document).ready(function () {
	  
	  var bnoValue = '<c:out value="${getPostResult.bno}"/>';
	  var replyUL = $(".chat");
	  
		// 댓글 목록 표시 함수 호출
	    showList(1);
	    
	 	// 댓글 목록을 표시하는 함수
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
	    
	 	// 댓글 페이지를 표시하는 함수
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
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        var active = pageNum == i? "active":"";
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
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

	    var modal = $(".modal");
	    var modalInputReply = modal.find("input[name='reply']");
	    var modalInputReplyer = modal.find("input[name='replyer']");
	    var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	    var modalModBtn = $("#modalModBtn");
	    var modalRemoveBtn = $("#modalRemoveBtn");
	    var modalRegisterBtn = $("#modalRegisterBtn");
	    
	 	// 모달 닫기 버튼
	    $("#modalCloseBtn").on("click", function(e){	    	
	    	modal.modal('hide');
	    });
	    
	 	// 댓글 작성 버튼
	    $("#addReplyBtn").on("click", function(e){      
	      modal.find("input").val("");
	      modalInputReplyDate.closest("div").hide();
	      modal.find("button[id !='modalCloseBtn']").hide();
	      
	      modalRegisterBtn.show();
	      
	      $(".modal").modal("show");
	      
	    });
	    
		// 댓글등록버튼
	    modalRegisterBtn.on("click",function(e){	      
	      var reply = {
	            reply: modalInputReply.val(),
	            replyer:modalInputReplyer.val(),
	            bno:bnoValue
	          };
	      replyService.add(reply, function(result){
	        
	        alert(result);     
	        modal.find("input").val("");
	        modal.modal("hide");        
	        //showList(1);
	        showList(-1);   
	      });   
	    });
	    $(".chat").on("click", "li", function(e){	      
	      var rno = $(this).data("rno");	      
	      replyService.get(rno, function(reply){    
	        modalInputReply.val(reply.reply);
	        modalInputReplyer.val(reply.replyer);
	        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
	        .attr("readonly","readonly");
	        modal.data("rno", reply.rno);      
	        modal.find("button[id !='modalCloseBtn']").hide();
	        modalModBtn.show();
	        modalRemoveBtn.show();    
	        $(".modal").modal("show");      
	      });
	    });
	    
	  	// 댓글수정버튼
	    modalModBtn.on("click", function(e){   	  
	   	  var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
	   	  replyService.update(reply, function(result){   
	   	    alert(result);
	   	    modal.modal("hide");
	   	    showList(pageNum);
	   	  });
	   	});
	  	
		// 댓글삭제버튼
	   	modalRemoveBtn.on("click", function (e){
	   	  var rno = modal.data("rno");
	   	  replyService.remove(rno, function(result){     
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