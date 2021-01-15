package com.kh.Reader25.common;

import com.kh.Reader25.board.model.vo.PageInfo;

public class Pagination {
	public static PageInfo getPageInfo1(int currentPage, int listCount) {
		// 공지사항, 문의사항 
		
		int pageLimit = 5;
		int maxPage;
		int startPage;
		int endPage;
		int boardLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1)/pageLimit * pageLimit  + 1;
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		return pi;
	}
	public static PageInfo getPageInfo2(int currentPage, int listCount) {
		// 북리뷰
		
		int pageLimit = 5;
		int maxPage;
		int startPage;
		int endPage;
		int boardLimit = 18;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1)/pageLimit * pageLimit  + 1;
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		return pi;
	}

	

	
	// 기본
	public static PageInfo getPageInfo(int currentPage, int listCount) {
		
		
		int pageLimit= 10;
		int maxPage;
		
		int startPage;
		
		int endPage;
		
		int boardLimit = 5;
		
		
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		
		startPage = (currentPage-1)/pageLimit*pageLimit+1;
		
		endPage = startPage + pageLimit -1;
		
		if(maxPage < endPage) {
			
			endPage =maxPage;
		}
		
		
		
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		
		
		
		return pi;
	}
	


	public static PageInfo getPageInfo3(int currentPage, int listCount) {
		// 리뷰 디테일 페이징
		
		int pageLimit = 5;
		int maxPage;
		int startPage;
		int endPage;
		int boardLimit = 5;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1)/pageLimit * pageLimit  + 1;
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		return pi;
	}
	public static PageInfo getPageInfo5(int currentPage, int listCount) {
		// TIW 오늘은 나도 작가
		
		int pageLimit = 10;
		int maxPage;
		int startPage;
		int endPage;
		int boardLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1)/pageLimit * pageLimit  + 1;
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		return pi;
	}

	public static PageInfo getPageInfo5_1(int currentPage, int listCount) {
		// TIW 오늘은 나도 작가 - 댓글
		
		int pageLimit = 5;
		int maxPage;
		int startPage;
		int endPage;
		int boardLimit = 5;
		
		maxPage = (int)Math.ceil((double)listCount/boardLimit);
		startPage = (currentPage - 1)/pageLimit * pageLimit  + 1;
		endPage = startPage + pageLimit - 1;
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		PageInfo pi = new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
		return pi;
	}

}
