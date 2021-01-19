package com.kh.Reader25.visit.model.vo;

import java.sql.Timestamp;

public class Visitor {
	private int visit_id;
	private String visit_ip;
	private Timestamp visit_time;
	private String visit_refer;
	private String visit_agent;
	
	public  Visitor() {}

	public Visitor(int visit_id, String visit_ip, Timestamp visit_time, String visit_refer, String visit_agent) {
		super();
		this.visit_id = visit_id;
		this.visit_ip = visit_ip;
		this.visit_time = visit_time;
		this.visit_refer = visit_refer;
		this.visit_agent = visit_agent;
	}

	public int getVisit_id() {
		return visit_id;
	}

	public void setVisit_id(int visit_id) {
		this.visit_id = visit_id;
	}

	public String getVisit_ip() {
		return visit_ip;
	}

	public void setVisit_ip(String visit_ip) {
		this.visit_ip = visit_ip;
	}

	public Timestamp getVisit_time() {
		return visit_time;
	}

	public void setVisit_time(Timestamp visit_time) {
		this.visit_time = visit_time;
	}

	public String getVisit_refer() {
		return visit_refer;
	}

	public void setVisit_refer(String visit_refer) {
		this.visit_refer = visit_refer;
	}

	public String getVisit_agent() {
		return visit_agent;
	}

	public void setVisit_agent(String visit_agent) {
		this.visit_agent = visit_agent;
	}

	@Override
	public String toString() {
		return "Visitor [visit_id=" + visit_id + ", visit_ip=" + visit_ip + ", visit_time=" + visit_time
				+ ", visit_refer=" + visit_refer + ", visit_agent=" + visit_agent + "]";
	}
	
}
