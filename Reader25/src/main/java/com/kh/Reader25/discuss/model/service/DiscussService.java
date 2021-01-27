package com.kh.Reader25.discuss.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.vo.Discuss;
import com.kh.Reader25.discuss.model.vo.Reply;

public interface DiscussService {
	
	// 토론방 있는지 체크
	int getListCount(Map<String, Object> s);
	// 토론방 전체 리스트 검색
	ArrayList<Discuss> selectList(PageInfo pi, Map<String, Object> s);
	// 토론방 작성
	int insertDiscuss(Discuss d, Attachment at);
	// 상세페이지 게시판 검색
	Discuss selectDiscuss(int dNo);
	// 토론방 전체 페이지 파일 가져오기
	ArrayList<Attachment> selectatList();
	// 이미지 수정
	Attachment selectAt(int atcNo);
	// 토론방 수정
	int updateDiscuss(Discuss d);
	// 토론방 파일 수정
	int updateAtno(Attachment att, int atcno);
	// 토론방 삭제
	int deleteDiscuss(int dNo);
	// 댓글 추가
	int insertReply(Reply r);
	// 댓글 리스트 가져오기
	ArrayList<Reply> selectRList(Map<String, Integer> d);
	// 댓글 삭제
	int rDelete(Reply r);
	// 메인페이지(토론방) 리스트 불러오기기
	ArrayList<Discuss> discuss();
	// 댓글 수정시 찬성,반대,중립 변경이 있을시
	void changePCN(Map<String, Object> d);
	// 댓글 수정
	int rUpdate(Reply r);
	// 모든 토론방 검색
	ArrayList<Discuss> selectAllList();
	ArrayList<Discuss> discussd(int value);
	ArrayList<Discuss> discussw(int value);
	ArrayList<Discuss> discussm(int value);
}
