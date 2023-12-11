package org.project.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.BoardVO;
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
	public void testGetList() {
		System.out.println("testGetList");
		System.out.println(mapper.getList());
 
//		mapper.getList().forEach(board -> log.info(board));
		List<BoardVO> boards = mapper.getList(); //BoardVO클래스는 @Data 어노테이션에 의해 사용가능
		for (BoardVO board : boards) {
		    log.info(board);
		}
	}
}
