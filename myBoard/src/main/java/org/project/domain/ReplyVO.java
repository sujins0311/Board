package org.project.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyVO {

	private Long rno; //PK
	private Long bno; //FK(tbl_board)
	private String reply;
	private String replyer;
	// Java객체 -> JSON으로 표현하려면 중간에 변환(직렬화)가 필요함(배열로 넘어감)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Date replyDate;
	private Date updateDate;
	
    // setReplyDate가 호출되는 시점을 현재시간으로 등록됨
    public void setReplyDate() {
        this.replyDate = new Date();
    }

    public void setUpdatedDate() {
        this.updateDate = new Date();
    }
    
    public String getReplyDate() {
//    	NullPointerException이 뜬다는 것은 
//    	null을 반환해서 뜬 것이 아니고 값이 null이라서 뜬 것도 아니고
//    	null을 참조해서 뭔가 행위를 하려고 할 떄 뜬다.
    	if(this.replyDate != null) {
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        return dateFormat.format(this.replyDate);
    	} else {
    		return null;
    	}
    }

}
