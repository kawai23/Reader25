package com.kh.Reader25.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.Reader25.board.model.exception.BoardException;
import com.kh.Reader25.board.model.service.BoardService;
import com.kh.Reader25.board.model.vo.Attachment;
import com.kh.Reader25.board.model.vo.Board;
import com.kh.Reader25.board.model.vo.Bookmarkto;
import com.kh.Reader25.board.model.vo.Comments;
import com.kh.Reader25.board.model.vo.Liketo;
import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.board.model.vo.Pay;
import com.kh.Reader25.board.model.vo.Point;
import com.kh.Reader25.board.model.vo.SearchCate;
import com.kh.Reader25.board.model.vo.SearchCondition;
import com.kh.Reader25.board.model.vo.SearchReview;
import com.kh.Reader25.board.model.vo.Support;
import com.kh.Reader25.board.model.vo.TWITopWriter;
import com.kh.Reader25.book.model.service.BookService;
import com.kh.Reader25.book.model.vo.Book;
import com.kh.Reader25.common.Pagination;
import com.kh.Reader25.member.model.service.MemberService;
import com.kh.Reader25.member.model.vo.Member;

@SessionAttributes("loginUser")

@Controller
public class BoardController {
	@Autowired
	private BoardService bService;
	
	//포인트 관련
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BookService b_Service;
	
