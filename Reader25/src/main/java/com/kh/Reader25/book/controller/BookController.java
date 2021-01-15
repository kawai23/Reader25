package com.kh.Reader25.book.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.Reader25.board.model.exception.BoardException;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.book.model.service.BookService;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.common.Pagination;


public class BookController {
	@Autowired
	private BookService b_Service;
	
	@RequestMapping("booktrade.tr")
	public ModelAndView bookTradeList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int code = 0;
		int listCount = b_Service.getListCount(code);
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Book> b_List = b_Service.selectList(pi, code);
		if(b_List != null) {
			mv.addObject("b_List", b_List)
				.addObject("pi", pi)
				.setViewName("noticeList");
		}else {
			throw new BoardException("책 거래 게시판 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	//관리자창 : 결제 내역 조회
	@RequestMapping("paylist.ad")
	public ModelAndView adminPayList(@RequestParam(value="page", required=false) Integer page,
									ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
//		int listCount = b_Service.getListCount
		return mv;
	}
}

