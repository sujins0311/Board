package org.project.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.BoardVO;
import org.project.domain.Criteria;
import org.project.domain.PagingDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 
import lombok.Setter;
import lombok.extern.log4j.Log4j;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
 
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	


	@Test
	public void testGetListWithPaging1() {
		mapper.getListWithPaging(new Criteria(2,10)).forEach(boardVO -> log.info(boardVO));
	}
	

	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setCurrentPageNum(2);
		cri.setItemsPerPage(10); // 11~20 출력
		
	    List<BoardVO> list = mapper.getListWithPaging(cri);
	    list.forEach(boardVO -> log.info(boardVO.getBno())); // 람다
	    

	    
//		mapper.getListWithPaging(new PagedBoardVO(2, 10)).forEach(boardVO -> log.info(boardVO.getBno()));
		
//		for(int i = 0; i < list.size(); i++) {
//			BoardVO boardVO = new BoardVO();
//			boardVO = list.get(i);
//			log.info(boardVO.getBno());
//		}
		
//		for(BoardVO boardVO : list) {
//			log.info(boardVO.toString());
//		}// 향상된 for문
	}
	
 

	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
//		List<BoardVO> boards = mapper.getList(); 
//		for (BoardVO board : boards) {
//		    log.info(board);
//		}
	}
	
	
}
