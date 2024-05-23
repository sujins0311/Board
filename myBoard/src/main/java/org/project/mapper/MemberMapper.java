package org.project.mapper;

import java.util.List;

import org.project.domain.AuthVO;
import org.project.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void register(MemberVO memberVO); //register(post)
	public void registerAuth(List<AuthVO> list);
	
	public int deleteAuth(String userid);
	public int delete(String userid);
	public String getPassword(String userid);
	
	
	public int update(MemberVO memberVO); // update(post)
	public int updateAuth(MemberVO currentMember);

	public int updatePassword(MemberVO memberVO);

}
