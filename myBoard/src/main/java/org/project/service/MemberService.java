package org.project.service;

import org.project.domain.MemberVO;

public interface MemberService {
	
	// public List<BoardVO> getPostList(); //get(페이징x)
	//	public List<BoardVO> getPostList(Criteria cri); //get(페이징ㅇ)
	//	public int getTotal(Criteria cri); //get(페이징ㅇ)
		
	public void register(MemberVO memberVO); //post
	public MemberVO read(String username); //get
	public void delete(String username); //delete
	public boolean update(MemberVO memberVO); //update
}
