package com.kh.Reader25.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.board.model.vo.Liketo;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.SearchCate;
import com.kh.Reader25.board.model.vo.SearchCondition;

public interface BoardService {

	int getListCount(int code);

	ArrayList<Board> selectList(PageInfo pi, int code);

	int insertTIW(Board b);

	int getTIWListCount();

	ArrayList<Board> selectTIWList(PageInfo pi);

	Board selectTIWBoard(int boardNo);

	int insertBoardAndFiles(Board b, ArrayList<Attachment> atList);
	Board selectupTIWBoard(int boardNo);

	int updateTIWBoard(Board b);

	int deleteTIWBoard(int boardNo);

	Board selectBoard(int boardNo);

	ArrayList<Attachment> selectAttachmentList(int boardNo);

	int findLike(HashMap<String, Object> map);

	void deleteLike(Liketo like);

	void insertLike(Liketo like);

	ArrayList<Attachment> selectAttachmentTList(int atcCode);

	int insertBoardAndFile(Board b, Attachment at);

	int insertComments(Comments c);

	int updateCount(Comments c);

	ArrayList<Comments> selectCommentsList(int bId);

	Attachment selectAttachment(int boardNo);

	int getReListCount(String book);

	ArrayList<Board> selectAnotherReview(String book, PageInfo pi);

	int updateLike(Liketo like);

	int getCommentListCount(int boardNo);

	int getSearchTIWResultListCount(SearchCondition serchC);

	ArrayList<Board> selectSerchTIWResultList(SearchCondition serchC, PageInfo pi);

	int getSearchCateResultListCount(SearchCate serCa);

	ArrayList<Board> selectSearchCateResultList(SearchCate serCa, PageInfo pi);

	//ArrayList<Comments> selectCommentsList(HashMap<String, Object> hpage);





	
}
