package com.kh.Reader25.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

@Repository("bDAO")
public class BoardDAO {

	public int getListCount(SqlSessionTemplate sqlSession, int code) {
		return sqlSession.selectOne("boardMapper.selectListCount", code);
	}

	public ArrayList<Board> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int code) {
		
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() -1); // 원래는 0부터 시작하는것을 1부터 시작하게끔 설정해주는 변수
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit()); //  RowBounds 는 올린 게시물에 낮은 번호 순서대로  입력해준다 
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", code, rowBounds);
	}

	public int insertTIW(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertTIW", b);
	}

	public int getTIWListCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.getTIWListCount");
	}

	public ArrayList<Board> selectTIWList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectTIWList", null, rowBounds);
	}

	public int addTIWReadCount(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.addTIWReadCount", boardNo);
	}

	public Board selectTIWBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.selectTIWBoard", boardNo);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int insertAttachmentList(SqlSessionTemplate sqlSession, ArrayList<Attachment> atList) {
		int result = 0;
		for(Attachment at: atList) {
			result += sqlSession.insert("boardMapper.insertAttachment", at);
		}
		if(result == atList.size()) {
			result = 1;
		}else {
			result = 0;
		}
		return result;
	}
	public int updateTIWBoard(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateTIWBoard", b);
	}

	public int deleteTIWBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.deleteTIWBoard", boardNo);
	}




	public int addReadCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.addReadCount", boardNo);
	}

	public Board selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}

	public ArrayList<Attachment> selectAttachmentList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectAttachmentList", boardNo);

	}
	
	
	public int getSearchMyListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		
		
		
		return sqlSession.selectOne("boardMapper.SearchMyListCount", sc);
		
	}

	public ArrayList<Board> SeachMyList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("boardMapper.SeachMyList",sc , rowBounds);
		
		
	}
	

	public int findLike(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
			
		return sqlSession.selectOne("boardMapper.findLike", map);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, Liketo like) {
		// TODO Auto-generated method stub
		return sqlSession.delete("boardMapper.deleteLike",like);
	}

	

	public int insertLike(SqlSessionTemplate sqlSession, Liketo like) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertLike",like);
	}

	public ArrayList<Attachment> selectAttachmentTList(SqlSessionTemplate sqlSession, int atcCode) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectAttachmentTList", atcCode);
	}

	public int insertAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("boardMapper.insertAttachment", at);

	}


	public int deletemBList(SqlSessionTemplate sqlSession, String s) {
		
		return sqlSession.update("boardMapper.deletemBList",s);
	}

