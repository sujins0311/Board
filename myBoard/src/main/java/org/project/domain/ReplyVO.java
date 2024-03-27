package org.project.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyVO {

	private Long rno; //PK
	private Long bno; //FK(tbl_board)
	private String reply;
	private String replyer;
//	// Java객체 -> JSON으로 표현하려면 중간에 변환(직렬화)이 필요함, 변환하지 않고 넘어가니깐 저렇게 배열로 나오는것
	//@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime replyDate;
	private LocalDateTime updateDate;

	// setRepliedDate가 호출되는 시점을 현재시간으로 등록됨
	public void setReplyDate() {
	    this.replyDate = LocalDateTime.now();
	}


	// setUpdatedDate가 호출되는 시점을 현재시간으로 등록됨
	// LocalDateTime.now(): 컴퓨터의 현재 시간 정보를 저장한 LocalDateTime객체를 리턴한다.
	public void setUpdatedDate() {
		this.updateDate = LocalDateTime.now();
	}
	
//	public String getReplyDate() {
//		return this.replyDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//	}

}
