package com.kh.Reader25.board.model.vo;

public class Liketo {
	private int l_no;
	private int b_no;
	private String m_no;
	private int l_check;
	
	public Liketo() {
		
	}

	public Liketo(int l_no, int b_no, String m_no, int l_check) {
		super();
		this.l_no = l_no;
		this.b_no = b_no;
		this.m_no = m_no;
		this.l_check = l_check;
	}

	public int getL_no() {
		return l_no;
	}

	public void setL_no(int l_no) {
		this.l_no = l_no;
	}

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public String getM_no() {
		return m_no;
	}

	public void setM_no(String m_no) {
		this.m_no = m_no;
	}

	public int getL_check() {
		return l_check;
	}

	public void setL_check(int l_check) {
		this.l_check = l_check;
	}

	@Override
	public String toString() {
		return "Liketo [l_no=" + l_no + ", b_no=" + b_no + ", m_no=" + m_no + ", l_check=" + l_check + "]";
	}

	
	
}
