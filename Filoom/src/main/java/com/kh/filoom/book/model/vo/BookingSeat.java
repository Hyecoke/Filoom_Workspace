package com.kh.filoom.book.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class BookingSeat {

	private int bookingSeatNo;
	private Timestamp timeLimit;
	private int sseatNo;
	private int playingNo;
	private int bookNo;
	
	//추가 ??? 확인해보기
	private String status;
	private String seatId;
	
	private String seatNo;
	private String playTime;
	private int movieNo;
	private int screenNo;
	private int runtime;

	
	
	
	
	
	

}
