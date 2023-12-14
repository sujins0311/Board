package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;

public interface BoardService {
	
	public List<BoardVO> getList();
	public void register(BoardVO boardVO);
	public  BoardVO get(Long bno);
	
}
