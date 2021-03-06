
package com.kh.Reader25.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSessionManager;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.Reader25.board.model.dao.BoardDAO;
import com.kh.Reader25.board.model.exception.BoardException;
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

@Service("bService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO bDAO;
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getListCount(int code) {
		return bDAO.getListCount(sqlSession, code);
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi, int code) {
		return bDAO.selectList(sqlSession, pi, code);
	}

	@Override
	public int insertTIW(Board b) {
		// TODO Auto-generated method stub
		return bDAO.insertTIW(sqlSession, b);
	}

	@Override
	public int getTIWListCount() {
		// TODO Auto-generated method stub
		return bDAO.getTIWListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectTIWList(PageInfo pi) {
		// TODO Auto-generated method stub
		return bDAO.selectTIWList(sqlSession, pi);
	}

	@Override
	public Board selectTIWBoard(int boardNo) {
		int result = bDAO.addTIWReadCount(sqlSession, boardNo);

		Board b = null;
		if (result > 0) {
			b = bDAO.selectTIWBoard(sqlSession, boardNo);
		}

		return b;
	}

	@Override
	public int insertBoardAndFiles(Board b, ArrayList<Attachment> atList) {
		int result = bDAO.insertBoard(sqlSession, b);
		if (result > 0) {
			result = bDAO.insertAttachmentList(sqlSession, atList);
		}

		return result;
	}

	public Board selectupTIWBoard(int boardNo) {
		Board b = null;

		b = bDAO.selectTIWBoard(sqlSession, boardNo);

		return b;
	}

	@Override
	public int updateTIWBoard(Board b) {
		// TODO Auto-generated method stub
		return bDAO.updateTIWBoard(sqlSession, b);
	}

	@Override
	public int deleteTIWBoard(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.deleteTIWBoard(sqlSession, boardNo);
	}

	@Override
	public Board selectBoard(int boardNo) {
		Board b = null;
		// 1. 조회수 증가
		int result = bDAO.addReadCount(sqlSession, boardNo);
		if (result > 0) {
			b = bDAO.selectBoard(sqlSession, boardNo);
		}
		return b;
	}

	@Override
	public ArrayList<Attachment> selectAttachmentList(int boardNo) {
		return bDAO.selectAttachmentList(sqlSession, boardNo);
	}

	@Override
	public int findLike(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bDAO.findLike(sqlSession, map);
	}

	@Override
	public void deleteLike(Liketo like) {
		// TODO Auto-generated method stub

		bDAO.deleteLike(sqlSession, like);
	}

	@Override
	public void insertLike(Liketo like) {
		// TODO Auto-generated method stub
		bDAO.insertLike(sqlSession, like);

	}

	public ArrayList<Attachment> selectAttachmentTList(int atcCode) {
		return bDAO.selectAttachmentTList(sqlSession, atcCode);
	}

	@Override
	public int insertBoardAndFile(Board b, Attachment at) {
		int result = bDAO.insertBoard(sqlSession, b);
		if (result > 0) {
			result = bDAO.insertAttachment(sqlSession, at);
		}
		return result;
	}

	@Override
	public int insertComments(Comments c) {
		// TODO Auto-generated method stub
		return bDAO.insertComments(sqlSession, c);
	}

	@Override
	public int updateCount(Comments c) {
		// TODO Auto-generated method stub
		return bDAO.updateCount(sqlSession, c);
	}

	@Override
	public ArrayList<Comments> selectCommentsList(int bId) {
		// TODO Auto-generated method stub
		return bDAO.selectCommentsList(sqlSession, bId);
	}

	@Override
	public Attachment selectAttachment(int boardNo) {
		return bDAO.selectAttachment(sqlSession, boardNo);
	}

	@Override
	public ArrayList<Board> selectAnotherReview(String booktitle, PageInfo pi) {
		return bDAO.selectAnotherReview(sqlSession, booktitle, pi);
	}

	@Override
	public int getReListCount(String booktitle) {
		return bDAO.getReListCount(sqlSession, booktitle);
	}

	@Override
	public int updateLike(Liketo like) {
		// TODO Auto-generated method stub
		return bDAO.updateLike(sqlSession, like);
	}

	@Override
	public int getCommentListCount(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.getCommentListCount(sqlSession, boardNo);
	}

	@Override
	public int getSearchMyListCount(SearchCondition sc) {
		// TODO Auto-generated method stub
		return bDAO.getSearchMyListCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Board> SeachMyList(SearchCondition sc, PageInfo pi) {

		return bDAO.SeachMyList(sqlSession, sc, pi);
	}

	@Transactional
	@Override
	public int deletemBList(String[] lists) {

		int result = 0;

		for (String s : lists) {

			result += bDAO.deletemBList(sqlSession, s);

		}
		if (result != lists.length) {

			throw new BoardException("마이페이지 리스트 삭제 실패");
		}
		return result;
	}

	@Override
	public int getSearchTIWResultListCount(SearchCondition serchC) {
		// TODO Auto-generated method stub
		return bDAO.getSearchTIWResultListCount(sqlSession, serchC);
	}

	@Override
	public int getSearchCateResultListCount(SearchCate serCa) {
		// TODO Auto-generated method stub
		return bDAO.getSearchCateResultListCount(sqlSession, serCa);
	}

	@Override
	public ArrayList<Board> selectSearchCateResultList(SearchCate serCa, PageInfo pi) {
		// TODO Auto-generated method stub
		return bDAO.selectSearchCateResultList(sqlSession, serCa, pi);
	}

	@Override
	public Board selectBoardExceptAddCount(int boardNo) {
		return bDAO.selectBoard(sqlSession, boardNo);
	}

//	@Override
//	public ArrayList<Comments> selectCommentsList(HashMap<String, Object> hpage) {
//		// TODO Auto-generated method stub
//		return bDAO.selectCommentsList(sqlSession, hpage);
//	}
	@Override
	public ArrayList<Comments> selectAnotherComments(int boardNo, PageInfo pi1) {
		// TODO Auto-generated method stub
		return bDAO.selectAnotherComments(sqlSession, boardNo, pi1);
	}

	@Override
	public ArrayList<Board> selectSerchTIWResultList(SearchCondition serchC, PageInfo pi) {
		// TODO Auto-generated method stub
		return bDAO.selectSerchTIWResultList(sqlSession, serchC, pi);
	}

	@Override
	public int updateBoardAndFile(Board b, Attachment attachment) {
		int result = bDAO.updateBoard(sqlSession, b);
		if (result > 0) {
			result = bDAO.updateAttachment(sqlSession, attachment);
		}
		return result;
	}

	@Override
	public int deleteBoardAndFile(int boardNo) {

		int result = bDAO.deleteBoard(sqlSession, boardNo);
		if (result > 0) {
			result = bDAO.deleteAttachment(sqlSession, boardNo);
		}
		return result;
	}

	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	@Override
	public int getSearchReviewListCount(SearchReview sr) {
		return bDAO.getSearchReviewListCount(sqlSession, sr);
	}

	@Override
	public int insertIn(Board b) {
		// TODO Auto-generated method stub
		return bDAO.insertIn(sqlSession, b);
	}

	@Override
	public int seachBoardNo(Board b) {
		// TODO Auto-generated method stub
		return bDAO.seachBoardNo(sqlSession, b);
	}

	@Override

	public int getMyPayListCount(SearchCondition sc) {
		return bDAO.getMyPayListCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Pay> SeachMyPayList(SearchCondition sc, PageInfo pi) {
		return bDAO.SeachMyPayList(sqlSession, sc, pi);
	}

	public ArrayList<Board> selectSearchReviewList(SearchReview sr, PageInfo pi) {
		return bDAO.searchReviewList(sqlSession, sr, pi);
	}

	@Override
	public int getSortListCount(String sortValue) {
		return bDAO.getSortListCount(sqlSession, sortValue);
	}

	@Override
	public ArrayList<Board> selectSortList(String sortValue, PageInfo pi) {
		return bDAO.selectSortList(sqlSession, sortValue, pi);
	}

	@Override
	public int getSearchAndSortCount(HashMap<String, String> map) {
		return bDAO.getSearchAndSortCount(sqlSession, map);
	}

	@Override
	public ArrayList<Board> selectSearchSortList(HashMap<String, String> map, PageInfo pi) {
		return bDAO.selectSearchSortList(sqlSession, map, pi);
	}

	@Override
	public int insetFile(Attachment at) {
		// TODO Auto-generated method stub
		return bDAO.insetFile(sqlSession, at);
	}

	@Override
	public ArrayList<Comments> selectAdminCommentList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bDAO.selectAdminCommentList(sqlSession, map);
	}

	@Override
	public Board selectupInquiryBoard(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.selectupInquiryBoard(sqlSession, boardNo);
	}

	@Override
	public int updateInquiryBoard(Board b) {
		// TODO Auto-generated method stub
		return bDAO.updateInquiryBoard(sqlSession, b);
	}

	@Override
	public int deleteFile(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.deleteFile(sqlSession, boardNo);
	}

	@Override
	public int deleteInquiryBoard(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.deleteInquiryBoard(sqlSession, boardNo);
	}

	@Transactional
	@Override
	public int myPayDelete(String[] lists) {
		int result = 0;

		for (String s : lists) {

			result += bDAO.myPayDelete(sqlSession, s);

		}
		if (result != lists.length) {

			throw new BoardException("구매 리스트 삭제 실패");
		}
		return result;
	}

	@Override
	public int getuserCommentsListCount(HashMap<String, Object> umap) {
		// TODO Auto-generated method stub
		return bDAO.getuserCommentsListCount(sqlSession, umap);
	}

	@Override
	public ArrayList<Comments> selectuserComments(int boardNo, PageInfo pi0, String userId) {
		// TODO Auto-generated method stub
		return bDAO.selectuserComments(sqlSession, boardNo, pi0, userId);
	}

	@Override
	public ArrayList<Board> selectSearchTTitleListWriter(String userId) {
		// TODO Auto-generated method stub
		return bDAO.selectSearchTTitleListWriter(sqlSession, userId);
	}

	@Override

	public int MyLikeCount(SearchCondition sc) {
		return bDAO.MyLikeCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Board> MyLikeList(SearchCondition sc, PageInfo pi) {

		return bDAO.MyLikeList(sqlSession, sc, pi);
	}

	public ArrayList<Board> selectSearchTTitleListTitle(String bTitle) {
		// TODO Auto-generated method stub
		return bDAO.selectSearchTTitleListTitle(sqlSession, bTitle);
	}

	@Override
	public ArrayList<Board> selectSearchTTitleListContent(String bContent) {
		// TODO Auto-generated method stub
		return bDAO.selectSearchTTitleListContent(sqlSession, bContent);
	}

//	@Override
//	public ArrayList<Board> selectSearchTTitleList(String bTitle) {
//		// TODO Auto-generated method stub
//		return bDAO.selectSearchTTitleList(sqlSession, bTitle);
//	}

//	@Override
//	public ArrayList<Board> selectSearchTTitleList(SearchCondition serchC) {
//		// TODO Auto-generated method stub
//		return bDAO.selectSearchTTitleList(sqlSession, serchC);
//	}

	public int updateBoardAnFiles(Board b, ArrayList<Attachment> uploadAtList) {
		int result = bDAO.updateBoard(sqlSession, b);
		if (result > 0) {
			result = bDAO.deleteAttachmentList(sqlSession, b.getBoardNo());
			result = bDAO.insertAttachmentList2(sqlSession, uploadAtList);
		}
		return result;
	}

	@Override
	public int updateBoard(Board b) {
		return bDAO.updateBoard(sqlSession, b);
	}

	@Override
	public int todayListCount(String enrollDay) {
		// TODO Auto-generated method stub
		return bDAO.todayListCount(sqlSession, enrollDay);
	}

	@Override
	public ArrayList<Board> review() {
		return bDAO.review(sqlSession);
	}

	@Transactional
	@Override
	public int myLikeDelete(String[] lists) {

		int result = 0;

		for (String s : lists) {

			result += bDAO.myLikeDelete(sqlSession, s);

		}
		if (result != lists.length) {

			throw new BoardException("좋아요  삭제 실패");
		}
		return result;
	}

	@Override
	public ArrayList<Board> tiw() {
		return bDAO.tiw(sqlSession);
	}

	@Override
	public ArrayList<Board> views() {
		return bDAO.views(sqlSession);
	}

	@Override
	public ArrayList<Comments> selectLComments(int comNo) {
		// TODO Auto-generated method stub
		return bDAO.selectLComments(sqlSession, comNo);
	}

	@Override
	public int updateComments(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bDAO.updateComments(sqlSession, map);
	}

	@Override
	public int deleteComments(String comNo) {
		// TODO Auto-generated method stub
		return bDAO.deleteComments(sqlSession, comNo);
	}

	@Override
	public int deleteCount(String boardNo) {
		// TODO Auto-generated method stub
		return bDAO.deleteCount(sqlSession, boardNo);
	}

	@Override
	public int upPoint(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bDAO.upPoint(sqlSession, map);
	}
	
	@Override
	public ArrayList<Board> recod(int value) {
		// TODO Auto-generated method stub
		return bDAO.recod(sqlSession, value);
	}
	@Override
	public ArrayList<Board> recow(int value) {
		// TODO Auto-generated method stub
		return bDAO.recow(sqlSession, value);
	}
	@Override
	public ArrayList<Board> recom(int value) {
		// TODO Auto-generated method stub
		return bDAO.recom(sqlSession, value);
	}
	@Override
	public ArrayList<Board> reviewd(int value) {
		// TODO Auto-generated method stub
		return bDAO.reviewd(sqlSession, value);
	}
	@Override
	public ArrayList<Board> revieww(int value) {
		// TODO Auto-generated method stub
		return bDAO.revieww(sqlSession, value);
	}
	@Override
	public ArrayList<Board> reviewm(int value) {
		// TODO Auto-generated method stub
		return bDAO.reviewm(sqlSession, value);
	}
	@Override
	public ArrayList<Board> tiwd(int value) {
		// TODO Auto-generated method stub
		return bDAO.tiwd(sqlSession, value);
	}
	@Override
	public ArrayList<Board> tiww(int value) {
		// TODO Auto-generated method stub
		return bDAO.tiww(sqlSession, value);
	}
	@Override
	public ArrayList<Board> tiwm(int value) {
		// TODO Auto-generated method stub
		return bDAO.tiwm(sqlSession, value);
	}
	@Override
	public ArrayList<String> searchLikeList(SearchCondition sc) {
		return bDAO.searchLikeList(sqlSession, sc);
	}
	
	@Override
	public ArrayList<TWITopWriter> topWriterList() {
		// TODO Auto-generated method stub
		return bDAO.topWriterList(sqlSession);
	}

	@Override
	public ArrayList<TWITopWriter> topCommenterList() {
		// TODO Auto-generated method stub
		return bDAO.topCommenterList(sqlSession);
	}

	@Override
	public ArrayList<TWITopWriter> topLikerList() {
		// TODO Auto-generated method stub
		return bDAO.topLikerList(sqlSession);

	}
	
	@Override
	public int updateBoardInsertFile(Board b, Attachment attachment) {
		int result = bDAO.updateBoard(sqlSession, b);
		if(result > 0) {
			result = bDAO.insertAttachmentBoardNo(sqlSession, attachment);
		}
		return result;
	}

	@Override
	public int MyPointListCount(SearchCondition sc) {





		return bDAO.MyPointListCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Point> MyPointList(SearchCondition sc, PageInfo pi) {
		return bDAO.MyPointList(sqlSession, sc, pi);
	}
	
	

	@Transactional
	@Override
	public int myPointDelete(String[] lists) {
		
		int result = 0;

		for (String s : lists) {

			result += bDAO.myPointDelete(sqlSession, s);

		}
		if (result != lists.length) {

			throw new BoardException("좋아요  삭제 실패");
		}
		return result;
	}

	@Override
	public ArrayList<Board> recd(int value) {
		
		return null;
	}

	@Override
	public int findsupport(HashMap<String, Object> sap) {
		// TODO Auto-generated method stub
		return bDAO.findsupport(sqlSession, sap);
	}

	@Override
	public int updateSupport(Support suppoint) {
		// TODO Auto-generated method stub
		return bDAO.updateSupport(sqlSession, suppoint);
	}

	@Override
	public int findbookmark(HashMap<String, Object> bap) {
		// TODO Auto-generated method stub
		return bDAO.findbookmark(sqlSession, bap);
	}

	@Override
	public void insertMark(Bookmarkto mark) {
		// TODO Auto-generated method stub
		bDAO.insertMark(sqlSession, mark);
	}

	@Override
	public void deleteMark(Bookmarkto mark) {
		// TODO Auto-generated method stub
		bDAO.deleteMark(sqlSession, mark);
	}

	@Override


	public int MyBookMarkCount(SearchCondition sc) {
		
		return bDAO.MyBookMarkCount(sqlSession, sc);
	}

	@Override
	public ArrayList<Bookmarkto> BookMarkList(SearchCondition sc, PageInfo pi) {
		
		return bDAO.BookMarkList(sqlSession, sc,pi);
	}

	@Transactional
	@Override
	public int myBookMarkDelete(String[] lists) {
		
		int result = 0;

		for (String s : lists) {

			result += bDAO.BookMarkDelete(sqlSession, s);

		}
		
		
		
		if (result != lists.length) {

			throw new BoardException("북마크 삭제 실패");
		}
		
		return result;
	}

	
	


	public ArrayList<Board> selectSearchBook(SearchReview sr, PageInfo pi) {
		return bDAO.selectSearchBook(sqlSession, sr, pi);
	}

	@Override
	public int getSearchAndSortCountBook(HashMap<String, String> map) {
		return bDAO.getSearchAndSortCountBook(sqlSession ,map);
	}

	@Override
	public ArrayList<Board> selectSearchSortBookList(HashMap<String, String> map, PageInfo pi) {
		return bDAO.selectSearchSortBookList(sqlSession, map, pi);
	}

	@Override
	public int getSortBookListCount(String sortValue) {
		return bDAO.getSortBookListCount(sqlSession, sortValue);
	}

	@Override
	public ArrayList<Board> selectSortBookList(String sortValue, PageInfo pi) {
		return bDAO.selectSortBookList(sqlSession, sortValue, pi);
	}
	
	@Override
	public Attachment selectAttachmentzero(int boardNo) {
		return bDAO.selectAttachmentzero(sqlSession, boardNo);
	}


	@Override
	public ArrayList<Board> selectBookList(PageInfo pi, int code) {
		return bDAO.selectBookList(sqlSession, pi, code);
	}

	@Override
	public int getSearchBookListCount(SearchReview sr) {
		return bDAO.getSearchBookListCount(sqlSession, sr);
	}

	@Override
	public String searchBookSendEmail(Integer boardNo) {
		// TODO Auto-generated method stub
		return bDAO.searchBookSendEmail(sqlSession, boardNo);
	}

	@Override
	public int AddPay(String payNo) {
		
		return bDAO.AddPay(sqlSession ,payNo);
	}

	@Override
	public int downPoint(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bDAO.downPoint(sqlSession ,map);
	}

	@Override
	public int searchAGrade(int boardNo) {
		// TODO Auto-generated method stub
		return bDAO.searchAGrade(sqlSession ,boardNo);
	}

	@Override
	public Board selectBoard2(Integer boardNo) {
		return bDAO.selectBoard(sqlSession, boardNo);
	}


	
	

}