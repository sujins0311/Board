package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;
import org.project.domain.Criteria;

public interface BoardService {
	
	//public List<BoardVO> getPostList(); //get(페이징x)
	public void createPost(BoardVO boardVO); //post
	public BoardVO getPost(Long bno); //get
	public boolean deletePost(Long bno); //delete
	public boolean modifyPost(BoardVO boardVO); //update
	
	public List<BoardVO> getPostList(Criteria cri); //get(페이징ㅇ)
	//public int getTotal(Criteria cri);

}