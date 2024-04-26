package org.project.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
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

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("-------custom Login-------");

		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
			log.info("error: " + error);
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
			log.info("logout: " + logout);
		}
	}

	@GetMapping("/customLogout")
	public void logoutGET() {

		log.info("-------custom logout-------");
	}

	@PostMapping("/customLogout")
	public void logoutPost() {

		log.info("-------post custom logout-------");
	}
	
//	@PostMapping("/customLogout")
//	public String logoutPost(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
//	    log.info("post custom logout");
//	    
//	    // 세션 무효화
//	    new SecurityContextLogoutHandler().logout(request, response, authentication);
//	    
//	    // 로그아웃 후 리다이렉트
//	    return "redirect:/customLogin?logout";
//	}

}
