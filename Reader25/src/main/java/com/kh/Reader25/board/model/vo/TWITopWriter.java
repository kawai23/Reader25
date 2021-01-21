package com.kh.Reader25.board.model.vo;

public class TWITopWriter {
	private String id;
	private int count;
	
	public TWITopWriter() {
		
	}

	public TWITopWriter(String id, int count) {
		super();
		this.id = id;
		this.count = count;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "TWITopWriter [id=" + id + ", count=" + count + "]";
	}
	
	
}
