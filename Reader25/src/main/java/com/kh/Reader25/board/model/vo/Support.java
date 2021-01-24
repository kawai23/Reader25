package com.kh.Reader25.board.model.vo;

public class Support {
	private int sKey;
	private int sPoint;
	private String userId;
	private String sendId;
	private int bNo;
	
	public Support() {
		
	}

	public Support(int sKey, int sPoint, String userId, String sendId, int bNo) {
		super();
		this.sKey = sKey;
		this.sPoint = sPoint;
		this.userId = userId;
		this.sendId = sendId;
		this.bNo = bNo;
	}

	public int getsKey() {
		return sKey;
	}

	public void setsKey(int sKey) {
		this.sKey = sKey;
	}

	public int getsPoint() {
		return sPoint;
	}

	public void setsPoint(int sPoint) {
		this.sPoint = sPoint;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSendId() {
		return sendId;
	}

	public void setSendId(String sendId) {
		this.sendId = sendId;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	@Override
	public String toString() {
		return "Support [sKey=" + sKey + ", sPoint=" + sPoint + ", userId=" + userId + ", sendId=" + sendId + ", bNo="
				+ bNo + "]";
	}
	
	
}
