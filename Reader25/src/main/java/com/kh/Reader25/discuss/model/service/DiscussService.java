package com.kh.Reader25.discuss.model.service;

import java.util.ArrayList;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.discuss.model.vo.Discuss;

public interface DiscussService {
	
	// 토론방 있는지 체크
	int getListCount();
	// 토론방 전체 리스트 검색
	ArrayList<Discuss> selectList(PageInfo pi);
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

}
