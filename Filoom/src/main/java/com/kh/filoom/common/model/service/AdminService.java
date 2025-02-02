package com.kh.filoom.common.model.service;

import java.util.ArrayList;

import com.kh.filoom.common.model.vo.Chart;
import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.Poster;

public interface AdminService {

	Chart adminListView();
	
	Chart adminMovieList();
	
	Chart adminPlayingMovieList();
	
	Chart adminMemberCount();
	
	Chart adminTotalInput();
	
	Chart adminGenreCount();
	
	Chart adminTodayInput();
	
	ArrayList<Movie> selectMovieMainMovieList();
	
	ArrayList<Movie> seletMovieReview();
	
	ArrayList<Movie> selectMovieMainList();
	
	ArrayList<Poster> selectMovieReviewPoster();
}
