package com.kh.Reader25.book.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.SearchCondition;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.book.model.dao.BookDAO;
import com.kh.Reader25.book.model.exception.BookException;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;

@Service("b_Service")
public class BookServiceImpl implements BookService{
	@Autowired 
	private BookDAO b_DAO;
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int getListCount(int code) {
		return b_DAO.getListCount(sqlSession, code);
	}
	
	@Override
	public ArrayList<Book> selectList(PageInfo pi, int code) {
		return b_DAO.selectList(sqlSession, pi, code);
	}

	@Override
	public int getPayListCount() {
		return b_DAO.getPayListCount(sqlSession);
	}

	@Override
	public ArrayList<Pay> selectPayList(PageInfo pi) {
		return b_DAO.selectPayList(sqlSession, pi);
	}

	@Override
	public ArrayList<Book> selectBookList(PageInfo pi) {
		return b_DAO.selectBookList(sqlSession, pi);
	}

	@Override
	public Book selectBook(int b_no) {
		return b_DAO.selectBook(sqlSession, b_no);
	}

	@Override
	public int insertBook(Book book) {
		return b_DAO.insertBook(sqlSession, book);
	
	}

	@Override
	public int insertSB(ShoppingBasket sb) {
		return b_DAO.insertSB(sqlSession, sb);
	}

	
	@Override
	public int MyBasketListCount(SearchCondition sc) {
		
		return b_DAO.MyBasketListCount(sqlSession, sc);
	}

	@Override
	public ArrayList<ShoppingBasket> MyBasketList(SearchCondition sc, PageInfo pi) {
		
		return b_DAO.myBasketList(sqlSession,sc,pi);
	}

	
	@Override
	public int myPayDelete(String[] lists) {
		
		return 0;
	}



	@Override
	public int updateBook(Book book) {
		return b_DAO.updateBook(sqlSession, book);
	}

	@Override
	public int deleteBook(int b_no) {
		return b_DAO.deleteBook(sqlSession, b_no);
	}


	@Override
	public ArrayList<ShoppingBasket> selectSb(String userid) {
		return b_DAO.selectSB(sqlSession, userid);
	}

	
	
	@Transactional
	@Override
	public int myBasketDelete(String[] lists) {
		
		int result = 0;

		for (String s : lists) {

			result += b_DAO.BasketDelete(sqlSession, s);

		}
		
		
		
		if (result != lists.length) {

			throw new BookException("북마크 삭제 실패");
		}
		
		return result;
	}

	@Override
	public int insertPay(Pay pay) {
		return b_DAO.insertPay(sqlSession, pay);
	}

	@Override
	public ArrayList<Board> selectAutoBookList(SearchReview sr) {
		return b_DAO.selectAutoBookList(sqlSession, sr);
	}

}
