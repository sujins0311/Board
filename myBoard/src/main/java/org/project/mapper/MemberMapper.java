package org.project.mapper;

import org.project.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	public void insert(MemberVO vo); //register(post)

}
