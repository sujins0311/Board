package org.project.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid; // PK, loginID
	private String userpw;
	private String username;
	
	private String email;
	
	private boolean status;
	
	private Date regDate;
	private Date updateDate;
	
	private List<AuthVO> authList;

	// setRepliedDate가 호출되는 시점을 현재시간으로 등록됨
	public void setRegDate() {
	    this.regDate = new Date();
	}

	public void setUpdatedDate() {
		this.updateDate = new Date();
	}

}
