package com.kh.filoom.coupon.model.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Coupon {

	//	COUPON_NO	NUMBER
	private int couponNo;
	//	COUPON_NAME	VARCHAR2(300 BYTE)
	private String couponName;
	//	COUPON_DATE	DATE
	private Date couponExpDate;
	//	COUPON_STATUS	VARCHAR2(1 BYTE)
	private String couponStatus;
	//	COUPON_LEVEL	NUMBER
	private int couponLevel;
	//	REF_ENO	NUMBER
	private int refEno;
	
	// 혜원추가
	private String couponUser;
	private int eventNo;
}