	// 1. 공지사항 code = 0  ----------------------------------------------------
	// (1) 리스트 페이지
	@RequestMapping("notice.no")
	public ModelAndView noticeList(@RequestParam(value="page", required=false) Integer page,
							ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int code = 0;
		int listCount = bService.getListCount(code);
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Board> bList = bService.selectList(pi, code);
		if(bList != null) {
			mv.addObject("bList", bList)
				.addObject("pi", pi)
				.setViewName("noticeList");
		}else {
			throw new BoardException("공지사항 게시글 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	// (2) 글쓰기 페이지
	@RequestMapping("write.no")
	public String noticeWirteForm() {
		return "noticeWriteForm";
	}
	// (3) 글작성
	@RequestMapping("ninsert.no")
	public String insertNotice(@ModelAttribute Board b,
							@RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFile,
							HttpServletRequest request) {
		ArrayList<Attachment> atList =  new ArrayList<Attachment>();
		if(uploadFile.length != 0) {
			b.setCode(0); //공지사항 코드
			for(int i = 0; i < uploadFile.length; i++ ){
				Attachment at = saveFile(uploadFile[i], request, 0);
				if(i == uploadFile.length -1) {
					at.setAtcLevel(0);
				}else {
					at.setAtcLevel(1);
				}
				atList.add(at);
			}
		}
		int result = bService.insertBoardAndFiles(b, atList);

		if(result > 0) {
			return "redirect:notice.no";
		}else {
			throw new BoardException("공지사항 게시글 작성에 실패하였습니다.");
		}
	}
	//(4) 상세보기
	@RequestMapping("ndetail.no")
	public ModelAndView boardReviewDetailView(@RequestParam("boardNo") int boardNo,
										@RequestParam("page") int page, ModelAndView mv) {
		Board board = bService.selectBoard(boardNo);
		ArrayList<Attachment> atList = bService.selectAttachmentList(boardNo);
		if(board != null) {
			mv.addObject("board", board)
			   .addObject("page", page)
			   .setViewName("noticeDetail");
			if(atList != null) {
				mv.addObject("atList", atList);
			}
		}else {
			throw new BoardException("공지사항 상세보기가 실패하였습니다.");
		}
		return mv;
	}
	// (5) 수정하기 페이지
	@RequestMapping("modify.no")
	public ModelAndView modifyNoticeView(@RequestParam("boardNo") int boardNo, 
									@RequestParam("page") int page , ModelAndView mv) {
		Board board = bService.selectBoard(boardNo);
		ArrayList<Attachment> atList = bService.selectAttachmentList(boardNo);
		if(board != null) {
			mv.addObject("board", board)
			  .addObject("atList", atList)
			  .addObject("page", page)
			  .setViewName("noticeModify");
		}else {
			throw new BoardException("공지사항 수정하기 게시판 로드에 실패하였습니다.");
		}
		return mv;
	}
	//(6) 수정하기
	@RequestMapping("update.no")
	public String updateNotice(@ModelAttribute Board b, @RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFile,
							@RequestParam("page") int page, @RequestParam("nameArr") String[] nameArr,
							@RequestParam("originArr") String[] originArr,
							HttpServletRequest request) {
		ArrayList<Attachment> uploadAtList =  new ArrayList<Attachment>();
		int result = 0;
		if(uploadFile.length != 0) {
			for(String str : nameArr) {
				deleteFile(str, request);
			}
			for(int i = 0; i < uploadFile.length; i++) {
				Attachment at = saveFile(uploadFile[i], request, 0);
				at.setBoardNo(b.getBoardNo()); // Attachment가져오기 않기 때문
				if(i == uploadFile.length - 1) {
					at.setAtcLevel(0);
				}else {
					at.setAtcLevel(1);
				}
				uploadAtList.add(at);
			}
			result = bService.updateBoardAnFiles(b, uploadAtList);
		}else {
			result = bService.updateBoard(b);
		}
		if(result >0) {
			return "redirect:ndetail.no?boardNo=" + b.getBoardNo() + "&page=" + page; 
		}else {
			throw new BoardException("공지사항 게시물 수정하기에 실패하였습니다.");
		}
	}
	//(7)삭제하기
	@RequestMapping("delete.no")
	public String deleteNotice(@RequestParam("boardNo") int boardNo) {
		int result = bService.deleteBoardAndFile(boardNo);
		if(result > 0) {
			return "redirect:notice.no";
		}else {
			throw new BoardException("공지사항 게시물 삭제에 실패하였습니다.");
		}
	}
	// 문의사항 = 1----------------------------------------------------
	@RequestMapping("inquiry.in")
	public ModelAndView inquiryList(@RequestParam(value="page", required=false) Integer page,
							ModelAndView mv) {		
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		
		int code = 1;
		int listCount = bService.getListCount(code);
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Board> iList = bService.selectList(pi, code);
		if(iList != null) {
			mv.addObject("iList", iList)
				.addObject("pi", pi)
				.setViewName("inquiryList");
		}else {
			throw new BoardException("문의사항 게시글 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	//문의사항 작성 페이지 컨트롤러
	@RequestMapping("write.in")
	public String inquiryWriteForm() {
		return "inquiryWriteForm";
	}
	
	//문의사항 작성 컨트롤러
	@RequestMapping("inInsert.in")
	public String insertInquiry(@ModelAttribute Board b, @ModelAttribute Attachment at,
							@RequestParam("uploadFile") MultipartFile uploadFile,
							HttpServletRequest request) {
		
		int result = bService.insertIn(b);
		
		int boardNo = bService.seachBoardNo(b);
		b.setBoardNo(boardNo);
		
		if(uploadFile != null) {//첨부파일이 있다면
			at = saveFile2(uploadFile, request, 1);
			// renameFileName에 saveFile의 반환값을 넣어준다. 파일을 저장할 buploadFiles까지 가기 위해서는
			// HttpServletRequest가 필요하므로 매개변수로 추가해준다.
			at.setAtcLevel(0);
			at.setBoardNo(boardNo);
			int resultF = bService.insetFile(at);
			if(resultF > 0) {
				System.out.println("파일업로드 성공");
			} else {
				System.out.println("파일업로드 실패");
			}
		}
		if(result > 0) {
			return "redirect:inquiry.in";
		}else {
			throw new BoardException("공지사항 게시글 작성에 실패하였습니다.");
		}
	}
	
	//문의사항 파일 저장 컨트롤러
	public Attachment saveFile2(MultipartFile file, HttpServletRequest request, int code) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdir();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) 
								+ "." + originFileName.substring(originFileName.lastIndexOf(".") + 1);
		String renamePath = folder + "\\" + renameFileName;
		Attachment at = new Attachment();
		at.setAtcCode(code);
		at.setAtcOrigin(file.getOriginalFilename());
		at.setAtcName(renameFileName);
		at.setAtcPath(savePath);

		
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return at;
	}
	
	//문의사항 상세보기
	@RequestMapping("idetail.in")
	public ModelAndView indetailView(@RequestParam("boardNo") int boardNo,
									@RequestParam("page") int page, ModelAndView mv, HttpSession session) {
		Board board = bService.selectBoard(boardNo);
		ArrayList<Attachment> atList = bService.selectAttachmentList(boardNo);
		Member login = (Member)session.getAttribute("loginUser");
		
		if(board != null) {
			mv.addObject("board", board)
				.addObject("page", page)
				.setViewName("inquiryDetail");
			if(atList != null) {
				mv.addObject("atList", atList);
			}
		}else {
			throw new BoardException("문의사항 상세보기가 실패하였습니다.");
		}
		return mv;
	}
	
	//문의사항 관리자 댓글 작성
	@RequestMapping("addAdminComments.in")
	@ResponseBody
	public String addAdminComments(@ModelAttribute Comments c, @RequestParam("comment") String comment, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getId();
			
		c.setUserId(userId);
		c.setComment(comment);
			
		int result = bService.insertComments(c);
		int upCount = bService.updateCount(c);
			
		if(result > 0) {
			return "success";
		} else {
			throw new BoardException("댓글 등록에 실패하였습니다.");
		}
	}
	
	//문의사항 관리자 댓글 불러오기
	@RequestMapping("aCList.in")
	public void getACList(@RequestParam("boardNo") int boardNo, @RequestParam("userId") String userId, HttpServletResponse response) {
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		ArrayList<Comments> aCList = bService.selectAdminCommentList(map);
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		try {
			gson.toJson(aCList, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//문의사항 회원만 댓글 가져오기
	@RequestMapping("userComments.in")
	public void getuserComments(@RequestParam(value = "page0", required = false, defaultValue = "1") Integer page0,
			@RequestParam("boardNo") int boardNo, @RequestParam("userId") String userId,
			HttpServletResponse response) {
		
		response.setContentType("application/json; charset=UTF-8");
		int currentPage1 = 1;

		if (page0 != null) {
			currentPage1 = page0;
		}
		
		HashMap<String, Object> umap = new HashMap<String, Object>();
		umap.put("boardNo", boardNo);
		umap.put("userId", userId);

		int listCount = bService.getuserCommentsListCount(umap);
		PageInfo pi0 = Pagination.getPageInfo5_1(currentPage1, listCount);
		
		ArrayList<Comments> cList = bService.selectuserComments(boardNo, pi0, userId);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cList", cList);
		map.put("pi0", pi0);
			
		Gson gson = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	//문의사항 글 수정 컨트롤러
	@RequestMapping("inquiryUpView.in")
	public ModelAndView inquiryUpView(@RequestParam("boardNo") int boardNo, @RequestParam("page") int page, 
										ModelAndView mv) {
		
		Board board = bService.selectupInquiryBoard(boardNo);
		
		mv.addObject("board", board)
		  .addObject("page", page)
		  .setViewName("inquiryUpdateForm");
		
		return mv;
	}
	
	//문의사항 글 수정
	@RequestMapping("inquiryUp.in")
	public ModelAndView inquiryUp(
							@ModelAttribute Board b, @RequestParam("boardNo") int boardNo,
							@RequestParam("page") int page, HttpServletRequest request,
							@ModelAttribute Attachment at,
							@RequestParam("uploadFile") MultipartFile uploadFile,
							ModelAndView mv) {
		b.setBoardNo(boardNo);
		
		int result = bService.updateInquiryBoard(b);
		
		if(uploadFile != null) {//첨부파일이 있다면
			int resultD = bService.deleteFile(boardNo);
			at = saveFile2(uploadFile, request, 1);
			// renameFileName에 saveFile의 반환값을 넣어준다. 파일을 저장할 buploadFiles까지 가기 위해서는
			// HttpServletRequest가 필요하므로 매개변수로 추가해준다.
			at.setAtcLevel(0);
			at.setBoardNo(boardNo);
			int resultF = bService.insetFile(at);
			if(resultF > 0) {
				System.out.println("파일업로드 성공");
			} else {
				System.out.println("파일업로드 실패");
			}
		}
		
		if(result > 0) {
			mv.addObject("page", page)
			  .setViewName("redirect:idetail.in?boardNo=" + b.getBoardNo());
		} else {
			throw new BoardException("문의사항 게시글 수정에 실패하였습니다.");
		}
		
		return mv;
	}
	
	//오늘은 나도 작가 = 5 게시글 삭제 
	@RequestMapping("inquiryDel.in")
	public String inquiryDel(@RequestParam("boardNo") int boardNo) {
				
		int result = bService.deleteInquiryBoard(boardNo);
				
		if(result > 0) {
			return "redirect:inquiry.in";
		} else {
			throw new BoardException("게시글 삭제에 실패했습니다.");
		}
	}	
	
		
	// 책 리뷰 = 2 ----------------------------------------------------
	@RequestMapping("book.re")
	public ModelAndView bookreviewList(@RequestParam(value="page", required=false) Integer page,
								ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int code = 2;
		int listCount = bService.getListCount(code);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectList(pi, code);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(code);
		
		if(bList != null) {
			String[] booktitleArr = new String[bList.size()];
			String[] authorArr = new String[bList.size()];
			String[] wiseArr = new String[bList.size()];
			String[] contentArr = new String[bList.size()];
			for(int i = 0; i < bList.size(); i++) {
				booktitleArr[i] = bList.get(i).getbContent().substring(0, bList.get(i).getbContent().indexOf("#책제목"));
				authorArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#책제목") + 4, bList.get(i).getbContent().indexOf("#작가"));
				wiseArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#작가") + 3, bList.get(i).getbContent().indexOf("#명언"));
				contentArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#명언")+3);
			}
			mv.addObject("bList", bList)
				.addObject("pi", pi)
				.addObject("atList", atList)
				.addObject("contentArr", contentArr)
				.addObject("authorArr", authorArr)
				.addObject("booktitleArr", booktitleArr)
				.addObject("wiseArr", wiseArr)
				.setViewName("BookReview");
		}else {
			throw new BoardException("책리뷰 게시글 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	@RequestMapping("write.re")
	public String bookreviewWriteForm() {
		return "bookreviewWriteForm";
	}
	// 리뷰 게시판 상세페이지
	@RequestMapping("redetail.re")
	public ModelAndView bookreviewDetailView(@RequestParam("boardNo") int boardNo,
											 @RequestParam("page") int page,
											 ModelAndView mv, HttpServletRequest request) {
		Board board = bService.selectBoard(boardNo);
		Attachment at = bService.selectAttachment(boardNo);
		
		// 좋아요 
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		int heart = 0;
		if(loginUser != null) {
			String id = loginUser.getId();
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("loginUser", id);
			map.put("boardNo", boardNo);
			
			heart = bService.findLike(map) == 1? 1:0;
		}
		
		if(board != null) {
			
			String booktitle = board.getbContent().substring(0,(board.getbContent()).indexOf("#책제목"));
			String exbook = board.getbContent().substring((board.getbContent()).indexOf("#책제목")+4);
			String author = exbook.substring(0,exbook.indexOf("#작가"));
			String exauthor = exbook.substring(exbook.indexOf("#작가") + 3);
			String wise = exauthor.substring(0,exauthor.indexOf("#명언"));
			String content = exauthor.substring(exauthor.indexOf("#명언") + 3);
			
			board.setbContent(content);
			
			mv.addObject("board", board);
			mv.addObject("at", at);
			mv.addObject("booktitle", booktitle);
			mv.addObject("author", author);
			mv.addObject("wise", wise);
			mv.addObject("page", page);
			mv.addObject("heart", heart);
			mv.setViewName("bookReviewDetail");
		}else {
			throw new BoardException("리뷰 게시판 상세보기에 실패하였습니다.");
		}
		return mv;
	}
	// 이 책의 다른 리뷰보기
	@RequestMapping("reList.re")
	public void getAnotherList(@RequestParam(value="page1", required=false, defaultValue="1") Integer page1,
							   @RequestParam("booktitle") String book, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		int currentPage1 = 1;
		if(page1 != null) {
			currentPage1 = page1;
		}
		String booktitle = book + "#책제목";
		int listCount = bService.getReListCount(booktitle);
		PageInfo pi1 = Pagination.getPageInfo3(currentPage1, listCount);
		ArrayList<Board> reList = bService.selectAnotherReview(booktitle, pi1);
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		map.put("reList", reList);
		map.put("pi1", pi1);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy/MM/dd").create();
		 try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	//명대사 리스트 보기
	@RequestMapping("wiseList.re")
	public void getWiseList(@RequestParam(value="page2", required=false) Integer page2,
							@RequestParam("wise") String wise, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		int currentPage2 = 1;
		if(page2 != null) {
			currentPage2 = page2;
		}
		int listCount = bService.getReListCount(wise);
		PageInfo pi2 = Pagination.getPageInfo3(currentPage2, listCount);
		ArrayList<Board> wiseList = bService.selectAnotherReview(wise, pi2);
		
		String[] wiseArr = new String[wiseList.size()];
		int i = 0;
		for(Board b : wiseList) {
			wiseArr[i] = b.getbContent().substring(b.getbContent().indexOf("#작가") + 3, b.getbContent().indexOf("#명언"));
			i++;
		}
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		map.put("wiseList", wiseList);
		map.put("pi2", pi2);
		map.put("wiseArr", wiseArr);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy/MM/dd").create();
		 try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException | IOException e) {
			e.printStackTrace();
		}
	}
	
	//리뷰작성
	@RequestMapping("insert.re") 
	public String bookReviewInsert(@ModelAttribute Board b, @RequestParam(value="uploadFile", required=false) MultipartFile uploadFile,
									HttpServletRequest request,
									@RequestParam("booktitle") String booktitle,
									@RequestParam("author") String author,
									@RequestParam("wise") String wise, HttpSession session) {
		String contentAddTag =  booktitle + "#책제목"  + author + "#작가" + wise + "#명언" + b.getbContent();
		b.setbContent(contentAddTag);
		
		Member member = (Member)(request.getSession().getAttribute("loginUser"));
		String userId = member.getId();
		b.setUserId(userId);
		b.setCode(2);
		
		Attachment at = null;
		int result = 0;
		if(uploadFile != null && !uploadFile.isEmpty()) {
			at = saveFile(uploadFile, request, 2);
			
			at.setAtcLevel(0);
			result = bService.insertBoardAndFile(b, at);
		}else {
			result = bService.insertBoard(b);
		}
		
		if(result > 0) {
			//포인트 관련
			int point = pointChangeRe(session);

			return "redirect:book.re";
		}else {
			throw new BoardException("책리뷰 게시물 작성에 실패하였습니다.");
		}
	}
	
	public int pointChangeRe(HttpSession session) {
		Member login = (Member)session.getAttribute("loginUser");
		String id = login.getId();	
		int point = 200;
		String message = "책 리뷰 글 작성!";
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		map.put("pCon", message);
		
		int pointUpU = mService.upPointUser(map);
		int pointUp = bService.upPoint(map);
		
		int rankCheck = mService.muchPoint(id);
		
		
		if(rankCheck>=0 && rankCheck<=1000) {
			int rank = 1;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
			
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>1000 && rankCheck<=3000) {
			int rank = 2;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
		
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>3000 && rankCheck<=7000) {
			int rank = 3;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			return rankChange;
		} else if(rankCheck>7000 && rankCheck<=10000) {
			int rank = 4;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else {
			int rank = 0;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		}
		
	}
	
	// 수정하기 뷰
	@RequestMapping("modify.re")
	public ModelAndView reviewModifyView(@RequestParam("boardNo") int boardNo, @RequestParam("page") int page,
									ModelAndView mv) {
		Board board = bService.selectBoardExceptAddCount(boardNo);
		Attachment at = bService.selectAttachment(boardNo); 
		if(board != null) {
			String booktitle = board.getbContent().substring(0,(board.getbContent()).indexOf("#책제목"));
			String exbook = board.getbContent().substring((board.getbContent()).indexOf("#책제목")+4);
			String author = exbook.substring(0,exbook.indexOf("#작가"));
			String exauthor = exbook.substring(exbook.indexOf("#작가") + 3);
			String wise = exauthor.substring(0,exauthor.indexOf("#명언"));
			String content = exauthor.substring(exauthor.indexOf("#명언") + 3);
			
			board.setbContent(content);
			
			mv.addObject("board", board)
				.addObject("page", page)
				.addObject("booktitle", booktitle)
				.addObject("author", author)
				.addObject("wise", wise)
				.addObject("at", at)
				.setViewName("bookUpdateForm");
		}else {
			throw new BoardException("리뷰 게시판 수정하기에 값을 불러오는데 실패하였습니다.");
		}
		
		return mv;
	}
	// 수정하기
	@RequestMapping("update.re")
	public ModelAndView updateReviewBoard(@RequestParam("page") int page, @ModelAttribute Board b,
									@RequestParam(value="reloadFile", required=false) MultipartFile reloadFile,
									HttpServletRequest request, @ModelAttribute  Attachment at,
									ModelAndView mv,
									@RequestParam("booktitle") String booktitle,
									@RequestParam("author") String author,
									@RequestParam("wise") String wise) {
		
		String contentAddTag =  booktitle + "#책제목"  + author + "#작가" + wise + "#명언" + b.getbContent();
		b.setbContent(contentAddTag);
		
		if(reloadFile != null && !reloadFile.isEmpty()) {
			int result = 0;
			Attachment attachment =  saveFile(reloadFile, request, 2);
			System.out.println(":"+at.getAtcName()+":");
			
			if(at.getAtcName().trim() != "" && !at.getAtcName().isEmpty()) {
				deleteFile(at.getAtcName(), request);
				result = bService.updateBoardAndFile(b,attachment);
			}else {
				
				attachment.setAtcLevel(0);
				attachment.setBoardNo(b.getBoardNo());
				attachment.setAtcCode(2);
				result = bService.updateBoardInsertFile(b,attachment);
			}
			
			if(result > 0) {
				Board board = bService.selectBoard(b.getBoardNo());
				Attachment attach = bService.selectAttachment(b.getBoardNo());
				mv.addObject("board", board)
				  .addObject("boardNo", b.getBoardNo())
				  .addObject("page", page)
				  .addObject("at", attach)
				  .setViewName("redirect:redetail.re");
			}else {
				throw new BoardException("리뷰 게시물 수정에 실패하였습니다.");
			}
		}else {
			int result = bService.updateBoard(b);
			if(result >0) {
				Board board = bService.selectBoard(b.getBoardNo());
				Attachment attach = bService.selectAttachment(b.getBoardNo());
				mv.addObject("board", board)
				  .addObject("boardNo", b.getBoardNo())
				  .addObject("page", page)
				  .addObject("at", attach)
				  .setViewName("redirect:redetail.re");
			}else {
				throw  new BoardException("리뷰 게시물 수정에 실패하였습니다.");
			}
		}
		return mv;
	}
	// 삭제하기
	@RequestMapping("delete.re")
	public String deleteReviewBoard(@RequestParam("boardNo") int boardNo) {
		int result = bService.deleteBoardAndFile(boardNo);
		if(result > 0) {
			return "redirect:book.re";
		}else {
			throw new BoardException("리뷰 게시물 삭제에 실패하였습니다.");
		}
	}
	// 검색
	@RequestMapping("search.re")
	public ModelAndView searchReview(@ModelAttribute SearchReview sr, HttpServletRequest request,
								HttpServletResponse response, ModelAndView mv) {
		String condition = request.getParameter("searchCondition");
		String value = request.getParameter("searchValue");
		
		int searchCate = 0;
		if(condition.equals("title")) {
			sr.setTitle(value);
			searchCate = 1;
		}else if(condition.equals("author")){
			sr.setAuthor(value+"#작가");
			searchCate = 2;
		}else if(condition.equals("book")) {
			sr.setBook(value +"#책제목");
			searchCate = 3;
		}else if(condition.equals("writer")) {
			sr.setWriter(value);
			searchCate = 4;
		}else if(condition.equals("content")) {
			sr.setWriter(value);
			searchCate = 5;
		}else {
			sr.setCate(value);
			searchCate = 6;
		}
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		int listCount = bService.getSearchReviewListCount(sr);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		
		ArrayList<Board> bList = bService.selectSearchReviewList(sr, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(2);
		
		if(bList != null) {
			String[] wiseArr = new String[bList.size()];
			String[] contentArr = new String[bList.size()];
			
			for(int i = 0; i < bList.size(); i++) {
				wiseArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#작가") + 3, bList.get(i).getbContent().indexOf("#명언"));
				contentArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#명언")+3);
			}
			mv.addObject("bList", bList);
			mv.addObject("atList", atList)
				.addObject("pi", pi)
				.addObject("contentArr", contentArr)
				.addObject("wiseArr", wiseArr)
				.addObject("searchCate", searchCate)
				.addObject("searchValue", value)
				.setViewName("BookReviewSearch");
		}else {
			throw new BoardException("리뷰 게시판 검색하기에 실패하였습니다.");
		}
		return mv;
	}
	//분류하기
	@RequestMapping("sort.re")
	public ModelAndView sortBookReviewList(@RequestParam("sortValue") String sortValue, HttpServletRequest request,
											ModelAndView mv,
											@RequestParam(value="page", required=false) Integer page) {
		
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int listCount = bService.getSortListCount(sortValue);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectSortList(sortValue, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(2);
		
		if(bList != null) {
			String[] wiseArr = new String[bList.size()];
			String[] contentArr = new String[bList.size()];
			String[] booktitleArr = new String[bList.size()];
			String[] authorArr = new String[bList.size()];
			
			for(int i = 0; i < bList.size(); i++) {
				booktitleArr[i] = bList.get(i).getbContent().substring(0,(bList.get(i).getbContent().indexOf("#책제목")));
				authorArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#책제목") + 4,(bList.get(i).getbContent().indexOf("#작가")));
				wiseArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#작가") + 3, bList.get(i).getbContent().indexOf("#명언"));
				contentArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#명언")+3);
			}
			mv.addObject("bList", bList)
			  .addObject("atList", atList)
			  .addObject("pi", pi)
			  .addObject("contentArr", contentArr)
			  .addObject("wiseArr", wiseArr)
			  .addObject("sortValue", sortValue)
			  .addObject("booktitleArr", booktitleArr)
			  .addObject("authorArr", authorArr)
			  .setViewName("BookReview");
		}else {
			throw new BoardException("리뷰 게시판 분류하기에 실패하였습니다.");
		}
		return mv;
	}
	// 검색 후 분류하기
	@RequestMapping("searchsort.re")
	public ModelAndView searchAndSortReview(ModelAndView mv, @RequestParam("sortValue") String sortValue,
											 HttpServletRequest request, @ModelAttribute SearchReview sr) {
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		String condition = request.getParameter("searchCondition");
		String value = request.getParameter("searchValue");
		int searchCate = 0;
		if(condition.equals("title")) {
			sr.setTitle(value);
			searchCate = 1;
		}else if(condition.equals("author")){
			sr.setAuthor(value+"#작가");
			searchCate = 2;
		}else if(condition.equals("book")) {
			sr.setBook(value +"#책제목");
			searchCate = 3;
		}else if(condition.equals("writer")) {
			sr.setWriter(value);
			searchCate = 4;
		}else {
			sr.setContent(value);
			searchCate = 5;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sortValue", sortValue);
		map.put("writer",sr.getWriter());
		map.put("content",sr.getContent());
		map.put("book",sr.getBook());
		map.put("author",sr.getAuthor());
		map.put("title",sr.getTitle());
		
		int listCount = bService.getSearchAndSortCount(map);
		
		PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
		ArrayList<Board> bList = bService.selectSearchSortList(map, pi);
		ArrayList<Attachment> atList = bService.selectAttachmentTList(2);
			
		if(bList != null) {
			String[] wiseArr = new String[bList.size()];
			String[] contentArr = new String[bList.size()];
			
			for(int i = 0; i < bList.size(); i++) {
				wiseArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#작가") + 3, bList.get(i).getbContent().indexOf("#명언"));
				contentArr[i] = bList.get(i).getbContent().substring(bList.get(i).getbContent().indexOf("#명언")+3);
			}
			mv.addObject("bList", bList)
			  .addObject("atList", atList)
			  .addObject("pi", pi)
			  .addObject("contentArr", contentArr)
			  .addObject("wiseArr", wiseArr)
			  .addObject("sortValue", sortValue)
			  .addObject("searchCate", searchCate)
			  .addObject("searchValue", value)
			  .setViewName("BookReviewSearch");
		}else {
			throw new BoardException("리뷰 게시판 분류하기에 실패하였습니다.");
		}
		return mv;
	}
	//댓글 가져오기
	@RequestMapping("comments.re")
	public void getCommentsReviewList(@RequestParam(value = "page0", required = false, defaultValue = "1") Integer page0,
			@RequestParam("boardNo") int boardNo, HttpServletResponse response) {
		
		response.setContentType("application/json; charset=UTF-8");
		int currentPage1 = 1;

		if (page0 != null) {
			currentPage1 = page0;
		}

		int listCount = bService.getCommentListCount(boardNo);
		PageInfo pi0 = Pagination.getPageInfo5_1(currentPage1, listCount);
		ArrayList<Comments> cList = bService.selectAnotherComments(boardNo, pi0);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cList", cList);
		map.put("pi0", pi0);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//댓글 수정하기
	@RequestMapping("comupdate.re")
	@ResponseBody
	public int updateComment(@RequestParam("comNo") String comNo, @RequestParam("comment") String comment,
							@RequestParam("userId") String userId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("comNo", comNo);
		map.put("bContent", comment);
		map.put("userId", userId);
		
		int result = bService.updateComments(map);
		
		return result;
	}
	//댓글 삭제하기
	@RequestMapping("commentdel.re")
	@ResponseBody
	public int deleteComment(@RequestParam("comNo") String comNo, @RequestParam("boardNo") String boardNo) {
		int result = bService.deleteComments(comNo);
		if(result > 0) {
			result = bService.deleteCount(boardNo);
		}
		return result;
	}
	//책리뷰 code = 2-------------------------------------------------------------

	////////////////오늘은 나도 작가(TIW) 컨트롤러////////////////////////
	
	// 오늘은 나도 작가 = 5 리스트 폼 이동 컨트롤러
	@RequestMapping("goTIWList.to")
	public ModelAndView goTIWList(@RequestParam(value="page", required=false) Integer page, ModelAndView mv) {

	         
	      int currentPage = 1;
	      if(page != null) {
	         currentPage = page;
	      }
	      
	      SimpleDateFormat format1 = new SimpleDateFormat( "yy/MM/dd");
	      Calendar calendar = Calendar.getInstance();
	      String enrollDay = format1.format(calendar.getTime());
	         
	      int listCount = bService.getTIWListCount();
	      int todayListCount = bService.todayListCount(enrollDay);
	      
	      ArrayList<TWITopWriter> btList = bService.topWriterList();
	      ArrayList<TWITopWriter> bcList = bService.topCommenterList();
	      ArrayList<TWITopWriter> blList = bService.topLikerList();
	         
	      PageInfo pi = Pagination.getPageInfo5(currentPage, listCount);
	         
	      ArrayList<Board> list = bService.selectTIWList(pi);
	         
	      if(list != null) {
	         mv.addObject("list", list);
	         mv.addObject("pi", pi);
	         mv.addObject("btList", btList);
	         mv.addObject("bcList", bcList);
	         mv.addObject("blList", blList);
	         mv.addObject("todayListCount", todayListCount);
	         mv.setViewName("TIWListForm");
	      } else {
	         throw new BoardException("오늘은 나도 작가 게시글 전체 조회에 실패했습니다.");
	      }
	         
	      return mv;
	}
	
	// 오늘은 나도 작가 = 5 글 작성 폼 이동 컨트롤러
	@RequestMapping("writeTIW.to")
	public String writeTIW() {
		return "TIWWriteForm";
	}
	
	// 오늘은 나도 작가 = 5 글 작성 컨트롤러
	@RequestMapping("TIWinsert.to")
	public String TIWinsert(@ModelAttribute Board b,
				@RequestParam("code1") String code1,
				@RequestParam("code2") String code2, HttpSession session) {
		
		b.setCate(code1+"/"+code2);
		
		int result = bService.insertTIW(b);
		
		if(result > 0) {
			//포인트 관련
			int point = pointChangeTIW(session);
						
			return "redirect:goTIWList.to";
		} else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
	}
	
	//글 작성 후 포인트 변화
	public int pointChangeTIW(HttpSession session) {
		Member login = (Member)session.getAttribute("loginUser");
		String id = login.getId();	
		int point = 300;
		String message = "오늘은 나도 작가 글 작성!";
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		map.put("pCon", message);
		
		int pointUpU = mService.upPointUser(map);
		int pointUp = bService.upPoint(map);
		
		int rankCheck = mService.muchPoint(id);
		
		if(rankCheck>=0 && rankCheck<=1000) {
			int rank = 1;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
			
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>1000 && rankCheck<=3000) {
			int rank = 2;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
		
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else if(rankCheck>3000 && rankCheck<=7000) {
			int rank = 3;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			return rankChange;
		} else if(rankCheck>7000 && rankCheck<=10000) {
			int rank = 4;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		} else {
			int rank = 0;
			
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
			
			return rankChange;
		}
	}
	
	// 오늘은 나도 작가 = 5 디테일 뷰 컨트롤러
	@RequestMapping("TIWdetail.to")
	public ModelAndView boardDetail(@RequestParam("boardNo") int boardNo, @RequestParam("code") int code,
									@RequestParam("page") int page, @RequestParam(value="cpage", required=false) Integer cpage, 
									ModelAndView mv, HttpSession session) {
		
		Board board = bService.selectTIWBoard(boardNo);
		
		Member login = (Member)session.getAttribute("loginUser");
		String loginUser = login.getId();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("loginUser", loginUser);
		map.put("boardNo", boardNo);
		//map.put("code", code);
				
		int heart = bService.findLike(map) == 1? 1:0;
		
		HashMap<String, Object> sap = new HashMap<String, Object>();
		sap.put("sendId", loginUser);
		sap.put("bNo", boardNo);
		
		int support = bService.findsupport(sap);
		//System.out.println("support"+support);
		HashMap<String, Object> bap = new HashMap<String, Object>();
		bap.put("userId", loginUser);
		bap.put("boardNo", boardNo);
		int bookmark = bService.findbookmark(bap);
		
		String cate = board.getCate();
		
		String[] cates = cate.split("/");
		String categori = cates[0];
		String bookname = cates[1];
	
		if(board != null) {
			mv.addObject("board", board)
				.addObject("page", page)
				.addObject("categori", categori)
				.addObject("bookname", bookname)
				.setViewName("TIWDetailView");
			mv.addObject("heart", heart);
			mv.addObject("support", support);
			mv.addObject("bookmark", bookmark);
		} else {
			throw new BoardException("오늘은 나도 작가 게시글 상세보기를 실패하였습니다.");
		}
		
		return mv;
	}
	
	// 오늘은 나도 작가 = 5 북마크 클릭 컨트롤러
	@ResponseBody
	@RequestMapping("bookmark.to")
	public int bookmark(HttpServletRequest httpRequest) {

		int bookmark = Integer.parseInt(httpRequest.getParameter("bookmark"));
		int boardNo = Integer.parseInt(httpRequest.getParameter("boardNo"));
		String userId = ((Member) httpRequest.getSession().getAttribute("loginUser")).getId();
		Bookmarkto mark = new Bookmarkto();
		
		mark.setBoardNo(boardNo);
		mark.setUserId(userId);
	        
		if(bookmark >= 1) {
			bService.deleteMark(mark);
			bookmark=0;
		} else {
			bService.insertMark(mark);
			bookmark=1;
		}

		return bookmark;

	}
	
	// 오늘은 나도 작가 = 5 좋아요 클릭 컨트롤러
	@ResponseBody
    @RequestMapping("heart.to")
    public int heart(HttpServletRequest httpRequest) {

        int heart = Integer.parseInt(httpRequest.getParameter("heart"));
        int b_no = Integer.parseInt(httpRequest.getParameter("boardNo"));
        String m_no = ((Member) httpRequest.getSession().getAttribute("loginUser")).getId();
        Liketo Like = new Liketo();

        Like.setB_no(b_no);
        Like.setM_no(m_no);
        
        if(heart >= 1) {
            bService.deleteLike(Like);
            bService.updateLike(Like);
            heart=0;
        } else {
        	bService.insertLike(Like);
        	bService.updateLike(Like);
            heart=1;
        }

        return heart;

    }
	
	// 오늘은 나도 작가 = 5후원하기 클릭 컨트롤러
	@ResponseBody
	@RequestMapping("support.to")
	public int support(HttpServletRequest httpRequest, HttpSession session) {
		int support = Integer.parseInt(httpRequest.getParameter("support"));
		int sPoint = 50;
		int bNo = Integer.parseInt(httpRequest.getParameter("boardNo"));
		String sendId = ((Member) httpRequest.getSession().getAttribute("loginUser")).getId();
		String userId = httpRequest.getParameter("userId");
		
		Support suppoint = new Support();

		suppoint.setsPoint(sPoint);
		suppoint.setSendId(sendId);
		suppoint.setbNo(bNo);
		suppoint.setUserId(userId);
	    
		int upSup = bService.updateSupport(suppoint);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", userId);
		map.put("point", sPoint);
		
		HashMap<String, Object> cap = new HashMap<String, Object>();
		map.put("id", sendId);
		map.put("point", sPoint);
		
		if(upSup > 0) {
			support=support+1;
			mService.upPointUser(map);//받은 사람 포인트 상승
			mService.downPointUser(cap);//준 사람 포인트 하락
			int pointD = pointChangeSupD(session);//준사람 포인트 변화
			int pointU = pointChangeSupU(session,userId);//받은사람 포인트 변화
			System.out.println("pointD"+pointD);
			System.out.println("pointU"+pointU);
		}
		
		return support;

	}
	
	private int pointChangeSupU(HttpSession session, String userId) {
		String id = userId;	
		int point = 50;
		String message = "후원받았습니다!";
			
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		map.put("pCon", message);
						
		int rankCheck = mService.muchPoint(id);
		int pointUp = bService.upPoint(map);
			
		if(rankCheck>=0 && rankCheck<=1000) {
			int rank = 1;
					
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else if(rankCheck>1000 && rankCheck<=3000) {
			int rank = 2;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
			
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else if(rankCheck>3000 && rankCheck<=7000) {
			int rank = 3;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
			return rankChange;
		} else if(rankCheck>7000 && rankCheck<=10000) {
			int rank = 4;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else {
			int rank = 0;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		}
	}
	//후원 후 포인트 변화-준 사람
	public int pointChangeSupD(HttpSession session) {
		Member login = (Member)session.getAttribute("loginUser");
		String id = login.getId();	
		int point = 50;
		String message = "후원하였습니다!";
			
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		map.put("pCon", message);
						
		int rankCheck = mService.muchPoint(id);
		int pointUp = bService.upPoint(map);
			
		if(rankCheck>=0 && rankCheck<=1000) {
			int rank = 1;
					
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
				
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else if(rankCheck>1000 && rankCheck<=3000) {
			int rank = 2;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
			
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else if(rankCheck>3000 && rankCheck<=7000) {
			int rank = 3;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
			return rankChange;
		} else if(rankCheck>7000 && rankCheck<=10000) {
			int rank = 4;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		} else {
			int rank = 0;
				
			HashMap<String, Object> cap = new HashMap<String, Object>();
			cap.put("id", id);
			cap.put("rank", rank);
					
			int rankChange=mService.changeRank(cap);
				
			return rankChange;
		}
	}
	
	//댓글 작성
	@RequestMapping("addComments.to")
	@ResponseBody
	public String addComments(@ModelAttribute Comments c, @RequestParam("comment") String comment, HttpSession session) {
	
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getId();
		
		c.setUserId(userId);
		c.setComment(comment);
		 	
		int result = bService.insertComments(c);
		int upCount = bService.updateCount(c);
		
		if(result > 0) {
			return "success";
		} else {
			throw new BoardException("댓글 등록에 실패하였습니다.");
		}
	}

	// 댓글 불러오기
//	@RequestMapping("cList.to")
//	public void getCommentsList(@RequestParam("boardNo") int boardNo, HttpServletResponse response) {
//		
//		ArrayList<Comments> cList = bService.selectCommentsList(boardNo);
//		//System.out.println("cList"+cList);
//		response.setContentType("application/json; charset=UTF-8");
//		Gson gson = new GsonBuilder().setDateFormat("yy-MM-dd").create();
//		try {
//			gson.toJson(cList, response.getWriter());
//		} catch (JsonIOException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
	public void getCommentsList(@RequestParam(value = "page1", required = false, defaultValue = "1") Integer page1,
			@RequestParam("boardNo") int boardNo, HttpServletResponse response) {

		response.setContentType("application/json; charset=UTF-8");
		int currentPage1 = 1;
		
		if(page1 != null) {
	         currentPage1 = page1;
	    }
		
		int listCount = bService.getCommentListCount(boardNo);
		PageInfo pi1 = Pagination.getPageInfo5_1(currentPage1, listCount);
		ArrayList<Comments> cList = bService.selectAnotherComments(boardNo, pi1);
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("cList", cList);
		map.put("pi1", pi1);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();
		try {
			gson.toJson(map, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//댓글수정
	@RequestMapping("commentUp.to")
	@ResponseBody
	public int commentUp(@RequestParam("comment") String bContent,
							@RequestParam("comNo") String comNo,
							@RequestParam("userId") String userId) {
		
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("comNo", comNo);
		map.put("bContent", bContent);
		map.put("userId", userId);
		
		int result = bService.updateComments(map);
		
		return result;
	}
	
	//댓글삭제
	@RequestMapping("commentDe.to")
	@ResponseBody
	public int commentDe(@RequestParam("comNo") String comNo
						,@RequestParam("bNo") String boardNo) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("comNo", comNo);
		map.put("boardNo", boardNo);
		
		int result = bService.deleteComments(comNo);
		int upCount = bService.deleteCount(boardNo);
			
		return result;
	}
	
	
	// 오늘은 나도 작가 = 5 글 수정 폼 이동 컨트롤러
	@RequestMapping("TIWUpdateView.to")
	public ModelAndView TIWUpdateView(@RequestParam("boardNo") int boardNo, @RequestParam("page") int page, ModelAndView mv) {
		
		Board board = bService.selectupTIWBoard(boardNo);
		
		mv.addObject("board", board)
		  .addObject("page", page)
		  .setViewName("TIWUpdateForm");
		
		return mv;
	}
	
	// 오늘은 나도 작가 = 5 글 수정 컨트롤러
	@RequestMapping("TIWupdate.to")
	public ModelAndView TIWupdate(
							@ModelAttribute Board b, @RequestParam("code1") String code1,
							@RequestParam("code2") String code2,@RequestParam("boardNo") int boardNo,
							@RequestParam("page") int page, HttpServletRequest request,
							ModelAndView mv) {
		
		b.setCate(code1+"/"+code2);
		b.setBoardNo(boardNo);
		
		int result = bService.updateTIWBoard(b);
		
		if(result > 0) {
			mv.addObject("page", page)
			  .setViewName("redirect:TIWdetail.to?boardNo=" + b.getBoardNo());
		} else {
			throw new BoardException("게시글 등록을 실패하였습니다.");
		}
		
		return mv;
	}
	
	//오늘은 나도 작가 = 5 게시글 삭제 
	@RequestMapping("TIWDelete.to")
	public String boardDelete(@RequestParam("boardNo") int boardNo) {
			
		int result = bService.deleteTIWBoard(boardNo);
			
		if(result > 0) {
			return "redirect:goTIWList.to";
		} else {
			throw new BoardException("게시글 삭제에 실패했습니다.");
		}
	}
	
	//오늘은 나도 작가 = 5 게시글 검색
		@RequestMapping("searchTIW.to")
		public ModelAndView searchTIW(@ModelAttribute SearchCondition serchC,
										HttpServletRequest request, HttpServletResponse response, 
										ModelAndView mv) {
			
			String condition = request.getParameter("searchCondition");
			String value = request.getParameter("searchValue");
			
			if(condition.equals("writer")) {
				serchC.setWriter(value);
			} else if(condition.equals("title")) {
				serchC.setTitle(value);
			} else if(condition.contentEquals("content")) {
				serchC.setContent(value);
			}
			//currentPage 설정
			int currentPage = 1; //기본
			if(request.getParameter("currentPage") != null) { //currentPage가 들어 왔다면
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
				//넘어온 currentPage 값을 넣어준다
			}
			int listCount = bService.getSearchTIWResultListCount(serchC);
			//검색을 어떤걸로 할지에 따라 세팅된 sc를 매개변수로 넣어줘야한다
			
			PageInfo pi = Pagination.getPageInfo5(currentPage, listCount);
			//System.out.println("pi"+pi);
			ArrayList<Board> list = bService.selectSerchTIWResultList(serchC, pi);
			
			if(list != null) {
				mv.addObject("list", list)
				.addObject("pi", pi)
				.addObject("searchCondition", condition)
				.addObject("searchValue", value)
				.setViewName("TIWSearchListForm");
			} else {
				throw new BoardException("오늘은 나도 작가 게시글 검색 조회에 실패했습니다.");
			}
			
			return mv;
			
		}
		
	//오늘은 나도 작가 = 5 게시글 카테고리 통한 동일 작품 검색
	@RequestMapping("searchTIWCate.to")
	public ModelAndView searchTIWCate(@ModelAttribute SearchCate serCa,
									@RequestParam("cate") String cate, @RequestParam("userId") String userId,
									HttpServletRequest request, HttpServletResponse response, 
									ModelAndView mv) {		
		//currentPage 설정
		int currentPage = 1; //기본
		if(request.getParameter("currentPage") != null) { //currentPage가 들어 왔다면
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			//넘어온 currentPage 값을 넣어준다
		}
			
			int listCount = bService.getSearchCateResultListCount(serCa);
			//검색을 어떤걸로 할지에 따라 세팅된 sc를 매개변수로 넣어줘야한다
			
			PageInfo pi = Pagination.getPageInfo5(currentPage, listCount);
			
			ArrayList<Board> list = bService.selectSearchCateResultList(serCa, pi);
			
			if(list != null) {
				mv.addObject("list", list);
				mv.addObject("pi", pi);
				mv.setViewName("TIWSearchListForm");
			} else {
				throw new BoardException("오늘은 나도 작가 게시글 카테고리 검색 조회에 실패했습니다.");
			}
			
			return mv;
			
		}	
	
	//오늘은 나도 작가 검색 자동완성 컨트롤러
	@RequestMapping("searchTIWsub.to")
	public void searchTTitle(@RequestParam("tTitle") String bTitle,@RequestParam("searchCondition") String condition,
								@ModelAttribute SearchCondition serchC,
								HttpServletRequest request, HttpServletResponse response
								, ModelAndView mv) {
		response.setContentType("application/json; charset=UTF-8");	
		ArrayList<Board> tlist = null;
			
		if(condition.equals("writer")) {
			String userId = bTitle;
			tlist = bService.selectSearchTTitleListWriter(userId);
		} else if(condition.equals("title")) {
			tlist = bService.selectSearchTTitleListTitle(bTitle);
		} else if(condition.contentEquals("content")) {
			String bContent = bTitle;
			tlist = bService.selectSearchTTitleListContent(bContent);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();
			
		try {
			gson.toJson(tlist, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	
	////////////////오늘은 나도 작가(TIW) 컨트롤러////////////////////////

	// 관리자 창 : 공지사항 ----------------------------------------------------
	@RequestMapping("notice.ad")
	public ModelAndView noticetAdminView(@RequestParam(value="page", required=false) Integer page,
										ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int code = 0;
		int listCount = bService.getListCount(code);
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Board> list = bService.selectList(pi, code);
		if(list != null) {
			mv.addObject("list", list)
				.addObject("pi", pi)
				.addObject("page", page)
				.setViewName("notice");
		}else {
			throw new BoardException("공지사항 게시글 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	// 관리자 창 : 문의사항 ----------------------------------------------------
	@RequestMapping("inquiry.ad")
	public ModelAndView inquiryAdminView(@RequestParam(value="page", required=false) Integer page,
									ModelAndView mv) {
		int currentPage = 1;
		if(page != null) {
			currentPage = page;
		}
		int code = 1;
		int listCount = bService.getListCount(code);
		PageInfo pi = Pagination.getPageInfo1(currentPage, listCount);
		ArrayList<Board> list = bService.selectList(pi, code);
		if(list != null) {
			mv.addObject("list", list)
				.addObject("pi", pi)
				.setViewName("inquiry");
		}else {
			throw new BoardException("문의사항 게시글 전체 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	// B ---------------------------------------------------------금민석
	@RequestMapping("booklist.bo")
	public String bookListView() {
		return "noticeWriteForm"; //수정한 jsp파일 이름 집어넣기 !
	}
	
	
	// 파일  메소드 -----------------------------------------------------------------
	public Attachment saveFile(MultipartFile file, HttpServletRequest request, int code) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";
		File folder = new File(savePath);
		if(!folder.exists()) {
			folder.mkdir();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		int ranNum = (int)(Math.random()*100000);

		String originFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new Date(System.currentTimeMillis()))  + ranNum
								+ "." + originFileName.substring(originFileName.lastIndexOf(".") + 1);
		String renamePath = folder + "\\" + renameFileName;
		Attachment at = new Attachment();
		at.setAtcCode(code);
		at.setAtcOrigin(file.getOriginalFilename());
		at.setAtcName(renameFileName);
		at.setAtcPath(savePath);

		
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return at;
	}

	
	


	private void deleteFile(String atcName, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root+"\\buploadFiles";
		File f = new File(savePath + "\\" + atcName);
		if(f.exists()) {
			f.delete();
		}
	}
	//----------------------------------------------------------------------------

	
	
	@RequestMapping("myPayList.me")
	public ModelAndView myPayListForm(@RequestParam(value = "searchCondition", required = false) String searchCondition, @RequestParam(value = "searchValue", required = false) String searchValue, ModelAndView mv  , @RequestParam(value = "page", required = false) Integer page, HttpSession session) {
		
		
		
		
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
			int listCount = bService.getMyPayListCount(sc);
			
			System.out.println("listcount= "+ listCount);
			
			
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			
			ArrayList<Pay> list = bService.SeachMyPayList(sc,pi);
			
			System.out.println(list);
			
			mv.addObject("list", list);
			
			mv.addObject("pi", pi);
			
			
			
			mv.addObject("searchCondition",condition);
				
			mv.addObject("searchValue",value);
			
			
			
			
			
			mv.setViewName("myPayList");
			
			
		} catch (BoardException e) {
			
			
			throw new BoardException("구매 리스트 삭제 실패");
			
		}
		
		
		
		
		
		return mv; 
	}
	
	@RequestMapping("myPayDelete.me")
	public ModelAndView myPayDelete(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue,@RequestParam(value = "inFo", required = false) String inFo, ModelAndView mv ,@RequestParam(value = "code", required = false) Integer code , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
	

		
		
		
		
		String list = inFo;
		
		String [] lists = list.split(",");
		
		for(String s : lists) {
			
			System.out.println(s);
			
			
			
		}
		
		
		int result = bService.myPayDelete(lists);
		
		

	

		if (result > 0) {

			
			
			mv.addObject("page", page);
			

			
			
			if(searchValue!=null) {

				mv.addObject("searchCondition",searchCondition);
					
				mv.addObject("searchValue",searchValue);
			}
		
			
			
			
			mv.setViewName("redirect:myPayList.me");
		} else {

			throw new BoardException("구매 리스트 삭제 실패");
		}

		return mv;

	}
	
	@RequestMapping("mBlistDelete.me")
	public ModelAndView boardList(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue,@RequestParam(value = "inFo", required = false) String inFo, ModelAndView mv ,@RequestParam(value = "code", required = false) Integer code , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
	

		
		
		
		
		String list = inFo;
		
		String [] lists = list.split(",");
		
		for(String s : lists) {
			
			System.out.println(s);
			
			
			
		}
		
		
		int result = bService.deletemBList(lists);
		
		

	

		if (result > 0) {

			
			
			mv.addObject("page", page);
			mv.addObject("code",code);

			
			
			if(searchValue!=null) {

				mv.addObject("searchCondition",searchCondition);
					
				mv.addObject("searchValue",searchValue);
			}
		
			
			
			
			mv.setViewName("redirect:myList.me");
		} else {

			throw new BoardException("마이페이지 게시글 조회 실패");
		}

		return mv;

	}
	


	
	@RequestMapping("myLikeDelete.me")
	public ModelAndView myLikeDelete(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue,@RequestParam(value = "inFo", required = false) String inFo, ModelAndView mv , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
	

		
		
		
		
		String list = inFo;
		
		String [] lists = list.split(",");
		
		for(String s : lists) {
			
			System.out.println(s);
			
			
			
		}
		
		
		
		
		int result = bService.myLikeDelete(lists);
		
		

	

		if (result > 0) {

			
			
			mv.addObject("page", page);
			

			
			
			if(searchValue!=null) {

				mv.addObject("searchCondition",searchCondition);
					
				mv.addObject("searchValue",searchValue);
			}
		
			
			
			
			mv.setViewName("redirect:myLikeList.me");
		} else {

			throw new BoardException("좋아요 리스트 삭제 실패");
		}

		return mv;

	}



	@RequestMapping("myList.me")
	public ModelAndView mSearchList(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue, ModelAndView mv ,@RequestParam("code") Integer code , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
		// 마이페이지에서 검색
		
		
		Member loginUser = (Member)session.getAttribute("loginUser");
	 	
	 	String mId = loginUser.getId();
		
	 	
	 	
	
		
		

		
		
		int currentPage = 1 ;
		
		if(page != null) {
			
			currentPage = page;
			
		}
		
		SearchCondition sc = new SearchCondition();
		
		
		sc.setCode(code);
	
		sc.setmId(mId);
		
		
		String condition =null;
		
		String value =null;
		
		if(searchValue != null) {
			
			
			
			condition =searchCondition;
			
			value =  searchValue;
			
			
			if (condition.equals("Title")) {
				
				sc.setTitle(value);
			}else if (condition.equals("내용")) {
				
				sc.setContent(value);
			}
		}
		
		
		
		System.out.println("sc= " +sc);
		
		
		try {
			int listCount = bService.getSearchMyListCount(sc);
			
			System.out.println("listcount= "+ listCount);
			
			
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			
			ArrayList<Board> list = bService.SeachMyList(sc,pi);
			
			System.out.println(list);
			
			mv.addObject("list", list);
			
			mv.addObject("pi", pi);
			
			
			
			mv.addObject("searchCondition",condition);
				
			mv.addObject("searchValue",value);
			
			mv.addObject("code",code);
			
			
			
			mv.setViewName("myPageList");
			
			
		} catch (BoardException e) {
			
			
			throw new BoardException("마이페이지 게시글 검색 실패");
			
		}

		

		return mv;

	}
	
	
	
	
	@RequestMapping("myLikeList.me")
	public ModelAndView myLikeList(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue, ModelAndView mv , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
		// 마이페이지에서 검색
		
		
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
			
			
			if (condition.equals("Title")) {
				
				sc.setTitle(value);
			}else if (condition.equals("내용")) {
				
				sc.setContent(value);
			}
		}
		
		
		
		System.out.println("sc= " +sc);
		
		
		try {
			int listCount = bService.MyLikeCount(sc);
			
			System.out.println("listcount= "+ listCount);
			
			
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			
			ArrayList<Board> list = bService.MyLikeList(sc,pi);
			
			System.out.println(list);
			
			mv.addObject("list", list);
			
			mv.addObject("pi", pi);
			
			
			
			mv.addObject("searchCondition",condition);
				
			mv.addObject("searchValue",value);
			
		
			
			
			
			mv.setViewName("myLikeList");
			
			
		} catch (BoardException e) {
			
			
			throw new BoardException("마이페이지 좋아요 리스트 실패");
			
		}

		

		return mv;

	}
	
	

	
	
	@RequestMapping("myPointList.me")
	public ModelAndView myPointList(Model model,@RequestParam(value = "searchCondition", required = false) String searchCondition, @RequestParam(value = "searchValue", required = false) String searchValue, ModelAndView mv  , @RequestParam(value = "page", required = false) Integer page, HttpSession session) {
		
		
		
		
		 Member loginUser = mService.memberLogin((Member)session.getAttribute("loginUser"));
		
		
		System.out.println(loginUser);
		
		
		
		
		model.addAttribute("loginUser", loginUser);
		
		
		
		
		
		
		
	 	
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
				
			}else if (condition.equals("적립내역")) {
				
				sc.setContent(value);
			}
		}
		
		
		
		System.out.println("sc= " +sc);
		
		
		try {
			int listCount = bService.MyPointListCount(sc);
			
			System.out.println("listcount= "+ listCount);
			
			
			
			PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
			
			
			ArrayList<Point> list = bService.MyPointList(sc,pi);
			
			System.out.println(list);
			
			mv.addObject("list", list);
			
			mv.addObject("pi", pi);
			
			
			
			mv.addObject("searchCondition",condition);
				
			mv.addObject("searchValue",value);
			
			
			
			
			
			mv.setViewName("myPointList");
			
			
		} catch (BoardException e) {
			
			
			throw new BoardException("포인트 리스트 조회 실패");
			
		}
		
		
		
		
		
		return mv; 
	}
	
	@RequestMapping("myPointDelete.me")
	public ModelAndView myPointDelete(@RequestParam(value = "searchCondition", required = false) String searchCondition,@RequestParam(value = "searchValue", required = false) String searchValue,@RequestParam(value = "inFo", required = false) String inFo, ModelAndView mv ,@RequestParam(value = "code", required = false) Integer code , @RequestParam(value = "page", required = false) Integer page,HttpSession session) {
	

		
		
		
		
		String list = inFo;
		
		String [] lists = list.split(",");
		
		for(String s : lists) {
			
			System.out.println(s);
			
			
			
		}
		
		
		int result = bService.myPointDelete(lists);
		
		

	

		if (result > 0) {

			
			
			mv.addObject("page", page);
			

			
			
			if(searchValue!=null) {

				mv.addObject("searchCondition",searchCondition);
					
				mv.addObject("searchValue",searchValue);
			}
		
			
			
			
			mv.setViewName("redirect:myPointList.me");
		} else {

			throw new BoardException("포인트 리스트 삭제 실패");
		}

		return mv;

	}
	
	
	@RequestMapping("searchComplete.me")
	@ResponseBody
	public String searchLike(@RequestParam("tTitle") String bTitle,@RequestParam("searchCondition") String condition,
			HttpServletRequest request, HttpServletResponse response
			, ModelAndView mv , HttpSession session) {
		
		response.setContentType("application/json; charset=UTF-8");	
		System.out.println(bTitle+"검색단어");
		System.out.println("condition" + condition + "?");
		ArrayList<String> tlist = null;
		
		
		
		
		
		Member loginUser = (Member)session.getAttribute("loginUser");
	 	
	 	String mId = loginUser.getId();
		
	 	
	 	
		
		SearchCondition sc = new SearchCondition();
		
		
		
	
		sc.setmId(mId);
		
		
		
		
		
		if (condition.equals("Title")) {
			
			sc.setTitle(bTitle);
			
		}else if (condition.equals("내용")) {
			
			sc.setContent(bTitle);
		}
		
		
		System.out.println("sc = " + sc);
		
		tlist = bService.searchLikeList(sc);
		
		System.out.println(tlist);
		

		
		//return tlist;
		
		String [] array= tlist.toArray(new String[tlist.size()]);
		
		
		
		
		Gson gson = new Gson();

	    return gson.toJson(array);
	    
	    
		




}
	
	
	
	
	
	
	@RequestMapping("test.me")
	public String test() {
		return "test"; //수정한 jsp파일 이름 집어넣기 !
	}
	
	
	
	// ====================================================================================================================


	// ------------------------------------------------------------------------ 책방
		@RequestMapping("gobookr.bo")
		public ModelAndView gobookr(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) { // ModelAndView
																														// 는
																														// 값을
																														// 화면에
																														// 전달할때
																														// 쓰는
																														// 객체
			int currentPage = 1; // currentPage 현재 페이지
			if (page != null) { // page 값이 null 이 아닐때 currentPage에 page라는 값이 넣어진다
				currentPage = page;
			}
			int code = 3; // 책방 관한 게시물을 가져올때 코드를 지정하여 다른게시물과 차별점을 두어 구별할수있게 지정한 코드의 게시물만 가져올수있게 한다
			int listCount = bService.getListCount(code);// 총 게시물 갯수

			PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);// PageInfo는 게시물 페이징을 설정 하는 객체
			ArrayList<Board> bList = bService.selectList(pi, code); // selectList 총 게시물을 불러오는 함수 // 총 게시물 리스트를 받아오는 객체
			// 객체를 여러개 담을수 있는 객체
			/* ArrayList<Attachment> atList = bService.gobookr("Code"); */
			/* bService.selectAttachmentTList(code); */
			ArrayList<Attachment> atList = bService.selectAttachmentTList(code); // 첨부파일 리스트 받아오는 객체 (썸네일만 가져오게 해놓은것)
			ArrayList<Book> bookList = b_Service.selectList(pi, code); // 첨부파일 리스트 받아오는 객체 (썸네일만 가져오게 해놓은것)
			System.out.println(atList);
			System.out.println(bookList);
			System.out.println(bList.size());
			if (bList != null) {
				mv.addObject("bList", bList) // addObject 는 값을 mv에 값을 넣어주는 메소드
						.addObject("pi", pi)
						.addObject("atList", atList)
						.addObject("bookList", bookList)
						.setViewName("gobookr");// setViewName view 이름을
																								// 지정해준다
			} else {
				throw new BoardException("책방 게시글 전체 조회에 실패하였습니다."); // 사용자 예외를 발생시켰을때 "게시글 전체 조회에 실패하였습니다." 라고 오류 메시지를 띄움
			}
			return mv; // 최종 반환값을 mv로 반환해준다.
		}

		@RequestMapping("write.bo") 
		public String bookD() {
			return "bookD";
		}

		@RequestMapping("insert.bo") // 
		public String bookReviewInsert1(@ModelAttribute Board b, // @ModelAttribute 가 Board 라는 객체를 생성해준다
				@RequestParam(value = "uploadFile", required = false) MultipartFile[] uploadFile, HttpServletRequest request,
				@ModelAttribute Book book) {

			Member member = (Member)(request.getSession().getAttribute("loginUser")); 
			String userId = member.getId(); // 맴버 객체 안에서 userId 라는 값을 가져온다.
			b.setUserId(userId); // userId 를 b에 담는다
			b.setCode(3); // 해당 게시판을 식별할수있는 코드를 b에 담는다.

			ArrayList<Attachment> atList = new ArrayList<Attachment>(); // ArrayList<Attachment>() ArrayList안에
			
			if (uploadFile.length != 0) { // 업로드파일이 !=0 (없을시)
				b.setCode(3); // 공지사항 코드
				for (int i = 0; i < uploadFile.length; i++) {// 업르드 파일의 수만큼 돌린다
					Attachment at = saveFile(uploadFile[i], request, 3); // 업로드 파일 저장하기 위해 파일이름 구별하여 저장하기 위해 사용하고 saveFile에
					if (i == uploadFile.length -1) {
						at.setAtcLevel(0); // setAtcLevel() 썸내일 을 설정해주는 메소드
					} else {
						at.setAtcLevel(1);// setAtcLevel(1); 가로안에 1이 들어가면 썸내일이 아니다
					}
					atList.add(at); // 여러개의 파일을 담을수있는 객체를 at라는객체를 add라는 메소드를 통하여 추가로 담아준다.
				}
			}
			int result = bService.insertBoardAndFiles(b, atList);
			int result2 = b_Service.insertBook(book);
			
			if (result > 0 && result2 > 0) {
				return "redirect:book.bo";
			} else {
				throw new BoardException("책리뷰 게시물 작성에 실패하였습니다.");
			}
		}

		@RequestMapping("redetail.bo")
		public ModelAndView bookroomD(@RequestParam("boardNo") int boardNo,
				@RequestParam("page") int page, ModelAndView mv) {
			Board board = bService.selectBoard(boardNo);
			ArrayList<Attachment> atlist = bService.selectAttachmentList(boardNo);
			
			if (board != null) {
				

				mv.addObject("board", board);
				mv.addObject("atlist", atlist);
				mv.addObject("page", page);
				mv.setViewName("bookRD");// 북 상세페이지
			}
			return mv;
		}

		@RequestMapping("delete.bo")
		public String deleteReviewBoard1(@RequestParam("boardNo") int boardNo) {
			int result = bService.deleteBoardAndFile(boardNo);
			if (result > 0) {
				return "redirect:book.bo";
			} else {
				throw new BoardException("리뷰 게시물 삭제에 실패하였습니다.");
			}
		}

		@RequestMapping("book.bo")
		public ModelAndView bookreviewList1(@RequestParam(value = "page", required = false) Integer page, ModelAndView mv) {
			int currentPage = 1;
			if (page != null) {
				currentPage = page;
			}
			int code = 3;
			int listCount = bService.getListCount(code);

			PageInfo pi = Pagination.getPageInfo2(currentPage, listCount);
			ArrayList<Board> bList = bService.selectList(pi, code);
			ArrayList<Attachment> atList = bService.selectAttachmentTList(code);

			if (bList != null) {
				mv.addObject("bList", bList).addObject("pi", pi).addObject("atList", atList)

						.setViewName("gobookr");
			} else {
				throw new BoardException("책리뷰 게시글 전체 조회에 실패하였습니다.");
			}
			return mv;
		}
		@RequestMapping("modify.bo")
		public ModelAndView bookReviewModifyView(@RequestParam("boardNo") int boardNo, @RequestParam("page") int page,
										ModelAndView mv) {
			Board board = bService.selectBoardExceptAddCount(boardNo);
			/* Attachment at = bService.selectAttachment(boardNo); */
			ArrayList<Attachment> atlist = bService.selectAttachmentList(boardNo);
			if(board != null) {
				/*
				 * String booktitle =
				 * board.getbContent().substring(0,(board.getbContent()).indexOf("#책제목"));
				 * String exbook =
				 * board.getbContent().substring((board.getbContent()).indexOf("#책제목")+4);
				 * String author = exbook.substring(0,exbook.indexOf("#작가")); String exauthor =
				 * exbook.substring(exbook.indexOf("#작가") + 3); String content =
				 * exauthor.substring(exauthor.indexOf("#명언") + 3);
				 * 
				 * board.setbContent(content);
				 * 
				 * mv.addObject("board", board) .addObject("page", page) .addObject("booktitle",
				 * booktitle) .addObject("author", author) .addObject("at", at)
				 * .setViewName("bUpdateForm");
				 */
				
				
				
				String booktitle = board.getbContent().substring(0, (board.getbContent()).indexOf("#책제목"));
				String exbook = board.getbContent().substring((board.getbContent()).indexOf("#책제목") + 4);
				String author = exbook.substring(0, exbook.indexOf("#작가"));
				String exauthor = exbook.substring(exbook.indexOf("#작가") + 3);
				String content = exauthor.substring(exauthor.indexOf("#명언") + 3);

				board.setbContent(content);

				mv.addObject("board", board);
				mv.addObject("atlist", atlist);
				mv.addObject("booktitle", booktitle);
				mv.addObject("author", author);
				mv.addObject("page", page);
				mv.setViewName("bUpdateForm");
				
				

			}else {
				throw new BoardException("리뷰 게시판 수정하기에 값을 불러오는데 실패하였습니다.");
			}
			
			return mv;
		}
		// 수정하기
		@RequestMapping("update.bo")
		public ModelAndView bookRD(@RequestParam("page") int page, @ModelAttribute Board b,
										@RequestParam("reloadFile") MultipartFile[] reloadFile,
										HttpServletRequest request, @ModelAttribute  Attachment at,
										ModelAndView mv,
										@RequestParam("booktitle") String booktitle,
										@RequestParam("author") String author,
										@RequestParam("wise") String wise) {
			
			String contentAddTag =  booktitle + "#책제목"  + author + "#작가" + b.getbContent();//b.getbContent() 이거 뭐죠?
			b.setbContent(contentAddTag);
			
			if (reloadFile.length != 0) { // 업로드파일이 !=0 (없을시)
				b.setCode(3); // 공지사항 코드
				for (int i = 0; i < reloadFile.length; i++) {// 업르드 파일의 수만큼 돌린다
					/*Attachment at = saveFile(uploadFile[i], request, 3);*/ // 업로드 파일 저장하기 위해 파일이름 구별하여 저장하기 위해 사용하고 saveFile에
																			// uploadFile[i], request, 3 의 값을 받아와 Attachment
																			// at 에 담아준다.
					ArrayList<Attachment> atList = new ArrayList<Attachment>();
					if (i == reloadFile.length -1) {
						at.setAtcLevel(0); // setAtcLevel() 썸내일 을 설정해주는 메소드
					} else {
						at.setAtcLevel(1);// setAtcLevel(1); 가로안에 1이 들어가면 썸내일이 아니다
					}
					atList.add(at); // 여러개의 파일을 담을수있는 객체를 at라는객체를 add라는 메소드를 통하여 추가로 담아준다.
				}
			}
			int result = bService.updateBoardAndFile(b,at);
			
			if(result > 0) {
				Board board = bService.selectBoard(b.getBoardNo());
				Attachment attach = bService.selectAttachment(b.getBoardNo());// 이거 여러
				mv.addObject("board", board)
				  .addObject("boardNo", b.getBoardNo())
				  .addObject("page", page)
				  .addObject("at", attach)
				  .setViewName("redirect:redetail.bo");
			}else {
				throw new BoardException("리뷰 게시물 수정에 실패하였습니다.");
			}
			
			return mv;
		}
		
		@RequestMapping("cart.bo") // ****-------------------이거랑pcs.bo
		public String bookCart() {
			return "bookCart";
			}
		@RequestMapping("pcs.bo") 
		public String bookPurchase() {
			return "bookPurchase";	
			}
		/*
		 * @RequestMapping("delete.rr") public String
		 * deletebook(@RequestParam("boardNo") int boardNo) { int result =
		 * bService.deleteBoardAndFile(boardNo); if(result > 0) { return
		 * "redirect:book.rr"; }else { throw new BoardException("리뷰 게시물 삭제에 실패하였습니다.");
		 * } }
		 */

	}
