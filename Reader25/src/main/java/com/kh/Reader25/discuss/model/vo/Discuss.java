package com.kh.Reader25.discuss.model.vo;

import java.sql.Date;

public class Discuss {
	private int dNo;
	private String dTitle;
	private String dWriter;
	private String dContent;
	private Date dCreate;
	private int dPros;
	private int dCons;
	private int dNeutrality;
	private int dCount;
	private String dStatus;
	private int atcNo;
	private Date enrollDate;
	
	public Discuss() {}



	public Discuss(int dNo, String dTitle, String dWriter, String dContent, Date dCreate, int dPros, int dCons,
			int dNeutrality, int dCount, String dStatus, int atcNo, Date enrollDate) {
		super();
		this.dNo = dNo;
		this.dTitle = dTitle;
		this.dWriter = dWriter;
		this.dContent = dContent;
		this.dCreate = dCreate;
		this.dPros = dPros;
		this.dCons = dCons;
		this.dNeutrality = dNeutrality;
		this.dCount = dCount;
		this.dStatus = dStatus;
		this.atcNo = atcNo;
		this.enrollDate = enrollDate;
	}

	public int getdNo() {
		return dNo;
	}

	public void setdNo(int dNo) {
		this.dNo = dNo;
	}

	public String getdTitle() {
		return dTitle;
	}

	public void setdTitle(String dTitle) {
		this.dTitle = dTitle;
	}

	public String getdWriter() {
		return dWriter;
	}

	public void setdWriter(String dWriter) {
		this.dWriter = dWriter;
	}

	public String getdContent() {
		return dContent;
	}

	public void setdContent(String dContent) {
		this.dContent = dContent;
	}

	public Date getdCreate() {
		return dCreate;
	}

	public void setdCreate(Date dCreate) {
		this.dCreate = dCreate;
	}

	public int getdPros() {
		return dPros;
	}

	public void setdPros(int dPros) {
		this.dPros = dPros;
	}

	public int getdCons() {
		return dCons;
	}

	public void setdCons(int dCons) {
		this.dCons = dCons;
	}

	public int getdNeutrality() {
		return dNeutrality;
	}

	public void setdNeutrality(int dNeutrality) {
		this.dNeutrality = dNeutrality;
	}

	public int getdCount() {
		return dCount;
	}

	public void setdCount(int dCount) {
		this.dCount = dCount;
	}

	public String getdStatus() {
		return dStatus;
	}

	public void setdStatus(String dStatus) {
		this.dStatus = dStatus;
	}

	public int getAtcNo() {
		return atcNo;
	}

	public void setAtcNo(int atcNo) {
		this.atcNo = atcNo;
	}
	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}



	@Override
	public String toString() {
		return "Discuss [dNo=" + dNo + ", dTitle=" + dTitle + ", dWriter=" + dWriter + ", dContent=" + dContent
				+ ", dCreate=" + dCreate + ", dPros=" + dPros + ", dCons=" + dCons + ", dNeutrality=" + dNeutrality
				+ ", dCount=" + dCount + ", dStatus=" + dStatus + ", atcNo=" + atcNo + ", enrollDate=" + enrollDate
				+ "]";
	}

	
}
