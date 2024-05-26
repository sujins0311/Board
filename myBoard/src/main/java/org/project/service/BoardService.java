package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;
import org.project.domain.Criteria;
import org.project.domain.ReplyVO;

public interface BoardService {
	
	//public List<BoardVO> getPostList(); //get(페이징x)
	public List<BoardVO> getPostList(Criteria cri); //get(페이징ㅇ)
	public int getTotal(Criteria cri); //get(페이징ㅇ)
	
	public Long createPost(BoardVO boardVO); //post
	public BoardVO getPost(Long bno); //get
	public boolean deletePost(Long bno); //delete
	public boolean modifyPost(BoardVO boardVO, Long[] attachFileNums); //update
}
