package com.kh.filoom.movie.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class MovieWithPoster {
	private int movieNo;
    private String movieTitle;
    private String description;
    private Poster poster;
}
