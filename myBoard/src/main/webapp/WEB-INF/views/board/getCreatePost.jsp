<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 CSS CDN 링크 -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 등록</title>
</head>
<body>
	<!-- role: 시멘틱하지않은 요소에 추가설명을 위한 태그 -->
	<!-- action: controller의 메서드 경로 -->
	<!-- name: 서버로 전송할때 사용자입력한 내용과 같이 전송됨 -->
	<!-- value: 초기입력값, placeholder: hint text -->
	<!-- id: 고유식별자, class: CSS등 을 위한 식별자 우선순위: id>class -->
	<!-- type: 필드타입정의(text, password, submit, checkbox, radio, number 등) -->
	<!-- 부트스트랩클래스
"form-group":폼요소를 감싸는 컨테이너, 
"form-control":입력필트에 적용되어 부트스트랩 폼스타일 적용 -->

	<div role="boardForm" class="container">
		<h1>게시글등록</h1>
		<div class="row">
			<div class="col-lg-8">
				<form role="form" action="createPost" method="post">
					<div class="form-group">
						<label for="title">제목:</label> 
						<input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title">
					</div>
					<div class="form-group">
						<label for="content">내용:</label>
						<textarea class="form-control" placeholder="내용을 입력하세요" style="resize: none;" rows="8" cols="40" id="content" name="content"></textarea>
					</div>
					<div class="form-group">
						<label for="writer">작성자:</label> 
						<input type="text" class="form-control" id="writer" name="writer">
					</div>
					<button type="submit" class="btn btn-primary">등록</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>