package com.kh.filoom.movie.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.Poster;
import com.kh.filoom.movie.model.vo.Review;

@Repository
public class MovieDao {

	public int checkVideoCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkVideoCount");
	}

	public int checkOpenedVideoCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkOpenedVideoCount");
	}

	public int checkNotOpenVideoCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkNotOpenVideoCount");
	}

	public ArrayList<Movie> selectBoxOffice(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.selectBoxOffice", cpage);
	}

	public ArrayList<Movie> selectNowPlaying(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.selectNowPlaying", cpage);
	}

	public ArrayList<Movie> listbyOpenedOrder(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyOpenedOrder", cpage);
	}
	
	public ArrayList<Movie> listbyName(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyName", cpage);
	}

	public ArrayList<Movie> listbyNamePlaying(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyNamePlaying", cpage);
	}
	
	/**
	 * 미개봉작의 개봉예정일 빠른 순 정렬
	 * ※ '개봉 예정작' 페이지의 기본 정렬 기준
	 * 제작일: 2024-12-18
	 * 제작자: 정원섭
	 * @param sqlSession - 접속용 객체
	 * @return
	 */
	public ArrayList<Movie> listbyOpenOrder(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyOpenOrder", cpage);
	}

	public ArrayList<Movie> listbyNamePre(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyNamePre", cpage);
	}

	public ArrayList<Movie> selectNow4(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.selectNow4");
	}

	public ArrayList<Movie> selectPre4(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.comingVerySoon");
	}

	public ArrayList<Movie> searchMovie(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		return (ArrayList) sqlSession.selectList("movieMapper.searchMovie", map);
	}

	public ArrayList<Movie> listbyCritics(SqlSessionTemplate sqlSession, int cpage) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.listbyCritics", cpage);
	}


	// === [사용자] 상세 페이지 ===
	public Movie showDetail(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.showDetail", movieNo);
	}

	
	public Poster showThumbnail(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.showThumbnail", movieNo);
	}
	
	public ArrayList<Poster> selectImageList(SqlSessionTemplate sqlSession, int movieNo) {
		return (ArrayList) sqlSession.selectList("movieMapper.selectImageList", movieNo);
	}
	
	// └ 좋아요 관련
	public int checkFavCount(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkFavCount", movieNo);
	}
	
	public int checkTaste(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkTaste", map);
	}

	public int likeThis(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("movieMapper.likeThis", map);
	}

	public int notLikeThis(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.delete("movieMapper.notLikeThis", map);
	}

	// ※ 리뷰 관련 기능은 하단 관리자 쪽 리뷰 관리와 같이 있음
	
	// === [관리자] 영화 관리 기능 ===
	public int addMovie(SqlSessionTemplate sqlSession, Movie m) {
		// TODO Auto-generated method stub
		/* int influence = */sqlSession.insert("movieMapper.addMovie", m);
		// System.out.println(influence);
		// 이건 영향을 받은 row 수가 나오기 때문에 0 또는 1만 나오는 게 맞음
		
		// 추가된 영화의 movieNo 리턴하기 (포스터 추가와 추가 실패시 되돌리는데 활용)
		return /*int movieNo = */m.getMovieNo();
	}

	// 영화 수정
	public int updateMovie(SqlSessionTemplate sqlSession, Movie m) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.updateMovie", m);
	}

	public int addPoster(SqlSessionTemplate sqlSession, Poster p) {
		return sqlSession.insert("movieMapper.addPoster", p);
	}
	
	public int undoAddMovie(SqlSessionTemplate sqlSession, int movieNo) {
		return sqlSession.delete("movieMapper.undoAddMovie", movieNo);
	}

	public Movie selectMovietoModify(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.selectMovietoModify", movieNo);
	}

	public ArrayList<Movie> adminMovieList(SqlSessionTemplate sqlSession, int isOpen) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.adminMovieList", isOpen);
	}

	public int changePoster(SqlSessionTemplate sqlSession, Poster p) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.changePoster", p);
	}

	public int deletePoster(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("movieMapper.deletePoster", movieNo);
	}

	public int deleteMovie(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.deleteMovie", movieNo);
	}

	public int togglePremiere(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.togglePremiere", map);
	}
	
	public ArrayList<Movie> showRunInfo(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.showRunInfo", movieNo);
	}

	public int checkRunCount(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkRunCount", movieNo);
	}

	public int newRunInfo(SqlSessionTemplate sqlSession, Movie m) {
		// TODO Auto-generated method stub
		return sqlSession.insert("movieMapper.newRunInfo", m);
	}

	public int checkScreen(SqlSessionTemplate sqlSession, int screenNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkScreen", screenNo);
	}
	
	/**
	 * @param sqlSession - DB 접속용 객체
	 * @param playingNo - 상영정보 ID
	 * @return
	 * 12/24 15:46 정원섭
	 */
	public int removeRunInfo(SqlSessionTemplate sqlSession, int playingNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.removeRunInfo", playingNo);
	}

	
	// === 리뷰 관련 기능 ===
	// 리뷰 수 체크 (사용자, 관리자 공통)
	public int checkReviewCount(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkReviewCount", movieNo);
	}

	// 리뷰 조회 (사용자, 관리자 쿼리 동일)
	public ArrayList<Review> selectReview(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return (ArrayList) sqlSession.selectList("movieMapper.selectReview", map);
	}

	public double checkAverage(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkAverage", movieNo);
	}

	public double checkEvalNo(SqlSessionTemplate sqlSession, int movieNo, int k) {
		// TODO Auto-generated method stub
		// double로 구하는 이유 : 리뷰 수로 나누면 double이 나와야 함
		HashMap<String, Integer> form = new HashMap<>();
		form.put("movieNo", movieNo);
		form.put("score", k);
		
		return sqlSession.selectOne("movieMapper.checkEvalNo", form);
	}

	public Movie checkMovieTitle(SqlSession sqlSession, int movieNo) {
		return sqlSession.selectOne("movieMapper.checkMovieTitle", movieNo);
	}

	public int checkUserReview(SqlSessionTemplate sqlSession, int userNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("movieMapper.checkUserReview", userNo);
	}

	public int writeReview(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.insert("movieMapper.writeReview", r);
	}
	
	public int checkRid(SqlSessionTemplate sqlSession, int userNo, int movieNo) {
		HashMap<String, Integer> form = new HashMap<>();
		form.put("userNo", userNo);
		form.put("movieNo", movieNo);
		return sqlSession.selectOne("movieMapper.checkRid", form);
	}
	
	public int updateReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.update("movieMapper.updateReview", r);
	}

	public int adminDeleteReview(SqlSessionTemplate sqlSession, int reviewId) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.adminDeleteReview", reviewId);
	}

	public int deleteReview(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("movieMapper.deleteReview", map);
	}

	

	

}
