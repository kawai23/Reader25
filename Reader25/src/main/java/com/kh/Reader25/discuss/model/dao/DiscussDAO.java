package com.kh.Reader25.discuss.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.discuss.model.vo.Reply;

@Repository("dDAO")
public class DiscussDAO {

	// 토론방 있는지 체크
	public int getListCount(SqlSessionTemplate sqlSession, Map<String, Object> s) {
		return sqlSession.selectOne("DiscussMapper.ListCount", s);
	}
	// 토론방 전체 리스트 검색
	public ArrayList<Discuss> selectList(SqlSessionTemplate sqlSession, PageInfo pi, Map<String, Object> s) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() -1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("DiscussMapper.selectList", s, rowBounds);
	}
	// 토론방 파일 저장
	public int insertDAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("DiscussMapper.insertDAttachment", at);
	}
	// 토론방 작성
	public int insertDiscuss(SqlSessionTemplate sqlSession, Discuss d) {
		return sqlSession.insert("DiscussMapper.insertDiscuss", d);
	}
	// 상세페이지 게시판 검색
	public Discuss selectDiscussDetail(SqlSessionTemplate sqlSession, int dNo) {
		return sqlSession.selectOne("DiscussMapper.selectDiscuss", dNo);
	}
	// 토론방 전체 페이지 파일 가져오기
	public ArrayList<Attachment> selectAtList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("DiscussMapper.selectAtList");
	}
	// 이미지 검색
	public Attachment selectAt(SqlSessionTemplate sqlSession, int atcNo) {
		return sqlSession.selectOne("DiscussMapper.selectAt", atcNo);
	}
	// 토론방 수정
	public int updateDiscuss(SqlSessionTemplate sqlSession, Discuss d) {
		return sqlSession.update("DiscussMapper.updateDiscuss", d);
	}
	// 토론방 파일 번호 수정
	public int updateAtno(SqlSessionTemplate sqlSession, Attachment att) {
		return sqlSession.update("DiscussMapper.updateAt", att);
	}
	// 토론방 삭제
	public int deleteDisucss(SqlSessionTemplate sqlSession, int dNo) {
		return sqlSession.update("DiscussMapper.deleteDiscuss", dNo);
	}
	// 댓글추가
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("DiscussMapper.insertReply", r);
	}
	// 댓글 리스트 가져오기
	public ArrayList<Reply> selectRList(SqlSessionTemplate sqlSession, Map<String, Integer> d) {
		return (ArrayList)sqlSession.selectList("DiscussMapper.selectRList", d);
	}
	// 댓글수 업데이트
	public int updateCount(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("DiscussMapper.updateCount", r);
	}
	// 댓글 삭제
	public int rDelete(SqlSessionTemplate sqlSession, int rNo) {
		return sqlSession.update("DiscussMapper.rDelete", rNo);
	}
	// 댓글 삭제후 토론방 댓글 수, 찬반수 줄임
	public int changeCount(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.update("DiscussMapper.changeCount", r);
	}
	
	public ArrayList<Discuss> discuss_d(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("DiscussMapper.discussD", null);
	}
}
