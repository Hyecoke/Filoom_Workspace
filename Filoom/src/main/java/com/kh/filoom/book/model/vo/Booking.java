package com.kh.filoom.book.model.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Booking {

	private int bookNo;
	private int userNo;
	private String bookDate;
	private int bookTotalCost;
	private int bookCost;
	private String costProcess;
	private String costTid;
	private String status;
	private String modifyDate;
	
	//예매내역페이지에 뿌려주기 위해 필요한 데이터들
	private String userId;
	private String userName;
	private String playTime;
	
}

