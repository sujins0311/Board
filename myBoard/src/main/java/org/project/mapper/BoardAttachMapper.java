package org.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.domain.Criteria;

public interface BoardAttachMapper {
	
	//public List<AttachVO> readAttach(Long bno);
	public int insertAttach(AttachVO attachVO);
	public void deleteAttachFilesByBno(Long bno);
	public void deleteAttachFiles(@Param("anos") Long[] anos);
	}

	/*
	 * 	//public void deleteAttachFiles(Long[] anos); 으로 작성할때 아래와 같이 에러 발생
	 * ERROR: org.project.exception.CommonExceptionAdvice - Exception .....nested
	 * exception is org.apache.ibatis.binding.BindingException: Parameter 'anos' not
	 * found. Available parameters are [array] ERROR:
	 * org.project.exception.CommonExceptionAdvice -
	 * {exception=org.mybatis.spring.MyBatisSystemException: nested exception is
	 * org.apache.ibatis.binding.BindingException: Parameter 'anos' not found.
	 * Available parameters are [array]}
	 * 
	 * public void deleteAttachFiles(@Param("anos") Long[] anos); 으로 수정 후 해결
	 */