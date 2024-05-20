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
	// UserDetailsService는 Spring Security 프레임워크에서 username으로 사용자 정보를 로드하는 인터페이스
	// user의 정보와 권한이 들어있음

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + username);

		MemberVO vo = memberMapper.read(username); 
		// DB에서 username으로 조회
		// VO 객체에는 회원정보 + 권한정보(authList)가 들어있음

		log.warn("Queried by member mapper: " + vo);
		
		// 리턴타입이 UserDetails 이기 때문에 VO 객체를 바로 넣을 수는 없음
		// User 인터페이스를 구현한 CustomUser를 만들어 변환


		return vo == null ? null : new CustomUser(vo); 
		// User라는 인터페이스를 상속받은 CustomUser 객체 생성하여 반환
		// UserDetails로 return 하면 자동으로 업캐스팅
	} 

}
