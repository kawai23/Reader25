package com.kh.Reader25.board.model.vo;

public class SearchCondition {
	

	
	private String mId;
	
	private String title;
	
	private String writer;
	
	private String content;
	
	private String no;
	
	private int code;
	
	
	
	
	
	public SearchCondition() {}





	public SearchCondition(String mId, String title, String writer, String content, String no, int code) {
		super();
		this.mId = mId;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.no = no;
		this.code = code;
	}





	public String getmId() {
		return mId;
	}





	public void setmId(String mId) {
		this.mId = mId;
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





	public String getNo() {
		return no;
	}





	public void setNo(String no) {
		this.no = no;
	}





	public int getCode() {
		return code;
	}





	public void setCode(int code) {
		this.code = code;
	}





	@Override
	public String toString() {
		return "SearchCondition [mId=" + mId + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", no=" + no + ", code=" + code + "]";
	}


	


	
	
}









	

	
	
	
	
	
	
	
	
	
	
	

