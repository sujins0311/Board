package org.project.commons;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice { //공통로직
	
	@Before("execution(* org.project.service.BoardService*.*(..))")
	public void logBefore() {
		log.info("========================");	
	}

}