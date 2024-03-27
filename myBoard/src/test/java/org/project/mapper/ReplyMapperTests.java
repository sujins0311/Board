package org.project.mapper;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.ReplyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.project.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	private Long[] bnoArr = { 50L, 51L }; // 댓글 생성할 게시물 번호
	//int numberOfReplies = 20; // 각 게시물에 생성할 댓글 개수
	

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	//댓글 생성
	@Test
	public void testCreate() {
	    int targetBno = 16; // 16번 게시글에 댓글 추가

	    for (int j = 0; j < 500; j++) {
	        ReplyVO vo = new ReplyVO();
	        
	        // 게시물 번호 설정
	        vo.setBno((long) targetBno);
	        
	        // 댓글 내용과 작성자 설정
	        vo.setReply("댓글test" + j);
	        vo.setReplyer("replyer" + j);
	        
	        // 댓글 생성일 설정 (현재 시간)
	        vo.setReplyDate(LocalDateTime.now());
	        
	        // 데이터베이스에 댓글 추가
	        mapper.insert(vo);
	    }
	}


	public void testDelete() {
		Long targetRno = 1L;
		mapper.delete(targetRno);
	}


	public void testUpdate() {
		Long targetRno = 2L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("Update Reply____ ");
		int count = mapper.update(vo);
		log.info("UPDATE COUNT: " + count);
	}


	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}



	public void testList2() {
		Criteria cri = new Criteria(2, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 3145745L);
		replies.forEach(reply -> log.info(reply));

	}

	public void testRead() {
		Long targetRno = 2L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}

	public void testCreat() {
	    IntStream.rangeClosed(1, 100).forEach(i -> { // 1~100
	        ReplyVO vo = new ReplyVO();
	        System.out.println(bnoArr.length);

	        // 게시물 번호
	        vo.setBno(bnoArr[i % bnoArr.length]); // bnoArr 배열의 크기로 나눈 나머지를 사용하여 게시물 번호 설정
	        vo.setReply("댓글test" + i);
	        vo.setReplyer("replyer" + i);
	        vo.setReplyDate();

	        mapper.insert(vo);
	    });
	}
	
	public void testMapper() {
		// replyMapper타입의 객체가 작동하는지 Test
		log.info(mapper);
	}

}
