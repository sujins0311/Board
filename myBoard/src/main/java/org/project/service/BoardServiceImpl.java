package org.project.service;

import java.util.List;

import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.mapper.BoardAttachMapper;
import org.project.mapper.BoardMapper;
import org.project.mapper.ReplyMapper;
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
	
	/*
	 * Transaction 트랜잭션?
	 * 여러 DML(insert, delete, update)을 사용시 각각 반영 아닌 (가상의)논리적단위인
	 * 하나로 묶어 하나의 작업처럼 처리함. 모두 OK가 아닐 경우 rollback 하여 데이터 무결성을 지킴
	 */	

	private BoardMapper mapper;
	
	private BoardAttachMapper attachMapper;
	
	private ReplyMapper replyMapper;
	
	// 게시글등록+이미지등록
	@Override
	public Long createPost(BoardVO boardVO) {
		boardVO.setCreatedDate();
		log.info("createPost......" + boardVO);
		mapper.insert(boardVO);
		Long bno = boardVO.getBno();

		List<AttachVO> attachVOList = boardVO.getAttachVOList();

		// attachVOList가 null이 아니고 비어있지 않은 경우에만 실행
		// if(attachVOList != null && !attachVOList.isEmpty()) {
		if (attachVOList != null && attachVOList.size() > 0) {
			for (AttachVO attachVO : attachVOList) {
				attachVO.setBno(bno);
				attachMapper.insertAttach(attachVO);
			}
		}
		return bno;
	}
	
//	public void createPost(BoardVO boardVO) {
//		boardVO.setCreatedDate();
//		log.info("createPost......" + boardVO);
//		mapper.insert(boardVO);
//	}

	// 게시글조회
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

	// 게시글삭제
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public boolean deletePost(BoardVO boardVO) {
		log.info("deletePost.....");
		
		// 1. bno로 연관된 댓글 삭제
		int deletedRepliesCount = replyMapper.deleteByBno(boardVO.getBno());
		log.info("Deleted replies for bno: " +  boardVO.getBno() + ", success: " + deletedRepliesCount);
		
		// 2. bno로 연관된 이미지삭제		
		attachMapper.deleteAttachFilesByBno(boardVO.getBno());
		log.info("Deleted attach files for bno: " + boardVO.getBno());
		
		// 3. 게시글삭제
		boolean deletedBoard =  mapper.delete(boardVO.getBno()) == 1;
		log.info("Deleted board for bno: " +  boardVO.getBno() + ", success: " + deletedBoard);
		return deletedBoard;
	}
	
	
	// 게시글 수정은 attach, reply테이블의 bno에 외래키제약조건이 걸려있다
	// 부모 테이블의 특정 레코드를 삭제할 때 자식 테이블에 해당 레코드를 참조하는 데이터가 있는경우 삭제가 제한된다.(참조 무결성을 보장)
	// 그래서 자식 행을 먼제 삭제 후, 부모 테이블의 행을 삭제한다.
	// 이때, @Transactional(rollbackFor = {Exception.class})를 사용하여, 하나의 논리적 단위로 묶어 주어야한다.
	
	//	board  -- bno
	//	attachemt -- bno + 파일 지우기
	//	reply -- bno


	// rollbackFor = 롤백속성(하나 이상의 예외 클래스 타입) -> Class<? extends Throwable>[]
	// 트랜젝션 실행 중 예외가 발생하면 rollback 수행
	// 게시글 수정: attach(INSERT/DELETE), tbl_board(UPDATE)
	@Transactional(rollbackFor = {Exception.class})
	@Override
	public boolean modifyPost(BoardVO boardVO, Long[] attachFileNums) {
		boardVO.setUpdatedDate();
		log.info("modifyPost.....");
		log.info("attachFileNums: " + attachFileNums);

		List<AttachVO> attachVOList = boardVO.getAttachVOList();

		// 1. 이미지삭제
		// attachFileNums가 null이 아니고 길이가 0보다 큰 경우에만 실행
		if (attachFileNums != null && attachFileNums.length > 0) {
			attachMapper.deleteAttachFiles(attachFileNums);
		}

		// 2. 이미지등록
		// attachVOList가 null이 아니고 비어있지 않은 경우에만 실행
		if (attachVOList != null && !attachVOList.isEmpty()) {
			for (AttachVO attachVO : attachVOList) {
				attachVO.setBno(boardVO.getBno());
				attachMapper.insertAttach(attachVO);
			}
		}
		// 3. 게시글 수정
		return mapper.modify(boardVO) == 1;
	}
	
	
	// 게시글수정+이미지수정
//	@Override
//	public boolean modifyPost(BoardVO boardVO, Long[] attachFileNums) {
//		boardVO.setUpdatedDate();
//		log.info("modifyPost.....");
//
//		List<AttachVO> attachVOList = boardVO.getAttachVOList();
//
//		if (attachFileNums != null && attachFileNums.length > 0) {
//			mapper.deleteAttachFiles(attachFileNums);
//		}
//
//		// attachVOList가 null이 아니고 비어있지 않은 경우에만 실행
//		if (attachVOList != null && !attachVOList.isEmpty()) {
//			for (AttachVO attachVO : attachVOList) {
//				attachVO.setBno(boardVO.getBno());
//				mapper.insertAttach(attachVO);
//			}
//		}
//		return mapper.modify(boardVO) == 1;
//	}

	// 게시글목록
	@Override
	public List<BoardVO> getPostList(Criteria cri) {
		log.info("get List with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	// 게시글목록(페이징)
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count" + cri);
		return mapper.getTotalCount(cri);
	}

}
