package com.kh.Reader25.board.model.vo;

public class Bookmarkto {
	private int bmkNo;
	private int boardNo;
	private String userId;
	
	public Bookmarkto() {
		
	}

	public Bookmarkto(int bmkNo, int boardNo, String userId) {
		super();
		this.bmkNo = bmkNo;
		this.boardNo = boardNo;
		this.userId = userId;
	}

	public int getBmkNo() {
		return bmkNo;
	}

	public void setBmkNo(int bmkNo) {
		this.bmkNo = bmkNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Bookmark [bmkNo=" + bmkNo + ", boardNo=" + boardNo + ", userId=" + userId + "]";
	}
	
	
}
