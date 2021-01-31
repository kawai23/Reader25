package com.kh.Reader25.book.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.SearchCondition;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;

public interface BookService {
	
	int getListCount(int code);
	
	ArrayList<Book> selectList(PageInfo pi, int code);

	int getPayListCount();

	ArrayList<Pay> selectPayList(PageInfo pi);

	ArrayList<Book> selectBookList(PageInfo pi);

	Book selectBook(int b_no);

	int insertBook(Book book);

	int insertSB(ShoppingBasket sb);
	
	int MyBasketListCount(SearchCondition sc);

	ArrayList<ShoppingBasket> MyBasketList(SearchCondition sc, PageInfo pi);

	int myPayDelete(String[] lists);

	int updateBook(Book book);

	int deleteBook(int b_no);

	ArrayList<ShoppingBasket> selectSb(String userid);

	int myBasketDelete(String[] lists);

	int insertPay(Pay pay);

	ArrayList<Board> selectAutoBookList(SearchReview sr);

	int countUpdate(Book book);

	int selectPayNo();

	int updatePay(Integer integer);

	int updateSb(Map<String, Object> sb);

}
