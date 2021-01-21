package com.kh.Reader25.book.model.service;

import java.util.ArrayList;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.book.model.vo.Book;

public interface BookService {
	
	int getListCount(int code);
	
	ArrayList<Book> selectList(PageInfo pi, int code);

	int getPayListCount();

	ArrayList<Pay> selectPayList(PageInfo pi);

	ArrayList<Book> selectBookList(PageInfo pi);

	Book selectBook(int b_no);


}
