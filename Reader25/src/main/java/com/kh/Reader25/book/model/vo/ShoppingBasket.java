package com.kh.Reader25.book.model.vo;

public class ShoppingBasket {
	private int sb_no;
	private int sb_v;
	private String book_name;
	private String price;
	private String status;
	private String user_id;
	private int book_no;
	
	private int BOARD_NO;
	
	
	public ShoppingBasket() {}


	public ShoppingBasket(int sb_no, int sb_v, String book_name, String price, String status, String user_id,
			int book_no, int bOARD_NO) {
		super();
		this.sb_no = sb_no;
		this.sb_v = sb_v;
		this.book_name = book_name;
		this.price = price;
		this.status = status;
		this.user_id = user_id;
		this.book_no = book_no;
		BOARD_NO = bOARD_NO;
	}


	public int getSb_no() {
		return sb_no;
	}


	public void setSb_no(int sb_no) {
		this.sb_no = sb_no;
	}


	public int getSb_v() {
		return sb_v;
	}


	public void setSb_v(int sb_v) {
		this.sb_v = sb_v;
	}


	public String getBook_name() {
		return book_name;
	}


	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public int getBook_no() {
		return book_no;
	}


	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}


	public int getBOARD_NO() {
		return BOARD_NO;
	}


	public void setBOARD_NO(int bOARD_NO) {
		BOARD_NO = bOARD_NO;
	}


	@Override
	public String toString() {
		return "ShoppingBasket [sb_no=" + sb_no + ", sb_v=" + sb_v + ", book_name=" + book_name + ", price=" + price
				+ ", status=" + status + ", user_id=" + user_id + ", book_no=" + book_no + ", BOARD_NO=" + BOARD_NO
				+ "]";
	}
	
	
	
}
