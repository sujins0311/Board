package org.project.service;

import java.util.List;

import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.mapper.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.project.domain.Criteria;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Transactional
@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	private BoardMapper mapper;
	
	@Transactional
	@Override
	public Long createPost(BoardVO boardVO) {
		boardVO.setCreatedDate();
		log.info("createPost......" + boardVO);
		mapper.insert(boardVO);
		Long bno = boardVO.getBno();
		
		List<AttachVO> attachVOList = boardVO.getAttachVOList();

		// attachVOList가 null이 아니고 비어있지 않은 경우에만 실행
		// if(attachVOList != null && !attachVOList.isEmpty()) {
	    if(attachVOList != null && attachVOList.size() > 0){
	        for (AttachVO attachVO: attachVOList) {
	        	attachVO.setBno(bno);
	          mapper.insertAttach(attachVO);
	        }
	      }
		return bno;
	}
	
//	public void createPost(BoardVO boardVO) {
//		boardVO.setCreatedDate();
//		log.info("createPost......" + boardVO);
//		mapper.insert(boardVO);
//	}

	@Override
	public BoardVO getPost(Long bno) {
		log.info("getPost....." + bno);
		return mapper.read(bno);
	}

//	@Override
//	public List<BoardVO> getPostList() {
//		log.info("getPostList.....");
//		return mapper.getList();
//
//	}

	@Override
	public boolean deletePost(Long bno) {
		log.info("deletePost.....");
		return mapper.delete(bno) == 1;
	}

	@Override
	public boolean modifyPost(BoardVO boardVO, Long[] attachFileNums) {
		boardVO.setUpdatedDate();
	    log.info("modifyPost.....");
	    
		List<AttachVO> attachVOList = boardVO.getAttachVOList();
		
		if(attachFileNums != null && attachFileNums.length >0) {
			mapper.deleteAttachFiles(attachFileNums);
		}
			
		// attachVOList가 null이 아니고 비어있지 않은 경우에만 실행
		if(attachVOList != null && !attachVOList.isEmpty()) {
	        for (AttachVO attachVO: attachVOList) {
	        	attachVO.setBno(boardVO.getBno());
	          mapper.insertAttach(attachVO);
	        }
	      }
	    return mapper.modify(boardVO) == 1;
	}

	@Override
	public List<BoardVO> getPostList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count" + cri);
		return mapper.getTotalCount(cri);
	}

}
