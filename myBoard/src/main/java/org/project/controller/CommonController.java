package org.project.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {

		log.info("access Denied : " + auth);
		model.addAttribute("result", "Access Denied");
	}

	// 로그인 페이지에서 로그아웃을 요청할때 String logout
	// http://localhost:8888/Custom Login?error
	@GetMapping("/customLogin")
	public void loginPage(String error, Model model) {
		
		log.info("/customLogin");

		if (error != null) {
			model.addAttribute("error", "ID 또는 비밀번호를 확인 후 다시 입력해 주세요.");
			log.info("error: " + error);
		}
	}
	
	
	
//	@GetMapping("/customLogin")
//	public void loginPage(String error, String logout, Model model) {
//		
//		log.info("/customLogin");
//
//		if (error != null) {
//			model.addAttribute("error", "ID 또는 비밀번호를 확인 후 다시 입력해 주세요.");
//			log.info("error: " + error);
//		}
//
//		if (logout != null) {
//			model.addAttribute("logout", "로그아웃 성공했습니다.");
//			log.info("logout: " + logout);
//		}
//	}
	
//	@GetMapping("/customLogout")
//	public String logoutPage() {
//		
//		log.info("-------custom Login-------");
//		
//		return "redirect:/"; // 로그아웃 페이지로 이동하면 홈 페이지로 리다이렉트
//	}


//    @PostMapping("/customLogout") //핸들러가 있으니 없어도됨
//    public String logout() {
//    	log.info("--------------------------------------------post logout");
//        // 로그아웃 처리를 위해 추가적인 작업이 필요하지 않음
//        return "redirect:/"; // 로그아웃 후 홈 페이지로 리다이렉트
//    }


}
