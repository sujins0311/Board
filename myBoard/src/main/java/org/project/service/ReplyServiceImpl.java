package org.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.project.domain.ReplyPageDTO;
import org.project.domain.ReplyVO;
import org.project.domain.Criteria;
import org.project.mapper.ReplyMapper;
import org.project.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	private ReplyMapper mapper;
	
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO replyVO) {
		replyVO.setReplyDate();
		log.info("register....." + replyVO);
		return mapper.insert(replyVO);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get......" + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO replyVO) {
		replyVO.setUpdatedDate();
		log.info("modify......" + replyVO);
		return mapper.update(replyVO);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove...." + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
