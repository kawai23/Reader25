package com.kh.Reader25.book.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.book.model.exception.BookException;
import com.kh.Reader25.book.model.service.BookService;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;
import com.kh.Reader25.common.Pagination;

@Controller
public class BookController {
	@Autowired
	private BookService b_Service;
	@Autowired
	private BoardService bService;
	
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
	
	//book찾기
	@RequestMapping("search.bo")
	public ModelAndView searchBook(ModelAndView mv,@ModelAttribute SearchReview sr,
									HttpServletRequest request,
									HttpServletResponse response ) {
		String condition = request.getParameter("searchCondition");
		String value = request.getParameter("searchValue");
		
		int searchCate = 0;
		if(condition.equals("author")){
			sr.setAuthor(value);
			searchCate = 2;
		}else if(condition.equals("book")) {
			sr.setBook(value);
			searchCate = 1;
		}else {
			sr.setCate(value);
			searchCate = 3;
		}
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int listCount = bService.getSearchReviewListCount(sr);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectSearchBook(sr, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(3);
		mv.addObject("searchCate", searchCate)
		  .addObject("searchValue", value)
		  .addObject("pi", pi)
		  .addObject("bList", bList)
		  .addObject("atList", atList)
		  .setViewName("bookSearch");
		return mv;
	}
	// 책방 검색 후 분류하기
	@RequestMapping("searchsort.bo")
	public ModelAndView searchAndSortBook(ModelAndView mv, @RequestParam("sortValue") String sortValue,
										@ModelAttribute SearchReview sr,
										HttpServletRequest request) {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		String condition = request.getParameter("searchCondition");
		String value = request.getParameter("searchValue");
		int searchCate = 0;
		if(condition.equals("author")){
			sr.setAuthor(value);
			searchCate = 2;
		}else if(condition.equals("book")) {
			sr.setBook(value);
			searchCate = 1;
		}else {
			sr.setCate(value);
			searchCate = 3;
		}
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sortValue", sortValue);
		map.put("writer",sr.getWriter());
		map.put("book",sr.getBook());
		map.put("author",sr.getAuthor());
		map.put("cate",sr.getCate());
		
		int listCount = bService.getSearchAndSortCountBook(map);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectSearchSortBookList(map, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(3);
		if(bList != null) {
			mv.addObject("pi", pi)
			  .addObject("bList", bList)
			  .addObject("atList", atList)
			  .addObject("sortValue", sortValue)
			  .addObject("searchValue", value)
			  .addObject("searchCate", searchCate)
			  .setViewName("bookSearch");
		}else {
			 throw  new BookException("책방 검색, 분류하기에 실패하였습니다.");
		}
		return mv;
	}
	// 책방 분류하기
	@RequestMapping("sort.bo")
	public ModelAndView sortBook(@RequestParam("sortValue") String sortValue, ModelAndView mv,
								@RequestParam(value="page", required=false) Integer page,
								HttpServletRequest request) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int listCount = bService.getSortBookListCount(sortValue);
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectSortBookList(sortValue, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(3);
		
		if(bList != null) {
			mv.addObject("bList", bList)
			  .addObject("atList", atList)
			  .addObject("pi", pi)
			  .addObject("sortValue", sortValue)
			  .setViewName("gobookr");
		}
		return mv;
	}
}

