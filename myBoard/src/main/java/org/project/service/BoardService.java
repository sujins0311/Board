package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getPostList(); //get
	public void createPost(BoardVO boardVO); //post
	public BoardVO getPost(Long bno); //get
	public int deletePost(Long bno); //delete
	public boolean modifyPost(BoardVO boardVO); //update

	
}
