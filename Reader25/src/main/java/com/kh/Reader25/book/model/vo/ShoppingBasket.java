package com.kh.Reader25.book.model.vo;

public class ShoppingBasket {
	private int sb_no;
	private String sb_v;
	private String price;
	private String status;
	private String user_id;
	private int book_no;
	
	public ShoppingBasket() {}

	public ShoppingBasket(int sb_no, String sb_v, String price, String status, String user_id, int book_no) {
		super();
		this.sb_no = sb_no;
		this.sb_v = sb_v;
		this.price = price;
		this.status = status;
		this.user_id = user_id;
		this.book_no = book_no;
	}

	public int getSb_no() {
		return sb_no;
	}

	public void setSb_no(int sb_no) {
		this.sb_no = sb_no;
	}

	public String getSb_v() {
		return sb_v;
	}

	public void setSb_v(String sb_v) {
		this.sb_v = sb_v;
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

	@Override
	public String toString() {
		return "ShoppingBasket [sb_no=" + sb_no + ", sb_v=" + sb_v + ", price=" + price + ", status=" + status
				+ ", user_id=" + user_id + ", book_no=" + book_no + "]";
	}
	
	
}
