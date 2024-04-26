package org.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.project.domain.MemberVO;
import org.project.mapper.MemberMapper;
import org.project.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	//UserDetailsService는 Spring Security 프레임워크에서 username으로 사용자 정보를 로드하는 인터페이스

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + username);

		MemberVO vo = memberMapper.read(username); // DB에서 username으로 조회

		log.warn("queried by member mapper: " + vo);

		return vo == null ? null : new CustomUser(vo); // CustomUser 객체 생성하여 반환
	} 

}
