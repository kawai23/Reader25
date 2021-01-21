package com.kh.Reader25.visit.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.Reader25.board.model.vo.PageInfo;
import com.kh.Reader25.visit.model.vo.Visitor;


public interface VisitorService {

	int getVisitMonthCount();

	List<Map<String,String>> getDayVisitor(String today);

	List<Map<String, String>> getMonthVisitor(String month);

	ArrayList<Visitor> selectListVisitor(PageInfo pi);


}
