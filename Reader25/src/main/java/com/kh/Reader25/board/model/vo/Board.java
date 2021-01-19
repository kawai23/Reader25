package com.kh.Reader25.board.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class Board {
	private int boardNo;
	private String bTitle;
	private String bContent;
	private int bCount;
	private int bLike;
	private int comCount;
	private String bStatus;
	private Date  enrollDay;
	private Date updateDay;
	// 0 : 공지사항 1: 문의사항 2: 리뷰 3: 책방 4: 책쓰기5:오늘은 나도 작가 6:좋아요
	private String cate;
	private int code;
	private String userId;
	
	public Board() {}

	public Board(int boardNo, String bTitle, String bContent, int bCount, int bLike, int comCount, String bStatus,
			Date enrollDay, Date updateDay, String cate, int code, String userId) {
		super();
		this.boardNo = boardNo;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bCount = bCount;
		this.bLike = bLike;
		this.comCount = comCount;
		this.bStatus = bStatus;
		this.enrollDay = enrollDay;
		this.updateDay = updateDay;
		this.cate = cate;
		this.code = code;
		this.userId = userId;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public int getbCount() {
		return bCount;
	}

	public void setbCount(int bCount) {
		this.bCount = bCount;
	}

	public int getbLike() {
		return bLike;
	}

	public void setbLike(int bLike) {
		this.bLike = bLike;
	}

	public int getComCount() {
		return comCount;
	}

	public void setComCount(int comCount) {
		this.comCount = comCount;
	}

	public String getbStatus() {
		return bStatus;
	}

	public void setbStatus(String bStatus) {
		this.bStatus = bStatus;
	}

	public Date getEnrollDay() {
		return enrollDay;
	}

	public void setEnrollDay(Date enrollDay) {
		this.enrollDay = enrollDay;
	}

	public Date getUpdateDay() {
		return updateDay;
	}

	public void setUpdateDay(Date updateDay) {
		this.updateDay = updateDay;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", bTitle=" + bTitle + ", bContent=" + bContent + ", bCount=" + bCount
				+ ", bLike=" + bLike + ", comCount=" + comCount + ", bStatus=" + bStatus + ", enrollDay=" + enrollDay
				+ ", updateDay=" + updateDay + ", cate=" + cate + ", code=" + code + ", userId=" + userId + "]";
	}
}
