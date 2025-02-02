package com.kh.filoom.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.member.model.vo.Coupon;
import com.kh.filoom.member.model.vo.Favorite;
import com.kh.filoom.member.model.vo.History;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.member.model.vo.Reserve;
import com.kh.filoom.member.model.vo.Review;

@Repository
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {

		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {

		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String userId) {

		return sqlSession.selectOne("memberMapper.idCheck", userId);
	}

	public int changePwd(SqlSessionTemplate sqlSession, Member loginUser) {

		return sqlSession.update("memberMapper.changePwd", loginUser);
	}

	public int changeName(SqlSessionTemplate sqlSession, Member loginUser) {

		return sqlSession.update("memberMapper.changeName", loginUser);
	}

	public int changeGender(SqlSessionTemplate sqlSession, Member loginUser) {

		return sqlSession.update("memberMapper.changeGender", loginUser);
	}

	public int changeBirth(SqlSessionTemplate sqlSession, Member loginUser) {

		return sqlSession.update("memberMapper.changeBirth", loginUser);
	}

	public int changeMarketing(SqlSessionTemplate sqlSession, Member loginUser) {

		return sqlSession.update("memberMapper.changeMarketing", loginUser);
	}

	public int withdrawMember(SqlSessionTemplate sqlSession, String userId) {

		return sqlSession.update("memberMapper.withdrawMember", userId);
	}

	public List<Reserve> reserveList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.reserveList", userNo);
	}

	public List<Reserve> cancelList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.cancelList", userNo);
	}

	public List<Reserve> useCouponList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.useCouponList", userNo);
	}

	public List<History> historyList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.historyList", userNo);
	}
	
	public List<History> historyListByYear(SqlSessionTemplate sqlSession, int userNo, String year) {
		
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("year", year);
	    return sqlSession.selectList("memberMapper.historyListByYear", params);
	}


	public String findUserId(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {

		return sqlSession.selectOne("memberMapper.findUserId", paramMap);
	}

	public String findUserPwd(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {

		return sqlSession.selectOne("memberMapper.findUserPwd", paramMap);
	}

	public int updateUserPwd(SqlSessionTemplate sqlSession, Map<String, String> paramMap) {

		return sqlSession.update("memberMapper.updateUserPwd", paramMap);
	}

	public List<Favorite> favoriteList(SqlSessionTemplate sqlSession, int userNo, String sort) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("sort", sort);

	    return sqlSession.selectList("memberMapper.favoriteList", params);
	}

	public int deleteFavorite(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {

		return sqlSession.delete("memberMapper.deleteFavorite", paramMap);
	}
	
	public int deleteHistorySeat(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {

		return sqlSession.delete("memberMapper.deleteHistorySeat", paramMap);
	}

	public int deleteHistory(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {

		return sqlSession.delete("memberMapper.deleteHistory", paramMap);
	}

	public int checkEmail(SqlSessionTemplate sqlSession, String email) {

		return sqlSession.selectOne("memberMapper.checkEmail", email);
	}
	
	public List<Coupon> couponList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.couponList", userNo);
	}
	
	public List<Review> reviewList(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectList("memberMapper.reviewList", userNo);
	}
	
	
	
	
	
	
	// 관리자

	public int selectListCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("memberMapper.selectListCount", sqlSession);
	}

	public ArrayList<Member> memberList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.memberList", null, rowBounds);
	}

	public int selectSearchListCount(SqlSessionTemplate sqlSession, String keyword) {
	    return sqlSession.selectOne("memberMapper.selectSearchListCount", keyword);
	}

	public ArrayList<Member> searchMemberList(SqlSessionTemplate sqlSession, PageInfo pi, String keyword) {
	    int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
	    int limit = pi.getBoardLimit();

	    RowBounds rowBounds = new RowBounds(offset, limit);

	    return (ArrayList) sqlSession.selectList("memberMapper.searchMemberList", keyword, rowBounds);
	}

	public int selectStatusListCount(SqlSessionTemplate sqlSession, String status) {
	    return sqlSession.selectOne("memberMapper.selectStatusListCount", status);
	}

	public ArrayList<Member> selectStatusMemberList(SqlSessionTemplate sqlSession, PageInfo pi, String status) {
	    int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
	    int limit = pi.getBoardLimit();

	    RowBounds rowBounds = new RowBounds(offset, limit);

	    return (ArrayList) sqlSession.selectList("memberMapper.selectStatusMemberList", status, rowBounds);
	}
	
	public int updateMemberStatus(SqlSessionTemplate sqlSession, int userNo, String status) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("status", status);
	    return sqlSession.update("memberMapper.updateMemberStatus", params);
	}

	

	



	

	

}
