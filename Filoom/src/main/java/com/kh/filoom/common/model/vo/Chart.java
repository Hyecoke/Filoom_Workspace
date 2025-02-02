package com.kh.filoom.common.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Chart {

	// 1. 월별 사용자 수 증가
	private int twoMonthLaterMemberCount;
	private int oneMonthLaterMemberCount;
	private int currentMonthMemberCount;
	private int oneMonthAfterMemberCount;
	private int twoMonthAfterMemberCount;
	
	// 2. 월 별 예매 수
	private int twoMonthLaterBookCount;
	private int oneMonthLaterBookCount;
	private int currnetMonthBookCount;
	private int oneMonthAfterBookCount;
	private int twoMonthAfterBookCount;
	
	// 3. 회원의 나이대
	private int teenager;
	private int twenty;
	private int thirty;
	private int fourty;
	private int fifty;
	private int sixty;
	
	// 4. 영화 장르별
	private int action;
	private int horror;
	private int romance;
	private int drama;
	private int documentary;
	private int animation;
	
	// 5. 등록된 영화 개수
	private int movieCount;
	
	// 6. 상영중인 영화 개수 
	private int playingMovieCount;
	
	// 7. 총 회원 수
	private int memberCount;
	
	// 8. 당일 매출 액
	private int totalInput;
	
	
	
}
