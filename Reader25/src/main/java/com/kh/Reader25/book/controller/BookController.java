package com.kh.Reader25.book.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
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
	
	//메일 발송 관련
	@Autowired
	private JavaMailSender mailSender;
	
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
	// 결제 페이지 이동(+결제테이블에 인설트) // 책 수량 변경하기
	@RequestMapping("pcs.tr") 
	public ModelAndView bookPurchase(@RequestParam(value="b_no") ArrayList<Integer> b, @RequestParam(value="book_v") ArrayList<Integer> book_v, ModelAndView mv, HttpSession session) {
		String userid = ((Member)session.getAttribute("loginUser")).getId();
		ArrayList<Attachment> atList = new ArrayList<Attachment>();
		ArrayList<Book> bList = new ArrayList<Book>();
		ArrayList<Integer> pNoList = new ArrayList<Integer>();
		
		for(int i = 0; i<b.size(); i++) {
			Book book = b_Service.selectBook(b.get(i));
			Attachment at = bService.selectAttachmentzero(book.getBoardNo());
			book.setB_Q1(book_v.get(i));
			int result = b_Service.countUpdate(book);
			if(result < 0) {
				throw new BookException("책 수량 조절에 실패하였습니다.");
			}
			bList.add(book);
			atList.add(at);
			Pay pay = new Pay(book_v.get(i), (book_v.get(i)*book.getB_price()) ,userid, book.getB_no());
			result = b_Service.insertPay(pay);
			int pay_no = b_Service.selectPayNo();
			pNoList.add(pay_no);
			if(result < 0) {
				throw new BookException("주문내역 추가에 실패하였습니다.");
			}
		}
		mv.addObject("book", bList).addObject("at", atList).addObject("pay", pNoList).setViewName("bookPurchase");
		return mv;	
	}
	private String sendMailCheck(Integer integer) {
		Integer boardNo = integer;
		String bookSendEmail = bService.searchBookSendEmail(boardNo);
		//System.out.println(bookSendEmail);
		
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 판매자 님</h2><br><br>" 
				+ "<p>해당 메일은 등록하신 책에 대한 주문이 발생하여 안내 메일입니다.</p>"
				+ "<p>주문이 발생된 후 3일 이내에 발송을 해주셔야합니다.</p><br>"
				+ "<h3><a href='http://localhost:8105/Reader25'>Reader25 홈페이지 접속 (클릭!) </a></h3><br><br>"
				+ "Reader25에 향한 무한한 관심과 사랑 감사드립니다.";
		try {
			mail.setSubject("[Reader25] 주문이 발생하였습니다.", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(bookSendEmail));
			mailSender.send(mail);
		} catch (MessagingException e) { 
			e.printStackTrace();
		}
		return bookSendEmail;
		
	}
	// 결제완료 장바구니 리스트 N으로, 주문목록 Y로, 메일 보내기
	@RequestMapping("paylast.tr")
	@ResponseBody
	public String patLast(@RequestParam(value="b_no") List<Integer> b, @RequestParam(value="b_v") List<Integer> b_v, @RequestParam(value="pay") List<Integer> p_no, HttpSession session) {
		String userid = ((Member)session.getAttribute("loginUser")).getId();
		for(int i = 0; i< p_no.size(); i++) {
			int result = b_Service.updatePay(p_no.get(i));
			if(result < 0) {
				throw new BookException("결제상태 변경에 실패하였습니다.");
			}
		}
		for(int i = 0; i< b.size(); i++) {
			Map<String, Object> sb = new HashMap<String, Object>();
			sb.put("userid", userid);
			sb.put("b_no", b.get(i));
			sb.put("b_v", b_v.get(i));
			int result = b_Service.updateSb(sb);
			String sendMailCheck = sendMailCheck(4);
		}
		return "success";
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
		int listCount = bService.getSearchBookListCount(sr);
		
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
	
	// 책방 책이름 같은 리뷰 보기
	@RequestMapping("reList.bo")
	public void selectReviewList(@RequestParam(value="page1", required=false, defaultValue="1") Integer page1,
	   							@RequestParam("booktitle") String book, HttpServletResponse response) {
		   response.setContentType("application/json; charset=UTF-8");
			int currentPage1 = 1;
			if (page1 != null) {
				currentPage1 = page1;
			}
			String booktitle = book + "#책제목";
			int listCount = bService.getReListCount(booktitle);
			PageInfo pi1 = Pagination.getPageInfo3(currentPage1, listCount);
			ArrayList<Board> reList = bService.selectAnotherReview(booktitle, pi1);

			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("reList", reList);
			map.put("pi1", pi1);

			Gson gson = new GsonBuilder().setDateFormat("yyyy/MM/dd").create();
			try {
				gson.toJson(map, response.getWriter());
			} catch (JsonIOException | IOException e) {
				e.printStackTrace();
			}
	}
	
	@RequestMapping("autocomplete.bo")
	public void SearchAutocomplteBook(@RequestParam("tTitle") String bTitle, @RequestParam("searchCondition") String condition,
										@ModelAttribute SearchReview sr,
										HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");	
		String value = bTitle;
		
		if(condition.equals("book")) {
			sr.setBook(value);
		} else if(condition.equals("author")) {
			sr.setAuthor(value);
		}
		ArrayList<Board> autoList = b_Service.selectAutoBookList(sr);
		Gson gson = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();
		try {
			gson.toJson(autoList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	
	}
}

