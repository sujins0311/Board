package org.project.service;

import java.util.List;

import org.project.domain.MemberVO;

public interface MemberService {
	
	//public List<BoardVO> getPostList(); //get(페이징x)
//	public List<BoardVO> getPostList(Criteria cri); //get(페이징ㅇ)
//	public int getTotal(Criteria cri); //get(페이징ㅇ)
	
	public void register(MemberVO memberVO); //post
//	public BoardVO getPost(Long bno); //get
//	public boolean deletePost(Long bno); //delete
//	public boolean modifyPost(BoardVO boardVO); //update
}
