package org.project.mapper;

import java.util.List;

import org.project.domain.AuthVO;
import org.project.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	public void registerMember(MemberVO memberVO); //register(post)
	public void registerMemberAuth(List<AuthVO> list);
	public String delete(String username);
	public int update(MemberVO member); // update(post)

}
