package com.kh.filoom.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class History {
	
	private int bookNo;
	private int movieNo;
	private String movieTitle;
	private String playtime;
	private String screenName;
	private int totalTickets;
	private String fileCodename;
	private String imagePath;

}
