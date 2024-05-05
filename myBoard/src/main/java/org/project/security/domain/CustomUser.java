package org.project.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.project.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;

	// 사용자 정보를 저장할 MemberVO 객체
	private MemberVO member;

	// 사용자 정보를 초기화하는 생성자
	public CustomUser(
			String username, 
			String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(MemberVO vo) {

		// MemberVO 객체를 이용하여 사용자 정보를 초기화하는 생성자
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));

		// MemberVO 객체를 member 필드에 저장
		this.member = vo;
	}
}
