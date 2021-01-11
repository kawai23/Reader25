package com.kh.Reader25.discuss.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.dao.DiscussDAO;
import com.kh.Reader25.discuss.model.vo.Discuss;

@Service("dService")
public class DiscussServiceImpl  implements DiscussService{

	@Autowired
	private DiscussDAO dDAO; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 토론방 있는지 체크
	@Override
	public int getListCount() {
		return dDAO.getListCount(sqlSession);
	}
	// 토론방 전체 리스트 검색
	@Override
	public ArrayList<Discuss> selectList(PageInfo pi) {
		return dDAO.selectList(sqlSession, pi);
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
	// 이미지 수정
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

}
