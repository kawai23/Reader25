package com.kh.Reader25.book.model.vo;

import java.sql.Date;

public class Pay {
	private int payNo;
	private int amount; //수량  book_v
	private int price;
	private Date payDate;
	private String pay_status;
	private String status;
	private String userId;
	private int bookNo;
	
	public Pay() {}

	public Pay(int payNo, int amount, int price, Date payDate, String pay_status, String status, String userId,
			int bookNo) {
		super();
		this.payNo = payNo;
		this.amount = amount;
		this.price = price;
		this.payDate = payDate;
		this.pay_status = pay_status;
		this.status = status;
		this.userId = userId;
		this.bookNo = bookNo;
	}

	public int getPayNo() {
		return payNo;
	}

	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public String getPay_status() {
		return pay_status;
	}

	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}

	@Override
	public String toString() {
		return "Pay [payNo=" + payNo + ", amount=" + amount + ", price=" + price + ", payDate=" + payDate
				+ ", pay_status=" + pay_status + ", status=" + status + ", userId=" + userId + ", bookNo=" + bookNo
				+ "]";
	}
}
