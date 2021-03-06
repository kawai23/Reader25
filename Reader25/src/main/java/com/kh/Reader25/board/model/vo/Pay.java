package com.kh.Reader25.board.model.vo;

import java.sql.Date;

public class Pay {
	
	
	private int pay_no;
	
	private String book_name;
	
	private int book_v;
	private int price;
	
	private String pay_status;
	
	private Date pay_date;
	
	private String userId;
	
	private int book_no;
	
	private String status; //삭제 여부
	
	private String seller;
	
	private String account;
	
	private int BOARD_NO;
	
	private String PC_STATUS;

	public Pay() {
		
	}
	
	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pay_date, String userId,
			int book_no, String status, String seller,String account) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		this.pay_date = pay_date;
		this.userId = userId;
		this.book_no = book_no;
		this.status = status;
		this.seller = seller;
		this.account = account;
	}
	
	
	
	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pay_date, String userId,
			String seller, String account) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		this.pay_date = pay_date;
		this.userId = userId;
		this.seller = seller;
		this.account = account;
	}

	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pay_date, String userId,
			int book_no) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		this.pay_date = pay_date;
		this.userId = userId;
		this.book_no = book_no;
	}
	
	
	
	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pay_date, String userId,
			int book_no, String status) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		this.pay_date = pay_date;
		this.userId = userId;
		this.book_no = book_no;
		this.status = status;
	}
	
	
	public Pay(int book_v, int price, String userId, int book_no) {
		super();
		this.book_v = book_v;
		this.price = price;
		this.userId = userId;
		this.book_no = book_no;
	}

	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pay_date, String userId,
			int book_no, String status, String seller, int bOARD_NO, String pC_STATUS, String account) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		this.pay_date = pay_date;
		this.userId = userId;
		this.book_no = book_no;
		this.status = status;
		this.seller = seller;
		BOARD_NO = bOARD_NO;
		PC_STATUS = pC_STATUS;
		this.account = account;
	}

	public int getPay_no() {
		return pay_no;
	}

	public void setPay_no(int pay_no) {
		this.pay_no = pay_no;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public int getBook_v() {
		return book_v;
	}

	public void setBook_v(int book_v) {
		this.book_v = book_v;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getPay_status() {
		return pay_status;
	}

	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}

	public Date getPay_date() {
		return pay_date;
	}

	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getBook_no() {
		return book_no;
	}

	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public int getBOARD_NO() {
		return BOARD_NO;
	}

	public void setBOARD_NO(int bOARD_NO) {
		BOARD_NO = bOARD_NO;
	}

	public String getPC_STATUS() {
		return PC_STATUS;
	}

	public void setPC_STATUS(String pC_STATUS) {
		PC_STATUS = pC_STATUS;
	}
	
	
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	@Override
	public String toString() {
		return "Pay [pay_no=" + pay_no + ", book_name=" + book_name + ", book_v=" + book_v + ", price=" + price
				+ ", pay_status=" + pay_status + ", pay_date=" + pay_date + ", userId=" + userId + ", book_no="
				+ book_no + ", status=" + status + ", seller=" + seller + ", account=" + account + ", BOARD_NO="
				+ BOARD_NO + ", PC_STATUS=" + PC_STATUS + "]";
	}


}
