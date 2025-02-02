package com.kh.filoom.common.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.filoom.common.model.dao.AdminDao;
import com.kh.filoom.common.model.vo.Chart;
import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.Poster;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AdminDao adminDao;
	
	@Override
	public Chart adminListView() {

		return adminDao.adminListView(sqlSession);
	
	}

	@Override
	public Chart adminMovieList() {
		// TODO Auto-generated method stub
		return adminDao.adminMovieList(sqlSession);
	}

	@Override
	public Chart adminPlayingMovieList() {
		// TODO Auto-generated method stub
		return adminDao.adminPlayingMovieList(sqlSession);
	}

	@Override
	public Chart adminMemberCount() {
		// TODO Auto-generated method stub
		return adminDao.adminMemberCount(sqlSession);
	}

	@Override
	public Chart adminTotalInput() {
		// TODO Auto-generated method stub
		return adminDao.adminTotalInput(sqlSession);
	}

	@Override
	public Chart adminGenreCount() {
		// TODO Auto-generated method stub
		return adminDao.adminGenreCount(sqlSession);
	}

	@Override
	public Chart adminTodayInput() {
		// TODO Auto-generated method stub
		return adminDao.adminTodayInput(sqlSession);
	}

	
	// Main 관련 
	
	@Override
	public ArrayList<Movie> selectMovieMainMovieList() {
		// TODO Auto-generated method stub
		return adminDao.selectMovieMainMovieList(sqlSession);
	}

	@Override
	public ArrayList<Movie> seletMovieReview() {
		// TODO Auto-generated method stub
		return adminDao.seletMovieReview(sqlSession);
	}

	
	@Override
	public ArrayList<Poster> selectMovieReviewPoster() {
		// TODO Auto-generated method stub
		return null;//adminDao.selectMovieReviewPoster(sqlSession);
	}
	
	@Override
	public ArrayList<Movie> selectMovieMainList() {
		// TODO Auto-generated method stub
		return adminDao.selectMovieMainList(sqlSession);
	}


	


}
