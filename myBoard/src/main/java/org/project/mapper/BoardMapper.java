package org.project.mapper;

import java.util.List;

import org.project.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	public void insert(BoardVO board);
	public BoardVO read(Long bno);

}
