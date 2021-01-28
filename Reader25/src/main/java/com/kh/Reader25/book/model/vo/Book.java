package com.kh.Reader25.book.model.vo;

public class Book {
 private int b_no;
 private String b_name;
 private int b_price;
 private int b_Q1;
 private String b_Q2;
 private String b_Q3;
 private String author;
 private String b_Status;
 private int boardNo;
 
 public Book(){} 
public Book(int b_no, String b_name, int b_price, int b_Q1, String b_Q2, String b_Q3, String author,
		String b_Status, int boardNo) {
	super();
	this.b_no = b_no;
	this.b_name = b_name;
	this.b_price = b_price;
	this.b_Q1 = b_Q1;
	this.b_Q2 = b_Q2;
	this.b_Q3 = b_Q3;
	this.author = author;
	this.b_Status = b_Status;
	this.boardNo = boardNo;
}

public Book(int b_no, String b_name) {
	super();
	this.b_no = b_no;
	this.b_name = b_name;
}

public Book(int b_no, String b_name, int b_price, int b_Q1, String b_Q2, String b_Q3) {
	super();
	this.b_no = b_no;
	this.b_name = b_name;
	this.b_price = b_price;
	this.b_Q1 = b_Q1;
	this.b_Q2 = b_Q2;
	this.b_Q3 = b_Q3;
}

public int getB_no() {
	return b_no;
}

public void setB_no(int b_no) {
	this.b_no = b_no;
}

public String getB_name() {
	return b_name;
}

public void setB_name(String b_name) {
	this.b_name = b_name;
}

public int getB_price() {
	return b_price;
}

public void setB_price(int b_price) {
	this.b_price = b_price;
}

public int getB_Q1() {
	return b_Q1;
}

public void setB_Q1(int b_Q1) {
	this.b_Q1 = b_Q1;
}

public String getB_Q2() {
	return b_Q2;
}

public void setB_Q2(String b_Q2) {
	this.b_Q2 = b_Q2;
}

public String getB_Q3() {
	return b_Q3;
}

public void setB_Q3(String b_Q3) {
	this.b_Q3 = b_Q3;
}

public String getAuthor() {
	return author;
}

public void setAuthor(String author) {
	this.author = author;
}

public String getB_Status() {
	return b_Status;
}

public void setB_Status(String b_Status) {
	this.b_Status = b_Status;
}

public int getBoardNo() {
	return boardNo;
}
public void setBoardNo(int boardNo) {
	this.boardNo = boardNo;
}
@Override
public String toString() {
	return "Book [b_no=" + b_no + ", b_name=" + b_name + ", b_price=" + b_price + ", b_Q1=" + b_Q1 + ", b_Q2=" + b_Q2
			+ ", b_Q3=" + b_Q3 + ", author=" + author + ", b_Status=" + b_Status +", boardNo="+boardNo+ "]";
}
 
 
}
