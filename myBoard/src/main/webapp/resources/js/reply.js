console.log("Reply Module........");

// JS의 익명함수 
var replyService = (function() {

	function add(reply, callback, error) {
		console.log("add reply...............");

		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

//	function getList(param, callback, error) {
//
//		var bno = param.bno;
//		var page = param.page || 1;
//
//		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
//				function(data) {
//					if (callback) {
//						callback(data);
//					}
//				}).fail(function(xhr, status, err) {
//			if (error) {
//				error();
//			}
//		});
//	}
	
	

	function getList(param, callback, error) {

	    var bno = param.bno;
	    var page = param.page || 1;
	    
	    $.getJSON("/replies/pages/" + bno + "/" + page + ".json",
	        function(data) {
	    	
	          if (callback) {
	            //callback(data); // 댓글 목록만 가져오는 경우 
	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
	          }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }

	
	function remove(rno, replyer, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
	        data:  JSON.stringify({rno:rno, replyer:replyer}),    
	        contentType: "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	function update(reply, callback, error) {

		console.log("RNO: " + reply.rno);

		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	function get(rno, callback, error) {

		$.get("/replies/" + rno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

// 시간 값을 입력 받아 현재시간과 비교하여 보여주는 함수
	function displayTime(timeValue) {
	// 현재시간(new Date())을 나타내는 객체생성(today)
	timeValue =  new Date(timeValue); 
	
		// timeValue > Date객체로 변환
		var today = new Date(); 
		
		// today.getTime()은 현재까지의 경과된 시간을 밀리초단위로 표현한 것(currentTimeInMillis)
		var gap = today.getTime() - timeValue; 
		
		// 입력된 시간을 나타내는 Date 객체 복사
		var dateObj = new Date(timeValue);
		
		// 결과를 저장할 문자열 변수 초기화
		var str = "";

		// 현재 시간과 입력된 시간의 차이가 24시간 이내인 경우
		if (gap < (1000 * 60 * 60 * 24)) {

			// 입력된 시간의 시, 분, 초 값을 가져옴
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			// 시, 분 초가 한 자리 수인 경우 앞에 o을 추가하여 두 자리로 만듦
			// 배열을 이용하여 시, 분, 초를 구분자 ':'로 조합한 후 문자열로 반환
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else { // 현재 시간과 입렵괸 시간의 차이가 24시간 이상인 경우
		// 입력된 시간의 연, 월, 일 값을 가져옴 (월은 zero-based이므로 +1)
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			// 연, 월, 일이 한 자리 수인 경우 앞에 o을 추가하여 두 자리로 만듦
			// 배열을 이용하여 연, 월 일을 구분자 '/'로 조합한 후 문자열로 반환
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};


	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};

})();