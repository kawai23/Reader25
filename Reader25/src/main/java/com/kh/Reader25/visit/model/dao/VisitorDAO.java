package com.kh.Reader25.visit.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.Reader25.visit.model.vo.Visitor;

@Repository("vDAO")
public class VisitorDAO {

	public int insertVisitor(SqlSessionTemplate sqlSession,Visitor v) throws Exception{
		return sqlSession.insert("visitorMapper.insertVisitor",v);
	}

	public int getVisitTodayCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitorMapper.getVisitTodayCount");
	}

	public int getVisitTotalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("visitorMapper.getVisitTotalCount");
	}
	
}
