package org.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.project.domain.ReplyPageDTO;
import org.project.domain.ReplyVO;
import org.project.domain.Criteria;
import org.project.mapper.BoardMapper;
import org.project.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Transactional
@Log4j
@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	

	@Override
	public int register(ReplyVO replyVO) {
		replyVO.setReplyDate();
		log.info("register....." + replyVO);
		
		boardMapper.updateReplyCnt(replyVO.getBno(), 1);
		return replyMapper.insert(replyVO);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("get......" + rno);
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO replyVO) {
		replyVO.setUpdatedDate();
		log.info("modify......" + replyVO);
		return replyMapper.update(replyVO);
	}

	@Override
	public int remove(Long rno) {
		log.info("remove...." + rno);
		
		ReplyVO replyVO = replyMapper.read(rno);
		
		boardMapper.updateReplyCnt(replyVO.getBno(), -1);
		return replyMapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List of a Board " + bno);
		return replyMapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		return new ReplyPageDTO(replyMapper.getCountByBno(bno), replyMapper.getListWithPaging(cri, bno));
	}
}
