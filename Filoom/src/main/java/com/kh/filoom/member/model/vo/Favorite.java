package com.kh.filoom.member.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Favorite {
	
	private int movieNo;
	private String movieTitle;
	private String openDate;
	private String fileCodename;
	private String imagePath;

}
