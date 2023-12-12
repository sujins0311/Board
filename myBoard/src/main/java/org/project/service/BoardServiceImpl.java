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
	public void register(BoardVO board) {

		log.info("register......" + board);

		mapper.insert(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);
		// INFO : org.zerock.service.BoardServiceImpl - get.....1
		return mapper.read(bno);
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.....");

		return mapper.getList();

	}

}
