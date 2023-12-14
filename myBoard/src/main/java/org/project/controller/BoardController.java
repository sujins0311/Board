package org.project.controller;

import org.project.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*") 
// web.xml에 servlet-mapping 태그를 통해 localhost:8080"/" 경로로 들어오는 URL을 
// 디스패쳐서블릿에 매핑하여 특정 URL의 controller에 라우팅함
// URL(@RequestMapping("/baord/*"))과 매핑된 요청을 해당 controller에서 처리
// root-context.xml에 scan태그에 선언된 패키지에 어노테이션을 읽어 URL요청이 들어오면 처리 될 수 있도록 스프링 컨테이너에 빈을 등록함
@AllArgsConstructor //생성자주입
public class BoardController {
	
	private BoardService service;
	
// http://localhost:8080/baord/get?bno=1
	@GetMapping({ "/get"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("/get");
		model.addAttribute("board", service.get(bno));
	}
	
	// http://localhost:8080/baord/register
	@PostMapping("/register")
	public void register() {
		log.info("/register");
	}
	
	// http://localhost:8080/baord/list
	@GetMapping("/list") 
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());	
	}

}
