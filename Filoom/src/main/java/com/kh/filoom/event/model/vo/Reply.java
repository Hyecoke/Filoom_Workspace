package com.kh.filoom.event.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Reply {

	private int replyNo;			//	REPLY_NO	NUMBER
	private int refEno;				//	REF_ENO	NUMBER
	private String replyContent;	//	REPLY_CONTENT	VARCHAR2(4000 BYTE)
	private String replyWriter;		//	REPLY_WRITER	NUMBER
	private String createDate;		//	CREATE_DATE	DATE
	private String status;			//	STATUS	VARCHAR2(1 BYTE)
	private String drawingStatus; 
	private String winStatus; // 테이블에는 없지만 필요해서 가져온거 
}
