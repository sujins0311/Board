package org.project.domain;

import lombok.Data;

@Data
public class AttachVO {
	
	private Long ano; // PK
	private Long bno; // FK
	private String uuid; // 덮어쓸때 원본 파일이 사라지는 것을 방지하기 위해 36자리 문자열생성
	private String fileName;
	//private String uploadPath;
	//private boolean fileType;

	//private Long bno;

}
