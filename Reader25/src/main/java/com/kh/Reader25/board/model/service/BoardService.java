package com.kh.Reader25.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Bookmarkto;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.board.model.vo.Liketo;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.Point;
import com.kh.Reader25.board.model.vo.SearchCate;
import com.kh.Reader25.board.model.vo.SearchCondition;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.board.model.vo.Support;
import com.kh.Reader25.board.model.vo.TWITopWriter;
import com.kh.Reader25.book.model.vo.ShoppingBasket;
import com.kh.Reader25.discuss.model.vo.Discuss;

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


	int getSearchMyListCount(SearchCondition sc);

	Board selectBoard(int boardNo);

	ArrayList<Attachment> selectAttachmentList(int boardNo);



	ArrayList<Board> SeachMyList(SearchCondition sc, PageInfo pi);



	int findLike(HashMap<String, Object> map);

	void deleteLike(Liketo like);

	void insertLike(Liketo like);

	ArrayList<Attachment> selectAttachmentTList(int atcCode);

	int insertBoardAndFile(Board b, Attachment at);


	int deletemBList(String[] lists);

	int insertComments(Comments c);

	int updateCount(Comments c);

	ArrayList<Comments> selectCommentsList(int bId);

	Attachment selectAttachment(int boardNo);

	int getReListCount(String booktitle);

	ArrayList<Board> selectAnotherReview(String booktitle, PageInfo pi);

	int updateLike(Liketo like);

	int getCommentListCount(int boardNo);

	int getSearchTIWResultListCount(SearchCondition serchC);

	ArrayList<Board> selectSerchTIWResultList(SearchCondition serchC, PageInfo pi);

	int getSearchCateResultListCount(SearchCate serCa);

	ArrayList<Board> selectSearchCateResultList(SearchCate serCa, PageInfo pi);

	Board selectBoardExceptAddCount(int boardNo);

	//ArrayList<Comments> selectCommentsList(HashMap<String, Object> hpage);


	ArrayList<Comments> selectAnotherComments(int boardNo, PageInfo pi1);

	int updateBoardAndFile(Board b, Attachment attachment);

	int deleteBoardAndFile(int boardNo);


	int insertIn(Board b);

	int insetFile(Attachment at);

	int seachBoardNo(Board b);

	int insertBoard(Board b);

	int getSearchReviewListCount(SearchReview sr);


	int getMyPayListCount(SearchCondition sc);

	ArrayList<Pay> SeachMyPayList(SearchCondition sc, PageInfo pi);

	ArrayList<Board> selectSearchReviewList(SearchReview sr, PageInfo pi);

	int getSortListCount(String sortValue);

	ArrayList<Board> selectSortList(String sortValue, PageInfo pi);

	int getSearchAndSortCount(HashMap<String, String> map);

	ArrayList<Board> selectSearchSortList(HashMap<String, String> map, PageInfo pi);
	
	ArrayList<Comments> selectAdminCommentList(HashMap<String, Object> map);

	Board selectupInquiryBoard(int boardNo);

	int updateInquiryBoard(Board b);

	int deleteFile(int boardNo);

	int deleteInquiryBoard(int boardNo);


	int myPayDelete(String[] lists);



	int getuserCommentsListCount(HashMap<String, Object> umap);

	ArrayList<Comments> selectuserComments(int boardNo, PageInfo pi0, String userId);

	ArrayList<Board> selectSearchTTitleListWriter(String userId);

	ArrayList<Board> selectSearchTTitleListTitle(String bTitle);

	ArrayList<Board> selectSearchTTitleListContent(String bContent);

	//ArrayList<Board> selectSearchTTitleList(String bTitle);

	//ArrayList<Board> selectSearchTTitleList(SearchCondition serchC);

	




	int updateBoardAnFiles(Board b, ArrayList<Attachment> uploadAtList);

	int updateBoard(Board b);


	int MyLikeCount(SearchCondition sc);

	ArrayList<Board> MyLikeList(SearchCondition sc, PageInfo pi);

	int myLikeDelete(String[] lists);

	int todayListCount(String enrollDay);

	ArrayList<Board> review();

	ArrayList<Board> tiw();



	ArrayList<Comments> selectLComments(int comNo);

	int updateComments(HashMap<String, Object> map);

	int deleteComments(String comNo);

	int deleteCount(String boardNo);


	ArrayList<Board> views();
	

	int upPoint(HashMap<String, Object> map);



	ArrayList<String> searchLikeList(SearchCondition sc);

	int MyPointListCount(SearchCondition sc);

	ArrayList<Point> MyPointList(SearchCondition sc, PageInfo pi);

	ArrayList<Board> recd(int value);

	ArrayList<Board> recod(int value);


	ArrayList<TWITopWriter> topWriterList();

	ArrayList<TWITopWriter> topCommenterList();

	ArrayList<TWITopWriter> topLikerList();


	int myPointDelete(String[] lists);

	int updateBoardInsertFile(Board b, Attachment attachment);

	int findsupport(HashMap<String, Object> sap);

	int updateSupport(Support suppoint);

	int findbookmark(HashMap<String, Object> bap);

	void insertMark(Bookmarkto mark);

	void deleteMark(Bookmarkto mark);


	int MyBookMarkCount(SearchCondition sc);

	ArrayList<Bookmarkto> BookMarkList(SearchCondition sc, PageInfo pi);



	ArrayList<Board> recow(int value);

	ArrayList<Board> recom(int value);

	ArrayList<Board> reviewd(int value);

	ArrayList<Board> revieww(int value);

	ArrayList<Board> reviewm(int value);

	ArrayList<Board> tiww(int value);

	ArrayList<Board> tiwm(int value);

	ArrayList<Board> tiwd(int value);



	int myBookMarkDelete(String[] lists);



	ArrayList<Board> selectSearchBook(SearchReview sr, PageInfo pi);

	int getSearchAndSortCountBook(HashMap<String, String> map);

	ArrayList<Board> selectSearchSortBookList(HashMap<String, String> map, PageInfo pi);

	int getSortBookListCount(String sortValue);

	ArrayList<Board> selectSortBookList(String sortValue, PageInfo pi);
	

	Attachment selectAttachmentzero(int boardNo);

	ArrayList<Board> selectBookList(PageInfo pi, int code);

	int getSearchBookListCount(SearchReview sr);











	
}
