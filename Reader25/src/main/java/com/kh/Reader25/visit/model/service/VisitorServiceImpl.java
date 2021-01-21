package com.kh.Reader25.visit.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.Reader25.visit.model.dao.VisitorDAO;
import com.kh.Reader25.visit.model.vo.Visitor;

@Service("vService")
public class VisitorServiceImpl implements VisitorService{
	@Autowired
	private VisitorDAO vDAO; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getVisitMonthCount() {
		return vDAO.getVisitMonthCount(sqlSession);
	}

	@Override
	public List<Map<String,String>> getDayVisitor() {
		return vDAO.getDayVisitor(sqlSession);
	}

	@Override
	public List<Map<String, String>> getMonthVisitor() {
		return vDAO.getMonthVisitor(sqlSession);
	}



	
}
