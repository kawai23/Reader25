package com.kh.Reader25.board.model.vo;

public class SearchReview {
	private String title;
	private String writer;
	private String content;
	private String author;
	private String book;
	
	public SearchReview() {}

	public SearchReview(String title, String writer, String content, String author, String book) {
		super();
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.author = author;
		this.book = book;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getBook() {
		return book;
	}

	public void setBook(String book) {
		this.book = book;
	}

	@Override
	public String toString() {
		return "SearchReview [title=" + title + ", writer=" + writer + ", content=" + content + ", author=" + author
				+ ", book=" + book + "]";
	}
	
}