//	public int findLike(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
//		String result = sqlSession.selectOne("boardMapper.findLike", map);
//		
//		int result2;
//		
//		if((result == null) || (result =='1')) {
//			result2 = 0;
//		} else {
//			result2 = 0;
//		}
//		
//		return result2;
//	}

	public int insertComments(SqlSessionTemplate sqlSession, Comments c) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertComments", c);
	}

	public int updateCount(SqlSessionTemplate sqlSession, Comments c) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateCount", c);
	}

	public ArrayList<Comments> selectCommentsList(SqlSessionTemplate sqlSession, int bId) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommentsList", bId);
	}

	public Attachment selectAttachment(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectAttachment", boardNo);
	}

	public ArrayList<Board> selectAnotherReview(SqlSessionTemplate sqlSession, String booktitle, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectAnotherReview", booktitle, rowBounds);
	}

	public int getReListCount(SqlSessionTemplate sqlSession, String booktitle) {
		return sqlSession.selectOne("boardMapper.getReListCount", booktitle);
	}
	
	public int updateLike(SqlSessionTemplate sqlSession, Liketo like) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateLike", like);
	}

	public int getCommentListCount(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.getCommentListCount", boardNo);
	}

	public int getSearchTIWResultListCount(SqlSessionTemplate sqlSession, SearchCondition serchC) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.getSearchTIWResultListCount", serchC);
	}

	public ArrayList<Board> selectSearchTIWResultList(SqlSessionTemplate sqlSession, SearchCondition serchC, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTIWResultList", serchC, rowBounds);
	}

	public int getSearchCateResultListCount(SqlSessionTemplate sqlSession, SearchCate serCa) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.getSearchCateResultListCount", serCa);
	}

	public ArrayList<Board> selectSearchCateResultList(SqlSessionTemplate sqlSession, SearchCate serCa, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchCateResultList", serCa, rowBounds);
	}

	public ArrayList<Board> selectSerchTIWResultList(SqlSessionTemplate sqlSession, SearchCondition serchC,
			PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSerchTIWResultList", serchC, rowBounds);
	}

	public ArrayList<Comments> selectAnotherComments(SqlSessionTemplate sqlSession, int boardNo, PageInfo pi1) {
		int offset = (pi1.getCurrentPage() - 1) * pi1.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi1.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectAnotherComments", boardNo, rowBounds);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.update("boardMapper.updateAttachment", attachment);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}

	public int deleteAttachment(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteAttachment", boardNo);
	}


	public int insertIn(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertIn", b);
	}


	public int seachBoardNo(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.seachBoardNo", b);
	}

	public int getSearchReviewListCount(SqlSessionTemplate sqlSession, SearchReview sr) {
		return sqlSession.selectOne("boardMapper.selectSearchReviewCount", sr);

	}


	public int getMyPayListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		
		return sqlSession.selectOne("boardMapper.MyPayListCount", sc);
	}

	public ArrayList<Pay> SeachMyPayList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("boardMapper.SeachMyPayList",sc , rowBounds);
	}

	public ArrayList<Board> searchReviewList(SqlSessionTemplate sqlSession, SearchReview sr, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.searchReviewList", sr, rowBounds);
	}

	public int getSortListCount(SqlSessionTemplate sqlSession, String sortValue) {
		return sqlSession.selectOne("boardMapper.getSortListCount", sortValue);
	}

	public ArrayList<Board> selectSortList(SqlSessionTemplate sqlSession, String sortValue, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSortList", sortValue, rowBounds);
	}

	public int getSearchAndSortCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("boardMapper.getSearchAndSortCount", map);
	}

	public ArrayList<Board> selectSearchSortList(SqlSessionTemplate sqlSession, HashMap<String, String> map,
			PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchSortList", map, rowBounds);
	}
	public int insetFile(SqlSessionTemplate sqlSession, Attachment at) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insetFile", at);
	}

	public ArrayList<Comments> selectAdminCommentList(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectAdminCommentList", map);
	}

	public Board selectupInquiryBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.selectupInquiryBoard", boardNo);
	}

	public int updateInquiryBoard(SqlSessionTemplate sqlSession, Board b) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateInquiryBoard", b);
	}

	public int deleteFile(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("boardMapper.deleteFile",boardNo);
	}

	public int deleteInquiryBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.deleteInquiryBoard", boardNo);
	}


	
	public int myPayDelete(SqlSessionTemplate sqlSession, String s) {
		return sqlSession.update("boardMapper.myPayDelete",s);
	}


	public int getuserCommentsListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> umap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.getuserCommentsListCount", umap);
	}

	public ArrayList<Comments> selectuserComments(SqlSessionTemplate sqlSession, int boardNo, PageInfo pi0,
			String userId) {
		int offset = (pi0.getCurrentPage() - 1)* pi0.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi0.getBoardLimit());
		
		HashMap<String, Object> smap = new HashMap<String, Object>();
		smap.put("boardNo", boardNo);
		smap.put("userId", userId);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectuserComments", smap, rowBounds);
	}


	public int MyLikeCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		
		
		return sqlSession.selectOne("boardMapper.MyLikeCount", sc);
	}

	public ArrayList<Board> MyLikeList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("boardMapper.MyLikeList",sc , rowBounds);
	}
	public ArrayList<Board> selectSearchTTitleListWriter(SqlSessionTemplate sqlSession, String userId) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTTitleListWriter", userId);
	}

	public ArrayList<Board> selectSearchTTitleListTitle(SqlSessionTemplate sqlSession, String bTitle) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTTitleListTitle", bTitle);
	}

	public ArrayList<Board> selectSearchTTitleListContent(SqlSessionTemplate sqlSession, String bContent) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTTitleListContent", bContent);
	}

//	public ArrayList<Board> selectSearchTTitleList(SqlSessionTemplate sqlSession, String bTitle) {
//		// TODO Auto-generated method stub
//		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTTitleList", bTitle);
//	}

