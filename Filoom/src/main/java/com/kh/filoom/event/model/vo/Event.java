package com.kh.filoom.event.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Event {

	private int eventNo;			//	EVENT_NO	NUMBER
	private String eventTitle;		//	EVENT_TITLE	VARCHAR2(200 BYTE)
	private String eventContent;	//	EVENT_CONTENT	VARCHAR2(4000 BYTE)
	private String startDate;		//	START_DATE	DATE
	private String endDate;			//	END_DATE	DATE
	private String status;			//	STATUS	VARCHAR2(1 BYTE)
	private String eventStatus;		//	EVENT_STATUS	VARCHAR2(1 BYTE)
	private int eventType;			//	EVENT_TYPE	NUMBER
	
	// 실제 Event 테이블에 없는 컬럼이지만 필드로 추가 하여 썸네일 이미지 경로와 수정파일명 담을 필드 
	private String contentImg1; 
	

	
	public String getContentImg1() {
		return contentImg1;
	}
	
	public void setContentImg1(String contentImg1) {
		this.contentImg1 = contentImg1;
	}
	
	
}
