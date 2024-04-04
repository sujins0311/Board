// "Reply Module........"를 콘솔에 출력하는 로그
console.log("Reply Module........");

// replyService 객체 선언 및 정의 시작
var replyService = (function() {

	// add 함수 정의 시작
	function add(reply, callback, error) {
		// "add reply..............."를 콘솔에 출력하는 로그
		console.log("add reply...............");

		// AJAX를 사용하여 서버에 새 댓글 추가 요청
		$.ajax({
			// 요청 타입: POST
			type : 'post',
			// 요청 URL: /replies/new
			url : '/replies/new',
			// 전송할 데이터: reply 객체를 JSON 문자열로 변환하여 전송
			data : JSON.stringify(reply),
			// 전송하는 데이터 타입 지정: JSON 형식, UTF-8 인코딩 사용
			contentType : "application/json; charset=utf-8",
			// 요청 성공 시 실행되는 콜백 함수
			success : function(result, status, xhr) {
				// 콜백 함수가 주어진 경우 실행하여 결과를 전달
				if (callback) {
					callback(result);
				}
			},
			// 요청 실패 시 실행되는 콜백 함수
			error : function(xhr, status, er) {
				// 에러 처리 함수가 주어진 경우 실행하여 에러 정보를 전달
				if (error) {
					error(er);
				}
			}
		})
	} // add 함수 정의 끝

	// getList 함수 정의 시작
	function getList(param, callback, error) {

		// 댓글 목록을 가져오기 위한 서버 요청
		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					// 서버로부터 댓글 목록 데이터를 성공적으로 받은 경우 콜백 함수 실행
					if (callback) {
						// 댓글 숫자와 목록을 가져오는 경우 콜백 함수에 전달
						callback(data.replyCnt, data.list);
					}
				}).fail(function(xhr, status, err) {
			// 서버 요청 실패 시 에러 처리 함수 실행
			if (error) {
				error();
			}
		});
	} // getList 함수 정의 끝

	// remove 함수 정의 시작
	function remove(rno, callback, error) {
		// AJAX를 사용하여 댓글 삭제 요청
		$.ajax({
			// 요청 타입: DELETE
			type : 'delete',
			// 요청 URL: /replies/{rno}
			url : '/replies/' + rno,
			// 요청 성공 시 실행되는 콜백 함수
			success : function(deleteResult, status, xhr) {
				// 콜백 함수가 주어진 경우 실행하여 결과를 전달
				if (callback) {
					callback(deleteResult);
				}
			},
			// 요청 실패 시 실행되는 콜백 함수
			error : function(xhr, status, er) {
				// 에러 처리 함수가 주어진 경우 실행하여 에러 정보를 전달
				if (error) {
					error(er);
				}
			}
		});
	} // remove 함수 정의 끝

	// update 함수 정의 시작
	function update(reply, callback, error) {
		// 댓글 수정을 위한 서버 요청
		console.log("RNO: " + reply.rno);

		$.ajax({
			// 요청 타입: PUT
			type : 'put',
			// 요청 URL: /replies/{rno}
			url : '/replies/' + reply.rno,
			// 전송할 데이터: reply 객체를 JSON 문자열로 변환하여 전송
			data : JSON.stringify(reply),
			// 전송하는 데이터 타입 지정: JSON 형식, UTF-8 인코딩 사용
			contentType : "application/json; charset=utf-8",
			// 요청 성공 시 실행되는 콜백 함수
			success : function(result, status, xhr) {
				// 콜백 함수가 주어진 경우 실행하여 결과를 전달
				if (callback) {
					callback(result);
				}
			},
			// 요청 실패 시 실행되는 콜백 함수
			error : function(xhr, status, er) {
				// 에러 처리 함수가 주어진 경우 실행하여 에러 정보를 전달
				if (error) {
					error(er);
				}
			}
		});
	} // update 함수 정의 끝

	// get 함수 정의 시작
	function get(rno, callback, error) {
		// 특정 댓글을 가져오기 위한 서버 요청
		$.get("/replies/" + rno + ".json", function(result) {
			// 서버로부터 데이터를 성공적으로 받은 경우 콜백 함수 실행
			if (callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			// 서버 요청 실패 시 에러 처리 함수 실행
			if (error) {
				error();
			}
		});
	} // get 함수 정의 끝

	// displayTime 함수 정의 시작
	function displayTime(timeValue) {
		// 시간 값 계산을 위해 현재 시간 객체 생성
		var today = new Date();

		// 현재 시간과의 차이를 계산
		var gap = today.getTime() - timeValue;

		// 댓글 작성 시간을 가지고 온 날짜 객체 생성
		var dateObj = new Date(timeValue);
		var str = "";

		// 현재 시간과의 차이가 24시간 이내인 경우
		if (gap < (1000 * 60 * 60 * 24)) {
			// 시, 분, 초를 문자열로 조합하여 반환
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			// 24시간 이상이면 년, 월, 일을 문자열로 조합하여 반환
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줌
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	} // displayTime 함수 정의 끝

	// replyService 객체에 메서드 추가 및 반환
	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};

})(); // replyService 객체 선언 및 정의 끝
