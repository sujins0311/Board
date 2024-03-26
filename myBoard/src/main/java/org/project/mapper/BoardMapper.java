package org.project.mapper;

import java.util.List;
import java.util.Map;

import org.project.domain.BoardVO;
import org.project.domain.Criteria;

public interface BoardMapper {
	
	//@Select대신 BoardMapper.xml에 SQL문 처리
	//@Select("select * from tbl_board where bno > 0")
	List<BoardVO> getList(); //getPostList(get)
	List<BoardVO> getListWithPaging(Criteria cri); //getPostList(get)
	int getTotalCount(Criteria cri); // getPostList(get)
	
	void insert(BoardVO board); //createPost(post)
	BoardVO read(Long bno); //getPost(get)
	int delete(Long bno); //deletePost(delete)
	int modify(BoardVO boardVO); // modifyPost(update)
	 
	List<BoardVO> searchTest(Map<String, Map<String, String>> innerMap); //getPostList(get)
	}

