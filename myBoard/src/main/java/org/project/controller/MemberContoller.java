package org.project.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;



@Log4j
@RequestMapping("/auth/*") 
@Controller
@RequiredArgsConstructor
public class MemberContoller {
	
	// http://localhost:8888/user/all
	// http://localhost:8888/Custom Login?error
	@GetMapping
	public void loginPage(String error, String logout, Model model) {
		
		log.info("--------Custom Login Page--------");
		if(error !=null) {
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