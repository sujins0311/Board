package org.project.mapper;

import java.util.List;

import org.project.domain.BoardVO;

public interface BoardMapper {
	
	//@Select대신 BoardMapper.xml에 SQL문 처리
	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList(); //getPostList(get)
	public void insert(BoardVO board); //createPost(post)
	public BoardVO read(Long bno); //getPost(get)
	public int delete(Long bno); //deletePost(delete)
	public int modify(BoardVO boardVO); //modifyPost(update)

}
