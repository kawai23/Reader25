package com.kh.Reader25.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.board.model.vo.Liketo;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.SearchCate;
import com.kh.Reader25.board.model.vo.SearchCondition;

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

	public ArrayList<Board> selectAnotherReview(SqlSessionTemplate sqlSession, String book, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("boardMapper.selectAnotherReview", book, rowBounds);
	}

	public int getReListCount(SqlSessionTemplate sqlSession, String book) {
		return sqlSession.selectOne("boardMapper.getReListCount", book);
	}
	public int updateLike(SqlSessionTemplate sqlSession, int b_no) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateLike", b_no);
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

//	public ArrayList<Comments> selectCommentsList(SqlSessionTemplate sqlSession, HashMap<String, Object> hpage) {
//		PageInfo pi = ((PageInfo)hpage.get("pi"));
//		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
//		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
//		
//		int boardNo = (int)hpage.get("boardNo");
//		
//		HashMap<String, Object> page = new HashMap<String, Object>();
//		page.put("rowBounds", rowBounds);
//		page.put("boardNo", boardNo);
//		
//		return (ArrayList)sqlSession.selectList("boardMapper.selectCommentsList", null, rowBounds);
//	}



}
