package org.project.domain;

import java.util.List;

import org.project.domain.ReplyPageDTO;
import org.project.domain.ReplyVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	// 댓글 수와 댓글의 전체 목록을 전달해 페이징
	private int replyCnt; //댓글 수
	private List<ReplyVO> list; // 댓글 목록
	

}
