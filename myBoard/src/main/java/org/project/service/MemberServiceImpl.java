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
	public boolean update(MemberVO memberVO) {
		
//		if (member.getUserpw() != null && !member.getUserpw().isEmpty()) {
//			member.setUserpw(passwordEncoder.encode(member.getUserpw()));
//		}
		// 비밀번호가 변경된 경우 인코딩
		memberVO.setUpdatedDate();
		return mapper.update(memberVO) == 1;
	}
	
	// 비밀번호수정
	@Transactional
	@Override
	public boolean updatePassword(MemberVO memberVO) {
		// 비밀번호가 변경된 경우 인코딩
		if (memberVO.getUserpw() != null && !memberVO.getUserpw().isEmpty()) {
			memberVO.setUserpw(passwordEncoder.encode(memberVO.getUserpw()));
		}
		memberVO.setUpdatedDate();
		return mapper.updatePassword(memberVO) == 1;
	}
	
	// 회원정보삭제
	@Transactional
	@Override
	public boolean checkPassword(String userpw, String userid) {
	    // 저장된 비밀번호를 가져옴
	    String savedPassword = mapper.getPassword(userid);
	    
	    // 저장된 비밀번호가 null인지 확인
	    if (savedPassword == null) {
	        log.error("사용자의 비밀번호를 가져올 수 없습니다.");
	        return false;
	    }

	    // 비밀번호 일치 여부 확인
	    boolean passwordsMatch = passwordEncoder.matches(userpw, savedPassword);
	    log.info("비밀번호 일치 여부를 true 또는 false로 반환합니다 :"+ passwordsMatch);
	    
	    return passwordsMatch; //true 또는 false 반환
	}

	// 회원정보삭제
	@Transactional
	@Override
	public void delete(String userid) {
		
        // 외래 키로 묶인 member_auth 테이블의 데이터 삭제
		int deletedAuthCount = mapper.deleteAuth(userid);
        
		// member테이블의 데이터 삭제
		int deleteMemberCount = mapper.delete(userid);
		
		log.info("회원권한이 삭제된 행의 수를 반환합니다 :"+ deletedAuthCount);
		log.info("회원정보가 삭제된 행의 수를 반환합니다 :"+ deleteMemberCount);
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
        	memberVO.setEnabled(true); // memberVO.setEnabled("1"); //enabled CHAR(1) DEFAULT '1'

        	// 비밀번호인코딩
        	memberVO.setUserpw(passwordEncoder.encode(memberVO.getUserpw()));
    		mapper.register(memberVO);
    		
		
			// 권한정보등록
			AuthVO authVO = new AuthVO();
			authVO.setUserid(memberVO.getUserid());
			authVO.setAuth("ROLE_MEMBER"); // 사용자의 초기 권한을 ROLE_USER로 설정
			memberVO.setAuthList(Collections.singletonList(authVO));
			mapper.registerAuth(memberVO.getAuthList());
			
			log.info("register......" + memberVO);
        }
	}
	


}
