package org.project.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PagingDTO {
    
    private int startPageNum; // 현재 페이지 그룹의 시작 페이지 번호
    private int endPageNum; // 현재 페이지 그룹의 마지막 페이지 번호
    
    private boolean hasPrev; // 이전 페이지 여부
    private boolean hasNext; // 다음 페이지 여부
    private int totalItems; // 전체 아이템 개수
    private Criteria cri;
    
    public PagingDTO(Criteria cri, int totalItems) {

        this.cri = cri;
        this.totalItems = totalItems;

        this.endPageNum = (int) (Math.ceil(cri.getCurrentPageNum() / 10.0)) * 10;

        this.startPageNum = this.endPageNum - 9;

        int realEnd = (int) (Math.ceil((totalItems * 1.0) / cri.getItemsPerPage()));

        if (realEnd <= this.endPageNum) {
          this.endPageNum = realEnd;
        }

        this.hasPrev = this.startPageNum > 1;

        this.hasNext = this.endPageNum < realEnd;
      }
    
   


	

	
	
}