package org.project.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

import org.project.controller.MemberContoller;
import org.project.domain.MemberVO;
import org.project.security.domain.CustomUser;

@Log4j
@Component
public class UserSessionUtils {

	// 현재 로그인한 사용자 정보를 반환( Spring Security의 User)
	public CustomUser getCurrentUser() {
		// 현재 로그인한 사용자의 세부 정보를 가져옴
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		// authentication이 null이 아니고, authentication.getPrincipal()이 CustomUser 타입인 경우,
		// CustomUser 객체로 캐스팅하여 반환
		if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
			log.info("authentication.getPrincipal() : " + authentication);
			return (CustomUser) authentication.getPrincipal();
		}
		return null;
	}

	// 현재 로그인한 사용자의 정보를 조회 (단순 조회)
	public MemberVO getCurrentMemberVO() {
		CustomUser currentUser = getCurrentUser();
		if (currentUser != null) {
			MemberVO memberVO = currentUser.getMember();
			log.info("Current member in session: " + memberVO);
			return memberVO; //memberVO를 반환
		}
		return null;
	}

	// 세션의 사용자 정보를 삭제
	public void deleteCurrentUser() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
			SecurityContextHolder.clearContext();
			log.info("Deleted current user from session");
		}
	}

	// 세션의 사용자 정보를 업데이트
	public void updateCurrentUser(MemberVO updatedMemberVO) {
		CustomUser currentUser = getCurrentUser();
		if (currentUser != null) {
			currentUser.setMember(updatedMemberVO);
			log.info("Updated member in session: " + updatedMemberVO);
			//return updatedMemberVO; //memberVO를 반환
		}
		//return null;
	}

}
