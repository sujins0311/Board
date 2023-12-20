package org.project.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice { // 예외처리(java.jsp.bean등록)
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {

		return "error404";
	}


	// http://localhost:8080/sample/ex04?name=aaa&age=bbb&page=9
	// @ExceptionHandler(): 해당 메서드가 ()들어가는 예외타입을 처리하는 것을 의미
	// 해당어노테이션의 속성으로 Exception클래스 타입을 지정할 수 있다. except()만 이용해서 처리할수있다
	// exception 패키지는 servlet-context.xml에서 인식하지 않아 <component-scan>을 이용해야함
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {

		log.error("Exception ....." + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model);
		return "errorPage";

	}
}
