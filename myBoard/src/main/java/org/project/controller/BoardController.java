package org.project.controller;

import org.project.domain.BoardVO;
import org.project.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
// web.xml에 servlet-mapping 태그를 통해 localhost:8080"/" 경로로 들어오는 URL을 
// 디스패쳐서블릿에 매핑하여 특정 URL의 controller에 라우팅함
// URL(@RequestMapping("/baord/*"))과 매핑된 요청을 해당 controller에서 처리
// root-context.xml에 scan태그에 선언된 패키지에 어노테이션을 읽어 URL요청이 들어오면 처리 될 수 있도록 스프링 컨테이너에 빈을 등록함
@AllArgsConstructor // 생성자주입
public class BoardController {

	private BoardService service;
	

	// 조회페이지
	// http://localhost:8080/baord/getPost
	@GetMapping("getPost") // getPost.jsp
	public void getPost(@RequestParam("bno") Long bno,Model model) {
		log.info("getPost");
		model.addAttribute("getPostResult", service.getPost(bno));
	}
	
	
	// 수정페이지
	// http://localhost:8080/baord/getmodifyPost
	@GetMapping({"/getmodifyPost"}) // getmodifyPost.jsp
	public void getmodifyPost(@RequestParam("bno") Long bno,Model model) {
		log.info("getmodifyPost");
		model.addAttribute("getmodifyPostResult", service.getPost(bno));
	}

	
	// 수정 > 조회 페이지에서 삭제 버튼 > 수정페이지 > 수정 후 게시글 목록페이지
	// > 수정한 form을 받아 DB에 저장 > 모달창(수정완료) > 회원조회(RedirectAttributes)
	@PostMapping("/modifyPost")
	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("/modifyPost" + boardVO);
		
		service.modifyPost(boardVO);
		rttr.addFlashAttribute("modifyPostResult", boardVO.getBno());
		
		return "redirect:/board/get" + boardVO.getBno();
	}


	// 삭제 > 조회 페이지에서 삭제버튼 > 모달창 > 게시글 목록페이지
	// http://localhost:8080/baord/deletePost	
	@DeleteMapping
	public String deletePost(@RequestParam("bno") Long bno) {
		log.info("/deletePostResult" + bno);
		service.deletePost(bno);
		return "redirect:/board/list";
	}


	// 등록 > 모달창 > 게시글 목록페이지
	// http://localhost:8080/baord/getCreatePost
	@GetMapping("getCreatePost") // getCreatePost.jsp
	public void getCreatePost() {
		log.info("/getCreatePost");		
	}

	@PostMapping("/createPost") // getCreatePost.jsp
	public String createPost(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("/createPost" + boardVO);

		service.createPost(boardVO); // 게시글 등록(DB)
		rttr.addFlashAttribute("createPostResult", boardVO.getBno()); // 게시글 번호 전달(jsp에서 중복 확인)
		return "redirect:/board/list";
	}
	

	// 목록
	// http://localhost:8080/board/getPostList
	@GetMapping("/getPostList") // getPostList.jsp
	public void list(Model model) {
		log.info("list");
		model.addAttribute("getPostListResult", service.getPostList());
	}

}
