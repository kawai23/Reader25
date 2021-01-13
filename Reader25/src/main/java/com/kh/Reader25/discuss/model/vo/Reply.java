package com.kh.Reader25.discuss.model.vo;

import java.sql.Date;

public class Reply {
	private int rNo;
	private String rContent;
	private Date rDate;
	private String rStatus;
	private String rWhether;
	private String rWriter;
	private int dNo;
	
	public Reply() {}

	public Reply(int rNo, String rContent, Date rDate, String rStatus, String rWhether, String rWriter, int dNo) {
		super();
		this.rNo = rNo;
		this.rContent = rContent;
		this.rDate = rDate;
		this.rStatus = rStatus;
		this.rWhether = rWhether;
		this.rWriter = rWriter;
		this.dNo = dNo;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public Date getrDate() {
		return rDate;
	}

	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}

	public String getrStatus() {
		return rStatus;
	}

	public void setrStatus(String rStatus) {
		this.rStatus = rStatus;
	}

	public String getrWhether() {
		return rWhether;
	}

	public void setrWhether(String rWhether) {
		this.rWhether = rWhether;
	}

	public String getrWriter() {
		return rWriter;
	}

	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}

	public int getdNo() {
		return dNo;
	}

	public void setdNo(int dNo) {
		this.dNo = dNo;
	}

	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", rContent=" + rContent + ", rDate=" + rDate + ", rStatus=" + rStatus
				+ ", rWhether=" + rWhether + ", rWriter=" + rWriter + ", dNo=" + dNo + "]";
	}
	
	
}
