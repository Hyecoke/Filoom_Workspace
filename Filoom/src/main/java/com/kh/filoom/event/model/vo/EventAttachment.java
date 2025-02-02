package com.kh.filoom.event.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor
@Setter
@Getter
@ToString
public class EventAttachment {

	private int eventFileNo; 	//	EVENT_FILE_NO	NUMBER
	private int refEno;			//	REF_ENO	NUMBER
	private String originName;	//	ORIGIN_NAME	VARCHAR2(300 BYTE)
	private String changeName;	//	CHANGE_NAME	VARCHAR2(300 BYTE)
	private String filePath;	//	FILE_PATH	VARCHAR2(1000 BYTE)
	private String uploadDate;	//	UPLOAD_DATE	DATE
	private String status;		//	STATUS	VARCHAR2(1 BYTE)
	private int fileLevel;		//	FILE_LEVEL	NUMBER - 1 썸네일, 2 기본
}
