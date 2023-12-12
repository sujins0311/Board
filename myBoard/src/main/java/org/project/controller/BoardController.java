package org.project.controller;

import org.project.service.BoardService;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/baord/*")
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
