package org.project.controller;

import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;

import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.domain.PagingDTO;
import org.project.service.BoardService;
import org.project.util.UpDownUtil;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.introspect.TypeResolutionContext.Empty;

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
	private UpDownUtil upDownUtile; //파일업로드

	// 게시글목록
	// http://localhost:8080/board/getPostList
	@GetMapping("/getPostList")
	public void getPostList(
			Criteria cri, 
			Model model) {
		
		log.info("Criteria: " + cri);

		model.addAttribute("list", service.getPostList(cri)); //게시글목록
	    
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PagingDTO(cri, total)); //페이징
	}
	

	// 게시글조회
	// http://localhost:8080/board/getPost?bno=1
	@GetMapping("getPost") // getPost.jsp
	public void getPost(
			@RequestParam("bno") Long bno,
			Model model,
			@ModelAttribute("cri") Criteria cri) {
		log.info("getPost");
		
		BoardVO boardVO = service.getPost(bno);
		log.info("boardVO: " + boardVO);
		
		model.addAttribute("getPostResult", service.getPost(bno));
		log.info(service.getPost(bno));
	}
	

	// 게시글삭제 (> 조회 페이지에서 삭제버튼 > 모달창 > 게시글 목록페이지)
	// http://localhost:8080/board/deletePost?bno=1
	// 현재 application/x-www-form-urlencoded를 받음
	@PreAuthorize("hasAnyRole('principal.username == #boardVO.writer','ROLE_ADMIN')")
	@PostMapping("deletePost")
	public String deletePost(
			//@RequestParam("bno") Long bno,
			BoardVO boardVO,
			@RequestParam(value = "anos", required = false) Long[] anos,
			@RequestParam(value = "fullNames", required = false) String[] fullNames,
			RedirectAttributes rttr, 
			@ModelAttribute("cri") Criteria cri) {
		
		log.info("deletePost: " + boardVO);
		
		service.modifyPost(boardVO, anos);
		service.deletePost(boardVO.getBno());
		rttr.addFlashAttribute("deletePostResult", boardVO.getBno());
		upDownUtile.deleteFiles(fullNames);// 로컬에 저장한 파일삭제

		rttr.addAttribute("currentPageNum",cri.getCurrentPageNum());
		rttr.addAttribute("itemPerPage",cri.getItemsPerPage());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
			
		// board/getPostList로 리다이렉트하면 text/html타입으로 응답하는데 ajax는 text/*는 모두 text로 퉁침 
		return "redirect:/board/getPostList";
	}
	
//	@PreAuthorize("hasAnyRole('principal.username == #boardVO.writer','ROLE_ADMIN')")
//	@PostMapping("deletePost")
//	public String deletePost(
//			@RequestParam("bno") Long bno, 
//			RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		
//		log.info("deletePost: " + bno);
//		
//		if(service.deletePost(bno)) {
//			rttr.addFlashAttribute("deletePostResult", bno);
//		}
//		
//		rttr.addAttribute("currentPageNum",cri.getCurrentPageNum()); // 
//		rttr.addAttribute("itemPerPage",cri.getItemsPerPage());
//		rttr.addAttribute("type",cri.getType());
//		rttr.addAttribute("keyword",cri.getKeyword());
//			
//		// board/getPostList로 리다이렉트하면 text/html타입으로 응답하는데 ajax는 text/*는 모두 text로 퉁침 
//		return "redirect:/board/getPostList";
//	}

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
	
	
	// 게시글수정
	// http://localhost:8080/board/modifyPost?bno=10
	@PreAuthorize("hasAnyRole('principal.username == #boardVO.writer','ROLE_ADMIN')")
	@GetMapping({"modifyPost"})
	public void modifyPost(
			@RequestParam("bno") Long bno, 
			Model model, 
			@ModelAttribute("cri") Criteria cri) {
		
		log.info("modifyPost");
		model.addAttribute("modifyPostResult", service.getPost(bno));
	}

	
	// 수정 > 조회 페이지에서 삭제 버튼 > 수정페이지 > 수정 후 게시글 목록페이지
	// > 수정한 form을 받아 DB에 저장 > 모달창(수정완료) > 회원조회(RedirectAttributes)
	@PreAuthorize("hasAnyRole('principal.username == #boardVO.writer','ROLE_ADMIN')")
	@PostMapping("modifyPost")
	public String modifyPost(
			BoardVO boardVO,
			@RequestParam(value = "files",required = false) MultipartFile[] multipartFiles,
			@RequestParam(value = "anos", required = false) Long[] anos,
			@RequestParam(value = "fullNames", required = false) String[] fullNames,
			RedirectAttributes rttr, 
			@ModelAttribute("cri") Criteria cri) {
		
		log.info("boardVO: " + boardVO);
		
		log.info("----------------------------------------------");
		log.info(Arrays.toString(multipartFiles)); // MultipartFile[]이 배열이고, to String 으로 받음
		
		// 브라우저 업로드 파일이 서버로 전달 된 것을 받아 > upDownUtile로 전달
		// List타압의 attachVOList에 담아 > boardVO의 AttachVOList에 할당
		List<AttachVO> attachVOList = upDownUtile.uploadFormPost(multipartFiles);
		
		if (attachVOList != null && !attachVOList.isEmpty()) { // attachVOList가 null이 아니고 비어 있지 않을 때 실행할 코드
			boardVO.setAttachVOList(attachVOList);
		}
		
		if (service.modifyPost(boardVO, anos)) {
			// 삭제할 파일들 삭제
			upDownUtile.deleteFiles(fullNames);
			rttr.addFlashAttribute("modifyPostResult", boardVO.getBno());
		}
		

//		rttr.addAttribute("currentPageNum", cri.getCurrentPageNum());
//		rttr.addAttribute("itemPerPage", cri.getItemsPerPage());
//		rttr.addAttribute("type",cri.getType());
//		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/getPostList" + cri.getListLink();
	}
	
