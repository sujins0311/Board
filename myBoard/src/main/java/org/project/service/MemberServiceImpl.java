package org.project.service;

import java.util.Collections;
import org.project.domain.AuthVO;
import org.project.mapper.MemberMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.project.domain.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	private PasswordEncoder passwordEncoder;
	
	// 회원정보수정, 비밀번호수정
	@Transactional
	@Override
	public boolean update(MemberVO member) {
		// 비밀번호가 변경된 경우 인코딩
		if (member.getUserpw() != null && !member.getUserpw().isEmpty()) {
			member.setUserpw(passwordEncoder.encode(member.getUserpw()));
		}
		member.setUpdatedDate();
		return mapper.update(member) == 1;
	}

	// 회원정보삭제
	@Transactional
	@Override
	public void delete(String username) {
		mapper.delete(username);
	}

	// 회원정보조회
	@Transactional
	@Override
	public MemberVO read(String username) {
		return mapper.read(username);
	}
	
	//회원가입
	@Transactional
	@Override
	public void register(MemberVO memberVO) {
		
	   // 중복체크
       if (mapper.read(memberVO.getUserid()) != null) {
            throw new IllegalStateException("이미 존재하는 사용자 ID입니다.");
        }else {
            // 회원정보등록
        	memberVO.setRegDate();
        	// 비밀번호인코딩
        	memberVO.setUserpw(passwordEncoder.encode(memberVO.getUserpw()));
    		mapper.registerMember(memberVO);
    		
		
			// 권한정보등록
			AuthVO authVO = new AuthVO();
			authVO.setUserid(memberVO.getUserid());
			authVO.setAuth("ROLE_MEMBER"); // 사용자의 초기 권한을 ROLE_USER로 설정
			memberVO.setAuthList(Collections.singletonList(authVO));
			mapper.registerMemberAuth(memberVO.getAuthList());
			
			log.info("register......" + memberVO);
        }
	}
	


}
