package org.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.project.domain.AttachVO;
import org.project.domain.BoardVO;
import org.project.domain.Criteria;

public interface BoardAttachMapper {
	
	//public List<AttachVO> readAttach(Long bno);
	public int insertAttach(AttachVO attachVO);
	public void deleteAttachFiles(Long[] anos);
	public void deleteAttachFilesByBno(Long bno);
	}