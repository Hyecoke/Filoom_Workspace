package com.kh.filoom.movie.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Poster {
//	IMAGE_ID	NUMBER
//	MOVIE_NO	NUMBER
//	FILE_NAME	VARCHAR2(1000 BYTE)
//	FILE_CODENAME	VARCHAR2(1000 BYTE)
//	IMAGE_PATH	VARCHAR2(1000 BYTE)
//	UPLOAD_DATE	DATE
//	FILE_LEVEL	NUMBER
//	STATUS	CHAR(1 BYTE)
	private int imageId;
	private int movieNo;
	private String fileName;
	private String fileCodename;
	private String imagePath;
	private String uploadDate;
	private int fileLevel;
	private String status;
}
