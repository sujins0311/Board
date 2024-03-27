package org.project.mapper;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.project.domain.BoardVO;
import org.project.domain.Criteria;
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

	//map에 map 담아보기
//	public void tesrSearch() {
//		Map<String, String> innerMap = new HashMap<>();
//		innerMap.put("T", "제목");
//		innerMap.put("W", "작성자");
//		innerMap.put("C", "내용");
//		
//		Map<String, Map<String, String>> outerMap = new HashMap<>();
//		outerMap.put("map", innerMap);
//		
//		List<BoardVO> MapToList = mapper.searchTest(outerMap); //public List<BoardVO> searchTest(Map<String, Map<String, String>> innerMap); //getPostList(get)
//		
//		log.info(MapToList);
//	}
	
	
	@Test
	public void testSearch() {
		// 순수 자바로 짠 JDBC SQL실행 로직, 마이바티스 및 JPA에서 내부적으로 아래와 같이 동작한다.
		// conn은 datasource이다.
		// 즉 DBCP 여러개의 datasource, conn을 가지고 돌려쓴다.
//		Connection conn = DriverManager.getConnection(mysql://localhost:3306, "ID", "PW");
//		
//		PreparedStatement pstmt1 = 
//				conn.prepareStatement("select * from board where name = ? and title = ?");
//		pstmt1.setString(1, "book");
//		pstmt1.setString(2, "mytitle");
//		쿼리 실행 결과 row들이 rs에 들어간다.
//		ResultSet rs = pstmt1.executeQuery();
//		while(rs.next) { 각 row를 반복하여 가져온다.
//			String name = rs.getString("name");
//			.....
//			rs에서 가져온 값을 Bean에 넣는 등으로 사용한다.
//		}
//		**추가: 아래는 sql 문을 실행시키면 INSERT 일떄 생성된 ID 값을 리턴하는 옵션을 추가한 pstmt.
//		conn.prepareStatement("INSERT INTO board (name, title) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);

		Criteria cri = new Criteria();
		cri.setKeyword("제목");
		cri.setType("TWC");

		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}

	
//	public void testSearch() {
//		// 순수 자바로 짠 JDBC SQL실행 로직, 마이바티스 및 JPA에서 내부적으로 아래와 같이 동작한다.
//		// conn은 datasource이다.
//		// 즉 DBCP 여러개의 datasource, conn을 가지고 돌려쓴다.
////		Connection conn = DriverManager.getConnection(mysql://localhost:3306, "ID", "PW");
////		
////		PreparedStatement pstmt1 = 
////				conn.prepareStatement("select * from board where name = ? and title = ?");
////		pstmt1.setString(1, "book");
////		pstmt1.setString(2, "mytitle");
////		쿼리 실행 결과 row들이 rs에 들어간다.
////		ResultSet rs = pstmt1.executeQuery();
////		while(rs.next) { 각 row를 반복하여 가져온다.
////			String name = rs.getString("name");
////			.....
////			rs에서 가져온 값을 Bean에 넣는 등으로 사용한다.
////		}
////		**추가: 아래는 sql 문을 실행시키면 INSERT 일떄 생성된 ID 값을 리턴하는 옵션을 추가한 pstmt.
////		conn.prepareStatement("INSERT INTO board (name, title) VALUES (?, ?)", Statement.RETURN_GENERATED_KEYS);
//
//		Criteria cri = new Criteria();
//		cri.setTitleKeyword("제목");
//		cri.setContentKeyword("내용");
//		cri.setWriterKeyword("작성자");
//		cri.setType("TWC");
//
//		List<BoardVO> list = mapper.getListWithPaging(cri);
//		list.forEach(board -> log.info(board));
//	}
	
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
