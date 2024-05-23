package org.project.service;

import org.project.domain.MemberVO;

public interface MemberService {
		
	public void register(MemberVO memberVO); //post
	public MemberVO read(String username); //get
	public boolean update(MemberVO memberVO); //update
	public boolean updatePassword(MemberVO memberVO); //post
	//public boolean delete(MemberVO memberVO);
	
	public boolean checkPassword(String userpw, String userid);
	public void delete(String userid); //mapper.deleteAuth(userid); mapper.delete(userid);
	
}