//	@PostMapping("modifyPost")
//	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/modifyPost" + boardVO);
//		
//		if (service.modifyPost(boardVO)) {
//			rttr.addFlashAttribute("modifyPostResult", boardVO.getBno());
//		}
//		
//		return "redirect:/board/getPostList"+cri.getListLink();
//	}
	
//	@PostMapping("modifyPost")
//	public String modifyPost(BoardVO boardVO, RedirectAttributes rttr, 
//			@ModelAttribute("cri") Criteria cri) {
//		log.info("/modifyPost" + boardVO);
//		
//		if (service.modifyPost(boardVO)) {
//			rttr.addFlashAttribute("modifyPostResult", "success");
//		}
//		
//		rttr.addAttribute("currentPageNum", cri.getCurrentPageNum());
//		rttr.addAttribute("itemPerPage", cri.getItemsPerPage());
//	
//		return "redirect:/board/getPostList";
//	}


	// 등록 > 모달창 > 게시글 목록페이지
	// http://localhost:8080/board/createPost
	@GetMapping("createPost") // createPost.jsp
	@PreAuthorize("isAuthenticated()")
	public void createPost() {
	}

	

	@PostMapping("createPost") // createPost.jsp
	@PreAuthorize("isAuthenticated()") //인증된 사용자만 해당 메소드에 접근할 수 있다. //isAuthenticated()"는 현재 사용자가 인증되었는지를 확인하는 시큐리티 내장메소드
	public String createPost(
			BoardVO boardVO,
			@RequestParam(
					value = "files", // inputTypeName: files
					required = false // 파일이 없을 수도 있다.
					) MultipartFile[] multipartFiles,
			RedirectAttributes rttr) {
		
		log.info("boardVO: " + boardVO);//INFO : org.project.controller.BoardController - boardVO: BoardVO(bno=null, title=5, content=5, writer=ppoosumi, createdDate=null, updatedDate=null, replyCnt=0, attachVOList=null)
		
		log.info("----------------------------------------------");
		log.info(Arrays.toString(multipartFiles)); // MultipartFile[]이 배열이고, to String 으로 받음
		
		// 브라우저 업로드 파일이 서버로 전달 된 것을 받아 > upDownUtile로 전달
		// List타압의 attachVOList에 담아 > boardVO의 AttachVOList에 할당
		List<AttachVO> attachVOList = upDownUtile.uploadFormPost(multipartFiles); //jpg //[AttachVO(ano=null, bno=null, uuid=a2e52153-afd0-45c8-86a1-a10ba0738ec1, fileName=a2e52153-afd0-45c8-86a1-a10ba0738ec1_토끼1.jpg)]
		boardVO.setAttachVOList(attachVOList);//BoardVO(bno=null, title=5, content=5, writer=ppoosumi, createdDate=null, updatedDate=null, replyCnt=0, attachVOList=[AttachVO(ano=null, bno=null, uuid=a2e52153-afd0-45c8-86a1-a10ba0738ec1, fileName=a2e52153-afd0-45c8-86a1-a10ba0738ec1_토끼1.jpg)])
		
		service.createPost(boardVO); // 게시글 등록(DB) + 파일 업로드가 추가됨
		log.info("/게시글전달 bno" + boardVO.getBno());
		rttr.addFlashAttribute("createPostResult", boardVO.getBno()); // 게시글 번호 전달(jsp에서 중복 확인)
		
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
