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
public class Playing {

	private int playingNo;
	private java.sql.Timestamp playTime;
	private String status;
	private int movieNo;
	private int screenNo;
	
	//추가	
	private int runtime;
	private int screenCapacity;
	private int occupiedSeats;
	
	private String screenName;
	private int sseatNo;
	private String seatNo;
	private Date timeLimit;
	private String movieTitle;
	
	
	
	
}

