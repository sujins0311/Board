package org.project.service;

import java.util.List;

import org.project.domain.BoardVO;
import org.project.mapper.BoardMapper;
import org.project.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import org.project.domain.Criteria;
import org.project.domain.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper;
	
	@Override
	public void register(MemberVO memberVO) {
		memberVO.setRegDate();
		log.info("register......" + memberVO);
		mapper.insert(memberVO);
	}

//	@Override
//	public BoardVO getPost(Long bno) {
//		log.info("getPost....." + bno);
//		return mapper.read(bno);
//	}

//	@Override
//	public List<BoardVO> getPostList() {
//		log.info("getPostList.....");
//		return mapper.getList();
//
//	}

//	@Override
//	public boolean deletePost(Long bno) {
//		log.info("deletePost.....");
//		return mapper.delete(bno) == 1;
//	}
//
//
//	@Override
//	public boolean modifyPost(BoardVO boardVO) {
//		boardVO.setUpdatedDate();
//	    log.info("modifyPost.....");
//	    return mapper.modify(boardVO) == 1;
//	}
//
//	@Override
//	public List<BoardVO> getPostList(Criteria cri) {
//		log.info("get List with criteria: " + cri);
//		return mapper.getListWithPaging(cri);
//	}
//	
//	@Override
//	public int getTotal(Criteria cri) {
//		log.info("get total count" + cri);
//		return mapper.getTotalCount(cri);
//	}

}
