package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;
import org.project.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Override
	public void createPost(BoardVO boardVO) {
		boardVO.setCreatedDate();
		log.info("createPost......" + boardVO);
		mapper.insert(boardVO);
	}

	@Override
	public BoardVO getPost(Long bno) {
		log.info("getPost....." + bno);
		return mapper.read(bno);
	}

	@Override
	public List<BoardVO> getPostList() {
		log.info("getPostList.....");
		return mapper.getList();

	}

	@Override
	public int deletePost(Long bno) {
		
		log.info("deletePost.....");
		return mapper.delete(bno);
	}


	@Override
	public boolean modifyPost(BoardVO boardVO) {
		boardVO.setUpdatedDate();
	    log.info("modifyPost.....");
	    return mapper.modify(boardVO) == 1;
	}

	

}
