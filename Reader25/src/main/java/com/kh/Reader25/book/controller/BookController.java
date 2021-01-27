package com.kh.Reader25.book.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.book.model.exception.BookException;
import com.kh.Reader25.book.model.service.BookService;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;
import com.kh.Reader25.common.Pagination;

@Controller
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
			throw new BookException("책 거래 게시판 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	// 장바구니 인설트
	@RequestMapping("insertCart.tr")
	@ResponseBody
	public String insertSB(@ModelAttribute ShoppingBasket sb) {
		int result = b_Service.insertSB(sb);
		if(result < 0) {
			throw new BookException("장바구니 추가에 실패하였습니다.");
		} else {
			return "success";
		}
	}
	
	//관리자창 : 결제 내역 조회
	@RequestMapping("paylist.ad")
	public ModelAndView adminPayList(@RequestParam(value="page", required=false) Integer page,
									ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int listCount = b_Service.getPayListCount();
		PageInfo  pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Pay> payList = b_Service.selectPayList(pi);
		if(payList != null) {
			mv.addObject("payList", payList)
			  .addObject("pi", pi)
			  .setViewName("payment");
			return mv;
		}else {
			throw new BookException("관리자 창에서 결제 내역 조회에 실패하였습니다.");
		}
	}
}

