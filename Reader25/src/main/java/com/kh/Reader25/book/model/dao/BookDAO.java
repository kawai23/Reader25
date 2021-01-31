package com.kh.Reader25.book.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.SearchCondition;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;

@Repository("b_DAO")
public class BookDAO {
	public int getListCount(SqlSessionTemplate sqlSession, int code) {
		return sqlSession.selectOne("boardMapper.selectListCount", code);
	}

	public ArrayList<Book> selectList(SqlSessionTemplate sqlSession, PageInfo pi, int code) {
		int offset = pi.getBoardLimit() * (pi.getCurrentPage() -1);
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bookMapper.selectList", code, rowBounds);
	}

	public int getPayListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("bookMapper.getPayList");
	}

	public ArrayList<Pay> selectPayList(SqlSessionTemplate sqlSession,PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bookMapper.selectPayList", null, rowBounds);
	}

	public ArrayList<Book> selectBookList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("bookMapper.selectBookList", null, rowBounds);
	}

	public Book selectBook(SqlSessionTemplate sqlSession, int b_no) {
		return sqlSession.selectOne("bookMapper.selectBook", b_no);
	}
	public int insertBook(SqlSessionTemplate sqlSession, Book book) {
		
		return sqlSession.insert("bookMapper.insertBook", book);
	}

	public int insertSB(SqlSessionTemplate sqlSession, ShoppingBasket sb) {
		return sqlSession.insert("bookMapper.insertsb", sb);
	}

	
	public int MyBasketListCount(SqlSessionTemplate sqlSession, SearchCondition sc) {
		
		
		return sqlSession.selectOne("bookMapper.MyBasketListCount", sc);
	}

	public ArrayList<ShoppingBasket> myBasketList(SqlSessionTemplate sqlSession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit(); 
		
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		
		return  (ArrayList)sqlSession.selectList("bookMapper.MyBasketList",sc , rowBounds);
	}



	public int updateBook(SqlSessionTemplate sqlSession, Book book) {
		return sqlSession.update("bookMapper.updateBook", book);
	}

	public int deleteBook(SqlSessionTemplate sqlSession, int b_no) {
		return sqlSession.update("bookMapper.deleteBook", b_no);
	}


	public ArrayList<ShoppingBasket> selectSB(SqlSessionTemplate sqlSession, String userid) {
		return (ArrayList)sqlSession.selectList("bookMapper.selectSB", userid);
	}

	public int BasketDelete(SqlSessionTemplate sqlSession, String s) {
		
		
		return sqlSession.delete("bookMapper.BasketDelete",s);
	}

	public int insertPay(SqlSessionTemplate sqlSession, Pay pay) {
		return sqlSession.insert("bookMapper.insertPay", pay);
	}

	public ArrayList<Board> selectAutoBookList(SqlSessionTemplate sqlSession, SearchReview sr) {
		return (ArrayList)sqlSession.selectList("bookMapper.selectAutoBookList", sr);
	}

	public int countUpdate(SqlSessionTemplate sqlSession, Book book) {
		return sqlSession.update("bookMapper.countUpdate", book);
	}

	public int selectPayNo(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("bookMapper.selectPayNo");
	}

	public int updatePay(SqlSessionTemplate sqlSession, Integer p_no) {
		return sqlSession.update("bookMapper.updatePay", p_no);
	}

	public int updateSb(SqlSessionTemplate sqlSession, Map<String, Object> sb) {
		return sqlSession.update("bookMapper.updateSb", sb);
	}

}
