
package com.kh.Reader25.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.Reader25.board.model.dao.BoardDAO;
import com.kh.Reader25.board.model.exception.BoardException;
import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.board.model.vo.Liketo;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.SearchCate;
import com.kh.Reader25.board.model.vo.SearchCondition;

@Service("bService")
public class BoardServiceImpl implements BoardService{
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
		if(result > 0) {
			b = bDAO.selectTIWBoard(sqlSession, boardNo);
		}
		
		return b;
	}

	@Override
	public int insertBoardAndFiles(Board b, ArrayList<Attachment> atList) {
		int result = bDAO.insertBoard(sqlSession, b);
		if(result > 0) {
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
		if(result > 0) {
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
		if(result > 0) {
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
	public ArrayList<Board> selectAnotherReview(String book, PageInfo pi) {
		return bDAO.selectAnotherReview(sqlSession, book, pi);
	}

	@Override
	public int getReListCount(String book) {
		return bDAO.getReListCount(sqlSession, book);
	}
	@Override
	public int updateLike(Liketo like) {
		// TODO Auto-generated method stub
		return bDAO.updateLike(sqlSession, like.getB_no());
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
		
		return bDAO.SeachMyList(sqlSession,sc, pi);
	}
	
	
	@Transactional
	@Override
	public int deletemBList(String[] lists) {
		
		
		int result = 0;
		
		for(String s: lists) {			
			
			result += bDAO.deletemBList(sqlSession, s);

		}
		if(result != lists.length) {
			
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
		if(result > 0) {
			result = bDAO.updateAttachment(sqlSession, attachment);
			System.out.println(result);
		}
		return result;
	}

	@Override
	public int deleteBoardAndFile(int boardNo) {
		
		int result = bDAO.deleteBoard(sqlSession, boardNo);
		if(result > 0) {
			Attachment at = bDAO.selectAttachment(sqlSession, boardNo);
			if(at != null) {
				result = bDAO.deleteAttachment(sqlSession, boardNo);
			}
		}
		return result;
	}
	@Override
	public int insertBoard(Board b) {
		return bDAO.insertBoard(sqlSession, b);
	}

	
}