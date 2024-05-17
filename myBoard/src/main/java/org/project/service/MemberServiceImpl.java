package org.project.service;

import java.util.Collections;
import org.project.domain.AuthVO;
import org.project.mapper.MemberMapper;
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
	
	@Transactional
	@Override
	public void register(MemberVO memberVO) {
		
	   // 중복체크
       if (mapper.read(memberVO.getUserid()) != null) {
            throw new IllegalStateException("이미 존재하는 사용자 ID입니다.");
        }else {
            // 회원 정보 등록
        	memberVO.setRegDate();
    		mapper.registerMember(memberVO);
    		
		
			// 권한 정보 등록
			AuthVO authVO = new AuthVO();
			authVO.setUserid(memberVO.getUserid());
			authVO.setAuth("ROLE_USER"); // 사용자의 초기 권한을 ROLE_USER로 설정
			memberVO.setAuthList(Collections.singletonList(authVO));
			mapper.registerMemberAuth(memberVO.getAuthList());
			
			log.info("register......" + memberVO);
        }
	}

}
