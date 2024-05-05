<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!-- JSP 페이지 설정: Java 언어 사용, 문자 인코딩은 UTF-8 -->
<!-- 헤더 + 바디 ------------------------------------------------------------------------------ -->
<%@include file="./includes/logHeader.jsp"%>


<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
			
			
				<a class="snb-btn" href="/"> <!-- 아이콘 --> 
					<!-- <img src="/resources/images/icons/home.ico" width=24px; height=24px; />  -->
					<span>Home</span> |
				</a>

                 <a class="snb-btn" href="/board/getPostList">
                 	<!-- 아이콘 -->
                 	<!-- <img src="/resources/images/icons/list.ico" width=24px; height=24px;/> -->
                 	<span>게시글 목록</span> |
                 </a>
                 
                 <a class="snb-btn" href="/auth/register">
                 	<!-- 아이콘 -->
                 	<!-- <img src="/resources/images/icons/list.ico" width=24px; height=24px;/> -->
                 	<span>회원가입</span>
                 </a>
				
				
				<div class="panel-heading">
					<h3 class="panel-title">ID 로그인</h3>
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
							<a href="index.html" class="btn btn-lg btn-success btn-block">로그인</a>
						</fieldset>
						<!-- CSRF(Cross-Site Request Forgery)토큰은 서버가 브라우저에 전송한 토큰값과 비교해 처리하는 방식 > 세션 보관 -->
						<!-- <input type="hidden" name="_csrf"
						    value="c58c9d7a-a81e-4231-96dd-168c6662428a" /> -->
						<!-- 스프링 시큐리티 > CSRF토큰 비활성화  -->
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>

				</div>
			</div>
		</div>
	</div>
</div>



<!-- jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>
	<script>
  
  
  
  
  $(".btn-success").on("click", function(e){
    
    e.preventDefault();
    $("form").submit();
    
  });
  
  </script>

	<c:if test="${param.logout != null}">
		<script>
      $(document).ready(function(){
      	alert("로그아웃하였습니다.");
      });
      </script>
	</c:if>

</body>

</html>

<!-- 푸터------------------------------------------------------------------------------ -->
<%@include file="./includes/logFooter.jsp"%>