//	public ArrayList<Board> selectSearchTTitleList(SqlSessionTemplate sqlSession, SearchCondition serchC) {
//		// TODO Auto-generated method stub
//		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchTTitleList", serchC);
//	}




	public int insertAttachmentList2(SqlSessionTemplate sqlSession, ArrayList<Attachment> uploadAtList) {
		int result = 0;
		for(int i = 0; i < uploadAtList.size(); i++) {
			result += sqlSession.insert("boardMapper.insertAttachment2", uploadAtList.get(i));
		}
		return result;
	}

	public int deleteAttachmentList(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteAttachment", boardNo);

	}

	public int myLikeDelete(SqlSessionTemplate sqlSession, String s) {
		
		
		
		return sqlSession.delete("boardMapper.myLikeDelete",s);
	}

	public int todayListCount(SqlSessionTemplate sqlSession, String enrollDay) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.todayListCount", enrollDay);
	}

	public ArrayList<Board> review(SqlSessionTemplate sqlSession) {
		ArrayList<Board> result = (ArrayList)sqlSession.selectList("boardMapper.selectTitleRD", null);
		return result; 
				
	}

	public ArrayList<Board> tiw(SqlSessionTemplate sqlSession) {
		ArrayList<Board> result = (ArrayList)sqlSession.selectList("boardMapper.selectTitleTD", null);
		return result;
	}

	public ArrayList<Board> views(SqlSessionTemplate sqlSession) {
		ArrayList<Board> result =(ArrayList)sqlSession.selectList("boardMapper.selectTitleVD", null);
		return result;
	}

	public ArrayList<String> searchLikeList(SqlSessionTemplate sqlSession, SearchCondition sc) {
		return (ArrayList)sqlSession.selectList("boardMapper.searchLikeList", sc);
	}


	public ArrayList<Comments> selectLComments(SqlSessionTemplate sqlSession, int comNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.selectLComments", comNo);
	}

	public int updateComments(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateComments", map);
	}

	public int deleteComments(SqlSessionTemplate sqlSession, String comNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("boardMapper.deleteComments", comNo);
	}

	public int deleteCount(SqlSessionTemplate sqlSession, String boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.deleteCount", boardNo);
	}


	

	public int upPoint(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.upPoint", map);
	}



	public int MyPointListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		return sqlSession.selectOne("boardMapper.MyPointListCount", sc);
	}

	public ArrayList<Point> MyPointList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("boardMapper.MyPointList",sc , rowBounds);
	}



	public ArrayList<Board> recod(SqlSessionTemplate sqlSession, int value) {


		return (ArrayList)sqlSession.selectList("boardMapper.recd", value);
	}

	public ArrayList<TWITopWriter> topWriterList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.topWriterList");
	}

	public ArrayList<TWITopWriter> topCommenterList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.topCommenterList");
	}

	public ArrayList<TWITopWriter> topLikerList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("boardMapper.topLikerList");

	}

	public int myPointDelete(SqlSessionTemplate sqlSession, String s) {
		
		return sqlSession.delete("boardMapper.myPointDelete",s);
	}

	public int insertAttachmentBoardNo(SqlSessionTemplate sqlSession, Attachment attachment) {
		return sqlSession.insert("boardMapper.insertAttachment2", attachment);
	}

	public int findsupport(SqlSessionTemplate sqlSession, HashMap<String, Object> sap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.findsupport", sap);
	}

	public int updateSupport(SqlSessionTemplate sqlSession, Support suppoint) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.updateSupport", suppoint);
	}

	public int findbookmark(SqlSessionTemplate sqlSession, HashMap<String, Object> bap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.findbookmark", bap);
	}

	public void insertMark(SqlSessionTemplate sqlSession, Bookmarkto mark) {
		// TODO Auto-generated method stub
		sqlSession.insert("boardMapper.insertMark", mark);
	}

	public void deleteMark(SqlSessionTemplate sqlSession, Bookmarkto mark) {
		// TODO Auto-generated method stub
		sqlSession.delete("boardMapper.deleteMark",mark);
	}


	public int MyBookMarkCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		
		return sqlSession.selectOne("boardMapper.MyBookMarkCount", sc);
	}

	public ArrayList<Bookmarkto> BookMarkList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("boardMapper.BookMarkList",sc , rowBounds);
	}


	public ArrayList<Board> recow(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.recw", value);
	}

	public ArrayList<Board> recom(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.recm", value);
	}

	public ArrayList<Board> reviewd(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.reviewd", value);
	}

	public ArrayList<Board> revieww(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.revieww", value);
	}

	public ArrayList<Board> reviewm(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.reviewm", value);
	}

	public ArrayList<Board> tiwd(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.tiwd", value);
	}

	public ArrayList<Board> tiww(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.tiww", value);
	}

	public ArrayList<Board> tiwm(SqlSessionTemplate sqlSession, int value) {
		return (ArrayList)sqlSession.selectList("boardMapper.tiwm", value);
	}



	public int BookMarkDelete(SqlSessionTemplate sqlSession, String s) {
		
		return sqlSession.delete("boardMapper.BookMarkDelete",s);

	}


	public ArrayList<Board> selectSearchBook(SqlSessionTemplate sqlSession, SearchReview sr, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.searchBook", sr, rowBounds);
	}

	public int getSearchAndSortCountBook(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("boardMapper.getSearchAndSortCountBook", map);
	}

	public ArrayList<Board> selectSearchSortBookList(SqlSessionTemplate sqlSession, HashMap<String, String> map,
			PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSearchSortBookList", map, rowBounds);
	}

	public int getSortBookListCount(SqlSessionTemplate sqlSession, String sortValue) {
		return sqlSession.selectOne("boardMapper.getSortBookListCount", sortValue);
	}

	public ArrayList<Board> selectSortBookList(SqlSessionTemplate sqlSession, String sortValue, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectSortBookList", sortValue, rowBounds);
	}

	public Attachment selectAttachmentzero(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectAttachmentzero", boardNo);
	}

	public ArrayList<Board> selectBookList(SqlSessionTemplate sqlSession, PageInfo pi, int code) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectBookList", code, rowBounds);
	}









}
