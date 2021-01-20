package com.kh.Reader25.board.model.vo;

public class Point {
	
	private int pNo;
	private String pCon;
	private String id;
	private int point;
	
	public Point() {
		
	}

	public Point(int pNo, String pCon, String id, int point) {
		super();
		this.pNo = pNo;
		this.pCon = pCon;
		this.id = id;
		this.point = point;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getpCon() {
		return pCon;
	}

	public void setpCon(String pCon) {
		this.pCon = pCon;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	@Override
	public String toString() {
		return "Point [pNo=" + pNo + ", pCon=" + pCon + ", id=" + id + ", point=" + point + "]";
	}

	
	
}
