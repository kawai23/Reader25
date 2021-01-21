package com.kh.Reader25.visit.model.service;

import java.util.List;
import java.util.Map;


public interface VisitorService {

	int getVisitMonthCount();

	List<Map<String,String>> getDayVisitor();

	List<Map<String, String>> getMonthVisitor();


}
