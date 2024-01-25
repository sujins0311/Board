package org.project.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;	
	private LocalDateTime createdDate;
	private LocalDateTime updatedDate;

    // setCreatedDate가 호출되는 시점을 현재시간으로 등록됨
    public void setCreatedDate() {
    	this.createdDate = LocalDateTime.now();
    }
    
    // setUpdatedDate가 호출되는 시점을 현재시간으로 등록됨
    public void setUpdatedDate() {
        this.updatedDate = LocalDateTime.now();
    }
}
