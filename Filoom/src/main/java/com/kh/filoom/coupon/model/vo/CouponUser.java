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
public class CouponUser {

	private int couponNo;
	private int userNo;
	private int bookNo;
	private String couponUse;
	
	
	//추가 (형문)
	private String couponName;
	private Date couponExpDate;
	
	
	
}
