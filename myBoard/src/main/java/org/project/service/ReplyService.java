package org.project.service;

import java.util.List;

import org.project.domain.ReplyVO;
import org.project.domain.Criteria;
import org.project.domain.ReplyPageDTO;

public interface ReplyService {

    // 등록(create)
	public int register(ReplyVO vo);

    // 조회(get)
	public ReplyVO get(Long rno);

    // 수정(modify)
	public int modify(ReplyVO vo);

    // 삭제(remove)
	public int remove(Long rno);

    // 목록 조회(getList)
	public List<ReplyVO> getList(Criteria cri, Long bno);
	
    // 페이지별 목록 조회(getListPage)
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
