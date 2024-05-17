package org.project.controller;


import org.project.domain.MemberVO;
import org.project.domain.ReplyVO;
import org.project.service.BoardService;
import org.project.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/auth/*")
@Controller
@AllArgsConstructor // 생성자주입
public class MemberContoller {
	
    private MemberService service;
    
    // 회원가입
    //http://localhost:8888/auth/register
    @GetMapping("register")
    public void register() {
    	log.info("register");
    }
    
    
	@PostMapping("register")
	public String register(MemberVO memberVO, RedirectAttributes rttr) {
		log.info("register" + rttr);
		service.register(memberVO); // 회원가입(DB)
		rttr.addFlashAttribute("register",memberVO.getUserid());// 유저의 id 전달 > 모달창 띄워 완료
		return "redirect:/customLogin";	
	}

    
    
//	@PostMapping(value = "/register", // url
//				consumes = "application/json", // 요청타입 > json
//				produces = { MediaType.TEXT_PLAIN_VALUE }) // 응답타입 > text
//	public ResponseEntity<String> register(@RequestBody MemberVO memberVO) { 
//		// @RequestBody MemberVO -> 요청본문을 자바객체로 변환
//		// ResponseEntity<String> -> text로 반환하므로 string
//		
//		 // 회원가입 로직 수행
//        try {
//        	service.register(memberVO);
//        	log.info("MemberVO: ***** " + memberVO);
//            return new ResponseEntity<>("success", HttpStatus.OK);
//        } catch (Exception e) {
//            // 회원가입 실패 시
//            log.info("회원가입실패/register");
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//	}
	
    
    

	// http://localhost:8888/user/all
	// http://localhost:8888/Custom Login?error
	@GetMapping
	public void loginPage(String error, String logout, Model model) {

		log.info("--------Custom Login Page--------");
		log.info(error);
		if (error != null) {
			log.info("---------------");
			log.info(error);
		}
	}

	// http://localhost:8888/user/all
	@GetMapping("/all")
	public void All() {

		log.info("all....................");
	}

	// http://localhost:8888/user/member
	@GetMapping("/member")
	public void Member() {

		log.info("Member....................");
	}

	// http://localhost:8888/user/admin
	@GetMapping("/admin")
	public void Admin() {

		log.info("Admin only.....................");
	}
	

//  @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
//  @GetMapping("/annoMember")
//  public void doMember2() {
//    
//    log.info("logined annotation member");
//  }

//  @Secured({"ROLE_ADMIN"})
//  @GetMapping("/annoAdmin")
//  public void doAdmin2() {
//
//    log.info("admin annotaion only");
//  }

}