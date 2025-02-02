package com.kh.filoom.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Review {
	
	private int reviewId;
	private int userNo;
	private int movieNo;
	private String reviewTitle;
	private String reviewContent;
	private String reviewDate;
	private int score;
	private String movieTitle;
	private String fileCodename;
	private String imagePath;

}
