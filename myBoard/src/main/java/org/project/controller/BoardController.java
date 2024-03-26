package org.project.controller;

import org.project.domain.BoardVO;
import org.project.domain.PagingDTO;
import org.project.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.project.domain.Criteria;

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
	
	// JSP 부트스트랩 적용하기
	

	// 목록
	// http://localhost:8080/board/getPostList
	@GetMapping("/getPostList")
	public void getPostList(Criteria cri, Model model) {
		log.info("getPostList: " + cri);
		model.addAttribute("getPostListResult", service.getPostList(cri)); //게시글목록
	    
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PagingDTO(cri, total)); //페이징
	}
	
	
//	// 등록 + 파일업로드 (작성중)
//	@GetMapping("Upload") // getUpload.jsp
//	public void Upload() {
//		log.info("/Upload");		
//	}
//
//	// 등록 + 파일업로드 (작성중)
//	@PostMapping("/Upload") // Upload.jsp
//	public String createPost1(BoardVO boardVO, RedirectAttributes rttr) {
//		log.info("/createPost1" + boardVO);
//
//		service.createPost(boardVO); // 게시글 등록(DB)
//		rttr.addFlashAttribute("createPostResult", boardVO.getBno()); // 게시글 번호 전달(jsp에서 중복 확인)
//		return "redirect:/board/getPostList";
//	}
	

	// 조회페이지
	// http://localhost:8080/board/getPost?bno=1
	@GetMapping("getPost") // getPost.jsp
	public void getPost(@RequestParam("bno") Long bno,Model model,
			@ModelAttribute("cri") Criteria cri) {
		log.info("getPost");
		model.addAttribute("getPostResult", service.getPost(bno));
	}
	

	// 삭제 > 조회 페이지에서 삭제버튼 > 모달창 > 게시글 목록페이지
	// http://localhost:8080/board/deletePost?bno=1
	// 현재 application/x-www-form-urlencoded를 받음 
	@PostMapping("deletePost")
	public String deletePost(@RequestParam("bno") Long bno, RedirectAttributes rttr, 
			@ModelAttribute("cri") Criteria cri) {
		log.info("/deletePostResult" + bno);
		if(service.deletePost(bno)) {
			rttr.addFlashAttribute("deletePostResult", bno);
		}
		
		rttr.addAttribute("currentPageNum",cri.getCurrentPageNum()); // 
		rttr.addAttribute("itemPerPage",cri.getItemsPerPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
			
		// board/getPostList로 리다이렉트하면 text/html타입으로 응답하는데 ajax는 text/*는 모두 text로 퉁침 
		return "redirect:/board/getPostList";
	}

//	@PostMapping("deletePost")
//	public String deletePost(@RequestParam("bno") Long bno, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/deletePostResult" + bno);
//		if(service.deletePost(bno)) {
//			rttr.addFlashAttribute("deletePostResult", bno);
//		}
//
//		// board/getPostList로 리다이렉트하면 text/html타입으로 응답하는데 ajax는 text/*는 모두 text로 퉁침 
//		return "redirect:/board/getPostList"+cri.getListLink();
//	}
	
//	@PostMapping("deletePost")
//	public String deletePost(@RequestParam("bno") Long bno, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/deletePostResult" + bno);
//		if(service.deletePost(bno)) {
//			rttr.addFlashAttribute("deletePostResult", "success");
//		}
//		rttr.addFlashAttribute("deletePostResult",bno); //삭제한 번호 전달 값이 없으면 삭제성공 모달창
//		
//		// board/getPostList로 리다이렉트하면 text/html타입으로 응답하는데 ajax는 text/*는 모두 text로 퉁침 
//		return "redirect:/board/getPostList";
//	}
	
	
	// 수정페이지
	// http://localhost:8080/board/getmodifyPost?bno=10
	@GetMapping({"getModifyPost"}) // getmodifyPost.jsp
	public void getmodifyPost(@RequestParam("bno") Long bno,Model model, 
			@ModelAttribute("cri") Criteria cri) {
		log.info("getmodifyPost");
		model.addAttribute("getmodifyPostResult", service.getPost(bno));
	}

	
	// 수정 > 조회 페이지에서 삭제 버튼 > 수정페이지 > 수정 후 게시글 목록페이지
	// > 수정한 form을 받아 DB에 저장 > 모달창(수정완료) > 회원조회(RedirectAttributes)
	@PostMapping("modifyPost")
	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr, 
			@ModelAttribute("cri") Criteria cri) {
		log.info("/getModifyPost" + boardVO);
		
		if (service.modifyPost(boardVO)) {
			rttr.addFlashAttribute("getModifyPostResult", boardVO.getBno());
		}
		
		rttr.addAttribute("currentPageNum", cri.getCurrentPageNum());
		rttr.addAttribute("itemPerPage", cri.getItemsPerPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/getPostList";
	}
	
//	@PostMapping("modifyPost")
//	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/getModifyPost" + boardVO);
//		
//		if (service.modifyPost(boardVO)) {
//			rttr.addFlashAttribute("getModifyPostResult", boardVO.getBno());
//		}
//		
//		return "redirect:/board/getPostList"+cri.getListLink();
//	}
	
//	@PostMapping("modifyPost")
//	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/getModifyPost" + boardVO);
//		
//		if (service.modifyPost(boardVO)) {
//			rttr.addFlashAttribute("getModifyPostResult", "success");
//		}
//		
//		rttr.addAttribute("currentPageNum", cri.getCurrentPageNum());
//		rttr.addAttribute("itemPerPage", cri.getItemsPerPage());
//	
//		return "redirect:/board/getPostList";
//	}


	// 등록 > 모달창 > 게시글 목록페이지
	// http://localhost:8080/board/getCreatePost
	@GetMapping("getCreatePost") // getCreatePost.jsp
	public void getCreatePost() {
	}

	@PostMapping("getCreatePost") // getCreatePost.jsp
	public String createPost(BoardVO boardVO, RedirectAttributes rttr) {
		log.info("/getCreatePost" + rttr);

		service.createPost(boardVO); // 게시글 등록(DB)
		rttr.addFlashAttribute("getCreatePostResult", boardVO.getBno()); // 게시글 번호 전달(jsp에서 중복 확인)
		log.info("/게시글전달 bno" + boardVO.getBno());
		return "redirect:/board/getPostList";
	}
	

//	// 목록(페이징x)
//	// http://localhost:8080/board/getPostList
//	@GetMapping("/getPostList") // getPostList.jsp
//	public void list(Model model) {
//		log.info("getPostList");
//		model.addAttribute("getPostListResult", service.getPostList());
//	}

}
