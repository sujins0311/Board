package org.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler  {

    @Override
    public void onLogoutSuccess(
    		HttpServletRequest request, 
    		HttpServletResponse response,
			Authentication authentication) 
					throws IOException, ServletException {
		if (authentication != null && authentication.getDetails() != null) {
			//로그인된 사용자의 인증 객체가 존재하고, 이 객체에 추가적인 세부 정보(details)가 있는지 확인
			
			try {
				//request.getSession().invalidate(); // 세션을 무효화 > xml에 설정
				User user = (User) authentication.getPrincipal();
				String username = user.getUsername();//[a, d, m, i, n, 9, 9]
				log.info("--------------------------------------User " + username + " has been logged out successfully.");
				response.setStatus(HttpServletResponse.SC_OK);
				response.sendRedirect("/customLogin");
			} catch (IOException e) {
				log.error("------------------------------------------Error handling logout", e);
				e.printStackTrace();
			}
			//response.setStatus(HttpServletResponse.SC_OK);
	        //response.sendRedirect("/");
		}
	}
}
