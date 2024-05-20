package org.project.controller;


import org.project.domain.Criteria;
import org.project.domain.MemberVO;
import org.project.domain.ReplyVO;
import org.project.security.CustomUserDetailsService;
import org.project.security.UserSessionUtils;
import org.project.security.domain.CustomUser;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    private UserSessionUtils userSessionUtils;

    // ppoosumi 1234
    // 회원조회
	@GetMapping("member/read")
	public void read(Model model) {
		// UserSessionUtils를 사용하여 세션에 저장된 사용자 정보를 가져옴
		MemberVO memberVO = userSessionUtils.getCurrentMemberVO();
		log.info("Retrieved member: " + memberVO);

		if (memberVO != null) {
			model.addAttribute("member", memberVO);
		}
	}
    

    
    // 회원정보수정
	@GetMapping("member/update") // getPost.jsp
	public void update(Model model) {
		// UserSessionUtils를 사용하여 세션에 저장된 사용자 정보를 가져옴
		MemberVO memberVO = userSessionUtils.getCurrentMemberVO();
		log.info("Retrieved member: " + memberVO);

		if (memberVO != null) {
			model.addAttribute("member", memberVO);
		}
	}
	
	
	@PostMapping("member/update") // getPost.jsp
	public String update(MemberVO memberVO, RedirectAttributes rttr) {
		
		log.info("**************************memberVO" + memberVO);
		//INFO : org.project.controller.MemberContoller - **************************memberVOMemberVO(userid=admin99, userpw=null, username=관리자99ssdsd, email=admin99@example.com, status=false, regDate=null, updateDate=null, authList=null)

		// UserSessionUtils를 사용하여 세션에 저장된 사용자 정보를 가져옴
		// INFO : org.project.security.UserSessionUtils - Current member in session: MemberVO(userid=admin99, userpw=$2a$10$KKahc9s0tz5wtEPj7OrZr.iDfcaLVLjabbrYqG1Y/w5v7TUEj66MC, username=관리자99, email=admin99@example.com, status=false, regDate=Thu Apr 25 17:29:48 KST 2024, updateDate=Thu Apr 25 17:29:48 KST 2024, authList=[AuthVO(userid=admin99, auth=ROLE_ADMIN)])
		
		MemberVO currentMember  = userSessionUtils.getCurrentMemberVO();
		
		// 세션에 저장된 사용자 정보가 없을 경우 예외처리
		if(currentMember == null) {
			log.error("세션에 저장된 user를 찾을 수 없습니다.");
			return null; //뒤에 로직이 더 있기에 return을 해서 종료함
		}else {
			
			// 업데이트 된 사용자 정보를 세션에 저장
			//INFO : org.project.security.UserSessionUtils - 
			// Updated member in session: MemberVO(userid=admin99, userpw=$2a$10$KKahc9s0tz5wtEPj7OrZr.iDfcaLVLjabbrYqG1Y/w5v7TUEj66MC, 
			// username=null, email=admin99@example.com, status=false, regDate=Thu Apr 25 17:29:48 KST 2024, updateDate=Thu Apr 25 17:29:48 KST 2024, authList=[AuthVO(userid=admin99, auth=ROLE_ADMIN)])

			currentMember.setUsername(memberVO.getUsername());
			currentMember.setEmail(memberVO.getEmail());
			
			userSessionUtils.updateCurrentUser(currentMember);
			// INFO : org.project.controller.MemberContoller - Update current user in session: MemberVO(userid=admin99, userpw=$2a$10$KKahc9s0tz5wtEPj7OrZr.iDfcaLVLjabbrYqG1Y/w5v7TUEj66MC, username=관리자99ssdsd, email=admin99@example.com, status=false, regDate=Thu Apr 25 17:29:48 KST 2024, updateDate=Thu Apr 25 17:29:48 KST 2024, authList=[AuthVO(userid=admin99, auth=ROLE_ADMIN)])

			log.info("Update current user in session: " + currentMember);
			
			if(service.update(currentMember)) { //boolean
			// 업데이트 된 세션을 회원정보조회로 반환함 currentMember.getUsername()
			rttr.addFlashAttribute("member",currentMember);
			}
			return "redirect:/auth/member/read";
		}
	}
    
    
    // 회원정보삭제

    
    


	
	
    
    // 회원가입
    //http://localhost:8888/auth/register
    @GetMapping("register")
    public void register() {
    	log.info("register");
    }
    
    
    // ***ajax로 수정예정
    // form submit() : x-www-form-urlencoded  
    // ajax send() JSON : application/json 
	@PostMapping("register")
	public String register(MemberVO memberVO, RedirectAttributes rttr) {
		log.info("register" + rttr);
		service.register(memberVO); // 회원가입(DB)
		rttr.addFlashAttribute("register",memberVO.getUserid());// 유저의 id 전달 > 모달창 띄워 완료
		return "redirect:/customLogin";	
	}


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

	
//  @GetMapping("member/read")
//  public void read(Model model) {
//  	
//  	log.info("member/read");
//  	
//      CustomUser currentUser = userSessionUtils.getCurrentUser();
//      
//      if (currentUser != null) {
//          model.addAttribute("member", currentUser.getMember());
//      }
//  }
	
    // 회원정보조회
	// http://localhost:8888/auth/member/read
//	@GetMapping("member/read")
//	public void read(@RequestParam("username") String username, Model model) {
//		log.info("read");
//		model.addAttribute("readMemberResult",service.read(username));
//	}
	
//	@PostMapping(value = "/register", // url
//	consumes = "application/json", // 요청타입 > json
//	produces = { MediaType.TEXT_PLAIN_VALUE }) // 응답타입 > text
//public ResponseEntity<String> register(@RequestBody MemberVO memberVO) { 
//// @RequestBody MemberVO -> 요청본문을 자바객체로 변환
//// ResponseEntity<String> -> text로 반환하므로 string
//
//// 회원가입 로직 수행
//try {
//service.register(memberVO);
//log.info("MemberVO: ***** " + memberVO);
//return new ResponseEntity<>("success", HttpStatus.OK);
//} catch (Exception e) {
//// 회원가입 실패 시
//log.info("회원가입실패/register");
//return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//}
//}
}