package org.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.domain.Criteria;

public interface BoardMapper {
	
	//@Select대신 BoardMapper.xml에 SQL문 처리
	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList(); //getPostList(get)
	public List<BoardVO> getListWithPaging(Criteria cri); //getPostList(get)
	public int getTotalCount(Criteria cri); // getPostList(get)
	
	public int insert(BoardVO boardVO); //createPost(post)
	public BoardVO read(Long bno); //getPost(get)
	public int delete(Long bno); //deletePost(delete)
	public int modify(BoardVO boardVO); // modifyPost(post)
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("itemsPerPage") int itemsPerPage);

	}