package com.kh.Reader25.book.controller;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.kh.Reader25.board.model.exception.BoardException;

import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;

import com.kh.Reader25.board.model.vo.SearchCondition;

import com.kh.Reader25.board.model.vo.SearchReview;

import com.kh.Reader25.book.model.exception.BookException;
import com.kh.Reader25.book.model.service.BookService;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.book.model.vo.ShoppingBasket;
import com.kh.Reader25.common.Pagination;
import com.kh.Reader25.member.model.vo.Member;

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
	

	
	
	@RequestMapping("myBasketList.me")
	public ModelAndView myBasketList(@RequestParam(value = "searchCondition", required = false) String searchCondition, @RequestParam(value = "searchValue", required = false) String searchValue, ModelAndView mv  , @RequestParam(value = "page", required = false) Integer page, HttpSession session) {
		
		
		
		
		Member loginUser = (Member)session.getAttribute("loginUser");
	 	
	 	String mId = loginUser.getId();
		
	 	
	 	
	
		
		

		
		
		int currentPage = 1 ;
		
		if(page != null) {
			
			currentPage = page;
			
		}
		
		SearchCondition sc = new SearchCondition();
		
		
		
	
		sc.setmId(mId);
		
		
		String condition =null;
		
		String value =null;
		
		if(searchValue != null) {
			
			
			
			condition =searchCondition;
			
			value =  searchValue;
			
			
			
			if (condition.equals("번호")) {
				
				sc.setNo(value);
				
			}else if (condition.equals("책이름")) {
				
				sc.setTitle(value);
			}
		}
		
		
		
		System.out.println("sc= " +sc);
		
		
		try {
			int listCount = b_Service.MyBasketListCount(sc);
			
			System.out.println("listcount= "+ listCount);
			
			
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			
			ArrayList<ShoppingBasket> list = b_Service.MyBasketList(sc,pi);
			
			System.out.println(list);
			
			mv.addObject("list", list);
			
			mv.addObject("pi", pi);
			
			
			
			mv.addObject("searchCondition",condition);
				
			mv.addObject("searchValue",value);
			
			
			
			
			
			mv.setViewName("myBasketList");
			
			
		} catch (BoardException e) {
			
			
			throw new BookException("장바구니 리스트 삭제 실패");
			
		}
		
		
		
		
		
		return mv; 
	}
	
	@RequestMapping("myBasketDelete.me")
	public ModelAndView myBasketDelete(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue,@RequestParam(value = "inFo", required = false) String inFo, ModelAndView mv ,@RequestParam(value = "code", required = false) Integer code , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
	

		
		
		
		
		String list = inFo;
		
		String [] lists = list.split(",");
		
		for(String s : lists) {
			
			System.out.println(s);
			
			
			
		}
		
		
		int result = b_Service.myBasketDelete(lists);
		
		

	

		if (result > 0) {

			
			
			mv.addObject("page", page);
			

			
			
			if(searchValue!=null) {

				mv.addObject("searchCondition",searchCondition);
					
				mv.addObject("searchValue",searchValue);
			}
		
			
			
			
			mv.setViewName("redirect:myBasketList.me");
		} else {

			throw new BookException("장바구니 리스트 삭제 실패");
		}

		return mv;

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
			sr.setAuthor(value+"#작가");
			searchCate = 2;
		}else if(condition.equals("book")) {
			sr.setBook(value +"#책제목");
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
		
		ArrayList<Board> bList = bService.selectSearchReviewList(sr, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(2);
		
		return mv;
	}

}

