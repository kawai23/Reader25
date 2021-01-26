package com.kh.Reader25.discuss.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.dao.DiscussDAO;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.discuss.model.vo.Reply;

@Service("dService")
public class DiscussServiceImpl  implements DiscussService{

	@Autowired
	private DiscussDAO dDAO; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 토론방 있는지 체크
	@Override
	public int getListCount(Map<String, Object> s) {
		return dDAO.getListCount(sqlSession, s);
	}
	// 토론방 전체 리스트 검색
	@Override
	public ArrayList<Discuss> selectList(PageInfo pi, Map<String, Object> s) {
		return dDAO.selectList(sqlSession, pi, s);
	}
	// 토론방 작성
	@Override
	public int insertDiscuss(Discuss d, Attachment at) {
		int result = 1;
		if(at != null) {
			result = dDAO.insertDAttachment(sqlSession, at);
		}
		if(result > 0) {
			result = dDAO.insertDiscuss(sqlSession, d);
		}
		return result;
	}
	// 상세페이지 게시판 검색
	@Override
	public Discuss selectDiscuss(int dNo) {
		return dDAO.selectDiscussDetail(sqlSession, dNo);
	}
	// 토론방 전체 페이지 파일 가져오기
	@Override
	public ArrayList<Attachment> selectatList() {
		return dDAO.selectAtList(sqlSession);
	}
	// 이미지 검색
	@Override
	public Attachment selectAt(int atcNo) {
		return dDAO.selectAt(sqlSession, atcNo);
	}
	// 토론방 수정
	@Override
	public int updateDiscuss(Discuss d) {
		return dDAO.updateDiscuss(sqlSession, d);
	}
	// 토론방 파일 수정
	@Override
	public int updateAtno(Attachment att, int no) {
		int result = 0;
		if(no > 0) {
			result = dDAO.updateAtno(sqlSession, att);
		} else {
			result = dDAO.insertDAttachment(sqlSession, att);
		}
		return result;
	}
	// 토론방 삭제
	@Override
	public int deleteDiscuss(int dNo) {
		return dDAO.deleteDisucss(sqlSession, dNo);
	}
	
	// 댓글 추가
	@Override
	public int insertReply(Reply r) {
		int result = dDAO.updateCount(sqlSession, r);
		if(result > 0 ) {
			return dDAO.insertReply(sqlSession, r);
		}
		return 0;
	}
	// 댓글 리스트불러오기
	@Override
	public ArrayList<Reply> selectRList(Map<String, Integer> d) {
		return dDAO.selectRList(sqlSession,d);
	}
	
	// 댓글 삭제
	@Override
	public int rDelete(Reply r) {
		int result = dDAO.rDelete(sqlSession, r.getrNo());
		
		if(result > 0) {
			result = dDAO.changeCount(sqlSession, r);
		}
		return result;
	}
	// 메인페이지(토론방) 리스트 불러오기기
	@Override
	public ArrayList<Discuss> discuss() {
		return dDAO.discuss(sqlSession);
	}
	
	// 댓글 수정시 찬성,반대,중립 변경이 있을시
	@Override
	public void changePCN(Map<String, Object> d) {
		dDAO.changePCN(sqlSession, d);
	}
	// 댓글 수정
	@Override
	public int rUpdate(Reply r) {
		return dDAO.rUpdate(sqlSession, r);
	}
	// 모든 토론방 검색
	@Override
	public ArrayList<Discuss> selectAllList() {
		return dDAO.selectAllList(sqlSession);
	}
	@Override
	public ArrayList<Discuss> discussd(int value) {
		return dDAO.discussd(sqlSession, value);
	}
	@Override
	public ArrayList<Discuss> discussw(int value) {
		return dDAO.discussw(sqlSession, value);
	}
	@Override
	public ArrayList<Discuss> discussm(int value) {
		return dDAO.discussm(sqlSession, value);
	}
}
