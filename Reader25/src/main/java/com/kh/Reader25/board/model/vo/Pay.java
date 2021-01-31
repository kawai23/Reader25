package com.kh.Reader25.board.model.vo;

import java.sql.Date;

public class Pay {
	
	
	private int pay_no;
	
	private String book_name;
	
	private int book_v;
	private int price;
	
	private String pay_status;
	
	private Date PAY_DATE;
	
	private String userId;
	
	private int book_no;
	
	private String status; //삭제 여부
	

	public Pay() {
		
	}

	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pAY_DATE, String userId,
			int book_no) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		PAY_DATE = pAY_DATE;
		this.userId = userId;
		this.book_no = book_no;
	}
	
	
	
	public Pay(int pay_no, String book_name, int book_v, int price, String pay_status, Date pAY_DATE, String userId,
			int book_no, String status) {
		super();
		this.pay_no = pay_no;
		this.book_name = book_name;
		this.book_v = book_v;
		this.price = price;
		this.pay_status = pay_status;
		PAY_DATE = pAY_DATE;
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
		return PAY_DATE;
	}

	public void setPay_date(Date pAY_DATE) {
		PAY_DATE = pAY_DATE;
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

	@Override
	public String toString() {
		return "Pay [pay_no=" + pay_no + ", book_name=" + book_name + ", book_v=" + book_v + ", price=" + price
				+ ", pay_status=" + pay_status + ", PAY_DATE=" + PAY_DATE + ", userId=" + userId + ", book_no="
				+ book_no + ", status=" + status + "]";
	}
	

}
