package com.kh.filoom.movie.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Review {
	
	// Fields
	private int reviewId; // REVIEW_ID
	private int userNo; // USER_NO
	private int movieNo; // MOVIE_NO
	private String reviewTitle; // REVIEW_TITLE VARCHAR2(200)
	private Date reviewDate; // REVIEW_DATE
	private int score; // SCORE
	private String isWatched; // IS_WATCHED CHAR(1)
	private String reviewContent; // REVIEW_CONTENT VARCHAR2(2000)
	private String isDeleted; // IS_DELETED CHAR(1)
	
	// 추가 필드
	private String userId; // USER_ID (from MEMBER)
}
