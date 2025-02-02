package com.kh.filoom.notice.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Notice {
	
	private int noticeNo; //	NOTICE_NO	NUMBER
	private String noticeTitle; //	NOTICE_TITLE	VARCHAR2(200 BYTE)
	private String noticeContent;				//	NOTICE_CONTENT	VARCHAR2(4000 BYTE)
	private String createDate;				//	CREATE_DATE	DATE
	private int  count;				//	COUNT	NUMBER
	private String status;				//	STATUS	VARCHAR2(1 BYTE)
	
	// 없지만 필요해서 추가
	private int prevNum; // 이전글의 글번호 
	private int nextNum; // 다음글의 글번호 
	private String prevTitle; // 이전글의 제목
	private String nextTitle; // 다음글의 제목
	
}
